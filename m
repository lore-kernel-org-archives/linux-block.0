Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888836A372
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451245; cv=pass; b=OvstDbM5AlloHEgyc4X++x8wQioiW1yyOkptHn5bxgc3R6afSJLtYoi0dFzKJqL0yZdI5ZLRltfWAeft3sO7R//Iy/pQ7zS/x6jpKEG9HdGXtwHudsiw01rsEPgAmN9xAkox5X9YaaCvB6GTF0Wkir5KLtrQ46lf5oCaXWIjNZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451245; c=relaxed/simple;
	bh=xlJ7dUMljsBSIjHOpjWzMVXJP09oDEZOhL9iMhou8is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl9WULGpCAxA/2IWavmElAwGHWVDW1USbWewM63qikwwdJdKmF0YeRsGc1eTg8KDjpru7WwbBDczl8oPHj17ZvnXUzql9P0nNMt6rIwno86vRQWflF/PtYzxTfnLF/ALLJNnw9EJO2qZ8qoicFmGeSN6BTnGWZY2UD22mEAuZKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ykt8rEYk; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ykt8rEYk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so3479143f8f.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 05:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779451240; cv=none;
        d=google.com; s=arc-20240605;
        b=iCceSMKaFDPufH1V6v88K83T5/J3+XL3zYtZ5CIsinIxMBu2Gqmrmx9cDAzc1bGUlC
         XneQ3ns07jDCX/14SSDOcqGyoqhiKajpqdltUBIuzU1KxQEHUm14YpRBSWdIBNavp643
         nwKexQYnQ2dHBJHm0OYRIg4SEE7s6ygPoOOu8U7+ijwONST6sZF3ZiDW9TekV9cGS7TY
         SD2dS1aaX7sb0TvCy5WdBQ3c+bv9VqPp+1e2euSwxhE6Hts/PsaFqZM06+8tSM3hWlye
         x1RxZ4ytJm0VbDYNbd4gw5DCfYd+z/ngsXFXB1cMiaQ26JGi2l9iRHBAzNYOIDILP7E9
         l8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xlJ7dUMljsBSIjHOpjWzMVXJP09oDEZOhL9iMhou8is=;
        fh=Fyvd+LMsVDMnkq2/hxuxMWNudXyEKaMDLVBIy4dkdQI=;
        b=IbXreq5YdHjw7RBFYG0w1rd/WBjcgs3JBcdD4bzTOQIFR7XvBMUkIjbatcWN6HnhoB
         JH85/Nmt/9IybDoVjrfbSJVYpiMubal6lWcxOecrkYtjpqPbitcTK0Oy5hROM2og/mrc
         zHhpVV1mL8Gyf5JsOeC3ElR89WrIKDMjlg5ZKxudkAk1XzSZOOATZuUYLJv3AofKuow8
         CU+L38RgMwRa7j/5nkejlAIJLyeJVTepAdw459BlIRWjh6RIv2uyi8OTK1TbxDfeQ4En
         p3IrMTA8T/dFOOcHvXPZbuG7T6UrS3b4DQ2eVLybnMKJdAoqCbxzAN/urNE9TOyqiBk/
         iDog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779451240; x=1780056040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlJ7dUMljsBSIjHOpjWzMVXJP09oDEZOhL9iMhou8is=;
        b=Ykt8rEYkjenflb7/tF/677oVnGU7WtpMdZ6ISzY8xTpgUY0DBn1gluzaFRb00NlMLR
         xLDc2uU/A2VibLCdHftPzNRSQZiWHxIYzJ4aQ1G5as7cVH2ESs677x4uEeP4ABQ+1Xin
         d4fW3zhIPaQpSB6A/Smoclf2pUhu5oqV5TNR3Oba7JEoc4yS8bPQwCyHBHWSPaGRXf26
         OeNrIecdYr6J1T+7NjCAAin82H3sBtzZsbxOWHbmxI5BlgCRp9i/ExfBOYR7FLCB7bxG
         QB8PG8BVHWtlTgt3buXhNjQpq50tGP/dd2RNRtELocYHswOIPfFLghpCCuF2TLaKJz9b
         bGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779451240; x=1780056040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlJ7dUMljsBSIjHOpjWzMVXJP09oDEZOhL9iMhou8is=;
        b=SXSAnD+NXG88somns0k3MAgqvxFtn3uX2VvOPgxy+llII450nC729vzHkue0DKP23/
         fQEjHm9jFAVxmCwNwfY+W5mdwPFJaOz523PuLsGJES+cl2hCNUTOfvBcubpK1WbemM4z
         NgxAQn4qNhDJC6SA2LaO4txmVHBCVaOOAGde8REQzxl/UOYvfbghzPKu6nLSw6yr0gMR
         3XX4NvBEspeH/MYxe6tm9WAIlxKEDwXOhDmeIU5vqOPo+9+3l3yuuvIAq+dwKd+ECghQ
         CFiZSS1kiI4mhdcoR6hexk4L5o/G4NFld3KvdN50ZZDb3eeiLtbcOjkKfb5qcFvoR0Et
         7DDg==
