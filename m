Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D71284890
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423551; cv=pass; b=bTxMAyEiKsQrYXm2COv6qdI/k/5nlzwnWjf5T9ZaB/9yfzBSz5xisg7dNom0Cs+rQGGvFjjNBfznUh5YA0gOB0xQXSBht/todNf4NvE0QlRUW1pVb5/uEwZA7mo6SWW83sazF/TvsoN3AQ5nQ3AgIcaZYQvTYyPXDFBxQU+SsPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423551; c=relaxed/simple;
	bh=0IPQfandQcQcgM/09gru9lXRdDMyChSp6OWGiSUPAb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlT37TQXUuPf76LpmT7L1zuWanViEqi4NMP6g/OpfBqysRdIJ7HmVLCCqAd4PXlSdKiTwCyfJq8+9rcnc3KqIr+ADD9kIjCC0RFtw914/VGR/VUj6WBzY3x1RHxq8BJqLBzIdlOQ6D0sfn6kKLsiFsgEY7BI18i6BKH4X6yfEsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dyNzfm15; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dyNzfm15"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso34355605e9.2
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 06:05:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771423548; cv=none;
        d=google.com; s=arc-20240605;
        b=f6yVILrCCSG29O8JgXjmmsJmWDcpowf8Cizii4q4psvCCFG5svHoPIrtacfL0vgDAa
         olbYLu4GqZ/AvsQvsUL/lLXQ38CUywiS0bxLNZ31wArIbQHME2a4+DV9rQNA9q+4Bxl2
         L6NSm1Wkx5K2DETN15bdYiWJmWsj+pEtGXG9U4/foRSKpOTjypNVxj9n9yAhTmhdvQT0
         BLESOMc1X+htTvJCuCGTuVSDxWNvyLqJsfeaWXGdL7XA7s88meSUKUee+DRoqP+cGFTD
         BBn2QKzjggzBg3mWQhJdMRipMTSCf93Pux5uJyMT3NV/SJSMpFZH0Qo/+nWq3nxfQGxg
         6okA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        fh=XuZAMNlo0DApLagR0H4TDdFUwOsoap8nyehmwEI//6U=;
        b=PdsnLspiBtWHGNwfiIbt8T+h3IbFsBC39LuCkWE8/oJR4yk+tp/8DFi03k3AJlU9mq
         F6e47qfTVsuWE/75qsdTBgixd17tRLwfUE04QujX8xpbi2ZljCR69TEIdg8NPNOUpQF+
         boiJaspOX1t4PKpGWC3mrCL7mYoiqFeagB0vbwYYhih6Wxa34hHMUle/l6vaV3zxS6Bs
         rQcRjvkkJ/0zBsF24X6RSTB9hgNlkY11RhxH4hhxuyFajsDPFXNIbDLcl9a7jbWI7ACX
         H6pzyPMXnxcWh2WuIPJZttqFc+DmOObQO3FjzktpQkvONB4qWO3ZhW+OJcn0EuQR+kjy
         kt/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771423548; x=1772028348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        b=dyNzfm150yPWPRdOJcw6LyIJ4XntfMbNBXzov9rUmvcdHnJDvKWPkDWKM3TztbQvkE
         pzEt9TUbqJp65oD4B77ioqUynrlzYLn4RZ+H64gYMUrB2MeWJd4s1rIK5JbOW2RD43UE
         st7c9uQNIxiivA9EkzF1m38q0WkSvzgO2S2AzbYTuGk62vGvKWPRdnMxX+FTPBDarXgB
         p9MkVWtwB3vh5JcDYLpxCA1oyzao1FNWEPWfybwJCOoybp6PybozGDyn40WyaQVRyAbm
         ireEeWHy7PjmfuVBZX7ScZguZ+rcLi2uPECCeyQ3ZK4tQ+rg9aL351fOslGxCqx14fCf
         j4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423548; x=1772028348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        b=Rk2jDOcx3mpQUiQD9ZdprBSvddLK187wXk6KKDDjA5k/Je+bCDGWmoA1PweCYmUTKv
         xL5SgG35fU3NkRXZOmnScdx1MhByrpzQ+UcODXwg4RD/eEsw3evTuUctYqo4/9izvO5v
         NRahR/GVSWhXqBXZnhmf69VNDLMQqKQkT6LMEEk0gyyNiI2Ea7EDo9oCZSour5pda2+T
         Suf955WchvXXUSN64oGCi9VResB3Koh820s3FfHSwI7VTOZc0lk4iUAXrPmxW+xFI0Jl
         AAiZvrwphRHXmKYYUSjHYqx7JDSSnnMLfG2DF82NnrWihJyjMqsfR8VMpPG2esdsY7dt
         Mlmg==
