Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3EDC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F56206BF
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 01:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfDZBiR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDZBiR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 21:38:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 447E63005FE7;
        Fri, 26 Apr 2019 01:38:17 +0000 (UTC)
Received: from redhat.com (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5865F1820F;
        Fri, 26 Apr 2019 01:38:16 +0000 (UTC)
Date:   Thu, 25 Apr 2019 21:38:14 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426013814.GB3350@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 26 Apr 2019 01:38:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see that they are still empty spot in LSF/MM schedule so i would like to
have a discussion on allowing direct block mapping of file for devices (nic,
gpu, fpga, ...). This is mm, fs and block discussion, thought the mm side
is pretty light ie only adding 2 callback to vm_operations_struct:

    int (*device_map)(struct vm_area_struct *vma,
                      struct device *importer,
                      struct dma_buf **bufp,
                      unsigned long start,
                      unsigned long end,
                      unsigned flags,
                      dma_addr_t *pa);

    // Some flags i can think of:
    DEVICE_MAP_FLAG_PIN // ie return a dma_buf object
    DEVICE_MAP_FLAG_WRITE // importer want to be able to write
    DEVICE_MAP_FLAG_SUPPORT_ATOMIC_OP // importer want to do atomic operation
                                      // on the mapping

    void (*device_unmap)(struct vm_area_struct *vma,
                         struct device *importer,
                         unsigned long start,
                         unsigned long end,
                         dma_addr_t *pa);

Each filesystem could add this callback and decide wether or not to allow
the importer to directly map block. Filesystem can use what ever logic they
want to make that decision. For instance if they are page in the page cache
for the range then it can say no and the device would fallback to main
memory. Filesystem can also update its internal data structure to keep
track of direct block mapping.

If filesystem decide to allow the direct block mapping then it forward the
request to the block device which itself can decide to forbid the direct
mapping again for any reasons. For instance running out of BAR space or
peer to peer between block device and importer device is not supported or
block device does not want to allow writeable peer mapping ...


So event flow is:
    1  program mmap a file (end never intend to access it with CPU)
    2  program try to access the mmap from a device A
    3  device A driver see device_map callback on the vma and call it
    4a on success device A driver program the device to mapped dma address
    4b on failure device A driver fallback to faulting so that it can use
       page from page cache

This API assume that the importer does support mmu notifier and thus that
the fs can invalidate device mapping at _any_ time by sending mmu notifier
to all mapping of the file (for a given range in the file or for the whole
file). Obviously you want to minimize disruption and thus only invalidate
when necessary.

The dma_buf parameter can be use to add pinning support for filesystem who
wish to support that case too. Here the mapping lifetime get disconnected
from the vma and is transfer to the dma_buf allocated by filesystem. Again
filesystem can decide to say no as pinning blocks has drastic consequence
for filesystem and block device.


This has some similarities to the hmmap and caching topic (which is mapping
block directly to CPU AFAIU) but device mapping can cut some corner for
instance some device can forgo atomic operation on such mapping and thus
can work over PCIE while CPU can not do atomic to PCIE BAR.

Also this API here can be use to allow peer to peer access between devices
when the vma is a mmap of a device file and thus vm_operations_struct come
from some exporter device driver. So same 2 vm_operations_struct call back
can be use in more cases than what i just described here.


So i would like to gather people feedback on general approach and few things
like:
    - Do block device need to be able to invalidate such mapping too ?

      It is easy for fs the to invalidate as it can walk file mappings
      but block device do not know about file.

    - Do we want to provide some generic implementation to share accross
      fs ?

    - Maybe some share helpers for block devices that could track file
      corresponding to peer mapping ?


Cheers,
Jérôme
