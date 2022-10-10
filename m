Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2826C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 08:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJJICX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJJICW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 04:02:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAE53A6E
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 01:02:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3D8E1F385;
        Mon, 10 Oct 2022 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665388939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40e2mBT8cZBTYq+ErrM/aGNtnEuxJQyvlXKmpLVJ4vk=;
        b=0WneDkMd7cZJbDOKHkjQT83qwZCuGYYKKe2uDxWm7rn5vmySW1WzvSR9c0Q3lWAYuWCHey
        KnbLgU/Shhm9oM2H0pYRlrfotAn4jJQuBgeZeDnc9j0JeGCi7TtydO0WInuGvgXStS65yY
        OLYv9l7hePTXRui9JR4yHeVQBX5cl6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665388939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40e2mBT8cZBTYq+ErrM/aGNtnEuxJQyvlXKmpLVJ4vk=;
        b=5DS9DDWHy/+mz7n67aMqlniA0x1QEQRqF7PKNOBmSVKDVf5JOGsB/WE5UZ3KGIWBA/ZMs/
        17p6a5QpONBHaWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BD5C13ACA;
        Mon, 10 Oct 2022 08:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ktQSIovRQ2PfYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Oct 2022 08:02:19 +0000
Date:   Mon, 10 Oct 2022 10:02:18 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Message-ID: <20221010080218.uqhkvryiipybxidd@carbon.lan>
References: <20221007193825.4058951-1-kbusch@meta.com>
 <Y0PLerK6pBp9UC2G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0PLerK6pBp9UC2G@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 12:36:26AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 07, 2022 at 12:38:25PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The major/minor of a hidden gendisk is not propagated to the block
> > device. This is required to suppress it from being visible. For these
> > disks, we need to handle freeing the dynamic minor directly when it's
> > released since bdev_free_inode() won't be able to.
> 
> This now leads to a different lifetime.  I think the proper fix is
> the one below (untested):
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d36fabf0abc1f..1752ce356484e 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -507,6 +507,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  		 */
>  		dev_set_uevent_suppress(ddev, 0);
>  		disk_uevent(disk, KOBJ_ADD);
> +	} else {
> +		disk->part0->bd_dev = ddev->devt;
>  	}
>  
>  	disk_update_readahead(disk);

Doesn't give me the same consistent result as with Keith's version:

# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 10:00 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 09:58 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 09:58 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 10:00 /dev/nvme2
brw-rw---- 1 root disk 259,   2 Oct 10 10:00 /dev/nvme2n1
brw-rw---- 1 root disk 259,   3 Oct 10 10:00 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   5 Oct 10 10:00 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct 10 10:00 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct 10 10:00 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 10:00 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 10:00 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 10:00 /dev/nvme5
# nvme disconnect-all
# nvme connect-all
# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 10:00 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 09:58 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 09:58 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 10:00 /dev/nvme2
brw-rw---- 1 root disk 259,   3 Oct 10 10:00 /dev/nvme2n1
brw-rw---- 1 root disk 259,   5 Oct 10 10:00 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   9 Oct 10 10:00 /dev/nvme2n2
brw-rw---- 1 root disk 259,  23 Oct 10 10:00 /dev/nvme2n3
brw-rw---- 1 root disk 259,  25 Oct 10 10:00 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 10:00 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 10:00 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 10:00 /dev/nvme5
