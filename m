Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63A394788
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453426; cv=pass; b=oERtbqYuT/crhd3d98RD8G6eE+p65AXN7IziYAqC7T8A0fqyzNHQ4j+CjvGgL1tAMxKmXBI2oo18f83P3o3OLNkbFSYzXPhOCZH62NUaRHSXjFDOS4vXRVepG2V2K5K2HAJg15vwooK82wsb/YHx9pwYtTbw0sZfS4Fv0caaOWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453426; c=relaxed/simple;
	bh=tZ7Vr16O8Hec85rRbio7y3EbqChRXhggJYLkyQ6LEds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQLVyAsezsQT5nRYWhoeokv1WoO/9L/PRBlTgARXQbCoBBau0aHz3iG7QptuEYjhAkydvHxYM9AIFjDfkFiLSg4ZT1XjgyBenAqr+pGJZSTiEjAB3Gad2GGkYQHOP81AArefJyw+9JRJjb8/8FLSEaPOP1n9vkA76Jac3C/7ZWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Ae+KUwK6; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Ae+KUwK6"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a746f9c092so10742141e87.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 05:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779453423; cv=none;
        d=google.com; s=arc-20240605;
        b=ENuubwNgUqlYfjlyj6ljGSQ8j6A1zb/xriWE5mg5a9Lx6GkK5znSbLtFOMX9rVLbSW
         CENj5cU3FS51B/HfEWlA45v3UgqZR9MUdLCsnYpXUOVWZfdblIOrHPBBIPYiO7AeT/F/
         p1T2bWiqGGfIrVx9TEK83h9qD4ZCtzzbHpzaK4hDobVygGPagH/RWeElRT409MikoGR9
         /QZ4w7xkpvJddOMxHyl/19qmtyqv+gMJSbjwaIZOobu/DsYVPHVESZBi5udu/wvrlBEF
         NIvFoZ2wKfAKZmXjT9f7bTW2PzIEyGH4rNY1ikxRE9bWcTtPrNbBEkvxoEODBb2zpMwv
         ppRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6W3IP6GDpzrSYikuTvRwQBE/25kPdY7yfWifFgYPAiw=;
        fh=D6dm0eUnmeAvtWhKwEDD1RWN+dUy0FkLmZbfFYKk6yI=;
        b=DR4LhD4lgJVqVV+LHYFPEasAGmfY12g6/OVfqRgqzYVVQHZJC+WEj2LHLYzfchsI4V
         w6ociXdjM+y+UwhOTaP6ZmtV6FDw2AJpvvLRwTbJW6h5DvEGyuUi90DyR7Z2acHDpfJC
         V2sIMwXpbeS+bva8roXbzdZORWJf+4qOX7iXcSs5CFJMUAWwdayrUun+y3cPxF8JRfC/
         wHyDO7T3FsmHIKq1MCdJDxKEIIWMyB3OKB7TfpT9Q0ZguMpmkL9rvaFc7/gukYs8y+UF
         a7vPlDAmtLPWcMx6bUAXakB47BkUdhbCOpM6N7JGHv9LvlUt30t0jqSkNqtCUg9fYO+G
         EOQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779453423; x=1780058223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W3IP6GDpzrSYikuTvRwQBE/25kPdY7yfWifFgYPAiw=;
        b=Ae+KUwK6Tqy8QjS8RiHdeSx1on0dDaYwUGEdjeIbPrB6Qh7SfLDaQM6Um8ctBHK+Ku
         02wibVHDLRdJV1o1u3gQpdpgqtL8gOMnz+d/jWqJMpkF/4pqMmcL9B8+O3MiJaikQiJA
         W+fq6kOCvi6Y5vIpSrhb3z3HvHkvHO3PCTbsgDiAL5CPVnMSNp30n/dDxq4N+/JR7qCj
         YrRcjaPg+sDMXms+YXyqaAnBIgTkb0oDHiLkvrsvTyXDXpI9WP2sxc9xoNP+HxMdKJYb
         aCfZzeoxDTw1skT2/2DWF1jRFg8rn2hhipDiDzc7YgzwsmC2g1uOa+vlbG0j1pT+dVau
         Jhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453423; x=1780058223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6W3IP6GDpzrSYikuTvRwQBE/25kPdY7yfWifFgYPAiw=;
        b=qNEm6Udol051B0pwCF/nQ89rE/uyLGGhbybsVlBQLodM7LgpMUNSfVCKtmfo16Qy8h
         I+/qKoRPcgtNO9iEjFIapaHQx+19udwA2N9DlnsfYerbdglDM6oe2qMnEtJhuJ1U/YwV
         YHcSfTiaTA84DjqCZoANngwFArDlzmY/ARAfYNzUOGxrkUcS9KGsI8MjZQQrU8PEW+a0
         8JI9SJtMJQF1ru6RpImm3gm1P2bJ+KsSSUSExWBEgVgn/dBU0iOWvu9r6Gnl43Vtnu1W
         Th+pZYnacfrwrThSAFY2u62g5grZpcITYhi8UkBAO6WWw7fEu1+CSaVlMQfYMq0rYGOJ
         easg==
