Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172F45A2AD
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543292; cv=pass; b=aFYJ8e1iKFTxMisyityIkLXievFfm1kv9FTJMqxbKj5bG4Cf2XndHWoCKdlB3jjxZ3fe+Lm8qCXrqRHK4NxwgITDJLYF1SqLfOnHixTAn0c64ogxHzEmgj1O93HuFQpmwKy8Is6kotz3garIxYIQ35UFeg3VKBFN4l/UMTmPN7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543292; c=relaxed/simple;
	bh=NwhV7wARecxQh7esHydA5zPzLYoC9TtdLCxqqsKZyKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9+NZmlS3P4fZkb6q1BEFjrptuvJh6jqTX1ip3dU5f6foal/oYCA0MzteFe2mFmF+eibtI6IyrHyKYRJOllwDXH4WpDVdXXoZsSWbT9RYzZpOBT8Ito5IrHZtkrXxpVlTAhqfcOOVZUHNsGjJCFEBGmqWt7m6yX6cNhJM7PXB6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMzpZF95; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMzpZF95"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so13887155e9.1
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 07:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786543285; cv=none;
        d=google.com; s=arc-20260327;
        b=nr6s128rZuxwKqeVUFKoQt9Gwujin0mPUKdfOMiTBwOOr2aDSf4rhUtS8AdDJlVYqV
         Sjo0gB1tl9GEq2th1hUjlrA1wL32FXSsnAW+O0E88VfzcE2EV/5CbuqbKSlx9L54Iz8I
         SSEDryZuws2mecC5KNUMIHQ/ZpTYS0oLIaUW86FtIIGnGRY4zKBYG9HkyiFw4oGT9/tr
         jlqGvlLQSZ3rWLCox5gGPm/r41x6nevh3Wg4dZnvrvhfSoAgnTTniPZOSty0IOm/CZ3w
         adSnRROrSB9ATgaYd+yQ4OSJDa3ZACesMLt9I5Dv5KLDO6qyg0btUzf4MN50MVGmoo4d
         Y2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jDqguviqlm3mcw1WL6mm0X2Ptol7dkWT6XZ2U3iPzp8=;
        fh=/hJgXJspksohVGy+s9gyOXHWBf25t+3Zib479qQZEW8=;
        b=X1Uwwl9gIVA+9gjGU1nbL/PhdvKYpFLFwUwMrCkygb6qL0fEAD7fOUxsBszYkFsYEr
         2pJ9l0NFbvVo+w5e7wN9BVrQ2D88Kc+/CeETTn2yefOxnfkYtdeoZU2rb+Lsvui2XDfv
         elfo0E/ZE4TjyQMoIW81poxE2yVVuGI6P2fAEX6i70+Y+jBbZFQXAJI1nFCmKWlLT8AA
         INCo3DfcUIMhob2mlSAWvuGzSH+cPDvTPNVTzVzMOQbGFLxpXjlKtwAZazvhXvKrr84T
         iTMba21pAeQ9fom0lrTYjOcVJhpYviSg0hNJZpKSq8uAIPoD+k2MsRpgdI7rMg7mxdn8
         kqLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786543285; x=1787148085; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDqguviqlm3mcw1WL6mm0X2Ptol7dkWT6XZ2U3iPzp8=;
        b=bMzpZF95Zyx59JzfpcJo+ylEYm+3oxDx4U37dg5o3XJSkZyQ21hWHC5FXbiFKJCtwz
         nfL8s0PNyewVe5v64SBtAquLGvNNGElEyDtfv1m7v/EUT0QcQaNwuW9wyRpIIR/y1/I2
         qyuHfiXFEhkuVCzOfGa1P/JJm1Ww3OlOIFQUOqURWgtRFK8kysRFJzxjb7OvMNzhfMpb
         W8+AmyBf7xHon4mrE1Z3nJl7h0UZkwJNtUv59bhlanZJs285lei7wEGlgIgFrIFE7aDd
         1XE8+MzdFW1P0WnvvjHC5W9GJsp1YOEF6XalZDyutJgLrMAtkyEA347rD9gx0K5SzFQC
         UBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543285; x=1787148085;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jDqguviqlm3mcw1WL6mm0X2Ptol7dkWT6XZ2U3iPzp8=;
        b=d8Fg5m9t8V1jGcUsQyuyPLyo0rROlqOQ2t2/q2AV7rLg6zIW85iH1OnNj6PYfrgntw
         dz4DojYOtJK8f+t1WsbgK1n7gV7D70pZJ6NAwOY0wX++MBG/kr2wsPDMZzrFa0P6HPQx
         27++OO/ziBUzsSnkCo9yYkWyj5RI+Lh+cqMGHnjYHiKu+lfBaM2oHWQbfMVKDg0sw2dk
         /1pFIK1srPTwmrofFi7oYSEDiJ/BkVGLn/pncg0scY/9XXIRHqnPS84hCR3uy2kKyr5E
         9ThU5JA1/qbPk7hohTH9uAv03k0WOiv4uvwjfeWDlmNwO5u/5wjkJ/qKw/ubtBLOM6XC
         yeoA==
