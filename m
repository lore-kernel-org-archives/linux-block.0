Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38438322A
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037201; cv=pass; b=bAvD3MLSfW+CNfYir3ptr1SSOXiNiBZJAG4pVx202/8jaN5iAecvP8UbPZj1SfoD66/sHQftyxO4SKpyUXB+pWEomapn8YQqaHuf8WIB8xvD6R9PxW16rUK7Xqn7+WxdwC0Kr1a4RMIrW/TYjMQqOFwfM5tsjhnQYzzM8hmBacY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037201; c=relaxed/simple;
	bh=gslqVT1C4ZAxfFgX/Lm3Op7ina+YCPCXFvipiwlHJKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1PjYq33hSpq6lwf7i7huipQa5tNiFMiOEn7dsRgkhJgOtfFLEBcybtrwIjh8QHTk2YaInZMgkmvVtmCaE5atQl2B2tk6mjEhnJoSJ4Iu7Ajv6DJpJ0D/qqBd43u5Db6JccrOOt+aqXMjF2pzWFGF7L3RtDIoY4/L7oBRDGP6gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVgJB4Vt; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVgJB4Vt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b691cb44so16947045e9.0
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 17:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783037199; cv=none;
        d=google.com; s=arc-20260327;
        b=WXni3SCgq04eE6glfc1Pru89aHaX3M4TTyXSQId/hOUzEec2DD9P3Bs7K726PfI0tD
         sZtAs/Tz7A7lBJsP5dI7mNns2uhSppBvih67tytYHvDhQkl6PGgWrt29eFQd28Qry6H4
         eUXucEDfbIxIkx7Thn1uu5EqjRJzicPScN1AOdI8n4HykN76wnvOPj7v2QMj95UKc7UA
         ZXMoR+1Mn9TRW/nnhWj8yBUmWA7tmtems9Cp+t6b7sm7yQ0Pln124l892bg4L4wPjK4e
         vpZDptq4k+0F/Gcz73xh1dUHBVUMLDimtQinx2+pva7wBLw/sO3ON6CxKXdYx5Z28mdX
         LVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        fh=tzTgeYCgrRkVixc/ilhLwMMMWQprBrhOupuECSvJLAM=;
        b=sSRcgmjBl3jVuyPTILySGIOMB5TLayl2xXFlkpkE5VBhHxUdYFDxyjmKNlVcxIQlXJ
         VZMbPETaVysicjL/tXJbBHLP/he5s1U8fFj8HddoENpDLxJs09Jhz6fa7I+H5yOc6GaW
         3fE5DYv1QyT9c1valSdSFnk/78LxuV46OKynNoh2x3kOd2IGJnlKwVpK9YG84T4W3+DW
         sO2PqvPfIoopSFIzC+RA2S/PHNWWBOFrlESrJktEmSlAQu3DDRZ5eaDrgPmCQLUzmWVf
         wvYwi6LOpYKbPJqZAgfUNyO+xhb4mYQA/UM6FX8Ex3oa0puwzTXQ+4Y8D8h2lCscjd36
         dcAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783037199; x=1783641999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        b=AVgJB4Vtx27BcO1cdm5VPuhyft+sx1vbQjIKHjikjMs3dnbZCKjrLRwVIM0F82Vgsh
         Zlk4TqaBr8IH1nrscltvcgU84AkaKC9lglxNZt3ZW0hHoIGEM2ds3TLsTjrMU1vziRDB
         obwI4W3FpS3n76EF05KUJ4CRPXKvah3HjfKvZRYjJCXa2cMHm5VxSe27eir66OprVPMI
         V1MxZ6ew2nFkEQQk9TUMIz2ElA20dBwYPcFdDYGUc5ioml+o5YzMIoa33Wn+ZiCkUeIN
         Hq5I2o6sQ8Nuacr5iYhX9Ff7ZTUhsbObNEVb7AmMqIWQWLwU2vqGM17ukNUCra8xHT/y
         GXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037199; x=1783641999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        b=YY77m8jejGBRLs2O5zQzWu7ngTVCpWroSIRRJrBkLKmxgld4lBBx+CkZh1ezXk0a7v
         aJQDDKszUEKC9bkgXV7v9S0xMO1/zV2opqhrvDYuR6BQgJMSkUKDjcuAwwCSP3qUbAnE
         ZPTHWM2VCbhEMkY2+6sGoZEDAZ4AJ43L+6lPg6KxTQmkSkNslfB4sTbW/phoBtUU6BEb
         DFwUTBAAdGADhWcfH6voYkq13UMUU54Wfk0Jlcm+TWpU0WPjbdkWLjuUmoXUUcMC2YhI
         /NEmVk5XeQ1wTWUMWKE3tN1a8+OCkNisKtLerGuwrug47jf9oA7RlhvkkPki/Fdz43BQ
         99yw==
