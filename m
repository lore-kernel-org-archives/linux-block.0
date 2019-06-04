Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387BC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3C624C71
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 04:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfFDEKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:10:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFDEKe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 00:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C71DE307D914;
        Tue,  4 Jun 2019 04:10:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BB716014C;
        Tue,  4 Jun 2019 04:10:09 +0000 (UTC)
Date:   Tue, 4 Jun 2019 12:10:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
Message-ID: <20190604040946.GA27224@ming.t460p>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
 <20190603204422.GA7240@roeck-us.net>
 <20190604010002.GA24432@ming.t460p>
 <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Jun 2019 04:10:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 03, 2019 at 08:49:10PM -0700, Guenter Roeck wrote:
> On 6/3/19 6:00 PM, Ming Lei wrote:
> > On Mon, Jun 03, 2019 at 01:44:22PM -0700, Guenter Roeck wrote:
> > > On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
> > > > Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
> > > > and the buffer size is scsi_mq_sgl_size() which depends on smaller
> > > > value between shost->sg_tablesize and SG_CHUNK_SIZE.
> > > > 
> > > > Modern HBA's DMA is often capable of deadling with very big segment
> > > > number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
> > > > of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
> > > > 
> > > > Then if one HBA has lots of queues, and each hw queue's depth is
> > > > high, pre-allocation for sg list can consume huge memory.
> > > > For example of lpfc, nr_hw_queues can be 70, each queue's depth
> > > > can be 3781, so the pre-allocation for data sg list is 70*3781*2k
> > > > =517MB for single HBA.
> > > > 
> > > > There is Red Hat internal report that scsi_debug based tests can't
> > > > be run any more since legacy io path is killed because too big
> > > > pre-allocation.
> > > > 
> > > > So switch to runtime allocation for sg list, meantime pre-allocate 2
> > > > inline sg entries. This way has been applied to NVMe PCI for a while,
> > > > so it should be fine for SCSI too. Also runtime sg entries allocation
> > > > has verified and run always in the original legacy io path.
> > > > 
> > > > Not see performance effect in my big BS test on scsi_debug.
> > > > 
> > > 
> > > This patch causes a variety of boot failures in -next. Typical failure
> > > pattern is scsi hangs or failure to find a root file system. For example,
> > > on alpha, trying to boot from usb:
> > 
> > I guess it is because alpha doesn't support sg chaining, and
> > CONFIG_ARCH_NO_SG_CHAIN is enabled. ARCHs not supporting sg chaining
> > can only be arm, alpha and parisc.
> > 
> 
> I don't think it is that simple. I do see the problem on x86 (32 and 64 bit)
> sparc, ppc, and m68k as well, and possibly others (I didn't check all because
> -next is in terrible shape right now). Error log is always a bit different
> but similar.
> 
> On sparc:
> 
> scsi host0: Data transfer overflow.
> scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> scsi host0: DMA length is zero!
> scsi host0: cur adr[f000f000] len[00000000]
> scsi host0: Data transfer overflow.
> scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> scsi host0: DMA length is zero!
> 
> On ppc:
> 
> scsi host0: DMA length is zero!
> scsi host0: cur adr[0fd21000] len[00000000]
> scsi host0: Aborting command [(ptrval):28]
> scsi host0: Current command [(ptrval):28]
> scsi host0:  Active command [(ptrval):28]
> 
> On x86, x86_64 (after reverting a different crash-causing patch):
> 
> [   20.226809] scsi host0: DMA length is zero!
> [   20.227459] scsi host0: cur adr[00000000] len[00000000]
> [   50.588814] scsi host0: Aborting command [(____ptrval____):28]
> [   50.589210] scsi host0: Current command [(____ptrval____):28]
> [   50.589447] scsi host0:  Active command [(____ptrval____):28]
> [   50.589674] scsi host0: Dumping command log

OK, I did see one boot crash issue on x86_64 with -next, so could
you share us that patch which needs to be reverted? Meantime, please
provide me your steps for reproducing this issue? (rootfs image, kernel
config, qemu command)

BTW, the patch has been tested in RH QE lab, so far not see such reports
yet.

Thanks,
Ming
