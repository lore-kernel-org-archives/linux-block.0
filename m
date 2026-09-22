Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B453E2E5
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085924; cv=pass; b=jycBPu6HZKfmVyLkAR6xdQhdLB74cD24kEHi3hvy5s2SzD/EAnebtU2YgwCrl+3CSzSAmG6R2yHfS6jrEQsDE8UelG0jbNWeAjtKWehaF/Kphwj/20H9wu+faR9BAOgsoDY4QHlKqKwdkwjIFzQBEJKE1F6HFXQV9O4Z+MqHMl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085924; c=relaxed/simple;
	bh=u7bMS2QsTN3HhDT/yBr8GHkY+yLGOO8Zk8HLIkizkfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RECJNHkXsc9rB9xFxYByQEeENPtZnblHJSjZyVbR3dIXblquMC7ZzF5VWa0rJ0tcumKbFADgEFM9O2F6zV5eIRFRetcg038LUtS6S4QTC9kZVmHo3M+TU0wdD+hX6qkMGR4Alu7EIeGET/KobK/IrWxYukQmRqoCdE3Vd8TysnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CfDyf+MT; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CfDyf+MT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so2340019f8f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085920; cv=none;
        d=google.com; s=arc-20260327;
        b=oSgwfcb4ZdSm2vj+1tG5TaRqXKzVEVtQ549un4bVxFB4COquI4O+ldkORIchDGf2fC
         kd/lBEGhOIuAscyw/oBFWwk9iZjnn42EW0VrJ0Wu5Hq6Io+7wOE2cxIppfsgGLBGNwsB
         D2lVHgL9WVZMVJBP2u0fdVi5R1zLynmn7vH10Ohd+4ddhNbe0IDv4Nr3fkFsDQIW6+j1
         btrj8A2OEe5ZvstWB4NZEWeGPkbO/B65lISHvSO7fn8n+fiM351IoDOIJEv2NEFtrydh
         QFBBPlkpDtwYsmYaaU8LqKlGo09jknna77m0LLV5F1DlZvDBb3OaO1876wPzEOJ7E6Mx
         8Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZrtHB84b364jzwBBOljWxOCtEOH9Ysc3gFWF5Y09jm0=;
        fh=WkskHtO+zV6VHEgaers0TNLS/K4lj6PtSFA322WACdU=;
        b=VK2srwfXXGm48o6+eoh+CYiKCjQxwMy5fqNs1iHdnNO1MwjmwYumuuQPmVQYUjXMv0
         gBkCQztZBWepTNk81Ck7P8R3qNbAVkDZJol+ldVAnZ/JQ4ij/1OddzWrKG+jiX1b6NJc
         SBQ/Ue2DTKKsKIk8XN8ZMniFBy9iobuzFbbAmIW497VmtL7kEMJOJ4vVr63b3Ai36YGe
         DM4ltYKQ0D4lOUj0LbvOhQBuSH9MYgUkq0zv/j92TWiRc55uRNvu0O4/A7t3p2Teqdmf
         ewdsdQ46QkZHv80raQR4XlcxcAktvuVJIzIjEDg11MLvI4KYYj7e1lpQrXVKVvQ1Z1qW
         HESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790085920; x=1790690720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrtHB84b364jzwBBOljWxOCtEOH9Ysc3gFWF5Y09jm0=;
        b=CfDyf+MTCmv4aQBDyPn7h30jqSH6DJE210hWBVMGI5KYGsuu6nm12ks/c/rQGNTZzX
         kCUmPPD3ORq91m53TVuAXAAz5qZYW3x4Rqm5SmcqNF+Hdh1iPI2yViMDvnexfNvp1qUh
         pc0lpnS8PgmhJ46tz3+1W1uTAIadlNXtWVGHo3oxIPh9k7pqvc3eCzCWEn2Jd+CfwXN3
         OTCAN+SbZIfKF7w9i7O0MzNf1esKMSGIkuo6BAUgVRJ6QuyK22oPXVLy/AmDvTGMqYYT
         DXlNLrt9SKPci73qbXwvEFrBBbbPoLOOQhtji6hz6sJ9iEAteQMUBhj7mUIDKsLWtmCw
         0h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085920; x=1790690720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZrtHB84b364jzwBBOljWxOCtEOH9Ysc3gFWF5Y09jm0=;
        b=lIgMpwAwsfF0QfD0bVayI22wBIObvp9cgXNP/stk6+W1X8Ka6ELqnD781sC5hp7KL3
         koMTtvD3Sgly50NEmty0Y650qHXSCm2Vfgdzg9qFW8EqbEfEYd8ucRmVjfvP1HobGw0A
         pgu5IaUJh99Np6EtFXuOcRgORBkqXYv8og9hdQQ/o1Sj0D79lMYQSg3oqPRYX3j7RacO
         qPoJgpSvlP+iwaCxL8AR2Vbt0/vaWq0lA8PdMarNCPVPkLrmGMWtt7njI5cumam5gd2+
         qG8CEWzjYxxo6ef8UMzRAlGyqndThnOKk0zRqzqeQzON4swgvYrBGZglQ+S3Sd8AKZSI
         Pvbg==
