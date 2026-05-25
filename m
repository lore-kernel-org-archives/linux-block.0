Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CC1DED40
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674879; cv=pass; b=NgBEkviLXC/xzF8rTGk62+kCbrJkg3xvzpntCqy1ZJktD5WG1jBqh6aXfrHrAE+PVu91xInAKvqIbh0Osapcuo4Mv9F1QUxRDZzdvll3sy/zrYk+Oidohg0LHvqGNfTeHgSMF+fWg59i0IhWByg1HcmC+562YYACWOVm6w/v3uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674879; c=relaxed/simple;
	bh=Mj0VKG2oyBynjSSc+Zyi+sRM+jukULsqfWz363aIiVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7+jRoInffvJbVWMB9SyMboEMFat6BDGfIPP3h+BsTwloywQET6YW235kBhjeYuLLfavqpRishzQYWyJA49F/SnuVVJlJWb7+laiSzT+HLcQXn1aRu0tWtGIYJQ37WEHMyGlMj+UUtqL99nlJWyd5/Fz1VSsd33tvV3ObEPTr+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS5KuPGK; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS5KuPGK"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d92dbc420so1152508eaf.3
        for <linux-block@vger.kernel.org>; Sun, 24 May 2026 19:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779674877; cv=none;
        d=google.com; s=arc-20240605;
        b=kS3H5IjKfUotEBN4yVPd4Bkq+jlDnMGH4B0MoakRCcWq3fEXhFcP2k+AJEi/17aNcx
         56iL/g/yVoYNScpwV+0YjiqqVsozhsQvNVDtuH/26kT9vFENAaxWaruBEOdVGnvGyhnZ
         oZs5Pr1Xinug5jxeOIi1pmlIX0kB86KrzJywrlMfv8MyTSJOLlHzgBCwDIDBHIsF93MV
         uLJL+XbtX9cVbAgoxBFuEaTQjsNAGhMXLV3lAjlvWwp1ek9d6v0Ew27pmgXeSzgFnVhW
         aTQYcYZt3FFPtB4OqTbdP99cO/25sVHjg9Rg52G83iNzcpuf7vxj6vzm+gzotcMg6qCe
         d0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oNLeL1OYfTrqb5LOTrhhBd3cYXu0AMi2GPbXgT6BWxg=;
        fh=+XTDk9Df1SZb7mujoYEZzg807T6jN3qoNQjka59fd0c=;
        b=KKL/gfVPsgRlf+7CrxVYyWYdduWnJ+kAzLSyPqd30NepQmqSZ7VOOAAs3+ByrL/Emm
         0TshXCQeB9qesaKcEE5pQXXiOMe6HYquDPaS1O6RVGi3nqhqO3/dkUQQ2Wm3wLpnaq+G
         xegQGGj3BfEBu6teS9LOJYctl6nZFgSZIp0ce92L2Xkq+oREFtS0/wl0qBXOtizOV5mB
         TC7X/lvQJlSjbYvayer/q8zARzgb80GzpEdukG0Yg4H6dE9f0+rxbdG9ye5zWSFmo5CF
         zIeJ33+iwqx3wKQ0CaEzliq0YYcmtnT9P/N6LOIQI+h9KAxeoNIxnkdKL1MVRp5SFAVO
         zdEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779674877; x=1780279677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNLeL1OYfTrqb5LOTrhhBd3cYXu0AMi2GPbXgT6BWxg=;
        b=bS5KuPGKmo9Koovw/dAHJji++cwXec0nGnaosB4fzqH57ETI7R+SVjzM4p4/DdFRox
         TtZHoNhT+RFhxy/g1BXJSQHbkhvz8+QLpS9g7auSQIm5U2m4b8+QhyiIwmbq0QDs8oWA
         eotEvGv71JDOGBsahTv2QZnoXak6oNcQ+5JT5nOCCOXL4OCOgvM8xuauuNgmnKyI3iOC
         SikCu1Tg/dw1FnN75jmrzp4FtEV9xKcEQUV3VHELaBjqoCkzFzGdUSWeg5fi3SbR2gIF
         cAksKixv6biW4w/UTLLHllqrTwPyrC3Q27lWEAHTa1czLOqqJSsDHhET/SVABZPiW4mt
         5b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674877; x=1780279677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNLeL1OYfTrqb5LOTrhhBd3cYXu0AMi2GPbXgT6BWxg=;
        b=UJXQ3M6+F8Em5DFaunS73zQvZgmsXvQRmGROBhVIFyJFom6CIqopqhou+eTGkOmeXu
         aBeGJ82/O0hjAdd3mIYMAlmJR3NAtC8dVVC51A77UMu+FVR1uD1J1rVXBNxAog+aWVlc
         wn+KbjGoix7X6HFL0pZBwJw+NOc+SxCKsjwYlk8L4hGKyYf087SUBgJy5GcNG445N6hR
         UeDONnE0+SWxhT4TdVHiFY3Nt53lngLq3iy6ntxtnFVzb1YOQ+6VxLz9L1daqG0M2mwJ
         a6s26qjcKV2ibIotYbl4V0SFifl1EL/dII6AL/3xUVmb0pgTZv3fLV2PpQ2mIOa+FW3F
         YOVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6OGoMMEFT+STbrVLGK5bbocmIQFqlBYrHNto2hoBJvdftQmWHCwAT+HMKEZC4o98Vvm9pmbD0BC12yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuK9h+K8AJQoXjcMGAoOyaL7nfIeB8Mx9z/Y7PZ82FNU1mkv+T
	BrHb1xzdJyZhLGBA9/iWz7sAkfnTx7Y9Q2XhkXeJlCdJMoxrwda1HswVqcYai2InplfVf1FxALT
	kYK+gZgRRrCIdcPwCWw+sdV9mgefy99U=
