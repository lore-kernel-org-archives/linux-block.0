Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A84BA88
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s7YZG1N+"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-360576be804so2612505ab.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704902501; x=1705507301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll2VLSvfVJZgvZjBAdJKLeKajwGtXfw/x0gzQJjTH3k=;
        b=s7YZG1N+vACcPFwvf1XfsVJJqUYlT7oa6R6y7lDA8uULlKWpbfKaKgunwzOS9R0kkM
         GneSYVhl4n1lX9HJhAMYluk/dXgxlCqmgHWqrGtxJNBWXlWzRiV1K1ytNSLFwvMuWJKV
         TootfcIfl8qQhgp02aAQWeeefvERImfrrXhp899PjKU5xDvdbF9uZ+GeMO2yl+EdGUBR
         dmnaCM+McZMcX+IKq314gTAE26jtyqVyxxAaP8L0bols5D5f/qOMWa9Lg/CpOpM+0Ycm
         v49QselliholOgaKi7EIzuwWQJEGZlqHMGhSi08weQxiTaW4a6YjUbB1OT5ILJJUOlsU
         CS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902501; x=1705507301;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll2VLSvfVJZgvZjBAdJKLeKajwGtXfw/x0gzQJjTH3k=;
        b=KhQieMk6NjEYjZd1+DLxLNgOj2+2duPb2blXF9Bv/RVsHlTfRiO0P4sdYINn5+zDL5
         Gm3KZLVb4r4Pqlm77EyKNbzJvRbSqb0B1ewrkCe4ETNkJWWZZuhygLYNFKoMmjBi7z4+
         CuWX4E6z5rbcP6m+dbyZVEaHzNMzVX9oA+0WloB0P3qIzO2mI+MTO7R95dDMOKyxdoTb
         8wKC5lDBVjrzqCX02FqJkO6fMpIKw5lyQeI3ofbJwlXp4Ss7Lgc4H4Lw7PGnYv9LVoG+
         xBTHo7BTKHHX4X7SLLLm1J8ifhjEK3iPR9hjncZitJ/BxJtC+rWD47Vvlrzu0opy8Ne0
         LxNw==
X-Gm-Message-State: AOJu0Yx6SyRmAwfH94t8f9uNOu1XcMrVsb1S0k/8T+axeMG0i+CLnjkl
	W0IXuBRiYRS8OYkdVQfmcyFNcJiLiVDxqwnT/LutjplzlpEu8g==
X-Google-Smtp-Source: AGHT+IFgQkDxmmibT8OyGRHaZOJ88nofL0YVSaKNJUmqEWaFz1s5KiySsrvNQuGQKCyliaaOsh4qSA==
X-Received: by 2002:a05:6e02:1d94:b0:360:64ad:cf39 with SMTP id h20-20020a056e021d9400b0036064adcf39mr2963465ila.2.1704902500847;
        Wed, 10 Jan 2024 08:01:40 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bk8-20020a056e02328800b00360a32832e7sm818031ilb.66.2024.01.10.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:01:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240110092942.442334-1-dlemoal@kernel.org>
References: <20240110092942.442334-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: fix partial zone append completion handling
 in req_bio_endio()
Message-Id: <170490250001.1736393.1724380869887804757.b4-ty@kernel.dk>
Date: Wed, 10 Jan 2024 09:01:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 10 Jan 2024 18:29:42 +0900, Damien Le Moal wrote:
> Partial completions of zone append request is not allowed but if a zone
> append completion indicates a number of completed bytes different from
> the original BIO size, only the BIO status is set to error. This leads
> to bio_advance() not setting the BIO size to 0 and thus to not call
> bio_endio() at the end of req_bio_endio().
> 
> Make sure a partially completed zone append is failed and completed
> immediately by forcing the completed number of bytes (nbytes) to be
> equal to the BIO size, thus ensuring that bio_endio() is called.
> 
> [...]

Applied, thanks!

[1/1] block: fix partial zone append completion handling in req_bio_endio()
      commit: 748dc0b65ec2b4b7b3dbd7befcc4a54fdcac7988

Best regards,
-- 
Jens Axboe



