Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA33D9DAC
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452444; cv=pass; b=N1UZvlwGq7ASbOt78YOT2YdZPFgIQpeKyxCa3HX3wGUl/klHWmcoZQKadSPtFwpJxV7nvn3eCoPDnKHcQeh/oCqSqdnNzUrkL1Jn1Mnyge/ey1wvqgY4njlkY5lw6szc/+BSe5mvweItp3eEjoKIdaAcucu2kh5tXfAu28mseO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452444; c=relaxed/simple;
	bh=gvTYV6danPBvrbbKycCsMx9z3+3xksJLdC9fppoaH9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASIJkr93bahNB1Cn/X9knlol29G6FmwdKBnP2znkW4n3nFUg/DHkzOxNeafw9DPhwBkVCaTwxbsGmZOBlaW8qUeEw7wGEMes+yyGkVXI24lKHK9MJKHoJkxUp1l0GOa+sT/b/o4gvU09rQOI12EPjTsViAyzFSLKrwK0AcjIWrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AEXc+gia; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AEXc+gia"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5509393f8f.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 08:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774452441; cv=none;
        d=google.com; s=arc-20240605;
        b=L1rzDUlykIYkUOOFX+ODdk0hvRJotOs43XSHRsaIjHW59BJ0Dk1wSsin4KEu3lxEmM
         jvBL8U3Bv88DJPzu5SuJMZUGNAJk0o5eILwVrvY9YwRPQOi9vFg9SzBKU0agGmihdzSt
         XLESmbcDfJr4tU/LW75u5gz/6MrhUAPvmR36TryqogUzVCpVpZhjP4Tw/lZdqfIK6D60
         gwQXsnIpWQwGmshi1ksuuqexJSTMhXnVrhps9R9BC8h9H6eTghn5jjarqSqGi7Ft9zTZ
         qQt7mG9ov3F2qHuakx+4s33DRQ+7EcwVeOeFHkvuO8dNj1meMbdTS3gij6AyORyrbwEC
         +bBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dWX1QioYHvYuj0Wi+UEogcC2o0+HVIkdhxi+oA65LkU=;
        fh=X5pIBqC2Tiyf2aLKBBGTwrueKWkKbVZww8LOmAngZVk=;
        b=HLYRNcrWOjjMpWYNyjcMlUsWsisnZxSPTb3SjsEcrjcOUL+Y+tdXxvj6xWrObz8CKb
         f4Bwqds+JjHvFkTmnI8ofCAYzR0Eizi1EJoEa9MGwpJHAc5jCX2DvnPESj34/FXSdfyT
         +mDU6Ezz/ReY/oWTyEUMiKqKLVMNlzAIj9DeOh8Y1IFaUYWyjDe+6NpNQZcSZQmy+WTW
         DiGYYt6JWxedy47VY3DL684hSheDb9O1/uSOPPMG3ALzaanvL0lJovO+f1wSZ2EM8tx2
         +aeWgjqhPUeTsBsBk1tQ0g1QgAvFlxUtGP/3T/6bIsVucq+HI6WJ+CGUMyEn8+Mq1+Fo
         9Z9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774452441; x=1775057241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWX1QioYHvYuj0Wi+UEogcC2o0+HVIkdhxi+oA65LkU=;
        b=AEXc+gia4X2WLrsXhq+ccPCtrdadkzFqLhLeTTsWZF8bpUj/GXTEskGg0mLZrNfkSQ
         JTxIxfwUUtVmEkTp+p/XdRf4aBQHw4dLLa7VD9I+xhqdI8OMhDNA6wRxa+ihrFtfAyeU
         tsW4DPcoTLmEdeMUtBlR6SaGNeaW0rFq2MG8tLlXqM2mwX17jVnCDc0bXFg/KuXzAstc
         lDQGzmI36TJyyp1W0K3qOmq3HkVkfhOIlLfaN4I1aGCQ7IPpZ+bLP61gGiUgEPMVEpgB
         41VZEns+2sSHjOjGbE+ZpQgSW5dSlgsqz/N3j1WAUMrxdtUqMh93KP/qMfB/7yZnyn/Y
         cLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452441; x=1775057241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWX1QioYHvYuj0Wi+UEogcC2o0+HVIkdhxi+oA65LkU=;
        b=bR+PTJ6nuVRDDY8Hn9MY3SlCQNnRGfmeBlAnZA9SnQQC6UQX5w/qNcITh5LV02sGeE
         Kp015qCpDDw6OeCURDbTyZvu6PMHYSpaZioejnglWOigxNFdmrvPDJOQ2DViWHDZBWCV
         gF2xzr72tgBIpjzUQM1RGv8SNmLO+/Cyy0dHV3nFYRq+gwXnWmJKACBdv3Vi/fOAZp81
         rHuTxdD0LusdOcxbPlKUIDyCoV/mSy+htNwvC5/7bedk9laoxqIubFk5h9ATRFqQKUHb
         JpPX8O85Y5bv2iBYynDvTdhkFNwfNVFYZoqaCXasZB0L58O9GNENJSmGGqslPaApl28y
         goCA==
