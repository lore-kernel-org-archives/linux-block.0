Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8654857B
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085894; cv=pass; b=b9Kv3l3TLCvgU05eDJ1/4qdgSmVNZPD4ZJQW90nacEWxE+YhK/c3xhroqlRj+79uP1Zdc9xvFfqTvwFX3WUW8tPu67GD/Tb0Mgvers8p/s+HDjbE0tunnOb92VEsg4Cvmhwo36S+TaJe3GAMANLf1HH7B1n5wejwpr6RkaKqrnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085894; c=relaxed/simple;
	bh=HmtpJAgxyWzEhX/Kivuz0S1dXZLqzMoX1yiDfvCKtBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It8b6am6O8usZm09DsE+zmIRJPUI+1AZlfyV71i9KUXPBuJ2hE0+O4dHktj0JXaYAr0lxB4n6JU0XlgiUNOccD8Eubx4cuVc8idqNErOHzGdl4wGnzF2YpN+GoOk1bZrVbag90GLBPEBObNaQvzpmvGpjnIo3Ml2F2MvLgK+xxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGqCNwBa; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dGqCNwBa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356256so1411260f8f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085891; cv=none;
        d=google.com; s=arc-20260327;
        b=jxkU0fxykoy5ZFfwHlKhyPKN+zpJFGT9M/N1s61l6VSPcRB6ePerjef47OOyrvTX9v
         H7Zmzp4z2qxNjW1MpksO+45pQPY7I6IT5zN5DCqXzGRIhcr+J2oYAjHEQ4/uazROEFMf
         NCMVEJyqyGfXTf9nr8aIqqwl/nMhqE9ljXV2je9fssPM4rPfQ5uemBQfXubb3L8/8mTi
         nWhZJykjIWAl5ob/Fyc2zSL+VsA3oFgDeJB9uA6vnzKMWHTuc7Ao3nDxDPte8mxtFFuP
         nJ7xhhJLXxxk8zo8J8bYRecH5Xdl6X2l1DcJpBlFnBrPo/UbPN9CSAxxzYeGeb97r7fA
         /wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CAZT4Mc0RtafwpZHvhYs12WjFLpfTV2iCIMjczEtukc=;
        fh=Y9gXAdYcI7O9g81SmxPtV57vKfx7ckuKhHTrLMlvehg=;
        b=swHgKIrMXXuXhdSECCPW9K9aLxq9ImE7twOTq6dOzDuVHb6mrS8LA+oSaO5lSns4sT
         0wCOvc0lbaygJtirGyt8Oc5YfnpVZTxdlliL4aSg5jEyNMvvKfsNlm58DyH5tskEH+vA
         Uhj+UoX8INd+zgX8Vq+HtInpAyQ291Oxt4dqyFwx4SMGwp99lO/v+ozeoPMKTw2P68fX
         75y39i3GDfPAavhB0P+vhkAdhqfh92on/htRoUHMdg3ryO6FvQ45GIKwRo3yzh6nIW5a
         M8K6gSdJEdUF7sTQDUkAjtXKVY46h5xbDO2Y34dTtPRAUFHHzQhKz/T6aJyP1DmjSp0v
         DJ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790085891; x=1790690691; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAZT4Mc0RtafwpZHvhYs12WjFLpfTV2iCIMjczEtukc=;
        b=dGqCNwBa0Xaq3jy4paXVSMBTT3MP2lYYULb9Z44yy0vkdbpC/0TNieXlYfrRijvAR2
         FmgvSvR6c8lzvqqh/BURrpsdbO46Yzd2hgV8tpdFGwsvixIkm4sVpMKgd+5bNjPZ2vpR
         bW+Q/cHTDqxjmhd/85X/NYbhWNZCNr0Py7emGirEG+76SSZAlJE7OIrNBX7ABd/RGtOm
         PLnjYyRh78a7ZU295wEU4PIz2sUQVYUgtnFHUsPk+uoYhewXMPxkJ/mf3WTIODwzCY91
         hjKNKNngiPhAn2JTjB0ObRRrzTb3U41X8jmzpecrXpsV+Li4cTxI4pi5sWSQRMzlTJJ2
         bZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085891; x=1790690691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAZT4Mc0RtafwpZHvhYs12WjFLpfTV2iCIMjczEtukc=;
        b=KQ26Ur8mrc/1eE6Nb7c0bTFnEZh1UZsosz1pdGmfI0v3k/McSnCmKYsoJWG6YO5mMS
         rfaGH1UjG7Qpw/a7KJMd8gMYWg/cF1O2GxgewP1PytLx3srgmAFc8y6IXtutAONEHII1
         ULEWC11iPT7JCv7g55hU9BcCD1R0omkaK7yfUzqx8sCAi49QERHQRAVN23oWAxkntS1M
         klSG48ktNGoI3e/NX0yJLju5Efz21CKZI8K8n8RMxnbc0s/XDaE7qE9EGkTZrxo94vEc
         myUEybsvMQrCjw4domTLR+pcSHwueLpdS1NE19EIOlqwWqCX5ObPeBt58ymeDlqgHy0X
         jVgA==
