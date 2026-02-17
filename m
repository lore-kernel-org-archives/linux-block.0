Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3734322B74
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342012; cv=pass; b=nf1tBEvhr1YHMxcl+V2CN3kBL4cnO3PdDOr+pP4nJZwLRUgTO/uJYz5t4afQ8o/tKPw/1lxRpgG3gaqb3lMSY8h+AtIkRT8UCdFKr4UWMncWHjNdL2vHy0kkVq6Y4U+VSNU0Wc5zP7DPhBDEA/EJWcSHVtIJMbh9VsPnhA5Xv0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342012; c=relaxed/simple;
	bh=QU9gfqo/KGzkYFSrwSgaxescpixzrT1ChZPSPllm5xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKKiHHzL31iJ6gg+WJTTNSmUfS2IqlWywmn76LW1tuCJsJqHSkQeYL7LBP4HGlBkSigjMthUHXwqLkDmRADs3Jt95Ae2Mup3YmbIp8p+Nvzcla/OLQGZ7H8G0oE+MgLbtPLiT3rdrUrPNxwaxxryhLHJjwFdYiy5SCp23/ZYI7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tfoa6DlL; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tfoa6DlL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43621bf67ceso2681629f8f.2
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 07:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771342009; cv=none;
        d=google.com; s=arc-20240605;
        b=Rrf8NiXEVU1Q/yE2nfso4710ftaGF9Po12GG3WjWo5Gp1gviiXn7ItcjtP0iYsLOAV
         owXPYNwM5l7fqE4NkfhI/RXFmQIhhL/e83euPE62diXCgAnMBFY64mEp7R2JUgXqvlI5
         jz4AsRMSSgDQD3WCENjKWNouJ2qv9Pc7ZpQXuL62SPCqZn6ILoAYiAiJZR59AxsrSRaE
         M7dSPEzLagNHwfIALERtKg9pIhkvJS+IjqQCFNh64SlQoPozHOuplRzzIQScYDWl4Er1
         TbY9Qj6fLCMoiXnRsJYTLafXG0fvIqCwl4M1RGw4yad53MvyZ9PIrJOZHUxbK5koEyVu
         NKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        fh=YB99W5VVD3YuYjEXB7rTPQKaFAO7ypX01Yz/6OYnD2U=;
        b=X4CEi3yXgqtfBxSu1YDhwwbCveD1004BXr6qu9QxRhpKZ386jrjHsN/3rzcaYwIqFo
         lcWSDlXZBVdJbVG7AfUOOQ3HqflL4vPSH1eoFSc36e9AAcJCZ3K4vcXzTMFyS0S4dby+
         a+ydZRy4i5AEq7IsDqhmoT8R//EYPXFPhjMHu0dnt1Lv81WWHoMXWOKd0riNEBvsavyB
         1yIGnZba7rWR395GYlfr5hpYCqwFl2nxwBt9QzDxHpY5iEmogrsLy9jaxskqr1fzg+VB
         eWuSyVxvyUEX45pAhL+sKKaoYsY8bHlI8ILRSJeftCKXdOeVduBdfXiyMidczbZ42HdK
         Dp2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771342009; x=1771946809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        b=Tfoa6DlLAeYMFJe1P9zNlaGNGLAcninuSHjbgk9TuOno+zCq1H2OodBzFSs2DjXmlY
         8+iaWSgz2DFwLDr0Qw3CeJ0zd+7quytkef1PAl6ZRbdqWFT5iUKJpkHx95vSiP8Z8Ku5
         2TsC9nQkvJEyNPp4P+SK6pgmPPKIziGavu7d71AYX0ZVMV8+shEm+R6V6LgGoIbqp03g
         Zvg8qKWQuaeP/Zng3GdsYzEoZ0LYxhlNHY7qXdm8SzQ4tNa52nia3HZa/IgMgkxRUVJ/
         ihGfgJqfsZbXLW41eriFyD5VVDgTRV5UvC5sfaD51IQuUJ8UBNFQSTdEA3ZhKa6sYyyK
         UWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342009; x=1771946809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        b=Ihh3FeJvidKZgDmOrQHbpbwiBZwVVlPgoMnDEnofD5IN+Eq4AchO6dhFJ63okPCC0Q
         tQT1feMOJh1V46ddGtN/gBXAUUXYhaZoH5G0lBbesstuACZ9gi22CVheGy+yzE+zxwHv
         1jtF2fGnrYWv9J6jjVB74o9DkfEJ5Rtkx2dP7rHPPuXAYlEFaePySpWwErYxt1Bb6NjN
         SpIiU2l168r5l7uxbl3MlCZZ4UdLGFsHQG/A4ZgsXQ3XllvOIdtH0TJ2cfASfP9w4f5r
         6e1OeyU+FBVpLUv3C+OkMa71AQedh3IHdqrkRUWV8+gx8862ebSxkIHAGr8DONAzeMq2
         6naQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8MQjO+rx6rzZed9BcWa3hGdIv9gFjCCAhrg1zbz48SyrIC+x8EAxPP0sTBW3bF6Y/+gb3394GiReZFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ePQdN7muh7mVI3flHoalw0JUBrYIyl4eqBH3q7x9wV3O+nnK
	cbXM81KMXdxPIWYaqnXIBJ0/F0ADnUSLTrVNpfWg4JOgw2rMH3z0HrBUkAtZwx1HTVUxExySN1+
	L46wlSOtkxuVPVQ/7ZibOarZDQoyDb4QhwOhqhpS2Yg==
