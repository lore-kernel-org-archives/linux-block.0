Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB217BCA
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769867353; cv=none; b=YzCPkTK8uUl3qzXFrHinz5/Vc7R7M22QDFHWhj6n3QM+e28xtOJ/xDgaJlLVkh149c1sajZ33BEXDFc54GgFgtKfbl5TQYi8s1K/99ymGRnkYSHuPDmrOlP8oeOe091/yJO7t/TAQLY2l72j+KtrV0pMtjRdwJY3maozTMlWc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769867353; c=relaxed/simple;
	bh=f6k7ALdOVAWOrs5cKk+a3aEpKdtPurVjVpECEtMYa70=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h5vklG+h3c3ck18WC5EBjBgWX5gdIV6awuq7OVh07Djp4twtGij+vPMbxAXXfFQOKE+PWEvY8Y7nWAcaRfDZwujQatrnNimoL396ZqAVVIjTov5dehXOvuQgc40OgfCcmJOwpdsDdc3kMHjyOT9mKF5UCw+VjFORrMLTLTgFUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FkE2CeDx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FkE2CeDx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66307e10d1dso1557234eaf.0
        for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769867351; x=1770472151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pBDA9lF2FzKZhWCpmhdTZ6Cdm9a3pQch+N5zOUhpho=;
        b=FkE2CeDxT2KfRndl4bKEda5jHP8DlSVjNjr4Y9RG1ZPs1cbOKuKM1sRLTFOtA+tEsd
         ir7VHAYxwJaizXdOy1K02ts6SdP+25VLLbTnKHirZSWQeHBYSc3I9Ie60AobDqX8OLSV
         0L3guzsYUFo+CkJFM/WuZ0WwpGOE1kWl5qdkgEBZOZqUw/uen2tLW0xEUYXtMu30vmW0
         6iWYqUXVaUSWJI2R2Pk5lUUgDOF90rgs83vtvb0mgUCfE6THodbHXl6CK+628mg5QMow
         a/6ocRz7CS7SI2pqAEDtmufn2Y65PZi9mH3bTtsP4WLEJGfz+uzoN6FEjFGGZtN/5KrQ
         eQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769867351; x=1770472151;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pBDA9lF2FzKZhWCpmhdTZ6Cdm9a3pQch+N5zOUhpho=;
        b=RoyXrSGHJnMOJaqyatDqnSFxsnrOjaHLzyQbUSreo2T9ybrTMTFmtMKDQYvtEzwR25
         JprxJrCSrJ7zHh/LVlVA89SflpTBOs0hLqwqcVN+GjXXHXarvimrovFm4tT8Y3sjfcfg
         Le7I6TlOZC94JYnG2IpB7rVhAeh8evphgHimrNGNicNEmyCj14o/K3BRRvkkSWuWR9eY
         A4VYIU3adfAmCI/z8LdeRXUTMz7EdcjrPqTL4kvm5KV0jX41H2RexWWIktpSGfpBwC3x
         SjWrJL+EadKXTx4DtAzJyJarHon8t32mobS8iiMmyPHIzZmZESEEAMEccjxzj16hWDoE
         uZJQ==
X-Gm-Message-State: AOJu0YxJvSDgcrsqN9qpi7cOMTp85HhhXcbZnA9+v1mlCLZ7DdegeSc8
	KYmmIn/GUDFK/MkRBqkwIwQtYqp+47RzezNB82vV5GDWX+Y0lpBsoSeffzI93ESEgpF9gYKkMxy
	iP5OWKD0=
X-Gm-Gg: AZuq6aIGN9anwDBpgJHSPqvh4nCZfcIOOjPSxbHasUB9WRvJqQZfTuH2nnavv46QrLo
	697j9h0F092Yr3+FpcV041meP9RzW1XIsy32sFtvNKQQ0ap0Ur69v2XsiNjfM+EmrDcrs83dV1U
	lG/feax/UUFPaafYvT173xVp5opOgQ4BEnNXBRwaXK2LtwMzryG1O7UPurKXW7ZehHT3/QhHgXh
	e+ZC1sI4n4EP5AH+tuO7Z4vGmxAzQHTLvwZKBYacb0/yUEs92VnPgu1Pc6PcIIoIBGifw9OOVBx
	OgNv3iAkfA97vZsmKFnKnOy5z0eSTODkROT1/7jgEc99CHzlIBKP7nijFL39pQpa4jVJbQsQlak
	+4rGDe3AVCnYv0JPWa65lckNQipOXd/4dgbciBBpUK6KMowUpSUsojTnV/doCD75Cshb+8Gkrso
	rpfcgaTKEYKmAEIUxxvpLVZPuAFEP+MNay+QdEkbUmkZ1vK6NPsjTOKJEYagfwqo3+
X-Received: by 2002:a05:6820:2002:b0:65f:75e4:3481 with SMTP id 006d021491bc7-6630f3e5615mr2536722eaf.83.1769867349429;
        Sat, 31 Jan 2026 05:49:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a19cb4sm6575789eaf.9.2026.01.31.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 05:49:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/9] ublk: misc improvement in driver and selftests
Message-Id: <176986734815.961362.5601371269442256546.b4-ty@kernel.dk>
Date: Sat, 31 Jan 2026 06:49:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 30 Jan 2026 00:19:49 +0800, Ming Lei wrote:
> The 1st patch improves fetch command removal and canceling, which is
> reported as risk from AI.
> 
> The 2nd patch adds UBLK_F_NO_AUTO_PART_SCAN for disabling partition
> scanning during adding disk.
> 
> The other patches improves ublk selftests:
> 	- rename test_generic_15 to test_part_02
> 	- refactor test_null_04 into separate functions and simplifying
> 	  implementations
> 	- kill IO verify failure in null/integrity tests by not scanning partition
> 	- mark each test start and end in dmesg log
> 	- move all temp files/dir into single directory, and allow user to
> 	  override default temp dir
>   	- derive TID automatically from script name
> 
> [...]

Applied, thanks!

[1/9] ublk: check list membership before cancelling batch fetch command
      commit: 66d3af8d5d678d221776a1886baec8d78293592c
[2/9] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
      commit: 8443e2087e7002fa25984faad6bbf5f63b280645
[3/9] selftests: ublk: derive TID automatically from script name
      commit: 3a4d8bed0b47543b2dfce0b1d714b40d68ff2f7e
[4/9] selftests: ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN
      commit: e07a2039b6d4ae3acf8ae39b86be449b7fa18d4a
[5/9] selftests: ublk: rename test_generic_15 to test_part_02
      commit: 7a30d3dfea4a455d1109d5258fe332f2157071ba
[6/9] selftests: ublk: refactor test_null_04 into separate functions
      commit: 130975353b1548d76aa9790a4ac7e74bd2a37221
[7/9] selftests: ublk: disable partition scan for integrity tests
      commit: 76334de7da404c385e18efb3640ed60ca77a899f
[8/9] selftests: ublk: mark each test start and end time in dmesg
      commit: 4e0d293af9e37c735aec574c1e69ed71f81f94b2
[9/9] selftests: ublk: move test temp files into a sub directory
      commit: 2feca79ef8df5505b87c00812b9ba263b92c64ed

Best regards,
-- 
Jens Axboe



