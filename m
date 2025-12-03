Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D330277D
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773590; cv=none; b=XwUG/bIRZ7hPFr22LO4zZS4yP4VxHQlQR/RoYqqZaX+pwinGUZNL6Zv8LsVxZtdama+JCmh+Hs6fRbgYIqzMj8ubuIgEbq3ihmZclvGBVjzzRMUHc28tVMnqC2IH6At8qhz5uyc016sBUa/pb86B45NRJjITVXdiTPPIvPvE34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773590; c=relaxed/simple;
	bh=51vchZDDuCG99ZyXBOF75m/Ok9cyPANtpXmulk2ebMU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dKzRUHwPoTuiZ4ojyM43qYECPU1Cs7TKHKjve139MR4MyYb3wluqOabUdoSluQcf12JJJUzQm96NW5hkm85IwqeWnn7lPWXGIcbnSRLIjHREREQSStCY7DiMvnOt0PsK6sV8EE7k84WfyPzX4OGEwedkTP/gi+2/63GKBcDicbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WM6bKsSj; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WM6bKsSj"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3ec3e769759so2159720fac.3
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773587; x=1765378387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=WM6bKsSjxRqS9fzQkNFqQljre1d1/U7jIbEFzdQ53xb/Ykf83vGWbz1fENNm/EM/IN
         RgtJVNluLPT1CoQf6PPlW+ZhKRIA6LYzi7R5qgbujnjkFpRoIoXiufRnUxr08Y0Z7WBG
         HBD9I7FNRf/kuR+Wyx0hMhVHcBKjlXjk2QyTwZeQHjyjezVFaYLwErac93LuwD/6n7SX
         hqfnD7RN/Jv2J16t6xyFwTsq+VVtTvM9GuppO5bfUgSZKwrLgBT+Fo+ZKFy0H+62PQeT
         3o3+RPKj92QSWZ9z0HYxk8yisd1tJ630sGzwJq7Yobv3dMsiZR6oHoa1vbG1xo61lKAc
         dpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773587; x=1765378387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=YRi0MIVfPAQE2g2Lpet6MyUy3i3hNdQNbRQVlyRLvTzLWn+icYnUWFu6u4SAvP6Gd1
         ixHiX4huicCBfY8ChSq3o5LQzVl4fiUxMubDgcv581olUMQzpEohW/nqlk8ycUSQpeb7
         e7YmH/UsJP9xS3rtS6RM3e6yWwWKmWz93HmDhvIXejGQyKhP+C35T/buxQU39xcinf+3
         DmZY4tZXuUl0Sq8RTPc7/2wXnHBias8KGgFmm+QZeUahoVdX4Rldie1hAJfXS5NO805m
         TIQGXW99kWS3i+KM45otjAG/VuobSQg2gggU2KEM/FYVNmILD/8zCjvlBjS2fiPP29El
         5kCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6QHxxi1ZRkzrn4lxCR8A1h8LlhEPevHLfcCFfgmBfWSOT7/Dm5pRtyHjIvMrYRVbMWROpfQ31j+YChw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+ULQX4B5MSr+NHke1jVjVZDbQnVMtYIJ5pqSW9enaUcVyAtQ
	fH6gp9m9Q/MbhahvhQGkgINa+oMw+Nx+x4FYzyFrWceDa7b86kWs3bGhWv45EpQRZB4=
X-Gm-Gg: ASbGnctvHmeICUEejKhTakCodBN/TExh13v5ID8MNeEXsFaLCpSFezk92edXN5do/W3
	w3DMOjFsXd0H6s77Ww4gCC60fVHbSYBki/7cII2JhafET6uaHYSl+SKrX6PtEYzHOzyZsHZN8Ic
	rnzmBkanLx4xXVk9Xn6Hd0Ek1g2kyviFKHcaKwL+Cl/105gB2Mu3z9zPy3D6Il6Z60ew0V9+5Xv
	ElWhhX/2gEvO65jqPcz9/GT5CZ6U9OMp2JC3Cb/eiioTb99F3DsJ0vyEobs8Y64Y8bNqbpUFuIz
	3ZdBriXzKutyID6zSVXIAg+L09x/N44KGBaySpyBvanO0oG4+ZRDupyrQeWpIZRClyQ5xmbJz3m
	ggi3gnAPCYBZl5B3lZU9xEZl3Lz6F2oL8Cgq1OIk/l+EXSsHge+ggYl47EpvGFkHp+N1QK31cEi
	LzCg==
X-Google-Smtp-Source: AGHT+IEmBEK6bTGKnMdujI3ujDy4UcJas/45ozXk4d/lBkl5ABzvdXswERHZW/FvxgYvWIyzTXS/0Q==
X-Received: by 2002:a05:6808:1a08:b0:450:907:b523 with SMTP id 5614622812f47-4536e3af4f8mr1301320b6e.6.1764773587425;
        Wed, 03 Dec 2025 06:53:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org, 
 hch@infradead.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, 
 ming.lei@redhat.com, linux-nvme@lists.infradead.org, 
 Fengnan Chang <changfengnan@bytedance.com>
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
Subject: Re: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Message-Id: <176477358617.834078.6230499988908665369.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 17:21:47 +0800, Fengnan Chang wrote:
> For now, per-cpu bio cache was only used in the io_uring + raw block
> device, filesystem also can use this to improve performance.
> After discussion in [1], we think it's better to enable per-cpu bio cache
> by default.
> 
> v3:
> fix some build warnings.
> 
> [...]

Applied, thanks!

[1/2] block: use bio_alloc_bioset for passthru IO by default
      commit: a3ed57376382a72838c5a7bb4705bc6c8b8faf21
[2/2] block: enable per-cpu bio cache by default
      commit: de4590e1f1838345dfd5c93eda01bcff8890607f

Best regards,
-- 
Jens Axboe



