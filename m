Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF21F03D9
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169249; cv=none; b=E0ITQX/HKEAoTFPSjlrckR1jCX50kNOxzFe8Gx5XI9XcF1zL9EAFDQVdRNfCQ8AI7iJrgxCwwBRVuQKIVxSwlVmOVUirCTi5BqjVVG0qAYWlosmLJehO0BcZri6g0uXdelSyU8NqA/Em/BBNVO9e5YBfpHtDg2MbVnfjZUEx+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169249; c=relaxed/simple;
	bh=h1ztbyCaoMUIwUeNl5wpPYqLNtsW1lyOVhg9W2NtNqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XAlpHeXAx4cmMTjEzWrmGwlL4+1QDntgsrqRi7xFcqKdZtpPDztz5fhGVWCeNAuMFifm+5YAj10SDGoOprC9HbWcuDqRuplRfehDCBU5qALnRPZ4vGBtdbUV0nQ2wem3sCE653F5xlSPNvvbwOO6SRUSYeixES/ScAwTqQwLLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q3MF0ju0; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q3MF0ju0"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b3f92c866so169610339f.3
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747169246; x=1747774046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLLft2u8k4vwvi+nN7SccIZOcYXJWVb1XeNZw46IGIU=;
        b=Q3MF0ju0lDPtJLXjzkhDKobF3m+Ya5BcWsfhf9+un9o2F7P6V4N6LgmHZTa7eZuEJ4
         A7prfY9zdRDiczW2IfA/XhUHuoK7Lze3GyPrylKBBy7PBlsUEB9RAL8bYkjMSKfOfXUH
         Z9Cx4SPcds7vCxy/8D+5mIIRSsGchSyvuzPwChftDIwuy9Opm/kAuEOzXr/VdnkauSTB
         zcNse6nCQ3IA2RAvs4wCfc8JgdOzRAs1nZl6gi2mxQl9RuDUtN49txEgqRW+yagtflg9
         syTha2lpPgAL+qRuziK5I4A8gODCBjGaYi/eNH98iIlpHO6H4/2bfLID6GqhLUR6FAB0
         Iy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747169246; x=1747774046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLLft2u8k4vwvi+nN7SccIZOcYXJWVb1XeNZw46IGIU=;
        b=tNE2NpZWiW60U0OAGoqyfa8kV90VvbRPyu5WlIfo3kxhyWWVYOWi6nlbxV0SoN4ioy
         u1UnhczispdVGLVl8VLgHpnmFXdcNii92ZzpHwnqPLV/lRu+IbdYdvjFTDVTBPDVG569
         JL4Ll6ia8RoAd4A4dqLWEaH60PrHOayeTw/oRYL9j4rw3sx1ILafVt443eDVYdxM9++G
         lnerSOVtklPpgq6V1qx+ljWdEV3dohq8Yj7a1iJhZDor4x+o126zevbSKs3jtHg1HBjS
         y5VvjnT/WNA/cnn1/pGBxZO3o6Mr7eyNb8C3L75xmB+t546pBITCXgFeEyEPTZ3Iddqu
         hJUQ==
X-Gm-Message-State: AOJu0YzctY+PQTqYbTIyxVlbPSeDYgEJdQ5H09qJhW3ndv89n2PPGf/p
	d5DAkCwQJaSCb+6DT6sEBnuW7pYXaEeBamKBWsk/UXYP0bEPS5o3U0jKTl3HukKvB46X6aV/6Ew
	5
X-Gm-Gg: ASbGnctAR1+WTJH9+domOnC3Tk9w/s9MhJq1OAjWVnBbcjJFGRxbaQu6o75p6x7sX6m
	o5ltf8IZanziJQ3KkPLhNuyJklAvOO5Hq4kOPQA6bYztF7tVLfA1veFmfYfd0hPYLZpsb0IhaCz
	D0ngg18qcTOlDtpeXMseEco/dba8npJw4nmwh1XtDc5fj5HtKkkbPIhpOuk5JqrPLtJMsDfQg5O
	UOQ3shUlWeFbsW2L0/4lWtfXrRyYQddsxnF2UTmn2QHDIcAjxPRZmfYHftOny6c3jlaAa3AogPC
	KoincZr7u6TBgIDoE9T05QUsaveTLF8EGDSBi4Wi2g==
X-Google-Smtp-Source: AGHT+IEcGwUbQF/k5EHrd6mNVu9NXksoX5gQb1PGAV+o/Ry+GDB7/VpOwNJqG8UKlX5p473poWnE+Q==
X-Received: by 2002:a05:6602:388e:b0:867:3670:5d49 with SMTP id ca18e2360f4ac-86a08de1dddmr127268839f.7.1747169246170;
        Tue, 13 May 2025 13:47:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86763570018sm240731639f.1.2025.05.13.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 13:47:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com, 
 tj@kernel.org
In-Reply-To: <20250506020935.655574-1-wozizhi@huaweicloud.com>
References: <20250506020935.655574-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH V5 0/7] blk-throttle: Split the blkthrotl queue to
 solve the IO delay issue
Message-Id: <174716924503.10749.10556592372517387859.b4-ty@kernel.dk>
Date: Tue, 13 May 2025 14:47:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 06 May 2025 10:09:27 +0800, Zizhi Wo wrote:
> Changes since V4:
> Patch 6 was modified to resolve the conflict.
> 
> Changes since V1-3:
> 1) Updated the comments in patches 4 and 6 for greater specificity.
> 2) In patch 6, replaced the @queued parameter with @sq in both
> throtl_qnode_add_bio and throtl_pop_queued to facilitate internal changes.
> And the potential problem of null pointer dereference has been fixed.
> 
> [...]

Applied, thanks!

[1/7] blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
      commit: fd6c08b26460436ec0f53e125f8ded98738806f1
[2/7] blk-throttle: Refactor tg_dispatch_time by extracting tg_dispatch_bps/iops_time
      commit: 3660cd4228d9330b618e2700491891f08824011d
[3/7] blk-throttle: Split throtl_charge_bio() into bps and iops functions
      commit: a404be5399d762f5737a4a731b42a38f552f2b44
[4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
      commit: c4da7bf54b1f76e7c5c8cc6d1c4db8b19af67c5d
[5/7] blk-throttle: Split the blkthrotl queue
      commit: f2c4902bd08b854a23c3c2ab352382fd7eef959f
[6/7] blk-throttle: Split the service queue
      commit: 28ad83b774a6f11126d45bf912bb8a7c16cb2b2b
[7/7] blk-throttle: Prevents the bps restricted io from entering the bps queue again
      commit: d1ba22ab2becc8bf84d466791b970905abe99b23

Best regards,
-- 
Jens Axboe



