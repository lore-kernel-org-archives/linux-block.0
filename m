Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CF2BD030
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420722; cv=pass; b=D0N2NDbuPZpnqUvYAtLhgCa5K4/KUtqtDUqY3wtCgQ63Itk3jQpyxCC2X2zvpupiICGpvMytB3tg8Ft1r90WIlv3rWjVGuliPLfrz6T/OiZriVX9U+9NvpITBTuYEXjqXO3nJUDqaWLZfNOHPcDmuGJdzZJ6/6poiFwDEMrvKbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420722; c=relaxed/simple;
	bh=sLMGR09zI4y3gpjzSi6grOOg7wQjmI4f5Efbabe2ap4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qItm2AlfxkFyzrxTnkuNDVY+cu2uPZUqhZGzEyK5BqLm4gfWxhFpuESxkmnu1mg7VQvu/t1tZgmifUHWkUK8ID/7ZTB5L5CIpziWqSVKJbR/uy3xeJ5XFYLZZmPh4u0oXUxmgaWwMvRRJ1m7O2RGhDuebE7jxd3bSUUwhnoTiIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Onq8ALfd; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Onq8ALfd"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362507f0feso3459595f8f.0
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 05:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771420719; cv=none;
        d=google.com; s=arc-20240605;
        b=E4bhVc1FrNeN7pUGCg66YgifhBmNnjKAV+8n8Gn+pmjj3+1HdB9XIhqA6l96ymC3H0
         Kml43ovaMl2wJ0yyuYravdHrhf8+bUIPtixYFhH6L5ghJM8G/CiAaY/mTGE/YBUV2Veb
         3B9vl6bOJEreTGWNMnNCrLrY+zX05cHQJ9/skbF0+PUKCRNJD9yuFZ1s768jEkDa8AKM
         YQdg7fDp4TO5Nymi7aebdJvy2xsGPyG3ycHyWQNP7b/8tdYihNSwg+ROseQvuJ3lFMlW
         8RJRQcvFxrHQegYqtP8EyeI8mJkw12fzOrnOWLDZy+NfsBJLHqc62fHxL4mYUZKMQqk6
         jmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        fh=tkDVitkXIZgPgMMjflLyuBJq8zycLk8VygvIFU5rDjE=;
        b=OpM6V9v8B4ikLXW0PhD/Nd15jD9voMhni9W5B/4rf0Bv8+YLG8M97VH8sspjW+nZbE
         MpKA5yXJQpUC6t+l8bfqHBIRIRSQ7movvRmhQlsDuk/JwNrbOp18a7cDy86D1PJrMJn4
         FnAm4IqTel5X79DxmKJ6wcH7iU8tupAi9ZLnSb7DHqB/+tfKExmI3kd5jwjjDRHL8g4W
         GAcxCwjghUArzzAZRf+3ddHB0XW65E0CQ+t/Ofr9NQyvYcXSS9323RFDAm9k5ZYWBNwQ
         1zLHjOT18V2YaDawr6Lj08NXT+4fgoMgLNfbt2ERx4ZQ6MRPDv+iHgCMyIUzgqeM+3xq
         xijw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771420719; x=1772025519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        b=Onq8ALfdPQu6Dgw3a15nKbA09J6rzOwkPAfTk8y9o9yjRD3hqfqxCygRhg/J1sLKfM
         Zda5bkTSUgAHkYZ2+B2mAFmjB6ppVM8wLv27EGpnDQwFb+GlpW6Uyte60rYXZ/8e0ln2
         EuVFhhGluTzk3tW/Fdrs2OW/oWgIN1edYnlXhbo7Uc3Q4n0yo/YISsXUI/5xk6YcwfeD
         SU5IVMR1MzlTKb2N/eeJyfLmw6Kdf79yYFdTbCz1tAEq+u/4S+SBqsdpH833JE1w5Quh
         4PWRWOUoT773pY2oqnObD4ayXyAnXLMsF8T4bkTlnQnul9dCmLQgJ4Oi+qw83KsFdXXR
         t0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420719; x=1772025519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        b=WRs7Sfd66b8PMSkavp/bPFGdfiE5q7zBLlHbDipSYTB03Dl3mC7VYn1WIFE01z41VZ
         GIhrqQQ/cmV0BhvWLP7+xjLSb3KvFm7ISVwJCUf10avJSnA/MNiioof0Se24hsAh5MFe
         NwBJMb4dF2Jfjv8luEdLrMBco5w7eSp/kRKYyD7u7Vix/BPq//UY4Pfm1TwcyqkhRKTO
         neCJgXaGGHTBRXmdbPme6AxVKJSN77Pu3K5fr/Y3x3lr3F/VAWhZyp6+xZzav4lsfHCa
         LoVL+gBz3JlLVAf27k+wwz7VKBLPZiscvEFnnlHqabQBxzBqCFm5fZTvLgP3TSw9EKW7
         E2jg==