X-Forwarded-Encrypted: i=1; AFNElJ9X+rjt5N0VxqscqZ/Gai7Nn1sxv8AucIXvQvKTVvqS7OltQAtdJWCZHfBXBYFb5piCntZcSj34GYX48g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WUX9FowQAudhxLsNyQmAnC4y4V9EwP+4oWHQ/odFqV2p1tJ5
	8AYcXIzJGSdP8mMaUp3LrURsOoTQi3CwM0V6cuJJIlmsJc/2WkDELMs3f3e4H6jX2eaJGBbnoAX
	TMz1Hf1u9QqyE/CT5Tk/rc0r37qTXnaQ=
X-Gm-Gg: AfdE7cmSXw4hSHdDNLH83a2qk3gtUNtJtOLU4HTcz/jivr70ya2L+z+bQ1uMaaQagAB
	1takzmHd3+vOknjO4uFCNlutm2LN7bbH6tY2DcMeRqIN2qOPPZINaVUe2spg/xV96yBrDuIbP/C
	iMDqRfQR3ycjT65QqZsWec6UjiHzhvmsbXO8Zp20FsASi4IT6oOQ9Ng4pN47MLo0V1XaZ3NUdh6
	et8G65ufm4WiMBfV671EgekQgbz31748TIxQxdNRPDMSt2aBiplBX9jVqj5W12FXR5MQ7zRUqjF
	VeLAOw2WHhdsRjA//5a6xwgf5ap+cbH5hA7dNtzl3Y/Eii9oBz0p
X-Received: by 2002:a05:600c:5808:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493c2b855famr82697505e9.23.1783037198482; Thu, 02 Jul 2026
 17:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-11-joannelkoong@gmail.com> <akRlehPHzy-F_105@kbusch-mbp>
In-Reply-To: <akRlehPHzy-F_105@kbusch-mbp>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 17:06:26 -0700
X-Gm-Features: AVVi8Cdk_C73wAd0LEg65xZ99iaBn5MPuJR0EWtJiHzmTYc6q8IOOPpqNnJDiic
Message-ID: <CAJnrk1b2T1GiWzvBKaBg-97sEZ_9SA6EVEUO=9CknK1vS3oJ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] block: convert iomap ops to ->iomap_next()
To: Keith Busch <kbusch@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:55=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Jun 30, 2026 at 05:09:25PM -0700, Joanne Koong wrote:
> >  static const struct iomap_ops blkdev_iomap_ops =3D {
> > -     .iomap_begin            =3D blkdev_iomap_begin,
> > +     .iomap_next             =3D blkdev_iomap_next,
> >  };
>
> I think it's generally safe to use the same mailing list for the entire
> series. There's no context here on what "iomap_next" is because I'm
> subscribed only to linux-block. I found the rest here:
>
>   https://lore.kernel.org/linux-fsdevel/20260701000949.1666714-1-joannelk=
oong@gmail.com/

Ahh I see, thanks for the heads up Keith. I'll do that from now on.

Thanks,
Joanne
