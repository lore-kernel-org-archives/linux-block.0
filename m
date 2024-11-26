Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36E282F4
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633218; cv=none; b=CBn/z54mBQgaHGf2l+vhK6p+wXVYauaakTGgYd/1aB3/0xkrKVBmRtbEa36Rp/SAoJa11Aj41fJyc99GugU3OTW6a4VQ7DFrjaPZfPi/OfesYihgComXU3IPtH0trD+b//3rDh5ZxJ/KE6mS8HbGfWP4XIL/dpFEHVm5CQawO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633218; c=relaxed/simple;
	bh=QrKEW8nVo+nGUq4yf8SgcRklLa2XBc7LnpAQ76JVsS8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PkQ1P+3mMG7xXa2ZlwO58Iltluw7B/lucrfV0G0iEUsppUyGMgK74F3SJrnpZxOHW4cCZzyJ/DPgrhUha39l96VOPOUj4lLGONZ/F5yziNt0VjgrdlYc0b3of+Qw8oBrekPMBIKbZ59NI+x1/Z/DwyLjkOYoSIocDBZPAOBq/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RdyQQJ6J; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RdyQQJ6J"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso4520758fac.1
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732633212; x=1733238012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6IdjAZOz2pOHK755VOQK4GiXsiZimMhvVYGeCqSuh4=;
        b=RdyQQJ6JQ6zFDFa/tuwOxmsU3NgLRWYLXkb1TYR710MW22JFWGdZETctJ9yER5Y0kd
         mTZLoOpsCdQdQ/buHknG1CWihtoETGUlEWkB4kIX3cE1es7AAumRYz9BI0daDddqZ4vc
         8MST1h1JqQS2P7Q7/F6l8HO7GZZMgTvK6vOxIRr+Irv+87X9yeetBuQJJUZ60V9lOtWk
         bbGBBsDOLUnZrRYkuyFZiLmRAfeHjcfiMwTqb0AgW9DKWXaj46zeVTV4ARCeck0ukcHO
         BRAZG6mSaQTrorHeYu6Dm48u/6Yf2dxne7UmUfqigGiaonyVREUX8pkH831bf1A4e+Tm
         KAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633212; x=1733238012;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6IdjAZOz2pOHK755VOQK4GiXsiZimMhvVYGeCqSuh4=;
        b=eXIfRiiVot4Rqo4NXUThQ9j+TjPxJoxzywDqvE6F3vRcgpbIshqvAY3j0GjSa1MeIb
         98MkFAgAP1oy4k78ydv9lEQ39JicG1IPejxcLD1zLLAAMQzmr5h2yjMbBsMZaE+EnC+e
         D/O+4fZAkpQcGCCpBWrM7RA1LR2+34nxiXRORYXFs/yXc0Tc4v4EB1TI6MJvRz022k7P
         BYPhRbe7eoSIzGpEOoYj3B8kcbqRPumT0oT/qDN8qXwqSCp3+62P204WtlYBAaz+XCSy
         dAaGL6bL6UcAbj5f07We4qUXbgLPBz7A/NKe0KZd/Cw+/O8ov25VpvvuNtNg26QRX7t5
         bcLQ==
X-Gm-Message-State: AOJu0YzJWc+xR6VtbaAIXJZFgzUExdMJfJndYE3c179eus/iPqXvqVpF
	C9Dpzv4Qk0swV1Qjr0r3ZqbtCEAPukizNxMjcZqgYbd05GTBFMNCryfdTnGc1lS1VMLb9WYq6VE
	Et78=
X-Gm-Gg: ASbGncs6MtKIM6h27x5TQW5gT7Iu8x+ojRw3wbevSCBg3ylaAuDlbyVKQZlCAGSXJ2b
	NIcxbckI33sXXKswmGQ8QM/i9lhDx3wRFEG2xkcAR/SIMUw74j/W1Hhf0hfRY9KCkg+Ut5wpcLY
	pvsGbxXtOTUC0PRUKrExbH8zjmRdDDZkjxMtRJx31xXOIHev1IO2flNPGJIdLg9WXBoCTy+RVpw
	Fnn5lRKQ/9LfwRruUZFQxdhP86H0PcdWy9JP51j
X-Google-Smtp-Source: AGHT+IFk2t3KY/qlsxHcVtm5Z69BK3BnmG+g8a9FY9ehSPX9KXZVVnc9yKS1fUsrD7sE64sUBlg7Yg==
X-Received: by 2002:a05:6870:4725:b0:270:1f1e:e3ea with SMTP id 586e51a60fabf-29720dbdb85mr11965737fac.28.1732633211590;
        Tue, 26 Nov 2024 07:00:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d56cfdfsm3998512fac.5.2024.11.26.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 07:00:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241126104705.183996-1-dlemoal@kernel.org>
References: <20241126104705.183996-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: Prevent potential deadlock in
 blk_revalidate_disk_zones()
Message-Id: <173263321075.43959.8582658266330387427.b4-ty@kernel.dk>
Date: Tue, 26 Nov 2024 08:00:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 26 Nov 2024 19:47:05 +0900, Damien Le Moal wrote:
> The function blk_revalidate_disk_zones() calls the function
> disk_update_zone_resources() after freezing the device queue. In turn,
> disk_update_zone_resources() calls queue_limits_start_update() which
> takes a queue limits mutex lock, resulting in the ordering:
> q->q_usage_counter check -> q->limits_lock. However, the usual ordering
> is to always take a queue limit lock before freezing the queue to commit
> the limits updates, e.g., the code pattern:
> 
> [...]

Applied, thanks!

[1/1] block: Prevent potential deadlock in blk_revalidate_disk_zones()
      commit: 0b83c86b444ab467134b0e618f45ad2216a4973c

Best regards,
-- 
Jens Axboe