X-Forwarded-Encrypted: i=1; AKwUvBxpV+PO6SPZU79UZFysrplNerqmON/AsZcijrVM8+zTru7/ArL5NAuTsv24Bg6mA2749fR9qJeLqgFeMg==@vger.kernel.org
X-Gm-Message-State: AFuF++k4Ae5RlAsfWjBml0gqrA1c+vuJopugc9rcILyL3lvId3pGSL6c
	dyIKIYLweimFT4xHYBTO2krWs+A4hwdKHZFWWweNIe/gOl7kwcp26MBj0pIAKc35nkCdXxR0nob
	qTrQq5ppEIqCQhjo6Ugq1HV0nyERQzV5qDcGV9GXTEOdkzXAJ/3GAVcM=
X-Gm-Gg: AYBFou2eFr7FaouSlSyIoCVTcrbcW1LMlEOOPadKWjqNHdtEqG+HXX/vY+4iE1iwsCa
	5Tsndn0l+TnOEoALkGky+H8slo943zMrMVIqZqLqbnaXX3yVtgaSmF5AOvQ8bXikZcCWMhduBfM
	sgHIjX5IvU3yUFwnZLdNi6CoCKOviUQg8uF8XImCYU0WPy3xmaNSsaVfm8LRXlggQctTD5lm6Xj
	JnuNxi9n7cBe3b/ePaYTIZR53uj33Lwj2gr/CRVjIvoJs73yDDCR1uzOG09kJlCpgfjDKePgpmx
	XW5HqmlRALa4n6Rn1aSGEp3f1FPGYxqt5gHLCOhH6NaNvEwc6thaBXFa/fOG/U7JShUmSSoHBHv
	gTD1RmAzKrb7waDNpXD+9c9hhfENkkHHV2mZc5jblyeawq2q4oKuZ
X-Received: by 2002:a05:6000:4384:b0:487:218b:bbc9 with SMTP id
 ffacd0b85a97d-48861021845mr4010977f8f.19.1790085891037; Tue, 22 Sep 2026
 07:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-11-neelx@suse.com>
 <20260602031251.GG2295@sol> <CAPjX3Fer=5gfiBuB0Nk8rRdUZdhpk9txeBYtGFy=p6W-DmiVDQ@mail.gmail.com>