X-Forwarded-Encrypted: i=1; AJvYcCXY3CnozAJaRdYF7QFT7Nc5tgYWdOhW/1XD49GlCLqJHvn6EC1wj9QbyKg2rVFIQi21MAcvuV+HInaCrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOcIWqlMNEgt0SJkczjG8I4oiXVA8VOxVicFX/gzveg40CnLJ
	KdohvkFA/Aah6BJAx6zNppoJ3IaJplzsWgR4XFMGD93ZDJrzh96ttgtQWFC3rTIxnxEBjGDsv+5
	HZdUma1IiSp8bePrqCzdYfN1ZDNYIIuZawT0aur3DbnXyTzURkTxxJHvj/Q==
X-Gm-Gg: ATEYQzxJP+bAhpC6TddPGNldQvJoOx8bny8ABCTHDztbcDd2wdu1Rk1GJH6hOiHq6Na
	mzW+RYJB9AQPbXddrStfoJZuCoFOMm5hAye9RZkgvTYOFVAGJbbG9UA9KnizOhl5i/WWQZxm3Vk
	lgfMJO/NXaI4QV4jagyW7x4MRx88S94YzWmBRwK98xJUsRGXZxKIZEiif504yofN/tR1XEuA5EB
	Q+rWm8j81PNNcRldHj/xmjl+z5jKsvBwR+lb21dLTiHTQUNiKOHxbP/NHski9y+KgthR4o8s4PN
	J6GD8BReN2ByMV/0H9MUCB1Pxce0BX+f2pCQnKhsO4Qn6+5frW+I840w4jkR6DQF7YNYgBsi1Fu
	xvYUB
X-Received: by 2002:a5d:5f92:0:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b88a1d79emr5535228f8f.45.1774452440680; Wed, 25 Mar 2026
 08:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-36-neelx@suse.com>
 <20260208150339.3021113-1-clm@meta.com>
