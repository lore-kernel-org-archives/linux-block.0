Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0F54DAC0
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085972; cv=pass; b=nji2Q8OA+q9E/KfmSxo8AJDVqYLorB0P4orn4S78elOauqupzXTpOa5epy9PK+6TVcYfSqvdjbCjtKAGpn0xiPObyECeG8/syoGWL3gXFzvACuK4dGEbu+AeIcjhvsqGm3BZe403hbUgs38ofbjB6pk0HNgtL65NNZDJ5bYveu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085972; c=relaxed/simple;
	bh=6V0JdsZmrDPONncSpMZX6xqR02M8d8On8QjmlhG5X+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2H+bK4uTCQ/LbsdheNAqKxaOwTsdruHqQ5k83XEFbuKDDdnMmJGosGWen/dDe0z420JrvQAN77gVppKJncC3WORdrAS4uWj2uNRXwWePH5mvWLQx+O8a8ZrYYiHV5H57udAcCwAUVpYKrjnMYsHh2qgMlWTXvDSWEVdh5t7/8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ET408zLj; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ET408zLj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so29222535e9.3
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085969; cv=none;
        d=google.com; s=arc-20260327;
        b=O27Xq6FvBDrEydkGeXzwWVWwXTw8QUzW3pSURLwiOMlk0IpJ65Y+DSGB74Z/8ri2Nm
         PWWA5KtlByaclnbbwHDJjVDa6mCc7TZYqMbX5279UxFCL3U2w27vW/An4T5PKs33H58D
         bP6M5JzHRVKjZiLwmgHHNErUdWznYEMsnSFe3B+4L78UgLu3pIju1cqvdAuxBNnlPiTf
         jrip2aaX6OtHhVkwHsKwox3JqhV5QoXgUE/YsTsL//P4xnbUAB/A8J24ZCSLq2nzGTHC
         s9l9MhbUBYGc1LQwzVj5qfAJFcIPa2kAINWFb13M7xjR3BLmj4N5jRjZaDKaHavofZ5u
         qcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=99HU+/JZi5dG2Cu1dueoA580pKUbZlE9+G71ugT35kg=;
        fh=+YxF6K3CG/KXj8JtnXEl8lY4vj823Gnt9M1/W5UpqOc=;
        b=KhDE5Y9zwJ3nAC6PNLLz2NtViWv+jXjFTekrpIbq7Oo2ygdFwWRvBsOV+Suq8Cc5v3
         0tUgkvi5dcRl3nLov/hXjv5uNyfScD86jLCKB0zY+qZOhyT2SQUkWoQERS4GVtQQ4R0V
         B7v74T8QkVzbgn8lNciFmWi5kUEKU9SzuyeigqWQ223JyQZ1Md34q9GpUiGW0mVeQIAq
         Z8n5T34HmVVT6aYZK85dm86J4Bw9flW2WnLggBdbR/5N4t/n/TqjG0vCBuKYyq6nm8Fy
         vtJRp2t/RpW06wkitXpphAyvXDpR++ZaZvW/nYnxOG8gqye5KI2O5f/gAZ7v+VurBlUF
         Mf/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790085969; x=1790690769; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99HU+/JZi5dG2Cu1dueoA580pKUbZlE9+G71ugT35kg=;
        b=ET408zLjAzvCPY64foMxS80uN54uNuNIF6r4skc1oJu90iQbUarD8nhoXqWzkmWAhP
         OzdJ5SUo1qsNughomVYW4y3WageEMhf7g2TKk7Pj7NBIGWZITCafBLL445mCuVOYthBh
         A1C3YWvlMmt70ZJWhzmwhu+Ea0Pm26tvuWp/C7AOQ5B4sMwZGIZnuzK8qYiVQrcDyL5T
         YEZOVdbOCy31oUw1NwqNUH32rEsc4Jl0wWhKRxmhEld4/awf2LbVbWGX/sAXj9+262pr
         NqfMsnnyQ+k6fVEiZhuySOc6iy5v/62FKHzsDsmw0nFaS6lIAYqhPSt7wyRiAYiAFcfl
         ruGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085969; x=1790690769;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=99HU+/JZi5dG2Cu1dueoA580pKUbZlE9+G71ugT35kg=;
        b=M6yuhPhRvyQl/07IK68jMXJ+ZIUyzBS7cdfupi83lK/jxbUg529X/fSGcGn2AeaQ7P
         a/dWVn3MiUuBumAqhfHNuefc2PnSTXvMV2z2L5PbJF7CpumWF80ltyhB1F7dh7ni3l7M
         nXAFC7O6n2lQmzTOrzHoLhPykekagKqC/0lAchEgsyvVb0DI0gLhsZX8YXAgqE75shgh
         uFORWuEDct6ZX+laW+hEISkQiLq/I0ZWfrlEBY8b86gXWABKOmsVO6Bxoqito9/pyEO1
         Ln6MPYKzYJOsX3kYzYZVD4xGRNK3d5538ELzYPSj5YVFt1+JkfMTc5w0Ai3QkWQPC7/V
         mYEw==
X-Forwarded-Encrypted: i=1; AKwUvBzTk1ipr93xyiD5UsbWltCrF5YI5LEIYjtfJtR/N69om7qjRGg5iOcraZMql0tNma/0dgpnRHYVSAEOFA==@vger.kernel.org
X-Gm-Message-State: AFuF++n/kOn2n7J+wDKDf8tRhwv4u5s0IMEOA9HkEsv+FtyluEtPdza6
	2R1JVBf4mop66O4pZJzqpWU/E/zY+7YScP4KG8cwL0iBTQI32wjpcNL7jLRIIU3oj2VvvtgYFiA
	MA6jOoSP/zzueSm1+C0ubYn5vRcuqclacKeK9J6D2MDjqW2o+lLwBK4s=
