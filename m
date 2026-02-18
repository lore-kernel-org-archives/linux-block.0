Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D533123F
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426256; cv=pass; b=rk/bBcD6fo7/mw6iyGuL1mTw8InJQ2pciiI9lz7P+WyNf9eUIWtDN9o8zYyVMefNfE164j1lU9O+by8qrK+k9x91H4/6NBwUzFOOkzB0RK7e6KVYwCG914C0PcTuUnxWjF04PDnmQeC2sbFcupgJH47LZsBZuJ8Vmt8GmxcZjmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426256; c=relaxed/simple;
	bh=ayix/lpTEKTXsxUj2iKsjlFXfV7GOzT2zS6Ou5e131g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR7uZSXmSsEkXaKegZg5Y8TnxKKZU1PR0I6C6pW80eGNJcdH6EuquHLRc8ob86GbwMLS0fac4wK6M6Ds7c5IE52bj/cZ1aBP7xwuks9H+PAsCQCO/zUJkXhA85lADWrrAtoaapIi+OMYJrVA6qCwWZRwIAwVvophQDMqfSktMbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Btz8khYt; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Btz8khYt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435a11957f6so4547272f8f.0
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 06:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426254; cv=none;
        d=google.com; s=arc-20240605;
        b=PQi98sOXjOqjVWvlLE6AnAVpj1GCfv6lYVYy0GJ3nofg7YAA//YY3NX2NlCx/lrUze
         P+xNOdqNP1+L/H8+meS7NECIwbuYiUxLiqT+NatM/Uv9LlMecOoRsUSAYQhWRfVPX+xH
         5hDjQAU0PJ0Kguw+8Q7cip4v1W209M4+NJhrbN3HDBhlbsSSO+GPv34b1cSk1clMLB4I
         J4r7rq4KmpziF9WxFN+zy1irFgHHR9uQsjJnnH18MZsnnMEB08gkkoTA6u4pEY9GTns5
         jUFncpHq79dcWByCuyIUbD0IbJ0wU86uydhGlJ956BB9A7wOvdvQjsnCx+ofbEiMrcWc
         5q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        fh=v8G798mbiWZj+Bx0dpo8jICgr/rB855eEz8ppbfvi2Y=;
        b=T8r4+QnmjcyykC2aXDmT8ajQIh3Jk85kcakg0sjhkKORbuUmeqQ2x/i3mM7lQ3heI1
         to4+FzFVb3A/Mwd6Ju+Em4keM4VCf4EW7W9CcEBECVXpVJa/7l6jPBGXm+EbH+EfRfu9
         3bhJ2pQ40QFF4StuZrkuF73xj8HH0uYKRQRr8v84/uoFA8XEJCVKpwVCu1Bjb2tIBRcy
         oVGeXMek7/cEiftmLlIy2+Nm3Ez76XG1IET7GMtsNiFUmCqFAKCqX7Xq2xr2WMw8x6NH
         VgwUgX5G7ZdrgTTjKSG0LVALIZeLWe+fN8E1GT+c+27pAx66wgaN2IQn3fFjmq3Hd+HI
         WQ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771426254; x=1772031054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        b=Btz8khYtvNNsriVVeD6o6jXJ0W2Zjd7ItjK9kGtxHF5uZn0F5QYETeWA82Y7lAVbrW
         yOQ6GtzDcDWe/G5oPOHJNjHzsZXf05USpHbBMIipOB3s7eKpXmDec1mzLJ2OH5T/s+0J
         Z/Vc0AqWQ+cLF7wop8hhzL5WfTkLd6hQHLIKVREKCqJkxO844CVseJhe3vYj1Bh+eHJ2
         iIjdx9MMC4kLwixNEVvqD4EsyN3YAynm84fmsxoPNV3KskrOS/rKWKvbrAtf1YYV/QT4
         dX6q/hlUf6TSdswnyntXVAnnCgPVeDg5/om0obqPjDIOVQVYytb1jrq08em9DV1YqqdJ
         yLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426254; x=1772031054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        b=I2QxR+Bf/GEeQ5y3fOOKXKxLxyVejgpXrKGPxwGnI1buT071DEads7nIqoUf6jT2v/
         PyIM6Ln1Hf53L6Fkr270GEQW8jDFcGgqgnXN0FqOoKvoxLsezyGGjP0xFVoMAREVpEy8
         853n10qZoETxhsGvLFncfxisY13DPdtQrsd4Ez42RdipwG9PlQ9g3uzzDJnhDW2qNxeD
         lpbRm8g40lZIaZHcNYnRXPVGRD1zjYRTu6zvYDz27IddU0qgMSdzEgx5bCSM8jy81YUM
         Kmb5BjhXB/QG9VLKqlUgvnDxcFujsX94UVpsaolJ8CLPzSv/PxUBJ4tcVIK89b1bm7iL
         J/aw==
X-Forwarded-Encrypted: i=1; AJvYcCXx68zWl6r+KJDv3MRIRPpMQQOyDRm/xGi3N0SAyHTjVV/eLjzutwgpbcgXttfbyoMb0Uj9pjEhL2uDmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0U2GN1VR980xFib7bnYh6iMzmxcNeI5WQKt8GUqAjSN8bEj9
	CRWaJRGxI9ycAnyWfODDgh/Ls51SzyARuDZFgP+VkXeHr8T4n61DF9dPOD+X853D38OQndQtyZR
	PFtGruHUP5N0pzEevJOxnWm6rVPh0AEfvMloX8km62A==
