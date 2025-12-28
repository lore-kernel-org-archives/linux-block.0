Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144201F5847
	for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766939236; cv=none; b=KuSQbF6JjqZxjI3D4JzW8ToJN7xPIv33oKwTmxL0KoyybOCkjVvxztSxm5vTJqt5uWfJJrWBnAzBzsfQnjipo5eWJlBi7R5BpWJ9c3G0a3T0VjRs1ZfJe/2OWbj9LX4DHm+OGVJ4+sR/HZNhJv+Q2hHkj4zh6V/zPjAcdblKOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766939236; c=relaxed/simple;
	bh=Vs9A/fIJi2TExq/NcnRc1ZSgtCQUo1UhFlO8N/TLIL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q+1BliKZNRTVYkCBVNk9upMBmd3TB/Lf1pgu4JYdAqBlqYhyBySzlC6rwht8ah296o4y/AC3/lmczF674M+BweZjlj16WNjGbUowcrnv++/Dw0C7wyWplfxQGsdttjfrzDZXVRU+U/LkgsyYRbN1vn2/8puuWhkk6xkkqMd+4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JvqsNGMV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JvqsNGMV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c75fc222c3so3937878a34.0
        for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766939233; x=1767544033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DqIKwFbk7kJeOgEXq+nDmVnORnMcjdiNzRFh9MeNWw=;
        b=JvqsNGMVJUI/gR44pdBI1oVY6wgSLDlVEjk3CbWz+OFYjQ3jaem4xkiFT9ZjiMHNHn
         QtgrYbhHdSllbyAPAkBSHFbACgYinqhm6CW7fggk/KcdQTfdhQUji/2CplT/+2XleyoW
         Gn7LBvPo0D8fyFxcFJIga/WQPn3V2tDoOrzBbZtd+E9osqEhubhKJadOIaPPen8ycU9P
         jQ5UQ/W4xvuhxwxMwDLcIqvO2WWQrpW8kH99Dh83fOGLp61S0jQU/Nloba84F2tINwb3
         QPaDoAOeY4cjQRus/C+wpo+rSUiTQdIbKQZGKZ/vkDA6e2Hc8jkzSpm0/xkCOafGKgKh
         36Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766939233; x=1767544033;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5DqIKwFbk7kJeOgEXq+nDmVnORnMcjdiNzRFh9MeNWw=;
        b=kitmpgQr8cEI48JZNOQ5vUyyG8NkUqbElT2NhHY7uTAv4WYgYjyUtZJ01Qw6nfuZ2S
         6mLnDO49NASsXNiKkyyWW/RnATF9xWG9T3M30ijI3FjGP6+7T6Qal74yB3V/SYwCxPn4
         NXVn+zRfTwgJZDKWbPFnx6kj3Go6hYGkX35VgFOj/ba4+IQ1NsLqQj/5LswviXWSAD2w
         yhK/LpwHHOvCBEE/OGmGHnvsBJaN6/C5/tZDkcdaf7Kwn1AS1mLJl0E0wfZXJdAdNXT+
         ewQe9f02FM02078EnP6JGayCpS2IJVN0EO7beiWQAE1AOZ2nnPodNv5utVMqHrPIieQr
         fUXA==
X-Gm-Message-State: AOJu0YzcntL00uN0N59uooR9lYRYETSao2SHpGaP0qVkbeJmQu9VpfdB
	obZ6jUPjtd5CV9F52MSXtFRGxxWYtJofa4h667B+orJEFJ/aqpseilelxMQ9YWUjmHprjkSzwKt
	9FqFW
X-Gm-Gg: AY/fxX4s/iAihn5SDrtirfbO4Bno0qitIADbsiudWykyZn/Bcmb1Mdh6CHCSZZL1Q/N
	2+gimzWnq15F0xH/7FWTGP3wvTRD9JZrT12aGEZ8eSSuhSheY9+b4s66y79Q70O/Jht+N4s+dJt
	qN77cGgnDWmIOgJwGUOMMv4TT4fMEtuZWeFg9OfxIiCCwue2SEseJGKTy/iZoi8xg2fH4X7w+JH
	VKzffUFdcACZSpsqqZkZfg3mVEpWKAij77HeYckk6kNmobIr7EePle6WdDeSEd54inCFU51Q9dI
	g0iankwHJBRTdOutbY/MDr2w+n7p0qUI1c3wxO6K0J1eC28GuPyvBNJ3fLHLtRIn/qVz/SVDZJ/
	zgWcUbfA2m37Ur9DQ6OrUuq5Zpuz5H/Qg22UtMf4XlIp1nCBHtINLk5RFGFIjbalnH4tTkOM7uE
	O7nhWiYSvWJVtWIQ==
X-Google-Smtp-Source: AGHT+IFYdI9M5GtJ89EXBYpDKXCQmSCA59XEMvKqBqRuL0q9kr+crQhDhCo39NqjIFxpRqmMGLtmHQ==
X-Received: by 2002:a05:6808:1794:b0:450:b361:f48f with SMTP id 5614622812f47-457b20f4e4cmr15006515b6e.5.1766939233619;
        Sun, 28 Dec 2025 08:27:13 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3be228asm13019768b6e.9.2025.12.28.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:27:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251220235924.126384-1-thorsten.blum@linux.dev>
References: <20251220235924.126384-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] brd: replace simple_strtol with kstrtoul in
 ramdisk_size
Message-Id: <176693923203.195831.10871092800980020289.b4-ty@kernel.dk>
Date: Sun, 28 Dec 2025 09:27:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 21 Dec 2025 00:59:23 +0100, Thorsten Blum wrote:
> Replace simple_strtol() with the recommended kstrtoul() for parsing the
> 'ramdisk_size=' boot parameter. Unlike simple_strtol(), which returns a
> long, kstrtoul() converts the string directly to an unsigned long and
> avoids implicit casting.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing values, and
> removes use of the deprecated simple_strtol() helper. The current code
> silently sets 'rd_size = 0' if parsing fails, instead of leaving the
> default value (CONFIG_BLK_DEV_RAM_SIZE) unchanged.
> 
> [...]

Applied, thanks!

[1/1] brd: replace simple_strtol with kstrtoul in ramdisk_size
      commit: 44b8a74a16101bd710f97c46a8f1d3078e0518f5

Best regards,
-- 
Jens Axboe