X-Forwarded-Encrypted: i=1; AFNElJ+RThF9R9TlcFU1sEpe4YyycIcg6r4VaIAPbTqetjdrksMVgSFqHYYtVUxD5zfd8Xs110nnrEzQ/FgQcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoomOu10nZENLwyGt+J9i+gynQTSjuv7dYFh2Mwb15AeWXoVL
	wMj38kqahyNF4kZWfQS3Gl7DJ8GB+hwwOmbukm+BJ38cr+3xDHT0n0rF9imGmKTXoFUjNqmYdWe
	Lqk+BCKkPGjieRrz1nzv/r7pEMXah5p4xDUC4x77zgQ==
X-Gm-Gg: Acq92OG/GaR7UFip84TnuxdGD7p734i6kzmgfDwi4TL9TdHqw7iryjRApTcax4ISjOl
	PMXd0sKK2Vp/Q24/5XrpkG+LNxWMlACbFJibBoLJhUDNpIcsYliaraGfiu8UTR27JD0sQ95AVzB
	YSIsQnInsgJt+CiuxjwfFwmDDKzDXSti7EGnGsh9VWh0W5aRy3w6bWFI89PKSMnILmGxUDMOsXe
	r2//J3tix4q5mMCm05xJTB2lvDziOxvCNK9eXTMe07MBJYaLDY30Gs5cOgGNXEFAYm16bmT9e6T
	dxTY5w==
X-Received: by 2002:a05:6512:3e26:b0:5a7:46f9:be3b with SMTP id
 2adb3069b0e04-5aa322fb14dmr958020e87.14.1779453422742; Fri, 22 May 2026
 05:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522113751.171630-1-yizhou.tang@shopee.com> <20260522121219.GB21338@lst.de>
In-Reply-To: <20260522121219.GB21338@lst.de>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Fri, 22 May 2026 20:36:51 +0800
X-Gm-Features: AVHnY4LDrzKGXHb9sI7dAGj2P72m9yJoyj7NC29hBQqTftUzx_URtqIC48b6XpQ
Message-ID: <CACuPKx=zxKfG1vSMW_+CrXTc2uK3nrEBchnLhoH6uZ+Dq3TheQ@mail.gmail.com>
Subject: Re: [PATCH] block: propagate in_flight to whole disk on partition I/O
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, yukuai@fnnas.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:12=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, May 22, 2026 at 07:37:51PM +0800, Tang Yizhou wrote:
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1043,6 +1043,8 @@ unsigned long bdev_start_io_acct(struct block_dev=
ice *bdev, enum req_op op,
> >       part_stat_lock();
> >       update_io_ticks(bdev, start_time, false);
> >       part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
> > +     if (bdev_is_partition(bdev))
> > +             part_stat_local_inc(bdev_whole(bdev), in_flight[op_is_wri=
te(op)]);
>
> overly lone line.

OK. I will update in the next patch.

>
> > +     if (bdev_is_partition(bdev))
> > +             part_stat_local_dec(bdev_whole(bdev), in_flight[op_is_wri=
te(op)]);
>
> Same.
>
> >  }
> > @@ -1144,6 +1147,9 @@ static inline void blk_account_io_start(struct re=
quest *req)
> >       part_stat_lock();
> >       update_io_ticks(req->part, jiffies, false);
> >       part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))=
]);
> > +     if (bdev_is_partition(req->part))
> > +             part_stat_local_inc(bdev_whole(req->part),
> > +                                 in_flight[op_is_write(req_op(req))]);
>
> and tis duplicates the above logic.  Mabye factor the common code
> into two little helpers?

Sure.

>