X-Gm-Gg: AZuq6aIvoEvJjk7H7h7NcjO+uhon2MEMXttW8bmDgmvKuG3Ad/jWZHh4hd4ooPdq+nZ
	WTrN4dCC34zQeT4/yibVvNd0t4NFucayJLrLNqExQOjgDg75hKJyivvZn8WFbSnkxKwjPKe9/7k
	dnR7u7JkUPL7o8jwP5h6jstrvCMP6bv6uEHYQgOz05qi4Vmm/Mf6ny2aXkC34aTV54dQf7gBBBP
	5inswiLzZbB6J7PoAf56jzvycF5fajdjVFWyrsxoiygHiIaKnM72iPf+5Az+r2azckzfiThSN4u
	bXhx5owPcomQ+E5F//Z0KzZCEngqLP923xjbiepqVS5bsPVQTaCTkFSe98spGlmt9FKDiJfZjLJ
	O7679zh4PtBbOd/k=
X-Received: by 2002:a05:6000:4284:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-43797913f31mr29698913f8f.34.1771426253517; Wed, 18 Feb 2026
 06:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-15-neelx@suse.com>
 <20260208152914.3379032-1-clm@meta.com>
In-Reply-To: <20260208152914.3379032-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 15:50:42 +0100
X-Gm-Features: AaiRm5279eD5QNXNIKOKA9PJgdBQDs7fON79j563pfmi1shHVB7og3gAxuO5tGo
Message-ID: <CAPjX3FcyGRN4PZSJCjj37TtK3cYjkBK8qiguPRZFDyQ1igH4cQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/43] btrfs: handle nokey names
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:30, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >
> > For encrypted or unencrypted names, we calculate the offset for the dir
> > item by hashing the name for the dir item. However, this doesn't work
> > for a long nokey name, where we do not have the complete ciphertext.
> > Instead, fscrypt stores the filesystem-provided hash in the nokey name,
> > and we can extract it from the fscrypt_name structure in such a case.
> >
> > Additionally, for nokey names, if we find the nokey name on disk we can
> > update the fscrypt_name with the disk name, so add that to searching for
> > diritems.
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
> commit fabad1c3ea82184fba8e78ce1da1b2fbe8c34fae
> Author: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>
> btrfs: handle nokey names
>
> This commit adds support for handling nokey names in btrfs, enabling
> proper hash calculation and disk name extraction for long encrypted
> filenames when the encryption key is unavailable.
>
> > diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> > index 6e10dd4a4e9e1..75c213bd826e9 100644
> > --- a/fs/btrfs/dir-item.c
> > +++ b/fs/btrfs/dir-item.c
> > @@ -228,6 +228,27 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
> >       return di;
> >  }
> >
> > +/*
> > + * If appropriate, populate the disk name for a fscrypt_name looked up without
> > + * a key.
> > + *
> > + * @path:    The path to the extent buffer in which the name was found.
> > + * @di:              The dir item corresponding.
> > + * @fname:   The fscrypt_name to perhaps populate.
> > + *
> > + * Returns: 0 if the name is already populated or the dir item doesn't exist
> > + * or the name was successfully populated, else an error code.
> > + */
> > +static int ensure_disk_name_from_dir_item(struct btrfs_path *path,
> > +                                       struct btrfs_dir_item *di,
> > +                                       struct fscrypt_name *name)
> > +{
> > +     if (name->disk_name.name || !di)
> > +             return 0;
> > +
> > +     return btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
> > +}
> > +
>
> [ ... ]
>
> > @@ -263,6 +287,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
> >
> >       if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
> >               return NULL;
> > +     if (ret == 0)
> > +             ret = ensure_disk_name_from_dir_item(path, di, name);
> >       if (ret < 0)
> >               di = ERR_PTR(ret);
> >
>
> Does ensure_disk_name_from_dir_item() leak memory when it allocates a
> disk name? Looking at the call chain:
>
> btrfs_unlink_subvol() at inode.c:4583 calls btrfs_lookup_dir_item_fname(),
> which calls ensure_disk_name_from_dir_item(), which calls
> btrfs_fscrypt_get_disk_name() at fscrypt.c:34, allocating memory via
> kmalloc() and storing it in name->disk_name.name.
>
> However, btrfs_unlink_subvol() cleans up with fscrypt_free_filename() at
> include/linux/fscrypt.h:503, which only frees name->crypto_buf.name, not
> name->disk_name.name.
>
> The same issue appears in btrfs_search_dir_index_item() at line 405, which
> also calls ensure_disk_name_from_dir_item().
>
> For nokey encrypted filenames, wouldn't this leak memory on every
> successful lookup?

Should `name->crypto_buf.name` equal to `name->disk_name.name` in this case?
How about this:

--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -243,10 +243,18 @@ static int ensure_disk_name_from_dir_item(struct
btrfs_path *path,
                       struct btrfs_dir_item *di,
                       struct fscrypt_name *name)
 {
+    int ret;
+
     if (name->disk_name.name || !di)
         return 0;

-    return btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
+    ret = btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
+    if (ret)
+        return ret;
+
+    name->crypto_buf.name = name->disk_name.name;
+    name->crypto_buf.len  = name->disk_name.len;
+    return 0;
 }

 /*

Thanks.

--nX