X-Forwarded-Encrypted: i=1; AJvYcCXvb4PEK3s7VXF6wVYWSk6Y5prhkg5fQM48fWuNJBM8bpwzYaTFoljqB8w+tfHZ+LCbg7UdrPkpS4/R6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSZ9AXXfjd7gV4bzXOHkDAA064h7RlFz9nveETYn3A23gOxq+
	5e3tTjQ40IfNjaGMxUq/KEUUuanJbfoKTXyZZ2qV5sLb7+k0J0HJDu+NTKNEXtYotZPuPjFJD4F
	I6tFQ6Fe+BnNYPBjVBDL38sdQSEAO33pnqi1WpKPBRA==
X-Gm-Gg: AZuq6aLo6qocanbM8lC4zL9N2NI/Hj1SmVPJ40ocVKBrH2dhDeR/IVnoGCgGTPxB2cD
	496egNz0HpGGDd4lelcZKdedOyesvHyEerww3eX5i2tFv/1RgXzy4CjHGdmyfxVNJ7mAUAGixuA
	yeLg3ukHQaQEii4vbAG0fPRYEC3gCkFI07krIKGPZPzGI1IuY16L2YDZdo1nIX7ot9U0O7sYQY4
	2fnTT+bzVXs2xzDoTSPqtZuf+OGVdmYF+J9HQBpS90PVVzBtGB7eHL9rN1PzsQq2xnAXlq8o8vP
	BCY/v5zXiii+O9zDXaiBvstp4abtnwSfq4neosuV7zaGW4Qv0I+/RWmAE6Q5U19blwSQsektb2C
	TW//o
X-Received: by 2002:a05:600c:6912:b0:483:709e:f22d with SMTP id
 5b1f17b1804b1-4837108fc46mr300110235e9.27.1771423547925; Wed, 18 Feb 2026
 06:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-14-neelx@suse.com>
 <20260208153607.3466929-1-clm@meta.com>
In-Reply-To: <20260208153607.3466929-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 15:05:37 +0100
X-Gm-Features: AaiRm510tlnOinFS7nG7T90JA_M8mhwdBINiTRaMYypuSLi3O4tUUbZEt6vztBA
Message-ID: <CAPjX3FdE9nLWE12KRxpXyj9Hy-Z1JSmWcDMBgT0fuyQsfafAHw@mail.gmail.com>
Subject: Re: [PATCH v6 13/43] btrfs: adapt readdir for encrypted and nokey names
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:36, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > Deleting an encrypted file must always be permitted, even if the user
> > does not have the appropriate key. Therefore, for listing an encrypted
> > directory, so-called 'nokey' names are provided, and these nokey names
> > must be sufficient to look up and delete the appropriate encrypted
> > files. See 'struct fscrypt_nokey_name' for more information on the
> > format of these names.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit e264482bd61ca8096981d81cc5e7c839284ac969
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: adapt readdir for encrypted and nokey names
>
> This commit adapts the btrfs readdir implementation to handle encrypted
> filenames and nokey names, enabling directory listing and deletion of
> encrypted files even without the encryption key.
>
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 1739a0b29c49d..c19213fab3dda 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
>
> [ ... ]
>
> > @@ -1820,7 +1823,25 @@ bool btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
> >               d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
> >               btrfs_disk_key_to_cpu(&location, &di->location);
> >
> > -             over = !dir_emit(ctx, name, name_len, location.objectid, d_type);
> > +             if (di->type & BTRFS_FT_ENCRYPTED) {
> > +                     int ret;
> > +                     struct fscrypt_str iname = FSTR_INIT(name, name_len);
> > +
> > +                     fstr->len = fstr_len;
> > +                     /*
> > +                      * The hash is only used when the encryption key is not
> > +                      * available. But if we have delayed insertions, then we
> > +                      * must have the encryption key available or we wouldn't
> > +                      * have been able to create entries in the directory.
> > +                      * So, we don't calculate the hash.
> > +                      */
> > +                     ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname, fstr);
> > +                     if (ret)
> > +                             return ret;
> > +                     over = !dir_emit(ctx, fstr->name, fstr->len, location.objectid, d_type);
> > +             } else {
> > +                     over = !dir_emit(ctx, name, name_len, location.objectid, d_type);
> > +             }
>
> Does the return statement at line 1840 cause silent error loss?
>
> The function btrfs_readdir_delayed_dir_index returns bool, but
> 'return ret;' returns an int error code from fscrypt_fname_disk_to_usr.
> Since ret is negative on error (e.g., -EUCLEAN from fname_decrypt
> failures), this converts to 'true' in bool context.
>
> The caller btrfs_real_readdir at inode.c:6410 interprets true as "stop
> iteration normally":
>
>     if (btrfs_readdir_delayed_dir_index(inode, &fstr, ctx, &ins_list))
>         goto nopos;
>
> The nopos label at line 6417 sets ret = 0, which means readdir()
> completes successfully with incomplete results when crypto operations
> fail on encrypted directory entries.