X-Gm-Gg: Acq92OEH2g3MDy1nO/3Pf3J7xo8Z9sq7D3M7kOV2apeBJRzJBlCJ5Dy14ZRY0QQ8uVo
	8ne5Ao/zVG2xhmKwIzz1gMwjBXmpaWTtDlKaltnhjG2ti3ocwDnbMf5gyOp0u6YX2JkumhDPTHz
	ud4g4Jph/8YpG16SSoeAsk8qje+mXk5PU8uPE7FqfDy2v7Hrc/bcjsJnscWOjXsaIK6gFMqq+m+
	18pNHMK7XZINrJaTMbmDBzu6JfWR9OFrMCBX8RC15xmwxSmzApcOX3j13hIayQtuAY0oiADJ+z7
	X+sMXfEVQQ==
X-Received: by 2002:a05:6820:a0a:b0:696:6f52:95f8 with SMTP id
 006d021491bc7-69d7eb3065dmr6682220eaf.3.1779674876819; Sun, 24 May 2026
 19:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522141638.298530-1-yizhou.tang@shopee.com> <ahBnKR-IunwxVDzg@kbusch-mbp>
In-Reply-To: <ahBnKR-IunwxVDzg@kbusch-mbp>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 25 May 2026 10:07:45 +0800
X-Gm-Features: AVHnY4Kg1Q1B_CQHoSSOh5jCQ4sew34bm8RUGZ3jtvjR-FyDtFLgqjDdS7irsY8
Message-ID: <CAOB9oObj75KCCfV0frti1_FDaRi37OrmFAquO=MvTXDpBEZ3BA@mail.gmail.com>
Subject: Re: [PATCH v5] block: propagate in_flight to whole disk on partition I/O
To: Keith Busch <kbusch@kernel.org>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:53=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, May 22, 2026 at 10:16:38PM +0800, Tang Yizhou wrote:
> > @@ -1073,7 +1073,7 @@ void bdev_end_io_acct(struct block_device *bdev, =
enum req_op op,
> >       part_stat_inc(bdev, ios[sgrp]);
> >       part_stat_add(bdev, sectors[sgrp], sectors);
> >       part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
> > -     part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
> > +     bdev_inc_in_flight(bdev, op);
>
> This one should be bdev_dec_in_flight().

Thanks for pointing that out.

Best regards,
Yi

>
