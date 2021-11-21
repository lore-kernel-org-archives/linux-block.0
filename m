Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6ADC433F5
	for <linux-block@archiver.kernel.org>; Sun, 21 Nov 2021 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhKUJ1x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Nov 2021 04:27:53 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:47520 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhKUJ1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Nov 2021 04:27:52 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Nov 2021 04:27:52 EST
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id E1A7615F93A;
        Sun, 21 Nov 2021 18:17:57 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1AL9HuGG001818
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 21 Nov 2021 18:17:57 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1AL9HtRR002571
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 21 Nov 2021 18:17:56 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 1AL9HtFY002570;
        Sun, 21 Nov 2021 18:17:55 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "NeilBrown" <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
Date:   Sun, 21 Nov 2021 18:17:55 +0900
In-Reply-To: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
        (NeilBrown's message of "Wed, 17 Nov 2021 15:31:34 +1100")
Message-ID: <87ee79yiik.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"NeilBrown" <neilb@suse.de> writes:

> congestion_wait() in this context is just a sleep - block devices do not
> in general support congestion signalling any more.
>
> The goal here is to wait for any recently written data to get to
> storage.  This can be achieved using blkdev_issue_flush().

Purpose of flush option should be for making umount faster, not data
integrity. (but current flush implement is strange at several places, IMO)

So, I don't think the issue_flush is not proper for it (flush is very
slow on some usb thumb), and rather I think it is better off to just
remove the congestion_wait().

Thanks.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/fat/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 13855ba49cd9..c50a52f40e37 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -175,9 +175,9 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  static int fat_file_release(struct inode *inode, struct file *filp)
>  {
>  	if ((filp->f_mode & FMODE_WRITE) &&
> -	     MSDOS_SB(inode->i_sb)->options.flush) {
> +	    MSDOS_SB(inode->i_sb)->options.flush) {
>  		fat_flush_inodes(inode->i_sb, inode, NULL);
> -		congestion_wait(BLK_RW_ASYNC, HZ/10);
> +		blkdev_issue_flush(inode->i_sb->s_bdev);
>  	}
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