In-Reply-To: <20260208150339.3021113-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 25 Mar 2026 16:27:09 +0100
X-Gm-Features: AQROBzAFWXwvrixpcNfzyjbXsLbgIekQDOVglJXPaG63xqqZ-H6T96gnhiEXVX4
Message-ID: <CAPjX3Ffn_Q1mPs3-6ZpdOTrp6i=2c8ZiJSyR9Mu_MTe_=OQjnA@mail.gmail.com>
Subject: Re: [PATCH v6 35/43] btrfs: make btrfs_ref_to_path handle encrypted filenames
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:04, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We use this helper for inode-resolve and path resolution in send, so
> > update this helper to properly decrypt any encrypted names it finds.
> >
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
>
> commit 473bbb12052f731a4e2ce3c48e7d7e9f2510528b
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: make btrfs_ref_to_path handle encrypted filenames
>
> This commit updates btrfs_ref_to_path() to handle encrypted filenames by
> introducing a new copy_resolved_iref_to_buf() helper that can decrypt
> names when the filesystem has encryption enabled.
>
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 9bb406f7dd302..577c3ef87791a 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
>
> [ ... ]
>
> > @@ -2107,6 +2108,39 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
> >       return ret;
> >  }
> >
> > +static int copy_resolved_iref_to_buf(struct btrfs_root *fs_root,
> > +                                  struct extent_buffer *eb, char *dest,
> > +                                  u64 parent, unsigned long name_off,
> > +                                  u32 name_len, s64 *bytes_left)
> > +{
> > +     struct btrfs_fs_info *fs_info = fs_root->fs_info;
> > +     struct fscrypt_str fname = FSTR_INIT(NULL, 0);
> > +     int ret;
> > +
> > +     /* No encryption, just copy the name in. */
> > +     if (!btrfs_fs_incompat(fs_info, ENCRYPT)) {
> > +             *bytes_left -= name_len;
> > +             if (*bytes_left >= 0)
> > +                     read_extent_buffer(eb, dest + *bytes_left, name_off, name_len);
> > +             return 0;
> > +     }
> > +
> > +     ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = btrfs_decrypt_name(fs_root, eb, name_off, name_len, parent, &fname);
> > +     if (ret)
> > +             goto out;
> > +
> > +     *bytes_left -= fname.len;
> > +     if (*bytes_left >= 0)
> > +             memcpy(dest + *bytes_left, fname.name, fname.len);
> > +out:
> > +     fscrypt_fname_free_buffer(&fname);
> > +     return ret;
> > +}
> > +
> >  /*
> >   * this iterates to turn a name (from iref/extref) into a full filesystem path.
> >   * Elements of the path are separated by '/' and the path is guaranteed to be
> > @@ -2138,10 +2172,10 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
> >               dest[bytes_left] = '\0';
> >
> >       while (1) {
> > -             bytes_left -= name_len;
> > -             if (bytes_left >= 0)
> > -                     read_extent_buffer(eb, dest + bytes_left,
> > -                                        name_off, name_len);
> > +             ret = copy_resolved_iref_to_buf(fs_root, eb, dest, parent,
> > +                                             name_off, name_len, &bytes_left);
> > +             if (ret)
> > +                     break;
> >               if (eb != eb_in) {
> >                       if (!path->skip_locking)
> >                               btrfs_tree_read_unlock(eb);
>
> Does this code leak the extent buffer when copy_resolved_iref_to_buf()
> fails? Looking at the loop structure in btrfs_ref_to_path(), when
> copy_resolved_iref_to_buf() returns an error and we break at line 2178,
> the cleanup code that follows never executes:
>
>     if (eb != eb_in) {
>         if (!path->skip_locking)
>             btrfs_tree_read_unlock(eb);
>         free_extent_buffer(eb);
>     }
>
> This can happen in subsequent iterations where eb != eb_in (the extent
> buffer was detached from path->nodes[0] and set to NULL in the previous
> iteration). The cleanup at the end of the function (btrfs_release_path()
> at line 2216) cannot free eb since it's no longer in the path.

Right, the break should be placed only after the cleanup.

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2174,13 +2174,14 @@ char *btrfs_ref_to_path(struct btrfs_root
*fs_root, struct btrfs_path *path,
     while (1) {
         ret = copy_resolved_iref_to_buf(fs_root, eb, dest, parent,
                         name_off, name_len, &bytes_left);
-        if (ret)
-            break;
         if (eb != eb_in) {
             if (!path->skip_locking)
                 btrfs_tree_read_unlock(eb);
             free_extent_buffer(eb);
         }
+        if (ret)
+            break;
+
         ret = btrfs_find_item(fs_root, path, parent, 0,
                 BTRFS_INODE_REF_KEY, &found_key);
         if (ret > 0)

Thanks.

--nX

> This could be triggered when decryption fails in copy_resolved_iref_to_buf()
> due to btrfs_iget() error, fscrypt_fname_alloc_buffer() ENOMEM, or
> fscrypt_prepare_readdir() failure on an encrypted filesystem.
>
> Before this patch, the name copy operation (read_extent_buffer) could not
> fail, so the cleanup always happened before any error check.
>

On Sun, 8 Feb 2026 at 16:04, Chris Mason <clm@meta.com> wrote:
>
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We use this helper for inode-resolve and path resolution in send, so
> > update this helper to properly decrypt any encrypted names it finds.
> >
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
>
> commit 473bbb12052f731a4e2ce3c48e7d7e9f2510528b
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: make btrfs_ref_to_path handle encrypted filenames
>
> This commit updates btrfs_ref_to_path() to handle encrypted filenames by
> introducing a new copy_resolved_iref_to_buf() helper that can decrypt
> names when the filesystem has encryption enabled.
>
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 9bb406f7dd302..577c3ef87791a 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
>
> [ ... ]
>
> > @@ -2107,6 +2108,39 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
> >       return ret;
> >  }
> >
> > +static int copy_resolved_iref_to_buf(struct btrfs_root *fs_root,
> > +                                  struct extent_buffer *eb, char *dest,
> > +                                  u64 parent, unsigned long name_off,
> > +                                  u32 name_len, s64 *bytes_left)
> > +{
> > +     struct btrfs_fs_info *fs_info = fs_root->fs_info;
> > +     struct fscrypt_str fname = FSTR_INIT(NULL, 0);
> > +     int ret;
> > +
> > +     /* No encryption, just copy the name in. */
> > +     if (!btrfs_fs_incompat(fs_info, ENCRYPT)) {
> > +             *bytes_left -= name_len;
> > +             if (*bytes_left >= 0)
> > +                     read_extent_buffer(eb, dest + *bytes_left, name_off, name_len);
> > +             return 0;
> > +     }
> > +
> > +     ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = btrfs_decrypt_name(fs_root, eb, name_off, name_len, parent, &fname);
> > +     if (ret)
> > +             goto out;
> > +
> > +     *bytes_left -= fname.len;
> > +     if (*bytes_left >= 0)
> > +             memcpy(dest + *bytes_left, fname.name, fname.len);
> > +out:
> > +     fscrypt_fname_free_buffer(&fname);
> > +     return ret;
> > +}
> > +
> >  /*
> >   * this iterates to turn a name (from iref/extref) into a full filesystem path.
> >   * Elements of the path are separated by '/' and the path is guaranteed to be
> > @@ -2138,10 +2172,10 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
> >               dest[bytes_left] = '\0';
> >
> >       while (1) {
> > -             bytes_left -= name_len;
> > -             if (bytes_left >= 0)
> > -                     read_extent_buffer(eb, dest + bytes_left,
> > -                                        name_off, name_len);
> > +             ret = copy_resolved_iref_to_buf(fs_root, eb, dest, parent,
> > +                                             name_off, name_len, &bytes_left);
> > +             if (ret)
> > +                     break;
> >               if (eb != eb_in) {
> >                       if (!path->skip_locking)
> >                               btrfs_tree_read_unlock(eb);
>
> Does this code leak the extent buffer when copy_resolved_iref_to_buf()
> fails? Looking at the loop structure in btrfs_ref_to_path(), when
> copy_resolved_iref_to_buf() returns an error and we break at line 2178,
> the cleanup code that follows never executes:
>
>     if (eb != eb_in) {
>         if (!path->skip_locking)
>             btrfs_tree_read_unlock(eb);
>         free_extent_buffer(eb);
>     }
>
> This can happen in subsequent iterations where eb != eb_in (the extent
> buffer was detached from path->nodes[0] and set to NULL in the previous
> iteration). The cleanup at the end of the function (btrfs_release_path()
> at line 2216) cannot free eb since it's no longer in the path.
>
> This could be triggered when decryption fails in copy_resolved_iref_to_buf()
> due to btrfs_iget() error, fscrypt_fname_alloc_buffer() ENOMEM, or
> fscrypt_prepare_readdir() failure on an encrypted filesystem.
>
> Before this patch, the name copy operation (read_extent_buffer) could not
> fail, so the cleanup always happened before any error check.
>
