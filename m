Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4789C7EE23
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 02:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEECH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 22:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672312713
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683252405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1lZHH9cJOkUnL6+SkM6O5cU5HIeggOc99mIe6aElrU=;
        b=ASosaWtJswzd1Dx4dzqF0AVaoH0T6NrwQtmfLGxzZIsaenlrYfrqg9Vei2wKsisxf2PEJU
        00rg91PlwIT70nQ7V/PeB3PO3QsE38u4Joua/9Xv5tgTXoi0xIGsayyqLbpGLIIAZuF5u6
        43ZZZSbJWj2T3xQQD7ab7RgdSTJ70ZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-vimcqaoUNs6Ig5aKRDdcoA-1; Thu, 04 May 2023 22:06:41 -0400
X-MC-Unique: vimcqaoUNs6Ig5aKRDdcoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F118A85A5B1;
        Fri,  5 May 2023 02:06:40 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C782B2026D16;
        Fri,  5 May 2023 02:06:33 +0000 (UTC)
Date:   Fri, 5 May 2023 10:06:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZFRkpKrhKDgi/lmf@ovpn-8-16.pek2.redhat.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZFPWeOg5xJ7CbCD0@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFPWeOg5xJ7CbCD0@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 04, 2023 at 09:59:52AM -0600, Keith Busch wrote:
> On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> > Hello Guys,
> > 
> > I got one report in which buffered write IO hangs in balance_dirty_pages,
> > after one nvme block device is unplugged physically, then umount can't
> > succeed.
> > 
> > Turns out it is one long-term issue, and it can be triggered at least
> > since v5.14 until the latest v6.3.
> > 
> > And the issue can be reproduced reliably in KVM guest:
> > 
> > 1) run the following script inside guest:
> > 
> > mkfs.ext4 -F /dev/nvme0n1
> > mount /dev/nvme0n1 /mnt
> > dd if=/dev/zero of=/mnt/z.img&
> > sleep 10
> > echo 1 > /sys/block/nvme0n1/device/device/remove
> > 
> > 2) dd hang is observed and /dev/nvme0n1 is gone actually
> 
> Sorry to jump in so late.
> 
> For an ungraceful nvme removal, like a surpirse hot unplug, the driver
> sets the capacity to 0 and that effectively ends all dirty page writers
> that could stall forward progress on the removal. And that 0 capacity
> should also cause 'dd' to exit.

Actually nvme device has been gone, and the hang just happens in
balance_dirty_pages() from generic_perform_write().

The issue should be triggered on all kinds of disks which can be hot-unplug,
and it can be duplicated on both ublk and nvme easily.

> 
> But this is not an ungraceful removal, so we're not getting that forced
> behavior. Could we use the same capacity trick here after flushing any
> outstanding dirty pages?

set_capacity(0) has been called in del_gendisk() after fsync_bdev() &
__invalidate_device(), but I understand FS code just try best to flush dirty
pages. And when the bdev is gone, these un-flushed dirty pages need cleanup,
otherwise they can't be used any more.


Thanks,
Ming

