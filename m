Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA14142651
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365109; cv=none; b=ELdj44b/hPS4RuE7/emBHnMZq8/UhO1Y/8/oRGiO7XkQR26PWVHJ9iRGMEApEB6g1q8iSTIUl1ei3vb/adB69dycJk9zZlZY5G0/mJR/aMNIzbnXwx4XzzxGe6PGSET0bMXXfnQ4jwQCNU1fMhpdhjHJbVl+RFzH+ZQ0d+eFzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365109; c=relaxed/simple;
	bh=NfUxxHjE+Cn/MiCnHfCgoCOBjizOPP0wp3qvrWV2keQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FQPFppOY+00azSh+bdAznnZcP0LdaZ1zBmYtGaa3osvyPwdZ5uvf2gWYJ2YGxWJxSU0VEWdiJaqTa1lBq7F3yriT/zYRYbZZWxmVTGtkCEXFkVa0Q5TLZCEnFbWvKUUJK8Mq4J7c4p4bERZAXw9RnB0qIDVzjLsOLmAsdwEAuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LOMEfyu0; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LOMEfyu0"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d9c78d108eso16063039f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713365106; x=1713969906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93lR72EH2SumRe+cYfl38gsZj9oAOrxhoKGK4t1Sw1M=;
        b=LOMEfyu01JWVHzZLKXnk17u7GOC6qfo3WliatdhCW9wazG5VMgUEwK9qEpySbTPrhp
         wJxFGqzGshEqNqDxD+kg9WKZS1PYtZCP+KK5xoZC/vnII7wauHoO4QRSoJ53WS56OPeW
         x7ZTjEqN3jK5UEPzG1g411gH/TKUclHlS9Jb/XA6tqtZf8zDANJB4JEHDhdWUuJNVqYL
         GuALVBK0pO0AOCputa7eigeni79+sLZbj3oKViUMFfYIMWr2d+lzwQz5uIq7MUYn9X0O
         3SGZpGTS9Y2dndbYBv7h6RZEWOK5lctQE0yUcfSR3L9SraOIP0iqzH7HWg9IQasrKDbt
         OfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365106; x=1713969906;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93lR72EH2SumRe+cYfl38gsZj9oAOrxhoKGK4t1Sw1M=;
        b=QkA++J4OMPJVK9CWApm1EAD/PvPvrYG9WChQM8qkKLWjk91RUUyNrY7pYSH5KC3sL9
         5AP1n1ebTg4lc/v5H3KRdYeAA7Y4VozLpNzklER1sqygbVezkovWx6wzTvJ0rluhRvPc
         94bG/h129hHvJSIOT+2hUMDJXAymtF/jkCFbIwrLoeX11FIv6XLKp9kA4uscb8IA3Lox
         LVP5eE7QUyYZy8cn6kOs7EWpNQOEhfIjF+Bro2n/N55v7D+MngsBKIB8i3Ok1Z3N9hn5
         X6ZJdiNrbD80wIcXxoi/A5h7Gmg3JVDh/udHHEcTJ3MXVwas0Ev7kiM5dCJCOyjtlGEX
         Kfhw==
X-Gm-Message-State: AOJu0YyY8YwUabKN6vw9VIu0AVwV9ftBlfXelzmrdZn+s6Bv8sYFZo1q
	A+EcN2VK55V61L7bSbo+11Y5e/aNY8cMsl/PGZ5ulnsO4Ed5fLhrNitfCD5I9fg=
X-Google-Smtp-Source: AGHT+IEPiZD1IWykUr0aMlm1/oNwrfRjggT3IgnMcCpc9s1R4V/HM8Sdn02EQice9kTYsZiyohbnBQ==
X-Received: by 2002:a92:c14d:0:b0:36a:3ee8:b9f0 with SMTP id b13-20020a92c14d000000b0036a3ee8b9f0mr13764480ilh.0.1713365106291;
        Wed, 17 Apr 2024 07:45:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a92d942000000b0036a373e3874sm3727881ilq.78.2024.04.17.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:45:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240411085502.728558-1-dlemoal@kernel.org>
References: <20240411085502.728558-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/3] Some null_blk cleanups
Message-Id: <171336510481.151809.6754490778086480882.b4-ty@kernel.dk>
Date: Wed, 17 Apr 2024 08:45:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Apr 2024 17:54:59 +0900, Damien Le Moal wrote:
> 3 patches to cleanup null_blk main code and improve zone device support.
> With the last 2 patches, some performance improvements (up to +1.7%) can
> be measured for a null zoned device with no zone resource limits. The
> maximum IOPS measured with zone write plugging with a multi-stream 4K
> sequential write workload (32 jobs) is:
> 
> Before patches:
>  - mq-deadline: 596 KIOPS
>  - none: 2406 KIOPS
> 
> [...]

Applied, thanks!

[1/3] null_blk: Have all null_handle_xxx() return a blk_status_t
      commit: cb9e5273f6d97830c44aeecd28cf5f5723ef2ba3
[2/3] null_blk: Do zone resource management only if necessary
      commit: 3bdde0701e5f819df0fa0e32fa8d5df7dc184cb5
[3/3] null_blk: Simplify null_zone_write()
      commit: e994ff5b55e3bf30ecb6ed354eaec77c989aa4ae

Best regards,
-- 
Jens Axboe