X-Gm-Gg: AYBFou2E2Si2xZdlPMFrTrZhAUkL7VEgiC2ikxRcuzyIjG5yXQ5vFOZ8qa0iFPhm3o/
	e0TBdBshu7MQgO+z5rpsDNWDupj1yqy2eekj8QQjw1UHjvrH2021m4c7yaIbr2zMFXEcWKyU0DD
	Y4wdlplMvNP9GmqRKCEsl0QSx9ofMni9ILokU1ZQuxLszUeOqRbmi1XeHwG0DrbFlsw4AOV5j0G
	ZJybr9WNIUBah+uJz80dIVHoJd6ZJ1wZUmVKY5H9tXM6b/civkRvpEAy5kDa1nxq+MUuoioLBH/
	FgujstNIYFkmCv6W/w6vk4cvMEXg/9tj38fJmi5nO7fpp8xOsqHgtUj/9XDdO7gTz8STIPNqiJ5
	OBy4W0izjg9dMvGpJ7s9/hTb6suCEYql3OtjPdUwPO/MtmnZZDicd
X-Received: by 2002:a05:600c:8b81:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49fc568125bmr178646965e9.7.1790085969364; Tue, 22 Sep 2026
 07:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-37-neelx@suse.com>
 <20260602024253.GD2295@sol>
In-Reply-To: <20260602024253.GD2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Sep 2026 16:05:58 +0200
X-Gm-Features: AclHuK94ZowdPkv8oLMNoMqk3wQaTqmzoE8-Amh55RA3X3wy5PPxpE6ut7cEYZ4
Message-ID: <CAPjX3FdyCWLszDifMeEuT=x=QScr8K-dKsHCyD_bJOxOSQEnMw@mail.gmail.com>
Subject: Re: [PATCH v7 36/43] btrfs: deal with encrypted symlinks in send
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 04:44, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:53:10AM +0200, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Send needs to send the decrypted value of the symlinks, handle the case
> > where the inode is encrypted and decrypt the symlink name into a buffer
> > and copy this buffer into our fs_path struct.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > No changes in v7.
> > v6 changes:
> >  * read_symlink_encrypted() reworked from using pages to using folios.
> > v5: https://lore.kernel.org/linux-btrfs/4d97f35d6f85ff041b09bed33b63446a92b7a20c.1706116485.git.josef@toxicpanda.com/
> > ---
> >  fs/btrfs/send.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 89d72d8cb85f..d5256c22fe7a 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -1701,9 +1701,7 @@ static int find_extent_clone(struct send_ctx *sctx,
> >       return ret;
> >  }
> >
> > -static int read_symlink(struct btrfs_root *root,
> > -                     u64 ino,
> > -                     struct fs_path *dest)
> > +static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino, struct fs_path *dest)
> >  {
> >       int ret;
> >       BTRFS_PATH_AUTO_FREE(path);
> > @@ -1764,6 +1762,47 @@ static int read_symlink(struct btrfs_root *root,
> >       return fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
> >  }
> >
> > +static int read_symlink_encrypted(struct btrfs_root *root, u64 ino, struct fs_path *dest)
> > +{
> > +     DEFINE_DELAYED_CALL(done);
> > +     const char *buf;
> > +     struct folio *folio;
> > +     struct btrfs_inode *inode;
> > +     int ret = 0;
> > +
> > +     inode = btrfs_iget(ino, root);
> > +     if (IS_ERR(inode))
> > +             return PTR_ERR(inode);
> > +
> > +     folio = read_mapping_folio(inode->vfs_inode.i_mapping, 0, NULL);
> > +     if (IS_ERR(folio)) {
> > +             iput(&inode->vfs_inode);
> > +             return PTR_ERR(folio);
> > +     }
> > +
> > +     buf = fscrypt_get_symlink(&inode->vfs_inode, folio_address(folio),
> > +                               BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info),
> > +                               &done);
> > +     folio_put(folio);
> > +     iput(&inode->vfs_inode);
> > +
> > +     if (IS_ERR(buf))
> > +             return PTR_ERR(buf);
> > +
> > +     ret = fs_path_add(dest, buf, strlen(buf));
> > +     do_delayed_call(&done);
> > +     return ret;
> > +}
> > +
> > +
> > +static int read_symlink(struct btrfs_root *root, u64 ino,
> > +                     struct fs_path *dest)
> > +{
> > +     if (btrfs_fs_incompat(root->fs_info, ENCRYPT))
> > +             return read_symlink_encrypted(root, ino, dest);
> > +     return read_symlink_unencrypted(root, ino, dest);
> > +}
>
> This just assumes that all the symlinks on the filesystem are encrypted,
> without checking the actual encrypt flag in the inode.
>
> Of course, looking at the Sashiko review for this patch, it already
> found this, as well as a use-after-free.
>
> I don't know why I'm even reviewing this.

This is unrelated to fscrypt; it is internal to btrfs. Btrfs
encryption is experimental and under development. Not all features are
ready.
For now, btrfs send is not implemented or supported and it returns
EINVAL with an error message in the log before the code even reaches
this point. So far read_symlink() is never called on encrypted FS.
Yes, it can be improved, but it was not a priority right now.
I am really grateful for your insight as I am not familiar with all
the fscrypt internals. And don't get me wrong, for the next version
I'm also addressing the points Sashiko raised. I am sure we can all
work together to get btrfs encryption into a usable state.

--nX

> - Eric
