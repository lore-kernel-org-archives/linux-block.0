Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D933A008
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177278; cv=none; b=BCiB4SYfJOsklpdhrPNmjd4AAWum24Z8u8ePdhBwKWVme93dboi0mS8MNlggJ+TGfFKneofGJCthA3s06h01oZg5iiGd6SfISoYXFLPUvS/sv0vCHYLiiUiTZA+zhyt/vzCQryWJcgZL30p3XfuTjvB1lKl9uS+kbx6vIINGRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177278; c=relaxed/simple;
	bh=uWVb7imaoBwQd084csoILb6EvrrasnUptYGTVswGUdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I9ilXQ7ThgTOATEaW+LcvpqPwzfxrbO3vcezlEYbEn/iwZEA7+tVfhxUjW5WSf+tgWg11bh4jGXibnXAZS2t6HxGJvbfWy9wNg2TD9OKvw5Mr7noOv98N3Q/uqM/yxzA2EggK835a4qP3n+25k+27moWdulvclSDxsybdZ2YzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P7R6wbO0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P7R6wbO0"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-434709e7cc9so133195ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764177275; x=1764782075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Waaw/w2j2pENd/kSDmzcSGfaP1pnvDn9JVdDG4gqLck=;
        b=P7R6wbO0eEMFlSfHdnGGCLpHJN8Pf+J8hAPffkG6H0Is17JkabMfPoDYftvhFmrGuz
         5CKwXv0jtlYZmoa8O6chWylRb70FOFfb7n3vpQJBshOX2OaayM1xL0PAEWJkoXKCJ8Bh
         119v4cTgvRdRslLxRgzcWlFVpo04IcQsqpTAGDRAEpgpwiw+TszGby8zN4LBSwckGVSl
         rLhfZdu20tSLOVkVy9i0xPvrWglrkipSeYeDpur0iD3tNv9b0MZklPd9nizzkyVCfNEB
         bjRQxMEEXZjApH2cMSs2t5bQpv8uO+5thOs2EeZ06SRmWml3Krpt1kEVQ0hnTbIMQkfX
         9fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177275; x=1764782075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Waaw/w2j2pENd/kSDmzcSGfaP1pnvDn9JVdDG4gqLck=;
        b=l4bK3YWV5OqJFVOf9qXz0hKtmmJk5CYlIiCeMR3V+02SOdmXnhvbDUqhVIdrvav5vL
         oAI8iuJ7V9uiq1wAzs69eZLX98FNJ7HgQwVg1rTcGLg04zK1wvVNMTNxikeHBuDiAZIi
         1yzGhZmLiK/KluxDtuL9aAgUDYNbgGF6nE091cQSmtX4MXqNKZoPR0h8JH+R/joyK18V
         +mAzYaqVQWXeo6GTJsw7Wz83psozWDU7I/6sf/vqCiUDdWna6XFH6rCdb2COmOMeqjzj
         g+fV7C6C+M8+bMiJSAR+jFzJfnF8GeXN5cT32kZcR1x1O+VQM9YTEldh7bQOMi6HuQin
         5Wcw==
X-Gm-Message-State: AOJu0YxYLNhmfh9NAHKfBeUsDqFJ7ndEPKlH2tnCo3YeXdgLizIjHaHp
	ZBsPsY4PrJs7ErSqPua5+NdZqWpk/jOD3XviT3J/490aRbItPmvzlFgKTUYme4zdZg3euFfXBh4
	qOE+B
X-Gm-Gg: ASbGncvj0/OPG0R43LNIh+esOMTpj02QnHEFoM/qDfz+LZnsRbiLSaBRsO4hqrt3f/M
	HteDEI4RXj8KRfHxV1tA0cQveYFRG8B2RUpwFwNGvvnjk+B+mmGfCspOBoBDp9VzCkgWsgQtxJc
	Gi+8KupYpYXy1228jcwWs4Mac6wnL3GozqK75VGjeukeQflq3fhtPUq9ejPkfH7Em7lEcA63CAd
	flnWYVCy+0y8d6YfijD/8WQxvPBzznr6NDGzZvPvlYSrlrGxiiu9BFI4mkf2uSTlCmWWm3ZJZj+
	yB58WuObO00IPkvvIUADoup5B87ZscuJzzA0/qW9qDLaXHs/XOsn8pAJQs5s337U45ACW+yETbD
	Ln5rDW9oTNYtVjOXJquEaFn25MiaweplrblDkymJ0VQ64wEhuqm31Sh2QoqevbLog91JeMrnbqC
	TZgA==
X-Google-Smtp-Source: AGHT+IHwHHDUwlmQFfLs1EZPhOMv9ft82AclYixifNYet0D7/yodkeU+uFnr4uBAVbfHn8ILovtdkw==
X-Received: by 2002:a05:6e02:3e92:b0:433:5e33:d41d with SMTP id e9e14a558f8ab-435b8e7a0dcmr160640095ab.30.1764177275359;
        Wed, 26 Nov 2025 09:14:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90dba32sm88409755ab.28.2025.11.26.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:14:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390/dasd: Minor cleanups and copy-pair swap fix
Message-Id: <176417727431.85325.2478471808597740699.b4-ty@kernel.dk>
Date: Wed, 26 Nov 2025 10:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 26 Nov 2025 17:06:30 +0100, Stefan Haberland wrote:
> this small series contains cleanups in the DASD driver
> (string formatting, naming helper refactoring, debugfs simplification)
> as well as a fix for the gendisk parent after a copy-pair swap.
> 
> Please apply.
> 
> Thanks,
> Stefan
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: Fix gendisk parent after copy pair swap
      commit: c943bfc6afb8d0e781b9b7406f36caa8bbf95cb9
[2/4] s390/dasd: Remove unnecessary debugfs_create() return checks
      commit: 764def9e8eaf1b1ccdcd89b8c16db4194ade775f
[3/4] s390/dasd: Move device name formatting into separate function
      commit: 43198756ee8cade0acc17a89f959764cd17776bb
[4/4] s390/dasd: Use scnprintf() instead of sprintf()
      commit: a857d99201cc4eb3cb78b9dcb6f1d027ef3ae699

Best regards,
-- 
Jens Axboe