X-Forwarded-Encrypted: i=1; AFNElJ/csZEAd/jDBYs65Av9J5bRUYxfa0wbWdSSnyine5qUbGiFGd3K8IVKibZz+ebfwvjJgXyUqDILLYiaEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTxhed1f7NfKJTeEgzWoWwf0eJWvXUWt1/7+ZgNrv5zyFRfw9
	+LSqe8PBnVdsn3QYraxUW9U5z5Yy/FSFDuv/ZckhvmbubMSAL8oTMycZ16MkBWqL7iIO65JGr4q
	ZXzn+GLw6JgT1aj3uYUuwZmqTdoO9lMzL2Kpe5i0qfw==
X-Gm-Gg: Acq92OFm2knYDWndPOAawBol57P/xzwne4+tT2BLx2SJqnzAf83+vQ7erIPOGPn4Xb8
	/Ebg6h924WPOY82Ig6q9fZkZkMaVtXXXba/nt6Ytxw/3A9HSKu/mdsTDHbS9YWKAypS632Em+6m
	DOAMqtAffQQqGE6sc1q0ChkXETQSuPqOqAKNuGpxL9eZ3U6JaaAW047KKiA0b3dSV1VZN+5J5Py
	6FeO250g6PhXgtEQZKwS9Nz3jn2bk3uFEMDYvQtf+Ww4x9Qi2bs5kuML9jRkRpddgxn5Hjcnxpt
	pKNvBT68MYyar/fDm1AjH6qjVziMtHDkT4Kq4tUPFroEZkIdb1oM1ejWLQwILFDfq+6VKbMMdGd
	fVMGntIjxpzxVPgA=
X-Received: by 2002:a05:600c:3547:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-4904224b05emr46591285e9.0.1779451239711; Fri, 22 May 2026
 05:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-18-neelx@suse.com>
 <ahAfvPa_yl6AKZoW@infradead.org>
In-Reply-To: <ahAfvPa_yl6AKZoW@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 22 May 2026 14:00:28 +0200
X-Gm-Features: AVHnY4L-B6zCGkAkTyjhybBzvlntESV7mYOAACpjsS69rRBft3tIVAlMyDpZ2_s
Message-ID: <CAPjX3FeoGzNOBnmY5ie34irNaAOZiFqV_Ccf7dXFrZJeUXh8PA@mail.gmail.com>
Subject: Re: [PATCH v7 17/43] btrfs: add get_devices hook for fscrypt
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 11:19, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, May 13, 2026 at 10:52:51AM +0200, Daniel Vacek wrote:
> > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >
> > Since extent encryption requires inline encryption, even though we
> > expect to use the inlinecrypt software fallback most of the time, we
> > need to enumerate all the devices in use by btrfs.
>
> How does this handled adding/removing devices at runtime?

When called, this callback returns the list of bdevs opened by the
given superblock. If devices are added or removed, this function
returns a different list.
In other words it always returns a valid list.

This is called from `fscrypt_get_devices()`, which is called from
`fscrypt_select_encryption_impl()` or
`fscrypt_prepare_inline_crypt_key()` or
`fscrypt_destroy_inline_crypt_key()`. All these functions walk the
returned list and discard it immediately afterwards.

Note that with btrfs at this point we're only using the inline crypto fallback.
Is there any particular reason you asked this question?

--nX
