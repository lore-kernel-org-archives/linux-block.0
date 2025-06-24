Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63962D8DA7
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776702; cv=none; b=RJPn6Ky4xODQIlbiUZOIvo8kN/h3DiZBGhTlV+9Tw4w8/CFyb3xhg4jqkhYUzKGkNGHLLIZhmUsxdzLloMENejAN3D8FMBMb8Rmvd2xOkyYfhBx92fHNjXQpGvI2Aj2Y2v47YRcxKiKbeDizcy/bsjPl08BM/gr/LU/C5y1J9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776702; c=relaxed/simple;
	bh=lLZo3XCioGN2VmZspbBH/cVKc6ZfitGtAZniesui4/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b9mYxePynci4spYy4NkoCS5bHUJPaME/tsOxfZ5wH64LajuJs2Zo1QKiZcjeYOywSqMktBagP4ve6tUDFeaFjw5tiqEbvYCtc11racoS6P1Nio3XvY9Wrknv1nZhGtXAqKmgIby/4CPtDerKhtz0xhSrxtJYxL0lYC734Bj3ixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IxHo/Sm7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IxHo/Sm7"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso621027a12.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750776699; x=1751381499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z19LlO/VoQnqGK1HuixLHllJsIaoa4G6NY9ebJQWkH4=;
        b=IxHo/Sm7hJn7xYn792S+O7Pr1Q/ymFQ9DJdweh6K6nm+u5nQlhU2N/rR1AoyeNMobB
         h/jjGA59Tscc8j2unr6r7dO8dnnJGNo7vspW6O9MwnC/X+TzPzXryiuSGV8gmqvo0uo0
         ou+fR4sYDfzKhGM39eT/yuQAyb3+FZCEzeEJ/osH7QE0BRzGmCiCtCIudybmGuxXqlbk
         nKYDN/fpvqpmKpcp31fCPe2tQE3WfugEWpOhymSXkRa6U7guaxzCuA1vL+j5o/+NulhC
         bNOtcILAwGkGol/TuzrXFY3D7zArttKDAWe1AJ09MDQT9HpJ+g60i7W93f076KFiBnPJ
         3Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776699; x=1751381499;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z19LlO/VoQnqGK1HuixLHllJsIaoa4G6NY9ebJQWkH4=;
        b=GVEEnCCevF1+ScSgzZXlUi3FwgmyGJ6SyxmWnNh97xKx6BopmoyRnUjaybEGM4huKx
         U6po9ttkUDrgHFgHmEe/6HVRYbUW7/b1RwaZmdbqtWDOFhg62OeFDQna8LIISHaQlF9m
         c9dW5KN1nJWIRlUjQemljl5cpJUvleEPzD6vCHSvvmFx7zPVDSFDDYofW4XXUUBaZ3+H
         WAU+0i7iz2BWnX/eZ5xanLLKB6bcLsOHJWfkBLMz1DyE8p2WUjyoWxAte4CIpACyK6uI
         9bE00/qvMu3T67IIDg2YvJKUIrWITsmD5TOdvK/uXAFc8PDh5CT3NrD4eb3WUbhpjDBk
         P6ew==
X-Gm-Message-State: AOJu0Yx6eCCkoMbO31I4CU3zoS3rNWGfC76YqxQL+Aub4QBNMJinntAX
	jx58acpSZT9eTBFCybpUWWWJtUAajBJKXDj97hRjaUAoVHbYWW1aYVNL4YIE+FKFVI4=
X-Gm-Gg: ASbGncvL/8HVse5zzarUuA8kEL4FX+zAK2THbaQJRDLSXVLlSGkV1S3wa87m6FHnvTx
	w1DtI559FQeSZWN0SsKTeYF9FcZko/UUN3Nikotkh8b9opGAv41r3QYrS0MFS/UF8n39vmdDBEd
	ggUhtZ/oNL6jKuEpylVRUP7961yXWxR6fa98RqNDp+KTErkRGjmmUf3laD3DmYzNWa4iRxxVzB0
	hFDdCvV1OIjmKzzuRu6z7z4s6QEuvCI5Ehze6WRfpedeTTOR2w7RtOdWXW9bsEaOt5giEvssRQp
	4R2d/CpTzyfl9W+/bctNqCUHyud9Q65+wCwDWNbyVf/4qRISWDH0FwaonjO60VGp
X-Google-Smtp-Source: AGHT+IFZyzRo/UAITbV/zDfxTScnqprYg7Di4OXsosoYjfCox+lBtVp6/BiIQ7bRR2ZphjmtS6/f3w==
X-Received: by 2002:a05:6a00:a1f:b0:748:2e1a:84e3 with SMTP id d2e1a72fcca58-7490d9aae0emr28940263b3a.8.1750776699238;
        Tue, 24 Jun 2025 07:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c887378csm2040731b3a.178.2025.06.24.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:51:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250623011934.741788-1-ming.lei@redhat.com>
References: <20250623011934.741788-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] ublk: fix ublk_queue_rqs() and selftests
 test_stress_03
Message-Id: <175077669775.72735.2176536502790722928.b4-ty@kernel.dk>
Date: Tue, 24 Jun 2025 08:51:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Mon, 23 Jun 2025 09:19:25 +0800, Ming Lei wrote:
> The 1st patch fixes ublk_queue_rqs().
> 
> The 2nd patch fixes test_stress_03.sh.
> 
> Thanks,
> 
> 
> [...]

Applied, thanks!

[1/2] ublk: build per-io-ring-ctx batch list
      commit: e867d6c4d51a564943e88e08fb1b27bc68a81b49
[2/2] selftests: ublk: don't take same backing file for more than one ublk devices
      commit: 4cb1a3d63eb7d4d0263b2d3ab4f61555263b69aa

Best regards,
-- 
Jens Axboe



