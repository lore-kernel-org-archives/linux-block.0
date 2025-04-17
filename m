Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696D10E0
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853557; cv=none; b=mjRT66Jsssyc6iTlANqUMVkHlqyNL3i/D2+SgZoP1Z2aQRxBs72JpyHw1WI8Xgw6ABzVsQBN5rx6rCk2AoTy5y7VPYYi+7z+Ap3Z7f2YTaWw+MnlVA2l7M+vFkgFYVtVQN4i+bL9XFbXAkEkwpD2B9ltz40KBPCyIuhuhC2zod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853557; c=relaxed/simple;
	bh=NwI0pwNMU8mkx40AK7UHvPun2Xk6qbe25FDQtw/obgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UZrEqd9nLv952TZAJgk5bI+rezpNpyQ7fMYnCy+WEFTMirgGH0kMGHDbsySpfYQL251TccvmFI3FUbRNh3Kr/L08i93yGIZVm2qhCXglOAcGZrW7j3KrfDbiP4CmGVJFMYt6PMbWQtVorsFFbVF/tpp8s8Sk9tT/+cMifq564NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QBkzo4BI; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QBkzo4BI"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86117e5adb3so6440039f.2
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744853552; x=1745458352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJCcqEIrwqixU62MsYmr96Z8R+93qs8hQRDXXp+kH4k=;
        b=QBkzo4BIF9Hx9jZCHuF4McV9/Lxlf85lIGUVdHIgcl/Ku0EqbjnugeK3Z9lGu1X4SW
         UZgzmD9CFSCL+zcBWnXBOWIbi3YXeHJYs2SQzqMEc3nHZLjS1wPf8rYz8eNVFS/4hfdt
         odsJiwY/jA/8t8xoHG3r0suTWgLqkugkPIWfEGMn4UQCpC3yZtCW0kWn5NTXEg9NSq1k
         QnG1Yb5wKSGcwSpD4no/fL3iV8yicjcgpw2ax8YO5/Ppx9p40TKmqdQabD+ywzBf6hhU
         nvHZEWBQl/TMrz6ju/dBPcHCuD038nbdpzFn0ZBj6nz+46i3a/nbeybQotpOG63a0y/t
         fUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853552; x=1745458352;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJCcqEIrwqixU62MsYmr96Z8R+93qs8hQRDXXp+kH4k=;
        b=dpXkknavfEfASpvh/jqt1Ga+6H4uwWXiiyuovYled9FkKvUDMTc6V9j/rsdUyUBXik
         KEADPO/2N1N4sa5rem/ZumqiY1zRHjCosEOFmmk9DBiodHyeUwM8f8WjNlJAF/X5e8If
         +PJjz0q4nPF9ddSWK1IR4RRGOGlHFwqV7vW5Cwrd9PruhqTP89dYGoeHrM6zIPuKbM7X
         yAla4qJYxkeLjXdgOQUT1EkGZl1qUjbeFTODLumL1BC995LtKwJZfmhTW+iMrkjzsh5I
         RSdpyn3P/5gnbLIuE1+Ybz7pjAgWtZiJLCiVBm4ztwO6ZeSq6V45uJhl4V9Lf4PcijNf
         TRKA==
X-Gm-Message-State: AOJu0Yya4wss7Uy6PpSjxxwv6oZWguK5QEdOK9qbyIvkQBU7Es0a/xWp
	ZLiXhDbL9DGgP57XRCjdV6UjAclG9DfKVSC+aA+tPnJOBdZKNF7hqD+UNm6Of2s=
X-Gm-Gg: ASbGnctQ/yxMxKVVf0hOnkpbCRg4XOH36S6fygCP3mXFtSKNiiLUIah33BCiovNRKAU
	DU88ebaN7i3ua4YPhCadFBu9J41vqYs5fl52+vAfixRENUUPU8/YHYzI4Gtd4sM5OOxW/TrNxXQ
	+kWqdx2Q8oAZhTL747aXcZWEWfaLDov8oix2GvsAlAy5CjBrhG5LPB3VA5dGpiCU3DS4AuuUnxf
	OF/UWk3GMU28AtL/978NU4EQQU0kLIwAB8nLejh/tn9OQ/UBTT+HoUbShn1xW07KfiP9S1VgZiV
	mLjK2SaoD0rg9p/6vcfz5ixr2o4JcQGE
X-Google-Smtp-Source: AGHT+IEb5BX4PRKtQMu/jhU8gaYRedXIJR3QcWo21+JWPPaFh5QdjKR8GA8Dix3dagMW6Tnpnc+DDg==
X-Received: by 2002:a05:6e02:3705:b0:3d4:337f:121c with SMTP id e9e14a558f8ab-3d815b0a435mr39583995ab.10.1744853552573;
        Wed, 16 Apr 2025 18:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba854f8sm40680585ab.21.2025.04.16.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:32:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 00/13] selftests: ublk: test cleanup & add more
 tests
Message-Id: <174485355153.494937.16719697605603092527.b4-ty@kernel.dk>
Date: Wed, 16 Apr 2025 19:32:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Sat, 12 Apr 2025 10:30:16 +0800, Ming Lei wrote:
> This patchset cleans up ublk selftests and add more tests:
> 
> - two bug fixes(1, 2)
> 
> - cleanup (3, 4)
> 
> - allow to run tests in parallel(5), also big simplification on
> test script
> 
> [...]

Applied, thanks!

[01/13] selftests: ublk: fix ublk_find_tgt()
        commit: ec120093180b9d92b0c84cb89a205876f9a4cb40
[02/13] selftests: ublk: add io_uring uapi header
        commit: 9cad26d66b7a6306fa1e3cf64e30941afdadf6c8
[03/13] selftests: ublk: cleanup backfile automatically
        commit: 8d31a7e505340a69528cbccb0894ef530f123cbb
[04/13] selftests: ublk: make sure _add_ublk_dev can return in sub-shell
        commit: 573840ab90ad5bfc8711f0252cf88db028ad473e
[05/13] selftests: ublk: run stress tests in parallel
        commit: bb2cabf23568d74407a3881e81f43777f490299b
[06/13] selftests: ublk: add two stress tests for zero copy feature
        commit: d836590d9a9e1d822667e2720ef0d5e69a566aef
[07/13] selftests: ublk: setup ring with IORING_SETUP_SINGLE_ISSUER/IORING_SETUP_DEFER_TASKRUN
        commit: 62867a046a223e6eb771e23d2048e839c1d949d7
[08/13] selftests: ublk: set queue pthread's cpu affinity
        commit: 2f0a692a93a585ead9ccffd0642694946d74411f
[09/13] selftests: ublk: increase max nr_queues and queue depth
        commit: 6c62fd04e8bfc06f37ccda0d12fd367591445954
[10/13] selftests: ublk: support target specific command line
        commit: 810b88f3dcb6d04e274b37d05f421330e20a3714
[11/13] selftests: ublk: support user recovery
        commit: 57e13a2e8cd208db254968631820fc1353da9db0
[12/13] selftests: ublk: add test_stress_05.sh
        commit: 2f9a30bd16643d842da0921dc37bf00c750b0a8b
[13/13] selftests: ublk: move creating UBLK_TMP into _prep_test()
        commit: 3bf540609cab0402a7c3e40c1425532f3376318a

Best regards,
-- 
Jens Axboe