X-Forwarded-Encrypted: i=1; AHgh+RppbSWuuXsRvcxhXA9IIXal4nbeKnOTWXRMAX5rX7p7kHcNEOnowd27nyGaTzDaZxiQcIPwQOIg9QRBxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwftoHLm3HqlE4cWzxnDuQfl/H3KVCKjxqY3j0JPLA2FkHvQQVC
	UzjYFTZzA1gT+vI//6VUW4e3CNM4PAkoGR4jsXoht6ryHiYLO1TcvxyRht2f1lBcLVoBki6o0ut
	hHINcqCmNwZpaxrshpJaogC1nrm5SMGoZbrTFlA9SAA==
X-Gm-Gg: AR+sD11Ex0M8d68k7mOrOybddHar4CyUvwf9GGe4VNYOicFyOTQvH71IYK8lVXQD0F+
	NkWLMEzI+Ll0wdbDdgSWQnsqEXXZKNibpv4sUg54G4LEEDahotw7uhph823eA/7OVf0gd+HT0id
	+4icz3ajc+yDVyjYHDOtmSyfXt7VnVAKRvSYcFxjI+XjmwZ423aqN6yXa6MAXLmLca1X62tk9tO
	bleYF/YwLeyZjNYkfO2EW6SuxkY/oROoRoWw5xMhW29Uy0wT6pEP89vlLSBAE9d6YKN2FaJObYp
	DXVks0P94K8nwoNqVctyc+pCDetgbdEmlQu5wTVo+QsmtbvNPGnjb+m3RCjuNJlhxPHJVOqpuxd
	bm3348KXZzwz6oWFe7gJG5427WEyz7S4fHYIAGgl7xQ==
X-Received: by 2002:a05:600c:3545:b0:499:71d6:359a with SMTP id
 5b1f17b1804b1-4997a656f46mr109313045e9.8.1786543284052; Wed, 12 Aug 2026
 07:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-4-neelx@suse.com>
 <20260602023330.GB2295@sol>
In-Reply-To: <20260602023330.GB2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 12 Aug 2026 16:01:12 +0200
X-Gm-Features: AUfX_myvt915vzGFwNYRlfFfUivl5kbirxl8PA9N2EQBXfOqTu-HUsUGoJNjjyY
Message-ID: <CAPjX3FdO6sn4Yi0x30cJSASqJXJYnit-RVOOAaz56VhBQPKmXA@mail.gmail.com>
Subject: Re: [PATCH v7 03/43] fscrypt: add a __fscrypt_file_open helper
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 04:34, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:37AM +0200, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We have fscrypt_file_open() which is meant to be called on files being
> > opened so that their key is loaded when we start reading data from them.
> >
> > However for btrfs send we are opening the inode directly without a filp,
> > so we need a different helper to make sure we can load the fscrypt
> > context for the inode before reading its contents.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > No changes in v7.
> > v6 changes:
> >  * Adapted to fscrypt changes since the last two years.
> > v5: https://lore.kernel.org/linux-btrfs/4a372419c3fe6ad425e1b124c342a054e9d6db23.1706116485.git.josef@toxicpanda.com/
> > ---
> >  fs/crypto/hooks.c       | 38 ++++++++++++++++++++++++++++++++------
> >  include/linux/fscrypt.h |  8 ++++++++
> >  2 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> > index a7a8a3f581a0..3142cf106bde 100644
> > --- a/fs/crypto/hooks.c
> > +++ b/fs/crypto/hooks.c
> > @@ -9,6 +9,37 @@
> >
> >  #include "fscrypt_private.h"
> >
> > +/**
> > + * __fscrypt_file_open() - prepare for filesystem-internal access to a
> > + *                      possibly-encrypted regular file
> > + * @dir: the inode for the directory via which the file is being accessed
> > + * @inode: the inode being "opened"
> > + *
> > + * This is like fscrypt_file_open(), but instead of taking the 'struct file'
> > + * being opened it takes the parent directory explicitly.  This is intended for
> > + * use cases such as "send/receive" which involve the filesystem accessing file
> > + * contents without setting up a 'struct file'.
> > + *
> > + * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
> > + */
> > +int __fscrypt_file_open(struct inode *dir, struct inode *inode)
> > +{
> > +     int err;
> > +
> > +     err = fscrypt_require_key(inode);
> > +     if (err)
> > +             return err;
> > +
> > +     if (!fscrypt_has_permitted_context(dir, inode)) {
> > +             fscrypt_warn(inode,
> > +                          "Inconsistent encryption context (parent directory: %llu)",
> > +                          dir->i_ino);
> > +             return -EPERM;
> > +     }
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(__fscrypt_file_open);
> > +
> >  /**
> >   * fscrypt_file_open() - prepare to open a possibly-encrypted regular file
> >   * @inode: the inode being opened
> > @@ -60,12 +91,7 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
> >       rcu_read_unlock();
> >
> >       dentry_parent = dget_parent(dentry);
> > -     if (!fscrypt_has_permitted_context(d_inode(dentry_parent), inode)) {
> > -             fscrypt_warn(inode,
> > -                          "Inconsistent encryption context (parent directory: %llu)",
> > -                          d_inode(dentry_parent)->i_ino);
> > -             err = -EPERM;
> > -     }
> > +     err = __fscrypt_file_open(d_inode(dentry_parent), inode);
> >       dput(dentry_parent);
> >       return err;
> >  }
>
> This change makes fscrypt_file_open() execute an unnecessary extra
> fscrypt_require_key().  Could we just leave fscrypt_file_open() as-is?

Yes, I'm aware of that. Well, it's static inline and gated only for
encrypted inodes. But yeah, I'll refactor it a bit further.

--nX

> - Eric
