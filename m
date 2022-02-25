Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F737C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 21:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiBYVNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBYVNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 16:13:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B604154732;
        Fri, 25 Feb 2022 13:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z7wdJC+0kx3l3p5CC3OcwuCNDMS9JX4YUo0ttYZ2ZwM=; b=ygSlH9a1M/ftI6oY6my+MlD6eC
        EEV0B1vnHT25QM5WDR+hJ0S7ubm+ux4FI9SzqVWUVUaSQVdUTeTRiIuAFKd8TL1JUnYGgN1vlijpw
        xIm00yGWOeN2BiA8lNJEF36tz8t3MFtfYhqDTJviUfTO62k/QzdHFEcPgnszHhTb5IHUCTwLWRz6Q
        o0N8qtN+IBPbblm1H8jj9aSu92jwkTPjjJTSJuZaJXsuqrVld3e+6+zhlBhFY98m0JIqx4Ni5CsBB
        WKxctf6LS6EblB1BbeN/8WNm+el64EN6OQGCsX47ptE89Ppf1rxd+Db5kLduntNmWUyucNPcbOWMy
        lLUZHNag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNhtY-006zda-Pp; Fri, 25 Feb 2022 21:12:56 +0000
Date:   Fri, 25 Feb 2022 13:12:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] losetup: don't skip adding a new device if it already
 has a device node
Message-ID: <YhlGWEJ8w2iXmie7@bombadil.infradead.org>
References: <20220225180903.1341819-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180903.1341819-1-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 25, 2022 at 07:09:03PM +0100, Christoph Hellwig wrote:
> Linux plans to deprecate the auto-creation of block devices based on
> access to the devic node starting from kernel 5.18.  Without that feature
> losetup will fail to create the loop device if a device node already
> exists, but the loop device to back it in the kernel does not exist yet.
> This is a scenario that should not happen in modern udev based
> distributions, but apparently there still are various scripts around that
> manually call the superflous mknod.
> 
> Change losetup to unconditionally call loopcxt_add_device when a specific
> device node is specified on the command line.  If the loop device
> already exists the LOOP_CTL_ADD ioctl will fail, but given that losetup
> ignores the return value from loopcxt_add_device that failure has no
> further effect.

I think it would help to explain what the issue is, with a simple
example on the commit log.

By default loading the loop module we'll create only 8 loopback
devices. Prior to the new CONFIG_BLOCK_LEGACY_AUTOLOAD which intends
to deprecate the whole oldschool probe functionality which used try
to load the respective block driver (loop in this case) when the
driver is not present but the nodes are created manually, the following
piece of code would work:

losetup -D
modprobe -r loop
modprobe loop

rm -f foo.img
truncate -s 10M foo.img

# Note: /dev/loop8 by default won't exist as we default to 7
# loop devices
rm -f /dev/loop8
mknod /dev/loop8 b 7 8
losetup /dev/loop8 foo.img

When deprecating this probe --> module load logic, if the
mknod is run we'd currently fail at the last step. With this
fix the last step will still work. However please note that
CONFIG_BLOCK_LEGACY_AUTOLOAD goes away the above will require
manually loading the loop module. Scripts which fail to load
the loop module prior to mknod will fail by definition of the
deprecation effort.

> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With that said:

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

> ---
>  sys-utils/losetup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> index c400cbf12..09c028b6b 100644
> --- a/sys-utils/losetup.c
> +++ b/sys-utils/losetup.c
> @@ -522,7 +522,7 @@ static int create_loop(struct loopdev_cxt *lc,
>  		}
>  	}
>  
> -	if (hasdev && !is_loopdev(loopcxt_get_device(lc)))
> +	if (hasdev)
>  		loopcxt_add_device(lc);
>  
>  	/* losetup --noverlap /dev/loopN file.img */
> -- 
> 2.30.2
> 
