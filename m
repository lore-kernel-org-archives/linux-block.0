Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073132E122
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339714; cv=pass; b=ZDuDlHCicrKk6n6ly8QtUki0BZsD0eWByMRgslxE1LMRd4Cw/QzDv4j1923RisvljRy62PRNkUuE22d9i4waHp1sKZ696+rYaZIr0CaVe9zGClY8ycywZxxdSED0j7tWu2/2dnkt4a56LJbpHAgYgENyyoI7dUaAkwK/Rv1fv3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339714; c=relaxed/simple;
	bh=BdwdGKvnO7fFw0MoaFXmtoP5xcQ32uwyD+1ybxKNc1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaxxiphA84lj22xC+5/26ir4KZwyyBNoBpmOouA1NwBBMWa8zdvYOpJUD0Uptlj6ekuvkUmJHj8YW4hvfx011FiCoAWlMZn9cc+PEFrFeixRCnjHHveuZZk+c4y0lJRiSaW/y2nM0ewOlP3phwpjcMn8melPF3SWW4Oe0jAr3HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cz3swEMt; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cz3swEMt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so3276816f8f.0
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 06:48:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771339712; cv=none;
        d=google.com; s=arc-20240605;
        b=VDt/UGVwf//iJua3hw1jHAaX2jzVBAu384aaqMv8KHHxtNRZC2Xg0GCDu7ldSxv0Sx
         1PDERw9sXpi5GBcTGphxrwAxJCTFgSzCUJuyxPR7cyfy7bS3FUHyJ8+u73Bp2+mvIZ4+
         /U6ytjft5+riwQ6tTMN7cZ2/fM+dqnnyv5x7xrww2b/DKmBjAeivmYVumCfLP94a38Hd
         6nsUtHVaPrymyHx+Fmrw9Xy3MZUoRHFsap6oGmByJDUuPhsLlxyoEoiX7QpLjirhpMH1
         uvoSi+st08n/VbUqjl+J8Nc74pkbgYfU60xfXhfiet0994ZsBLb1l0pMryf7HONULAhd
         c7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        fh=ZNeTe/BGWf+2dVTxVGLwB/N3o3JkxiBgY1DY2U0YIHI=;
        b=YjLnNHnaWGTWuE2hwtni/8a0Ha83MOOg7ttdzSWjS/TifwQgUvVnMi1FVwSaI4GQpI
         TIaiPCBYP/VgJbSslDJrrLp+vIzuJJmiuADj03lBseXOpovkAM9a4s9fvZG/ERhFQQRw
         Q9WqLk1ChYUuMasElM4QZtCgI+siO1qpjmIyQn4ZAaVLtI6NBq7vpgGlWTNrsRxg8C+Z
         GB9CovkO5+HxWWmToc0lTTKPdk5JALkc7tgwUNo1rF05SibO4BoDrvbA/6MzuPWSG8yg
         B/v1WSX24y/Sej3JzUPS3bWMmvEWDP0v9TXjAt9a5bn7RbA2pXnW1MxiShMOHl/RBa9V
         ANkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771339712; x=1771944512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        b=cz3swEMtk3PN2RvOTaW1z9hz0lQ4TdrxSP5U4gFFonwIFdUREVJHg2O0IHPFiUgqAI
         /uLteasIn9nknhnHTDUkGJRc/i5uKsLd3jaXqFXT6zVXHjGWz3C3yloiJNOqXQcqBBsV
         jCokeQ61LqCfTqKJ2wcPo/zgjmO2BiS6tkgRih/Gi0XRIYCABxADDHT98I2HVyvzU/A1
         djJbUeL74d4jMn70Bev0C9NAjMdbKk7xepPqG4QNTrbsgHaylLMgTa9tfmO37CODknEu
         +E1/4EBZQWP3owZXPGPNAZJoaJoGF/43yIGsyO5nvGgSTyu+nuWPqb8WztbMWQUYhWMi
         OoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771339712; x=1771944512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        b=Rlgjp0ySh4nSuzyDb90n4rZ46AqViy3Jc/CyODfUCajseHw9M/mHCOepjktmZcA360
         o+blZjrudvfP0F2zSZRh5vyYzNTTlv8bA+0WSQkyMWx+Vs80U+RrYuIlWdRlMvKxWFlK
         xeNrxtZKNaYqM70mXXj0qgo170WScJJJ/T/veH+97qsZu6Tco3BA9lLvVtZSC4v3OSFF
         UryNjKbXFQlmvvgy6op3nfmIeHsL9rMeBAxj98SH+fZf/qRKm6CR08MJeafvBg2/6qRq
         FDbniPynuCq0h2ntFCzoLwp4h3M2Bgcmf1C/7ZuRluRMUxEjvtWQHfV6vO1spuMEYG3F
         XcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlRot8j2I26h/BTMQ0YyIrO75zGSp6V8ejVLg7EnsFiI73rjIWD2aKc2f3tLX5A/MSIDW4ANd8OM1FPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbRH/TH5Cjf83NDoR9npH/1YIxk1VgdJxXd0Kl+E0pV0QeOad
	9+KWEJx+2kvrOlRXb6QgNvoGH7ncs0+PMCbbF4qupFjqPkmLmzVPAJ72Y2aRQlRXSFW2ZZ2suTU
	kk8vfxsFKE0FcSgGaqlKdKUxJCStCzUMFzvePsWr93g==
