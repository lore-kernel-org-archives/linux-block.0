Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A534D385
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923152; cv=none; b=en4hpJhtdHAr2oZOXzTQdMTJttUQz1yEfwxlollQ12Dsvbd6p2qn8Mul3WQ1Sz648UYTaadpNoJ6n9eg/am4rFMSCdIb7zhW1ssvOgpSlD6fOpnFsuyUdXxZ6XltcjFNLd1ydY/Pcur1KkvzjKvR7XxbG2e+GHjgTquergFJtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923152; c=relaxed/simple;
	bh=O5l4TkAdQv7h6Ni21WOu1ey+TV0EFyrTLTBth+SNUe0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AwuTkRbLEfkIwg2wB/h+gHOS2IR3CHlaswYDN5ndwE/VoFKIPUnhjMr/OLkHlugW2TiGX41sVFVKc4H5D9sifAUZv/fJKg26obDhkxnskhZqcGw24kMAO1PFlVLJzFFh/gHURGpFcLAGLY28/mVwsgugxEQJJwDdg4yM/UbGENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NdE76bSs; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NdE76bSs"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430d7638d27so20526125ab.3
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761923147; x=1762527947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8cvAPKv3mb7AhUVdmpvo6tHI5k8pw6yNxWW9OX7WNA=;
        b=NdE76bSsBUg+LhKT3LTVAS6iDZfocxzElamKsLtHaoylt3AWGFahX6H3wQFQ5KoegG
         XHvb/meF2iarh5m/ScTRjbLCSgk4Z+z0Z/CeCO0k6XMI6MKj7AokpKJzXY2mpl19P07X
         oJhntAiCA/OqZMKM82mq7FdaUczUdKt5nBjvWsz1mph0ovXMsxqKMjIfoCd8hUtIdVoX
         RkVUDHfKW6B6A5XXe7Xpxih/df3p6DmEL8DTjbq+NrNyfnLO6FwhAn47GniWj7JXj6Op
         S3LKxrx0ub0SfYmsoMWqWPlT8w6gpNweptR/UU4qxdJpuU++zD2INeouERxn1epkqm78
         MUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923147; x=1762527947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8cvAPKv3mb7AhUVdmpvo6tHI5k8pw6yNxWW9OX7WNA=;
        b=eWOguHkqScgm7IQmbzvkroGcRkGwIopGftl9B30SNi+yENyO/Zgilp6cVkPb7RpuXX
         /kIPadBLsZak8rshfcaYfJynFuhz9KFxNnU7gCagPg5UJ0z7032oOYWduTY/JDKuoOaA
         cOX3iRfM7Sq0FYtNbCawjgIGKq2wl8P+k/Ebk3mO9yg0OS7ke58KFMAY4c3IgVWE5jK1
         /BDfc9eC6tqXF49tAwbRHZUwAfhEr91yY4zQ1RHj9e2uWcqlZgvTfA3brHhUpuF4lQyM
         nopRmqrnHH1XUbEuoHVO3Vo1JHVOHhEGnUTqVXxoWX6qaGKZ3oZtqjQA6Oi5V/zAvn7w
         +GRQ==
X-Gm-Message-State: AOJu0YwbKwTEz2e9dFmF0UwEXsdCLi739nhPZIYKYzauNqcrvQ6wnUbj
	cgO6wxWJmNT/TAnBvVlqP73dJRHs8IoctHYkQ4Plrjc4xWiDevoU8sQ5S40OWf+NAUY=
X-Gm-Gg: ASbGncsT5z3Sq/PH4SZp80MIGRN5dwjX6Tg1kKhigRSq9lNZNGRil1/IO9fNqQ8PBMO
	GHNBT5GvPrUDur7w+no6G6wptKhGMJLgoPAyoclGxB5m5zSAtCF9DWQu1kWBnA+wCpPuvntdewV
	8H46uC8zsrfCftOX0LPAKooj+Q04IjGYLRgjplZFz6SZqgc+VxPBq9deZdJYNesiZNGBa5WHLiS
	iG6J/iLT4Y66hg+XlUXZXezu2NsEWGprnc4XFSXN3O3aEWg/EEE4iLK03zfjJGfn4+qWmth1abK
	WF2s6DLhoGwD8BSk5rTPrNYgXpl9/3JJS3q+pxsdX1gHEgMGnuQrfLedmG7RgPatsMAz0xf9fJ6
	lnhv4k1xQUQ6vpmX4y0stWDL45/kXJ+JOrgLqgiaj6RpdOFW9VIUQ3esXymUn0GqRNS4=
X-Google-Smtp-Source: AGHT+IHULlzZf4btYOjbD1WcGbBPBHNAt3oGZa8u5l57fP7BFLt9XpO+DGZBrtZgZuFdeUyKg6G+3A==
X-Received: by 2002:a05:6e02:3311:b0:430:a013:b523 with SMTP id e9e14a558f8ab-4330d1ddf1fmr65206255ab.25.1761923147342;
        Fri, 31 Oct 2025 08:05:47 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a2fded5bsm793557173.2.2025.10.31.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:05:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Christoph Hellwig <hch@lst.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
In-Reply-To: <20251031094826.135296-1-hans.holmberg@wdc.com>
References: <20251031094826.135296-1-hans.holmberg@wdc.com>
Subject: Re: [PATCH v4] null_blk: set dma alignment to logical block size
Message-Id: <176192314617.599606.8616539941373631435.b4-ty@kernel.dk>
Date: Fri, 31 Oct 2025 09:05:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 10:48:26 +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.
> 
> Apparently this wasn't noticed so far because none of the tests generate
> such buffers, but since commit 851c4c96db00 ("xfs: implement
> XFS_IOC_DIOINFO in terms of vfs_getattr") xfstests generates unaligned
> I/O, which now lead to memory corruption when using null_blk devices
> with 4k block size.
> 
> [...]

Applied, thanks!

[1/1] null_blk: set dma alignment to logical block size
      commit: 0d92a3eaa6726e64a18db74ece806c2c021aaac3

Best regards,
-- 
Jens Axboe