In-Reply-To: <CAPjX3Fer=5gfiBuB0Nk8rRdUZdhpk9txeBYtGFy=p6W-DmiVDQ@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Sep 2026 16:04:40 +0200
X-Gm-Features: AclHuK_rkaWCmtwpyZjV91f4SPFL36vekOWvX2NiWI_NE1BZdnnwGwyNNNf5oUo
Message-ID: <CAPjX3FdaOiWuTBp13mnOetOhi+qYH-5mNcLWLNv5YoD=bNgzqg@mail.gmail.com>
Subject: Re: [PATCH v7 10/43] btrfs: start using fscrypt hooks
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 05:14, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:44AM +0200, Daniel Vacek wrote:
> > @@ -9041,20 +9063,28 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >       };
> >       unsigned int trans_num_items;
> >       int ret;
> > -     int name_len;
> >       int datasize;
> >       unsigned long ptr;
> >       struct btrfs_file_extent_item *ei;
> >       struct extent_buffer *leaf;
> > +     struct fscrypt_str disk_link;
> > +     size_t max_len;
> > +     u32 name_len = strlen(symname);
> > +
> > +     /*
> > +      * BTRFS_MAX_INLINE_DATA_SIZE() isn't actually telling the truth, we actually
> > +      * limit inline data extents to min(BTRFS_MAX_INLINE_DATA_SIZE(), sectorsize),
> > +      * so adjust max_len given this wonderful bit of inconsistency.
> > +      */
> > +     max_len = min_t(size_t, BTRFS_MAX_INLINE_DATA_SIZE(fs_info), fs_info->sectorsize);
> >
> > -     name_len = strlen(symname);
> >       /*
> > -      * Symlinks utilize uncompressed inline extent data, which should not
> > -      * reach block size.
> > +      * fscrypt sets disk_link.len to be len + 1, including a NUL terminator,
> > +      * but we don't store that '\0' character.
> >        */
> > -     if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
> > -         name_len >= fs_info->sectorsize)
> > -             return -ENAMETOOLONG;
> > +     ret = fscrypt_prepare_symlink(dir, symname, name_len, max_len + 1, &disk_link);
> > +     if (ret)
> > +             return ret;
>
> This is off by one from the other filesystems.  Yes, the way the other
> filesystems do encrypted symlinks is weird, but this still doesn't fix
> it, since the unnecessary 'struct fscrypt_symlink_data' is still stored.
> If it's not being fixed completely, it should just be done the same way.
>
> Did you do it this way because you're trying to squeeze out an extra
> byte, to allow 4094-byte symlink targets instead of 4093 as the other
> filesystems do?  Or did you do it this way because btrfs doesn't count a
> nul terminator when checking unencrypted symlinks against
> BTRFS_MAX_INLINE_DATA_SIZE(fs_info), and you needed to preserve that
> behavior?  But at the same time, btrfs *does* count the nul terminator
> when validating against 'fs_info->sectorsize', and this changes that
> behavior.  So it's not clear what was intended here.

This comes from Omar/Josef authored [v1] of the patchset from September 2023.
I understand the intent was to utilize the last byte. But yeah, I
think it's perfectly fine sticking to 4093 bytes limit as other FSes
do. I'll drop the +1.

[v1] https://lore.kernel.org/linux-btrfs/912762ca48efcc684cd5cdde99b5a78cd25f1078.1695750478.git.josef@toxicpanda.com/

> > +     if (IS_ENCRYPTED(inode)) {
> > +             ret = fscrypt_encrypt_symlink(inode, symname, name_len, &disk_link);
> > +             if (ret) {
> > +                     btrfs_abort_transaction(trans, ret);
> > +                     btrfs_free_path(path);
> > +                     discard_new_inode(inode);
> > +                     inode = NULL;
> > +                     goto out;
> > +             }
> > +     }
>
> fscrypt_encrypt_symlink() already has an IS_ENCRYPTED(inode) check
> built-in.

Correct. I'll drop the check.

> > +static const char *btrfs_get_link(struct dentry *dentry, struct inode *inode,
> > +                               struct delayed_call *done)
> > +{
> > +     struct page *cpage;
> > +     const char *paddr;
> > +     struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +
> > +     if (!IS_ENCRYPTED(inode))
> > +             return page_get_link(dentry, inode, done);
> > +
> > +     if (!dentry)
> > +             return ERR_PTR(-ECHILD);
> > +
> > +     cpage = read_mapping_page(inode->i_mapping, 0, NULL);
> > +     if (IS_ERR(cpage))
> > +             return ERR_CAST(cpage);
> > +
> > +     paddr = fscrypt_get_symlink(inode, page_address(cpage),
> > +                                 BTRFS_MAX_INLINE_DATA_SIZE(fs_info), done);
> > +     put_page(cpage);
>
> This uses a different max_len from btrfs_symlink().

I'm not sure that matters. But unifying them shouldn't hurt.

> Speaking of symlinks, btrfs is also missing a hookup to
> fscrypt_symlink_getattr().

Uh, I was not aware of that. It seems like fstests is missing for this feature.

Thanks a lot.

--nX

> - Eric