X-Gm-Gg: AZuq6aIEkqbqdxoYf17kL81g6ou55D2ay4q4/EYZ8HXylhlX8qQfumpW7C11KZxRwKX
	uenV0dveQkMAZBiCNlecN9K/7GNJ1v6g+Vyh3XoN+rHjz9uAsOJr4toIQNrWTLFMslFoV5eASYf
	xdH9TQ/nAo21aOkEwZtafBDB67ZEhNYVp+MS1v/OiKszqWxaJULbVN7qV+dJjYJc+GcfQP1Ay7g
	U/CnlqfVN68WoAIuJiCIInRJg9hGDQFO7YDFDM/pgDsfKaiDqxFO1MtSTLLj1N3UhtnYpyu0XXt
	tCymovBOT4SQ4fBBxk3Z3kIMD5Ngw53/IZSQdGSDkWlxEvxo8QSHpzk7LCBx1CBJ/JEnZXzgRuL
	Id44w
X-Received: by 2002:a05:6000:1a8e:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-4379790e98amr27190797f8f.33.1771339711651; Tue, 17 Feb 2026
 06:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-9-neelx@suse.com>
 <64126c50-063e-40e4-a536-233cce94b65e@infradead.org>
In-Reply-To: <64126c50-063e-40e4-a536-233cce94b65e@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 17 Feb 2026 15:48:20 +0100
X-Gm-Features: AaiRm51hHUsbfTUEHtSwC9qIQM4TJ160IJ28Zz9PQrmVkFY3H02cMBpf6HPloMc
Message-ID: <CAPjX3FfLFDS5Q32BzbhPgohsX250f8+JX_YbKPLVaGqVGcfV6g@mail.gmail.com>
Subject: Re: [PATCH v6 08/43] fscrypt: add documentation about extent encryption
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 19:43, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/6/26 10:22 AM, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Add a couple of sections to the fscrypt documentation about per-extent
> > encryption.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > v5: https://lore.kernel.org/linux-btrfs/7b2cc4dd423c3930e51b1ef5dd209164ff11c05a.1706116485.git.josef@toxicpanda.com/
> >  * No changes since.
> > ---
> >  Documentation/filesystems/fscrypt.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > index 70af896822e1..8afec55dd913 100644
> > --- a/Documentation/filesystems/fscrypt.rst
> > +++ b/Documentation/filesystems/fscrypt.rst
> > @@ -283,6 +283,21 @@ alternative master keys or to support rotating master keys.  Instead,
> >  the master keys may be wrapped in userspace, e.g. as is done by the
> >  `fscrypt <https://github.com/google/fscrypt>`_ tool.
> >
> > +Per-extent encryption keys
> > +--------------------------
> > +
> > +For certain file systems, such as btrfs, it's desired to derive a
> > +per-extent encryption key.  This is to enable features such as snapshots
> > +and reflink, where you could have different inodes pointing at the same
> > +extent.  When a new extent is created fscrypt randomly generates a
> > +16-byte nonce and the file system stores it along side the extent.
>
>                                                alongside
>
> > +Then, it uses a KDF (as described in `Key derivation function`_) to
> > +derive the extent's key from the master key and nonce.
> > +
> > +Currently the inode's master key and encryption policy must match the
> > +extent, so you cannot share extents between inodes that were encrypted
> > +differently.
> > +
> >  DIRECT_KEY policies
> >  -------------------
> >
> > @@ -1488,6 +1503,27 @@ by the kernel and is used as KDF input or as a tweak to cause
> >  different files to be encrypted differently; see `Per-file encryption
> >  keys`_ and `DIRECT_KEY policies`_.
> >
> > +Extent encryption context
> > +-------------------------
> > +
> > +The extent encryption context mirrors the important parts of the above
> > +`Encryption context`_, with a few ommisions.  The struct is defined as
>
>                                      omissions
>
> > +follows::
> > +
> > +        struct fscrypt_extent_context {
> > +                u8 version;
> > +                u8 encryption_mode;
> > +                u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
> > +                u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> > +        };
> > +
> > +Currently all fields much match the containing inode's encryption
> > +context, with the exception of the nonce.
> > +
> > +Additionally extent encryption is only supported with
> > +FSCRYPT_EXTENT_CONTEXT_V2 using the standard policy, all other policies
>
>                                                 policy; all other policies
>
> > +are disallowed.
> > +
> >  Data path changes
> >  -----------------
> >
> > @@ -1511,6 +1547,11 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
> >  buffers regardless of encryption.  Other filesystems, such as ext4 and
> >  F2FS, have to allocate bounce pages specially for encryption.
> >
> > +Inline encryption is not optional for extent encryption based file
> > +systems, the amount of objects required to be kept around is too much.
>
>    systems; the amount of

Thanks Randy. I'll amend all these in the next iteration.

--nX

> > +Inline encryption handles the object lifetime details which results in a
> > +cleaner implementation.
> > +
> >  Filename hashing and encoding
> >  -----------------------------
> >
>
> --
> ~Randy
>
