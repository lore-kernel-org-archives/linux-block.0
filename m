Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24F25F7A1
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758309; cv=none; b=Qty4Mt2eeFGluClMCyPl5Xs1Pm3DryivMu2M1XNXm7gzW8Mq/jccHPyH/3bX/cWgbtGTeIqzbwqaBnIpyzxiMgk+OC798i9BVfUS/nNApFFaHQYtKtlACZ2qogQIJHVJX0mp0WGwYSVMZ9PFJ0ggRRX/w0Ksbt2Jf2MvZqApTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758309; c=relaxed/simple;
	bh=p0Whfw/DG9I0b3d26KrWqUGMqFDkcM87KkM0IgDeb34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BIDemirZD32KeITxqWFjPF3e9BozBAvbQYVqwypP1DUK+7huqsQkJM/uZ6X4RW29OCRgRNSc9lhNc+Y3tgiLisCsfIUR34c4+g9auMOT6XRqPQuGGaZH4dRTByiLdGfOU/ekD38E2mmxbhgK9QOqnF/NCB9GxbaQ1HxYvSE8Vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FYbZEQRe; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FYbZEQRe"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dc6a8bc915so7955855ab.1
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747758305; x=1748363105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLAndhlKRKbN71qUVtfJmt2T/Ss2q1PXi2kUc6FS8fw=;
        b=FYbZEQRePHWsG3AQWhOdYDwkU3gwocdruhhy9v3zZiQip5ufzdSzfMJ9XIzyGpcXAn
         gK0QbiYxXG8HdPcgACxrGO7Hqs+usiXZlu6b9ku3afUV/I9rflH+2d39Ey/gNPV0a0rp
         6FWUEwp6WcTPtCJTWNI6SXVuxV9U60YgPgB+bAcDWtjKJTFFCv3/aFdfjOdaBMOn07hY
         ZBnVSNW5Oi7rj77gU87NvL6Sb2Zn8tcMIqMEG0b4o6gIiOv79jIJwqldExL5aDInNS3e
         nI4OVsJszquxWwRNOQe8+8e1hzKE3fbf7ZgmSjP81PK5RN6ACNYHCIUOG4d0fgx0m2WV
         nH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758305; x=1748363105;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLAndhlKRKbN71qUVtfJmt2T/Ss2q1PXi2kUc6FS8fw=;
        b=bI4sIBa9/Vyp4jlf/tIJMCFMw43UmmscT9XpwQJEPYxQEJe2m7+xvqFdYAnljr7Wa+
         GI7U1p7M0NpK2N/oX4PHWbMiMZvcwZav6GW9T0715zonQtTe0NSuiwYRhjL5ecxhXn2/
         8ugqyP7SNd9qAymBc/juYTIzx+pPhb0WcK1hdaUHPf1H+52awBm7rVpyQiLem/i0BOrh
         z0d0zGRhrGEE9rExN3Sd7vmiLlsou1GKNyZPilxnDejnBb281ZyWKHxj3lQCfSY0crQk
         Hbi2kSoY5Ecvd6RcINVpAU/Xgx+VXoG8mLDJ0bGcqE/zcwUUDFfkQ/GRDk+SpoRDDeD/
         BOCw==
X-Gm-Message-State: AOJu0YwXXoQ7iM7/+yNANF9yv89VEEfpcMQAqA+kbADgDucX+xRDZAG/
	i7eK7GBRnv8P2BFfQE3YZGYjP6FUdyvK9b5DDgveX/EXmxJrusIxibL/KeWx8eFtAgTHBLsqxyx
	CC6UH
X-Gm-Gg: ASbGncsheQC5/GN183R3NXVcJ90oicKuXI2Mmz+UBs91peSoelLAn2oLQ+H82JwX7T4
	1XNGIIE0OoPuy1J4rhTn906n5SBUnkyLSMqO8XQsNaK4KOMjMG/fGmzDXlkhtvuyH4ka8iV2mlo
	ajXGxBj0jyLYcTfuV2DnyMAeIwd87OgKfbBx3GiqOUk1ym/ugjSoGCbMwsj8Kp9pEx1BUyiQ9yD
	L+Q1Ey7oiufv8NAXAa3Nczs8t9Bb83FStB1VkOw94VwHIj5GDxwkpx3lc/td6URlTWS4ybS4WiU
	DKG5eqIXcqYQ/733Zqhre7Z385SPwuCnKlSzuIAgFw==
X-Google-Smtp-Source: AGHT+IEpl9E5/Z6DhEo6WIAz91nWrW12mFVDJF1vm6cO/ilQ3qjwTFSam49Xm9hG/VYyaagRsMlU7Q==
X-Received: by 2002:a92:dcca:0:b0:3db:8567:5df5 with SMTP id e9e14a558f8ab-3db85675e31mr123535805ab.7.1747758304753;
        Tue, 20 May 2025 09:25:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3dec82sm2205762173.68.2025.05.20.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:25:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250520045455.515691-1-ming.lei@redhat.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/6] ublk: support to register bvec buffer
 automatically
Message-Id: <174775830297.740786.6316975017140444248.b4-ty@kernel.dk>
Date: Tue, 20 May 2025 10:25:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 20 May 2025 12:54:30 +0800, Ming Lei wrote:
> This patch tries to address limitation from in-tree ublk zero copy:
> 
> - one IO needs two extra uring_cmd for register/unregister bvec buffer, not
>   efficient
> 
> - introduced dependency on the two buffer register/unregister uring_cmd, so
>   buffer consumer has to linked with the two uring_cmd, hard to use & less
>   efficient
> 
> [...]

Applied, thanks!

[1/6] ublk: convert to refcount_t
      commit: b1c3b4695a4d5f7a3bf43f1f7eb774bfa79b86a7
[2/6] ublk: prepare for supporting to register request buffer automatically
      commit: 9e6b4756b35426801cae84a5a1d7a3e0d480d197
[3/6] ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
      commit: 99c1e4eb6a3fbbec27c7c70e5fce15cdc1422893
[4/6] ublk: support UBLK_AUTO_BUF_REG_FALLBACK
      commit: 53f427e7944b4f288866cc4a69835086e0958c6a
[5/6] selftests: ublk: support UBLK_F_AUTO_BUF_REG
      commit: 8ccebc19ee3db03284504d340e5cd2de4141350b
[6/6] selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK
      commit: 6f1a182a8750a679698366b021969a57ec589313

Best regards,
-- 
Jens Axboe