X-Forwarded-Encrypted: i=1; AKwUvBxjJdoZLXZv82zQ2sCpB9MSXLZnqZpbD6wDr1qJvmwx+kXykjHyM/ukba0+KW4ss2SLnfv605Dx+rj6eA==@vger.kernel.org
X-Gm-Message-State: AFuF++keGLw9tjRmVrjsnOJglwKUyzdx6cmBz0NpWTOQ6CYPUTUnWwbm
	xuOt0y1wWCmQ462w90gW/iWdjwkCRcYm+UtZbruvdGU3LI9yfZ2BMjUxJHGqt6J7PsdO/bX4Hy6
	a1AN3hjjXquGdc1reGTPRyeEYOKxldWrGmVYf+JG5FQ==
X-Gm-Gg: AYBFou1RGEgeOf6rU5PUpb9ZF6+AY69Z7NieUdTk+2twLz6JMjQDiWnOurWwseYxAHD
	CVjQrmfdA2o9Zgaf6yzkqZaSo0iONYDa/qFvxMHhnjrRmpE1YxVP+SzaWlhv3/eYbaS5RnRSBzl
	6QBXzq8RAWuisq5QijY0RhDDOH3H7PIDu66BTjClsp7FupYRQSKkUszznVXUf0/l3swewM9StT+
	rGP6VgqNB96Sx92+RCSIUaLnWL/8+KNoP/YFUhb9vCoxltv97Rs3eGT1b0nrhhaDgt7LJ7s7UCc
	U9L85WLeJiOSzTS7Z5Jy8qOlM4gAx0Yk0wGgtlGXy3mGcvqijUFSf1/uKS4w/DuMV0PITvh/mBF
	h7k1yeACELlaqKmoQ8yzBfNMsbrXNtHlxL0bOQI+yn/Kt++kG6G6e
X-Received: by 2002:a05:6000:1884:b0:487:ee6:b76c with SMTP id
 ffacd0b85a97d-4871e386891mr20725607f8f.56.1790085920335; Tue, 22 Sep 2026
 07:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-12-neelx@suse.com>
 <20260602032534.GH2295@sol>
