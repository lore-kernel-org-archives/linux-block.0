Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680A1E492D
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397306; cv=none; b=laqv0YEsD4cgtgMqV157JqNJ3ycSZn091pat3wWEua1nRncEyX4MFaaKh2BrEw8KKq3gMjBXbjAh0GO2kJsNECIkwvojbNwbJkuxISni2wWQa3Dc2wxWjLcPmYD91z9vmlSTidZxRToG01RnPQySFpyMC/s0kvhHCiYVhx3iXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397306; c=relaxed/simple;
	bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVyYwxERJoH486+OR22u4lPVnM3h4HpNfAJP4yBDuMR/15p+Qw93S+tgOvxLZA6Sqm9lSaO3RKFhnqT6JsjXmvNgHaOj5truisu8sIDAWPhAts0oLwtQBGcOZqluXquzAGZSfArLutiP37L69jw96X7nz9fblM7RQjmCcNJ3gHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTsjhEA/; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTsjhEA/"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfd380cd9eso2729882137.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766397303; x=1767002103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=;
        b=YTsjhEA/mxXuVWllpGJn8KGJQCLFwIh1OLqLUh9hzLj2jphX3J39kBVtuoG8Xp9UQP
         2V7B9aILJCuOEUYS9jDLk/9PZDCrJMGAR2dCwrXnPv/o4TkN6Xm6dqSISAgsDXBs+ENd
         LQpA14k+T9/sKtg8d22+dhdHPqmi5y2TYlekLsSA4B73uC+vKDWWrE4+WeI786YK7Ywc
         Rp06b9QthxtsxnQlrTFhMdxexZpWnP2MW/uNQpXSJ/AwjZkDU9kSvkQctxdPSk5diRXS
         +LEuwesdTVu0c+tUAcYhB4YCpgIvM8qp+9JqW0I1Q5829u5G8BsdQ+Q9b+JOuyFqb0H/
         Ozkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766397303; x=1767002103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wowOAeV/9FEMf0axu8HicDUpB+eAhJJ/hNVv5OpoQAA=;
        b=YZfnEe2Pgng9u13S0BEMbKAPViuCfEeAgtCfGmMdpdVrKoSycassro4yQl5wk0quV/
         JYnhMyD9KjyXMQMs/d2Stn616WsG7zLl4v62/goqJEN36ZjMdoZNgYIjcv94GwX/vqvc
         G6F6o0HizJikhCZbp+/0EVI+btNEPsWO7Ob9MunBH0BOrZnmdKX1diyH3yAC9BJlpICw
         3u5XSjV3apfKmnqj87FdRzn84Sl/TIYlY7lGDcoKFZv/r0fh1a6qE+50KOdg2X6q3Ju2
         vPr3V1ySEjy9Td68ShBGBaXPorGyMgoHGmrYSwhKBfraU815grExD5dtOomWLC9ys42Q
         aTPQ==
X-Gm-Message-State: AOJu0YzqIutrUg5W2A6fWCjPdjiDc+pj1ZgZjhq+itR/p9BIfoFZzbvI
	hS8/OI5SuUyw43gNt+BexkBLIXF1y5CLH6lmc+st5+ElkQz7TXb4HAdicTBLWa7qg5+l7WLfrC8
	0VLyHBEOkmeO5nFT6uQGr6qhzfX/xrKvJfbLmqOg=
X-Gm-Gg: AY/fxX6b+iw6uDqojQjs1fDztdxz3gebhXSReT/DTsxsO8EizXlPrxhFbagX5M1hHeT
	ahI2MsocoCgx0d/1gRZkKQQzgQIMJAgjKNi4TEacQg0rUJxmOpryVb0BEJp8atgSwy1tl/6uNR6
	4SisNBMjYh5aN/MF2OQNqy0K3PzHfFqhcAYnyYUeQyrLLPsvI4WIWGbgEZbQpLqoBtz3WN8PpLn
	9kyds8zwuQuqy/oADRJ2GMMA4jVuO56tVfVIkC+fY5N36onVn9aLCbiXIlpIwHDgcCTz//bc4WY
	yxDqRmKOOwGF7V7Nlw55IC9fdg==
X-Google-Smtp-Source: AGHT+IFUCJytn2HUHbFl4mzNuXmAK8kK+A0oe6GlFT83jM7AwAOBoV6P8AXE2BySrBcA6cvbNdp+qPAFe5Yfh5amYHE=
X-Received: by 2002:a05:6102:3f0e:b0:5d7:de28:5618 with SMTP id
 ada2fe7eead31-5eb1a61efd6mr3146522137.5.1766397303126; Mon, 22 Dec 2025
 01:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
In-Reply-To: <aUh_--eKRKYOHzLz@kbusch-mbp>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 22 Dec 2025 12:54:51 +0300
X-Gm-Features: AQt7F2oA_cd-Hnm73oPfh7DxIU2Mt7U5V-SzBc45sFerfpf4qyPQSqEwJCF67kw
Message-ID: <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! Thanks a lot for your reply! This is actually my first patch ever
so please don't blame me for not following some standards, I'll try to
resubmit it correctly.

Regarding the rest:

1) NVMe atomic boundaries seem to already be checked in
nvme_valid_atomic_write().

2) What's atomic_write_hw_unit_max? As I understand, Linux also
already checks it, at least
/sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
max_hw_sectors_kb.

3) Yes, I've of course seen that this function is also used by ext4
and xfs, but I don't understand the motivation behind the 2^n
requirement. I suppose file systems may fragment the write according
to currently allocated extents for example, but I don't see how issues
coming from this can be fixed by requiring writes to be 2^n.

But I understand that just removing the check may break something if
somebody relies on them. What do you think about removing the
requirement only for NVMe or only for block devices then? I see 3 ways
to do it:
a) split generic_atomic_write_valid() into two functions - first for
all types of inodes and second only for file systems.
b) remove generic_atomic_write_valid() from block device checks at all.
c) change generic_atomic_write_valid() just like in my original patch
but copy original checks into other places where it's used (ext4 and
xfs).

Which way do you think would be the best?

On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> > It contradicts NVMe specification where alignment is only required when=
 atomic
> > write boundary (NABSPF/NABO) is set and highly limits usage of NVMe ato=
mic writes
>
> Commit header is missing the "fs:" prefix, and the commit log should
> wrap at 72 characters.
>
> On the techincal side, this is a generic function used by multiple
> protocols, so you can't just appeal to NVMe to justify removing the
> checks.
>
> NVMe still has atomic boundaries where straddling it fails to be an
> atomic operation. Instead of removing the checks, you'd have to replace
> it with a more costly operation if you really want to support more
> arbitrary write lengths and offsets. And if you do manage to remove the
> power of two requirement, then the queue limit for nvme's
> atomic_write_hw_unit_max isn't correct anymore.
