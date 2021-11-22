Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D8EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 22 Nov 2021 00:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhKVAyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Nov 2021 19:54:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKVAyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Nov 2021 19:54:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99D43212C5;
        Mon, 22 Nov 2021 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637542270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+JFIQECy05kKq4JWtCYQM5TGB5afvz21jJ5dUroB8E=;
        b=I+kyBDwnV/FGE0HfkzhfpFFg6fKz6M0W9s+5htFg3tGWDOpN/BfJcBkp+eZrmMAvnS5vKb
        mSoZ7JKbJim4FejpT8Swme5ezsA7f0ylw2D4VGg6XPC0rOcIKKZIRQlFHu34LXdrmqm0jo
        ABubpYgcstoq7ZyTICih3um22DVzv4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637542270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+JFIQECy05kKq4JWtCYQM5TGB5afvz21jJ5dUroB8E=;
        b=2df4D1BSb3Kj5/0cx+BbQkjqWxHAofACiQzuhnzCi1EDpyxudT5Jmksf+xxS/C9wPHHjfU
        v6nMIfIGWUueitAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 643281331A;
        Mon, 22 Nov 2021 00:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kQp/B33pmmHaNwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 Nov 2021 00:51:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
In-reply-to: <87ee79yiik.fsf@mail.parknet.co.jp>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>,
 <87ee79yiik.fsf@mail.parknet.co.jp>
Date:   Mon, 22 Nov 2021 11:51:06 +1100
Message-id: <163754226639.13692.10449616189734943162@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 21 Nov 2021, OGAWA Hirofumi wrote:
> "NeilBrown" <neilb@suse.de> writes:
>=20
> > congestion_wait() in this context is just a sleep - block devices do not
> > in general support congestion signalling any more.
> >
> > The goal here is to wait for any recently written data to get to
> > storage.  This can be achieved using blkdev_issue_flush().
>=20
> Purpose of flush option should be for making umount faster, not data
> integrity. (but current flush implement is strange at several places, IMO)

I don't think that is true.  I believe the purpose of the flush option
is to write out data as soon as a file is closed, so that if the media
is removed without first unmounting, the data is more likely to be safe.
That is why the commit which introduce it:
 Commit ae78bf9c4f5f ("[PATCH] add -o flush for fat")
particularly mentions "removable media".

>=20
> So, I don't think the issue_flush is not proper for it (flush is very
> slow on some usb thumb), and rather I think it is better off to just
> remove the congestion_wait().

We already call blkdev_issue_flush() on fsync.  With my patch, a simple
close() effective becomes an fsync() and a close().  I think that is
completely consistent with the purpose of "-o flush".

Thanks,
NeilBrown


>=20
> Thanks.
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/fat/file.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fat/file.c b/fs/fat/file.c
> > index 13855ba49cd9..c50a52f40e37 100644
> > --- a/fs/fat/file.c
> > +++ b/fs/fat/file.c
> > @@ -175,9 +175,9 @@ long fat_generic_ioctl(struct file *filp, unsigned in=
t cmd, unsigned long arg)
> >  static int fat_file_release(struct inode *inode, struct file *filp)
> >  {
> >  	if ((filp->f_mode & FMODE_WRITE) &&
> > -	     MSDOS_SB(inode->i_sb)->options.flush) {
> > +	    MSDOS_SB(inode->i_sb)->options.flush) {
> >  		fat_flush_inodes(inode->i_sb, inode, NULL);
> > -		congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +		blkdev_issue_flush(inode->i_sb->s_bdev);
> >  	}
> >  	return 0;
> >  }
>=20
> --=20
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>=20
>=20