In-Reply-To: <20260602032534.GH2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Sep 2026 16:05:08 +0200
X-Gm-Features: AclHuK9buEKOllKFAYM2m_CAJ3xVlO7s0lRsVrq1N6uymn8JCD10DYisCBeAGOs
Message-ID: <CAPjX3FczT+7rBFbtu+t4FRg2_VCXO33BghmHAO4rD+mPA_5hDg@mail.gmail.com>
Subject: Re: [PATCH v7 11/43] btrfs: add inode encryption contexts
To: Eric Biggers <ebiggers@kernel.org>, Boris Burkov <boris@bur.io>, Chris Mason <mason@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Omar Sandoval <osandov@osandov.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 05:26, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:45AM +0200, Daniel Vacek wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > fscrypt stores a context item with encrypted inodes that contains the
> > related encryption information.  fscrypt provides an arbitrary blob for
> > the filesystem to store, and it does not clearly fit into an existing
> > structure, so this goes in a new item type.
> >
> > Signed-off-by: Omar Sandoval <osandov@osandov.com>
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > v7 changes:
> >  * Fix a path leak as found by Chri's AI review.
> > v6 changes:
> >  * Shorten the inode context key macro name to BTRFS_FSCRYPT_INODE_CTX_KEY.
> > v5: https://lore.kernel.org/linux-btrfs/5a88efb484b0874a7430b83bc6e5f6b9aa5858d5.1706116485.git.josef@toxicpanda.com/
> > ---
> >  fs/btrfs/fscrypt.c              | 116 ++++++++++++++++++++++++++++++++
> >  fs/btrfs/fscrypt.h              |   2 +
> >  fs/btrfs/inode.c                |  19 ++++++
> >  fs/btrfs/ioctl.c                |   8 ++-
> >  include/uapi/linux/btrfs_tree.h |  10 +++
> >  5 files changed, 153 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
> > index 6cfba7d94e72..c503f817cbe7 100644
> > --- a/fs/btrfs/fscrypt.c
> > +++ b/fs/btrfs/fscrypt.c
> > @@ -1,10 +1,126 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/iversion.h>
> >  #include "ctree.h"
> > +#include "accessors.h"
> >  #include "btrfs_inode.h"
> > +#include "disk-io.h"
> > +#include "fs.h"
> >  #include "fscrypt.h"
> > +#include "ioctl.h"
> > +#include "messages.h"
> > +#include "transaction.h"
> > +#include "xattr.h"
> > +
> > +static int btrfs_fscrypt_get_context(struct inode *inode, void *ctx, size_t len)
> > +{
> > +     struct btrfs_key key = {
> > +             .objectid = btrfs_ino(BTRFS_I(inode)),
> > +             .type = BTRFS_FSCRYPT_INODE_CTX_KEY,
> > +             .offset = 0,
> > +     };
> > +     struct btrfs_path *path;
> > +     struct extent_buffer *leaf;
> > +     unsigned long ptr;
> > +     int ret;
> > +
> > +
> > +     path = btrfs_alloc_path();
> > +     if (!path)
> > +             return -ENOMEM;
> > +
> > +     ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
> > +     if (ret) {
> > +             len = -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     leaf = path->nodes[0];
> > +     ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
> > +     /* fscrypt provides max context length, but it could be less */
> > +     len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
> > +     read_extent_buffer(leaf, ctx, ptr, len);
> > +
> > +out:
> > +     btrfs_free_path(path);
> > +     return len;
> > +}
>
> This doesn't conform to the calling convention for
> fscrypt_operations::get_context, specifically in the cases where
> -ENODATA and -ERANGE are expected.
>
>         /*
>          * Get the fscrypt context of the given inode.
>          *
>          * @inode: the inode whose context to get
>          * @ctx: the buffer into which to get the context
>          * @len: length of the @ctx buffer in bytes
>          *
>          * Return: On success, returns the length of the context in bytes; this
>          *         may be less than @len.  On failure, returns -ENODATA if the
>          *         inode doesn't have a context, -ERANGE if the context is
>          *         longer than @len, or another -errno code.
>          */
>         int (*get_context)(struct inode *inode, void *ctx, size_t len);
>
> It also seems to be assuming that any error from btrfs_search_slot()
> means "not found", which isn't correct.
>
> The size_t variable called 'len' is also being used to store negative
> errno values, which is weird.

Those are valid points. I fixed the return codes and cleaned up the
function a bit.

> > +static int btrfs_fscrypt_set_context(struct inode *inode, const void *ctx,
> > +                                  size_t len, void *fs_data)
> > +{
> > +     struct btrfs_trans_handle *trans = fs_data;
> > +     struct btrfs_key key = {
> > +             .objectid = btrfs_ino(BTRFS_I(inode)),
> > +             .type = BTRFS_FSCRYPT_INODE_CTX_KEY,
> > +             .offset = 0,
> > +     };
> > +     struct btrfs_path *path = NULL;
> > +     struct extent_buffer *leaf;
> > +     unsigned long ptr;
> > +     int ret;
> > +
> > +     if (!trans)
> > +             trans = btrfs_start_transaction(BTRFS_I(inode)->root, 2);
> > +     if (IS_ERR(trans))
> > +             return PTR_ERR(trans);
> > +
> > +     path = btrfs_alloc_path();
> > +     if (!path) {
> > +             ret = -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     ret = btrfs_search_slot(trans, BTRFS_I(inode)->root, &key, path, 0, 1);
> > +     if (ret < 0)
> > +             goto out_err;
> > +
> > +     if (ret > 0) {
> > +             btrfs_release_path(path);
> > +             ret = btrfs_insert_empty_item(trans, BTRFS_I(inode)->root, path, &key, len);
> > +             if (ret)
> > +                     goto out_err;
> > +     }
> > +
> > +     leaf = path->nodes[0];
> > +     ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
> > +
> > +     len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
> > +     write_extent_buffer(leaf, ctx, ptr, len);
> > +     btrfs_mark_buffer_dirty(trans, leaf);
> > +     btrfs_release_path(path);
> > +
> > +     if (fs_data)
> > +             goto out_err;
> > +
> > +     BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
> > +     btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
> > +     inode_inc_iversion(inode);
> > +     inode_set_ctime_current(inode);
> > +     ret = btrfs_update_inode(trans, BTRFS_I(inode));
> > +     if (ret)
> > +             goto out_abort;
> > +     btrfs_free_path(path);
> > +     btrfs_end_transaction(trans);
> > +     return 0;
> > +out_abort:
> > +     btrfs_abort_transaction(trans, ret);
> > +out_err:
> > +     if (!fs_data)
> > +             btrfs_end_transaction(trans);
> > +     btrfs_free_path(path);
> > +     return ret;
> > +}
>
> The 'len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));'
> line seems scary, since it just truncates the data given.

Right. Actually let's refactor both functions and split the common part.

> > @@ -199,7 +203,7 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
> >                     FS_NOATIME_FL | FS_NODUMP_FL | \
> >                     FS_SYNC_FL | FS_DIRSYNC_FL | \
> >                     FS_NOCOMP_FL | FS_COMPR_FL |
> > -                   FS_NOCOW_FL))
> > +                   FS_NOCOW_FL | FS_ENCRYPT_FL))
> >               return -EOPNOTSUPP;
>
> Do you know why FS_VERITY_FL isn't in this mask?

Not really. It seems that 41b37c51937e ("btrfs: initial fsverity
support") did not add this flag. I'm not sure if that is a mistake or
intentional. Maybe @Boris or @Chris would know?

--nX

> - Eric