X-Gm-Gg: AZuq6aIP/vhokaNkV9V2yVnb67nn8fSeeiP6v4zHGFOidPYvwBWPSoD+COPgLryjc2K
	3JBpVZZ0tVk9Qu0O387OuP4uR2muVr5dMRfecVmImtsXRhLXWZfDm1GLFYsNFfK9hR9FusciDHG
	ZJA9Z+9R3HwQbdKpkP/bKZJy//+KF59zpSjnKaVnycXkGvv2x3sPSYUauv3RAxrZ5hoYFxz776J
	brhxCzVvp4RjT/5SPNPRir/UGMjNGtUykPFiGrCuAaNW4NZ05jg4UQbXaNpXWe3FVXiFcrHQl4d
	JjMHziBwWOm3n4rZjECFGsl+LXzdkt1gHgeTwnpnRhWo3ZVnbcbqs7FgLneeA0URro/EkEdm2zN
	CxzIW77a0tTDmPxo=
X-Received: by 2002:a5d:5f94:0:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4379db263a3mr24419508f8f.5.1771342009087; Tue, 17 Feb 2026
 07:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-11-neelx@suse.com>
 <20260208154525.3580889-1-clm@meta.com>
In-Reply-To: <20260208154525.3580889-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 17 Feb 2026 16:26:38 +0100
X-Gm-Features: AaiRm520Z8Hl9bm0ivGx5cxjGTTyaohyph4iD5YmFA_17gCb_AqQi4Gw0P2mfxo
Message-ID: <CAPjX3Fd0mAMwust4F5VjS02sT4rE-OauSrEho9VSPPe5gi8WPQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/43] btrfs: start using fscrypt hooks
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:46, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > In order to appropriately encrypt, create, open, rename, and various
> > symlink operations must call fscrypt hooks. These determine whether the
> > inode should be encrypted and do other preparatory actions. The
> > superblock must have fscrypt operations registered, so implement the
> > minimal set also, and introduce the new fscrypt.[ch] files to hold the
> > fscrypt-specific functionality.
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
> commit 4d7d769810b1d47ec75a6efa0f691c43d9969b54
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: start using fscrypt hooks
>
> This commit adds fscrypt support to btrfs by implementing fscrypt hooks
> in various inode operations including create, open, rename, and symlink
> operations.
>
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b6c763a17406b..9d90e2e946fc4 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
>
> [ ... ]
>
> > @@ -6506,6 +6510,12 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
> >               return ret;
> >       }
> >
> > +     ret = fscrypt_prepare_new_inode(dir, inode, &args->encrypt);
> > +     if (ret) {
> > +             fscrypt_free_filename(&args->fname);
> > +             return ret;
> > +     }
> > +
>
> When fscrypt_prepare_new_inode() fails, are the ACLs leaked?
>
> Looking earlier in the function, posix_acl_create() allocates args->acl
> and args->default_acl. When fscrypt_prepare_new_inode() fails, the
> error path frees the filename but doesn't release these ACLs.
>
> Callers like btrfs_symlink() skip btrfs_new_inode_args_destroy() on
> error, so the ACLs would never be released. Should this add
> posix_acl_release() calls before returning?

True. Fixed with the below hunk. Thanks!

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6574,7 +6574,7 @@ int btrfs_new_inode_prepare(struct
btrfs_new_inode_args *args,

     ret = fscrypt_prepare_new_inode(dir, inode, &args->encrypt);
     if (ret) {
-        fscrypt_free_filename(&args->fname);
+        btrfs_new_inode_args_destroy(args);
         return ret;
     }


> [ ... ]
>
> > @@ -8994,20 +9015,28 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
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
> >
> >       inode = new_inode(dir->i_sb);
> >       if (!inode)
>
> [ ... ]
>
> > @@ -9044,10 +9073,22 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >               inode = NULL;
> >               goto out;
> >       }
> > +
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
> > +
> >       key.objectid = btrfs_ino(BTRFS_I(inode));
> >       key.type = BTRFS_EXTENT_DATA_KEY;
> >       key.offset = 0;
> > -     datasize = btrfs_file_extent_calc_inline_size(name_len);
> > +     datasize = btrfs_file_extent_calc_inline_size(disk_link.len - 1);
> >       ret = btrfs_insert_empty_item(trans, root, path, &key, datasize);
> >       if (unlikely(ret)) {
> >               btrfs_abort_transaction(trans, ret);
>
> [ ... ]
>
> > @@ -9084,6 +9125,29 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >       return ret;
> >  }
>
> Does this code leak disk_link.name when creating encrypted symlinks?
>
> According to fscrypt.h, when fscrypt_encrypt_symlink() is called,
> 'one will be kmalloc()'ed and the filesystem will be responsible
> for freeing it'. However, btrfs_symlink() never frees disk_link.name
> in any exit path, whether success or failure.
>
> Looking at ext4/namei.c:3443-3444, it correctly handles this:
>
>     if (disk_link.name != (unsigned char *)symname)
>         kfree(disk_link.name);
>
> Should similar cleanup be added here?

Agreed. I think this fixes that leak (untested):

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9196,7 +9196,7 @@ static int btrfs_symlink(struct mnt_idmap
*idmap, struct inode *dir,
         btrfs_free_path(path);
         discard_new_inode(inode);
         inode = NULL;
-        goto out;
+        goto free_name;
     }
     leaf = path->nodes[0];
     ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -9215,6 +9215,9 @@ static int btrfs_symlink(struct mnt_idmap
*idmap, struct inode *dir,

     d_instantiate_new(dentry, inode);
     ret = 0;
+free_name:
+    if (disk_link.name != (unsigned char *)symname)
+        kfree(disk_link.name);
 out:
     btrfs_end_transaction(trans);
     btrfs_btree_balance_dirty(fs_info);

Thanks again!

--nX