X-Forwarded-Encrypted: i=1; AJvYcCW2W7wckzyHJscBgbwUq6XBXhZingDkNytEfdBK3n9N/qnWm6oOusYvVXzm3f04DGjhCu7MpF3jdFVbjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48CfllJ0DnTdDnUxQXTrXNHKTL9Lr76Hwg5DRdqQbCbHXG59v
	dF2/mAfQIT6tXMy+55kmvYs3eTTATeAsU+q2AVNHMSw916WpPiZ7E5JDopJFQzW4fweeLaQv6mf
	Oul/xXEADYDC+wFxnPFNGTA/4zH1eBJ83NryE6wrwfw==
X-Gm-Gg: AZuq6aLHDxtNg+vjwLq/FykLTabzhY83CBq7J3357I+ORQlzgqzZjeFcVqhVaiAfQMo
	X20taNU/Knk7ArxWQStCukvLGiH87rXqpckXnMXeTqmim21YXAOA0D9hqsnLjvrP8adGsGWEvAj
	cww2XkPxMH9fhwhxdA6jYKXCadJ4furQfMs2iYIPwFM3gJR9qbRbs7BzQ96f1zu60dTOQXt0xpq
	jKmRPuwJqlOq8apS/lMhZLTnf1+olhLoMpFXNevS5CXRL1rndmwA9rBMwiCFquRCpfaAIYeqdjE
	7gq4pt2mrbGQNZA8zKJ64ex06FWaDeNzv0DgZPIPakLN1T6C/DTKznl7JVlzO0+QZgXv1CDv0m2
	xBYuM
X-Received: by 2002:a05:6000:26cd:b0:435:a815:dd8d with SMTP id
 ffacd0b85a97d-43796b04f57mr32979736f8f.55.1771420719317; Wed, 18 Feb 2026
 05:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-12-neelx@suse.com>
 <20260208153808.3476221-1-clm@meta.com>
In-Reply-To: <20260208153808.3476221-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 14:18:28 +0100
X-Gm-Features: AaiRm51fAAFTVBcqF-KI5-Lr8gaWIksaX5IH6JtEAzcWunIgDM49UiSlrdWV5YQ
Message-ID: <CAPjX3FdXC5LX6UBmsCf6cdGquwsPrh3gp3OKj0NEerXkbFSd5w@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] btrfs: add inode encryption contexts
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:38, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > fscrypt stores a context item with encrypted inodes that contains the
> > related encryption information.  fscrypt provides an arbitrary blob for
> > the filesystem to store, and it does not clearly fit into an existing
> > structure, so this goes in a new item type.
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
> commit 2d6114c2937b897d844735aa16d5369e3ec6d135
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: add inode encryption contexts
>
> fscrypt stores a context item with encrypted inodes that contains the
> related encryption information.  fscrypt provides an arbitrary blob for
> the filesystem to store, and it does not clearly fit into an existing
> structure, so this goes in a new item type.
>
> > diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
> > index 6cfba7d94e726..e9b024d671a22 100644
> > --- a/fs/btrfs/fscrypt.c
> > +++ b/fs/btrfs/fscrypt.c
>
> [ ... ]
>
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
> > +
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
> > +             return ret;
>
> Does this code leak the path when fs_data is non-NULL?
>
> In btrfs_fscrypt_set_context(), a path is allocated via btrfs_alloc_path()
> but when fs_data is provided (during inode creation with a transaction
> handle), the function returns here without calling btrfs_free_path(path).
>
> The btrfs_release_path() call above only releases internal references to
> extent buffers and locks but does not free the path structure itself.
>
> This leak occurs on every encrypted inode creation. The fix would be to add
> btrfs_free_path(path) before the return.

That's correct. Good catch!

--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -155,7 +155,7 @@ static int btrfs_fscrypt_set_context(struct inode
*inode, const void *ctx,
     btrfs_release_path(path);

     if (fs_data)
-        return ret;
+        goto out_err;

     BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
     btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));

Thanks.

--nX

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
> [ ... ]
>
