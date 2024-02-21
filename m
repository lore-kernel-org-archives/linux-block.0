Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8769E00
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525314; cv=none; b=kGpNBNxgnHMyjz9AjKT89j113sOd6Yu+re3ojCt04Fhh7JqHnG0ushVvIwlQ7XKpcmydYGSVAU/GTuSoHpOiGLZU5V6UrwyP0oFH+JE8AiAmeFsKgqNSbraYPSdveYZ+vAjizXdGwcMiPI7nfc9KrSXljylZBoZjD1dsLNXaNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525314; c=relaxed/simple;
	bh=sqw2NEBwaLFZGaNss1EkPeVvEGLMfk4qCgz+qe+YNPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pq77ZEw2vkQeMblXHJ516ZrWnJKFrr+iOxTzb2MbHRbwGyOobPZJHkcRm7Fm8yz9hTYALQ9TC405bElc6bBmvzmziA93CGcxOQ2iMuxF0YPFNGvih1j/eAejDkuvsEfXdz/cNhdrzrcJxuuagRN/i3lqZ0pP2jgKxvpZ+SJ6FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Te8Sa2R2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Te8Sa2R2"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfb8126375so1917746a12.1
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708525310; x=1709130110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7nNb1IyT9qxEHIQlGs4qvF1JRyEGVeiEE+XmvbU9sw=;
        b=Te8Sa2R260ODKS3FUrZ1GX23yaOqg4wDlNoI8j7BzJbTlpinm1yocCENLlbfDrKIGu
         RNHz98HteqS/iVfhlAu2ODimxlk/DYYMGQNt+MvxCpp3N/E6wiy+Ohmj/2zb3u1lmNpi
         XIFqhUJr3FXX7BhAJRANZJHdxy4EryKa8bKiNviIH0M70y7RmZqbgiZu69NYPzf5IA7U
         ZS/vmL1+NhNLvrCpmHMfwBo7zxf9IFP9bwG4nYKhrjy9oSpiTJcA2sugenfUEc+fQGQl
         M1RJE8sc0ZIV1u355X2xi2lHLdz53EDWEnWZHqLPB0iKHXVdxYY97LGoSepAho7dR4UU
         EG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525310; x=1709130110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7nNb1IyT9qxEHIQlGs4qvF1JRyEGVeiEE+XmvbU9sw=;
        b=wMypNpwje/An7FCUxV13eSJD8cLPWZqcRNvfseXYqRPmM8QcHqF5f11k7aWAreka5T
         tVLiO7H4i+aoE0nX8c0P6HwhzHCKFPzesp1uQsssb1JrsilM/woUgP8P5p8rxRif15WZ
         cuAJu8Hhp5rABkS4FwcYGBvSHzhelDm522Q2usOgTknoQL9ijwM/YsOBxO6qtM620BaD
         sy9W0MXZwhElRAJLxTw9BaVsnxaiNZnWoyWoCouuip58KLNYD0KGQLAkKfD5bPLELSC1
         u33paTo99lyNXrQYQFosZNY+AadMPHZEHo2Ig+qAnSWewlYNyaifqoGqUy0S/+3w7s+F
         4toA==
X-Gm-Message-State: AOJu0YydQGRKNwMGhgSX/24piKOa9y9mVvL+zEng/ket40tbaFGudZ/e
	ng5WKjH0qI8NaJyb3qcX/suRy5UCgBPy1zCm7IosQ20FRG14FwW4iGroSEbE1aJF539HPsCGCas
	J
X-Google-Smtp-Source: AGHT+IHegXAoHk9ujL42wUlYyp+gWdsJxmMHljepEmIwKXY0ByfRaLZ3s6QvSlt7LiWprD9f+9PG5w==
X-Received: by 2002:a17:902:8d98:b0:1db:de99:9e96 with SMTP id v24-20020a1709028d9800b001dbde999e96mr11143709plo.2.1708525310223;
        Wed, 21 Feb 2024 06:21:50 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7677:4d94:4513:899f:6e45:a331])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d71729ec9csm8116302plb.188.2024.02.21.06.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:21:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20240221125010.3609444-1-hch@lst.de>
References: <20240221125010.3609444-1-hch@lst.de>
Subject: Re: [PATCH] block: fix virt_boundary handling in
 blk_validate_limits
Message-Id: <170852530920.4152224.5996130051205184406.b4-ty@kernel.dk>
Date: Wed, 21 Feb 2024 07:21:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 21 Feb 2024 13:50:10 +0100, Christoph Hellwig wrote:
> Don't set the default max_segment_size value when a virt_boundary is
> used.
> 
> 

Applied, thanks!

[1/1] block: fix virt_boundary handling in blk_validate_limits
      (no commit info)

Best regards,
-- 
Jens Axboe



