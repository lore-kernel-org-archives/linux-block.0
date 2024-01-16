Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC1CAA5
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424321; cv=none; b=fkzTRb7IP+QBip/2V9xnjTuPfqDkbyhgGjZL+WRvJZGpPnflDIrlONEU/ZtEXElj7K4UaIkXYCnJI9SfwxdFZDExJN4rhaEp66RN0V+1eP+z+hjbRbR8ODdZIZZ0clQo3NBBwi6UAJvEXxJjCt4SDmzBKPXjoafBo19bnCJaK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424321; c=relaxed/simple;
	bh=nxy770h9U2pCY6K0bvqLPQukkjPVs7NcQl3n9FbjxB4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=EetFpp36JGw/YeoJOLY7PJfNX90YlNo6/xdJt6VFGJ8xaHZTjECCZsxM8tPbailvO/fv4oJdJAlsjU3o+D8ekXpzsOMgqrlSjbh/b3bXMuq3K3UuqgPsB2YhVt+CEJS1t12mwfOHAoE9IYYGQf4jG5zO2EklW+DZbH9A6tYEqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uGAuM8b/
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uGAuM8b/"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-360630beb7bso7915755ab.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424319; x=1706029119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI2jt+2IZp9dME34DGFD2FqtmRmP/aEuhYgGfBw4Gcw=;
        b=uGAuM8b/b67e/KJQKaBiiP4dXda98TeieWzuW3lP+6xsPyPUH0LX0GxeLVYccW19wi
         F5NoPgnGBRiTTMKG4vgIAhUB41YJKa853h4LR/SlJOGZ8DYmB217Zb0rnoFWpRP8AYnt
         PMN3zRUpsw0nVE1qCshVw1EwZb1/lvilylxo+rdUbxYMxmAtQKDm/C4e8A8oTmxNnzgH
         CmMr7Y+PqKRIW66tmbFnK7tcQmMz8L8fPRFgFsULgZ8acg+hSQmGi8VZnwRu2Pedg7/p
         P4ccy3NToyv4vU/91qhHUDBkqEYs7TRmTOWqwSQnbqc1dejuvM1ynFCSm5atMyX6iVIt
         qAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424319; x=1706029119;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI2jt+2IZp9dME34DGFD2FqtmRmP/aEuhYgGfBw4Gcw=;
        b=MSi2LgqvbGUvx/RFsm1FVX+hvxfLBZ1TJoJbUWFEt8Y1SzxAGInW/Ai//7LfSiKSDd
         EH0LYzI+v75PH1ITE7oZamHUjtlvZXM2V1VNpkDsmEkwSUlj2O2KvgPrPU0mvz1Y/9X4
         oAyEorFVbubIAL6JVYwfPZn0z/ivVzfndDUXFtY6qHQZN7Af4oJkGPJJkDoeAU/3lGYy
         3NndqJfnlDmoqhBJMBBiKRmcKzglCiNVyDB/x7arym5PR6T2pAvqJ4aFU3OqFLeyJdJU
         RmWk3qSQuoErtOx6eXt1z0UQ6J7O7P1JPUWZl2uuBPe9T05XAv98kcOnWWtmDjFEO5TR
         an7g==
X-Gm-Message-State: AOJu0YwD9ZeCzHzBA8K1D2ndYWi4hMi+3EG/SANlFGMsPluFcsVV9y2z
	zU/ibRhxJNZlc45laaOt9a1a2/QAiZF5Cp8d+z/0v3aFMUtgFA==
X-Google-Smtp-Source: AGHT+IGhrspUaoOewiUY9G6s4/s5oSLx6zkbxeRu95TiUkcF7cIKX1KoX3hGqMiHI7beX+df3r20bg==
X-Received: by 2002:a05:6602:1c7:b0:7bf:3651:4c6d with SMTP id w7-20020a05660201c700b007bf36514c6dmr7302125iot.2.1705424318830;
        Tue, 16 Jan 2024 08:58:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r8-20020a056638100800b0046dfd35b042sm2995191jab.73.2024.01.16.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240116143437.89060-1-dmantipov@yandex.ru>
References: <20240116143437.89060-1-dmantipov@yandex.ru>
Subject: Re: [PATCH] block: bio-integrity: fix kcalloc() arguments order
Message-Id: <170542431761.238046.7077269438448097738.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 09:58:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 16 Jan 2024 17:34:31 +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.1 20240116 (experimental)
> and W=1, I've noticed the following warning:
> 
> block/bio-integrity.c: In function 'bio_integrity_map_user':
> block/bio-integrity.c:339:38: warning: 'kcalloc' sizes specified with 'sizeof'
> in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>   339 |                 bvec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
>       |                                      ^
> block/bio-integrity.c:339:38: note: earlier argument should specify number of
> elements, later size of each element
> 
> [...]

Applied, thanks!

[1/1] block: bio-integrity: fix kcalloc() arguments order
      commit: be50df31c4e2a69f961a3bb759346d299eaa2b23

Best regards,
-- 
Jens Axboe



