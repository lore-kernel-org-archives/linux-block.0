Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07D23CEE8
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668309; cv=none; b=QBeQggTccJrAxpTeot/oOLFy5lVXTV5VEC7yOfjiQZEvzeacvb14SFV7eIIqFlaG3HUXnAOE/T7CjuGs1lCgOmu55/3PiLAPVESkQGCHrMEhMVLkEeYHiW3TJNiRhlUNQuC5+H/V8wivBL3RgvSbUZS0yr1rfIpYg8atOUOChZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668309; c=relaxed/simple;
	bh=y3iJyPw6FCISTHO3D9c1ds0wwiNtEMeVEeDKYrQ0Kz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M8FeMP35ev03ok3tM8uSRunTJeoYkbSd1V+n8C6HSnATu6aVNrnFAP7ZhVthCHLzK+lpY0GJXMm8A206zOeRrQadzCplk8XI866AFvBM0zpIj6w3FSFmw4QRHn6GwKsfIqdc9VWGiThPIg6ULABjl3/c4k/igxb12Uqk1WL5Yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a5OXKJxt; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a5OXKJxt"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce87d31480so3584835ab.2
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740668306; x=1741273106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj+Eami5X/yy89/49zk4G0LXseHgCDQs/4d4pWhcjKA=;
        b=a5OXKJxtr9e7auUfZYIKkP9bx6J7TXV1BoPV0IMqFTQp8ydezN/D9os7gRyj8iN+74
         9hUTodGX+9QwEw5lluptCKvqBoiBrgl/5PxL16Gi3NmPP0e/ExRnH+ViFUzblcFfLkPY
         ohb4ifOCXrD1ERYEZkqFgFy9yHryoDWaXewoMihln6K72gR52rMUm+1Q4Hv41mj2ZAEp
         hi8UaUnCIyJ5LLOxssAEgB/gM5Qkc6ck6jt7dOWoAr7R6B55YlNhVGUV/UUQVeBk/TQQ
         vTCmoOHCzJRMrgq8jt39r9rHj/SamA2qa0DnrutCXp01k+IqMA+TpZw8RIuZ6aAsb1ai
         uuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668306; x=1741273106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj+Eami5X/yy89/49zk4G0LXseHgCDQs/4d4pWhcjKA=;
        b=HsV9BwxjQuOq4xrdpM1Gu7AnPeUnhpFo3CaHQSHJ/vZY8Fcrr59w80qEbk69mNfKza
         g+NzQ0wDznMg4afvIUsRJS00gQRAHI1g0wCa0sABLX83bSetbrgKcDzsDOnOnX7mBSYF
         vGYiaRVwkhEraULt6Z9yh/ddDI8NvZmEB6YfQqOaZVpQ52BkDFbLUh8GB9uCiGzzNuCz
         xsFw/fqaFcOY33/ChjsXECxr9RgdP8K2dhNOkRfdwx2uKiKbIx6/ZjV2U49w6vI87lkC
         7H3f0Ehwn6GT9Ov1E2qQjFcGlUNEnwS7YtV8klu5q0VR5SGpZxaUP9wCWkhmADUwmb1p
         6QLg==
X-Gm-Message-State: AOJu0Yz1PquWJEXBNdPmjuJT4jSywP20f/sJ8Pba85gjB1nVQjIaIlMg
	ZpknEc60cIjbKXN9eiDnaT+5LXyEwBDf6Rg8gVB0Ep7fy0gtkHFjB2E0GSgQGHE=
X-Gm-Gg: ASbGnctLuPgvaOO3bovQWhNg6Obalw7HGd+9L8TdQgBHzkOTKVI2jhEDudVHs/L6xz3
	Jzt3CrDzFATbdw6hsKYpQojTwDlMpbxGabvZNvW7/ATsfXKQ5TuKIz1PFY7hBn+uCtugNwpWYLl
	GyTX9kpY40ChD0qnoJ4VLepPcg4eEs6+BPWC0WZ8lNOUJEJz1roIVcyM+yCxvpltMSs3sF8Iuxp
	NRvMSY9WoznE9mlvIv9icJ6ZiWFdS2bQQsGXxQffuqPrPyMbhBJTgVJQ+HU2yQ+SKP5dQ9sQ3sg
	h0ILHjwMw3Vi7ugM
X-Google-Smtp-Source: AGHT+IGelkMTh7LvQHlLpxMWXB46WluUnZpGDUVemPsYp4ftU3vyDNyEWjy+/H9rfs6oFLi7i5ijBw==
X-Received: by 2002:a92:cda1:0:b0:3d0:4700:db18 with SMTP id e9e14a558f8ab-3d3048baa74mr124173345ab.20.1740668306467;
        Thu, 27 Feb 2025 06:58:26 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3deee5d5asm3423265ab.67.2025.02.27.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:58:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250227103707.2640014-1-ming.lei@redhat.com>
References: <20250227103707.2640014-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: add DMA alignment limit
Message-Id: <174066830547.2449066.6411838120131047873.b4-ty@kernel.dk>
Date: Thu, 27 Feb 2025 07:58:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Thu, 27 Feb 2025 18:37:07 +0800, Ming Lei wrote:
> The in-tree ublk driver doesn't need DMA alignment limit because there
> is one data copy between request pages and the userspace buffer.
> 
> However, ublk is going to support zero copy, then DMA alignment limit
> is required, because same IO buffer is forwarded to backend which may
> have specific buffer DMA alignment limit, so the limit has to be exposed
> from the frontend driver to client application.
> 
> [...]

Applied, thanks!

[1/1] ublk: add DMA alignment limit
      commit: 9fcc4add3c0d6e43788d55bf7a957c1d4de8584a

Best regards,
-- 
Jens Axboe