This still seems correct to me. While rebasing, however, I missed that
the return type changed in 41e4ea0bf555 ("btrfs: make
btrfs_readdir_delayed_dir_index() return a bool instead").
If I'm not mistaken, we can just `return true;` here:

--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1837,7 +1837,7 @@ bool btrfs_readdir_delayed_dir_index(const
struct inode *inode,
              */
             ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname, fstr);
             if (ret)
-                return ret;
+                return true;
             over = !dir_emit(ctx, fstr->name, fstr->len,
location.objectid, d_type);
         } else {
             over = !dir_emit(ctx, name, name_len, location.objectid, d_type);

> [ ... ]
>
> > diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> > index 085a83ae9e62f..6e10dd4a4e9e1 100644
> > --- a/fs/btrfs/dir-item.c
> > +++ b/fs/btrfs/dir-item.c
>
> [ ... ]
>
> > @@ -227,6 +228,47 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
> >       return di;
> >  }
> >
> > +/*
> > + * Lookup for a directory item by fscrypt_name.
> > + *
> > + * @trans:   The transaction handle to use.
> > + * @root:    The root of the target tree.
> > + * @path:    Path to use for the search.
> > + * @dir:     The inode number (objectid) of the directory.
> > + * @name:    The fscrypt_name associated to the directory entry
> > + * @mod:     Used to indicate if the tree search is meant for a read only
> > + *           lookup or for a deletion lookup, so its value should be 0 or
> > + *           -1, respectively.
> > + *
> > + * Returns: NULL if the dir item does not exists, an error pointer if an error
> > + * happened, or a pointer to a dir item if a dir item exists for the given name.
> > + */
> > +struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *trans,
> > +                                                struct btrfs_root *root,
> > +                                                struct btrfs_path *path, u64 dir,
> > +                                                struct fscrypt_name *name, int mod)
> > +{
> > +     struct btrfs_key key;
> > +     struct btrfs_dir_item *di = NULL;
> > +     int ret = 0;
> > +
> > +     key.objectid = dir;
> > +     key.type = BTRFS_DIR_ITEM_KEY;
> > +     key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
> > +     /* XXX get the right hash for no-key names */
>
> Can this dereference a NULL pointer for long nokey names?
>
> When btrfs_unlink() calls fscrypt_setup_filename() with lookup=1 for a
> nokey encrypted filename, fname->disk_name.name is NULL for long nokey
> names (see fscrypt_setup_filename lines 370-375 in fs/crypto/fname.c).
>
> The call chain is: btrfs_unlink -> btrfs_unlink_inode ->
> __btrfs_unlink_inode (line 4396) -> btrfs_lookup_dir_item_fname.
>
> This passes NULL to btrfs_name_hash() at line 257, which calls
> crc32c(NULL, len), causing a kernel crash. The XXX comment at line 258
> acknowledges this is unhandled.
>
> Note: This issue is addressed in a later commit in the patch series
> (fabad1c3ea821 'btrfs: handle nokey names').

Yes, this is handled right in the next commit.

Thanks.

--nX
