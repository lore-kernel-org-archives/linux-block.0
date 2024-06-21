Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8451607B2
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994749; cv=none; b=TQ4BaRpxIj/EyKfNarGmDPWzrZIUsOBLJJlKdlLBTD8wk71Z9j1DT/5ogOHFTOIVqWynWBl8UHD7BKpg9nSnIZzPOkmRel/LVOVmGdrAGx/D2y2STBF63Ah6DblDHlHGgWVRojCIWXdrau31dAfcFNMvARp5k3nMloUbUuNV2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994749; c=relaxed/simple;
	bh=tGHhtRac8Lj0UhkMJFUBpO475OEk+R+2PdOc8uX0UE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VDuGTkS204BUVsoIcOZ0eXRBZrjJlbJ91tpw3AWL3nbS2lJZBYktZXcxjqcb8wvk4MihM/r9oqBy6OvruTJe7RyTemsvoTBOzanD//ior25FHT1EJhjJHfLM1ea31ueHLun3ObIie8tVTiZya361jfP7t6SYGmG3Dm+97mvL0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s9Ovq1xN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s9Ovq1xN"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25ce35c52e7so85922fac.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718994746; x=1719599546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T3jCmWwe1qtOEm4AV/Hq8j7QmmbF1sq5HEvcR2ludU=;
        b=s9Ovq1xNiB1EYGA3BcJJ/pKdEa9ACJPAlIijL+bscUoYxESLWviGH0bSZ/W52Dxr/4
         fkB0uY3r2GfFUG8goiOtbCAB8cRM7wTJ43IKzTriSYNnpi+JaoPJKz0xY4vGijPc0Bcp
         NQx8dKsQTegT2AYCtI87EFP4oVOSlC98lw+GLsIgtFdYF/o6RIYeXc6kbjgh1P1h+WcV
         ZRClmjkybxyBMoksmHdpQVN468k6rPv7m0DzkvJ61mBYb5xLlIVUTPAA5X4m/qp8oor5
         kU0nJKAHt5zaFyclOl2UNx762m/aq9gNjXyzvrk7DQj1PiliG3kcHGmrPJszYzFjcuaY
         ZplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718994746; x=1719599546;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T3jCmWwe1qtOEm4AV/Hq8j7QmmbF1sq5HEvcR2ludU=;
        b=JzZfIDuWCVIHRLP3Qqrt94jIqiE9hZBCH6imMp4e1GWhAGM9yZnWw6Q6EFy28USP6x
         xJ93Tfq+YVdpctlo31NAdResU60+miqE8dVtL9dFR61odhvBLBgg2RUHY3bkK+c2/bMs
         L84GQVkqO/SJ0bYZ2hEg4SVENXD1wtxoAi/6vdQvCQwRUrDA7U+R6O62t3M+pAz5eNss
         NLhOi8awRbuS6459nNwYhQp7xLlRDYJwqmsLFcV9DI2ULZ7C7xKzsH+cC/zJ85vBqbX1
         4LKyKxQD240vkgYomTv1Sl0siZpB0ib0WhguxhOeWZLfvc3gVAabFnw8P1EwHKXWOXc2
         oJHQ==
X-Gm-Message-State: AOJu0Yz8wCZGD5C3/UgrTwD3jQ+T/G0KM+XXNVR210sfz3g71zC2F8fy
	PcSeHRKrEXCmb52PttgRjCNVrR7zrc+ripJosm/0/W3r2hdMerTWXyOQBGIWQAE=
X-Google-Smtp-Source: AGHT+IG36B6le8tvml3S3bJBGefpCApaORZSBlIm5LdQKtdIOR1mLOCLvkCIHHeQq2OwPmogG9QccQ==
X-Received: by 2002:a05:6870:b022:b0:258:4dcb:7d51 with SMTP id 586e51a60fabf-25c94943702mr9984384fac.1.1718994746577;
        Fri, 21 Jun 2024 11:32:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c040f0sm504037fac.50.2024.06.21.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:32:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-next@vger.kernel.org, 
 broonie@kernel.org
In-Reply-To: <20240621183016.3092518-1-john.g.garry@oracle.com>
References: <20240621183016.3092518-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Fix blk_validate_atomic_write_limits() build
 for arm32
Message-Id: <171899474485.173167.18019920711327723687.b4-ty@kernel.dk>
Date: Fri, 21 Jun 2024 12:32:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 21 Jun 2024 18:30:16 +0000, John Garry wrote:
> For arm32, we get the following build warning:
>  In file included from /tmp/next/build/include/linux/printk.h:10,
>                   from /tmp/next/build/include/linux/kernel.h:31,
>                   from /tmp/next/build/block/blk-settings.c:5:
>  /tmp/next/build/block/blk-settings.c: In function 'blk_validate_atomic_write_limits':
>  /tmp/next/build/include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
>    222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>        |                                   ^~
> 
> [...]

Applied, thanks!

[1/1] block: Fix blk_validate_atomic_write_limits() build for arm32
      commit: 8324bb755a80d463ff53379e5d64991656512069

Best regards,
-- 
Jens Axboe



