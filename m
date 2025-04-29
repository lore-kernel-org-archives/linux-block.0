Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B72C10BB
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928136; cv=none; b=f66d9zYpyxOKywwGmE3xqHb1jyGhi5+JnpJ5Z1d0HgzR8/AzGsvC+RAlyMJMn57QDNz2nexbcIvSVx2XTdJkz+FYiYuYEdqoH3fTrDoBJecO7tWiJiIqmOVceEjg1D67tW/3CLQDsE0PteSuvPJcAo0dxqL0q0U4M/TeyslCfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928136; c=relaxed/simple;
	bh=YJ8IzNaIKQrQlJznsODIN2icpNZCmKCJE4SknKr+sbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=otanea8n7IAhrV2vbxnrpG5Qz0G6ivbEJiVKPFnLKasrxuqsf5+PYqqIj0Wy88XE7Kqbmvb6DtGkmuwl53Gl0/WYJyGFSSFWbe8h9B/N/NvxkAbPXnqcoCbJBvx1be3pcuFPTfloUEwNFLLOG2KWJxc/Nf9DoL069btRylKCl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NlBv304M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NlBv304M"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso71165275ad.2
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745928132; x=1746532932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyu59SCAErzgHc20ISxNwMVyVp/sHSdcy9ZP8BRPzik=;
        b=NlBv304MC1LNgoXEssvr7FrMlgZ+tcNxzkCh5/b9LTpv/nExbAhcV79Lf+J8hgH/8v
         FaXkG/IdFCIG+EG11vSgH5afDFn8Txghig8kULFkn8SVQCcm7ftHWpM7rJSCRsyGp+FI
         GeaFTK0DrEh8dMAxkjazuvJE1ksUB/LnlkQ4y9sVqQIXSTUxOSmhdtcIPLQHdg72CR0/
         VwlxF9CC6YZDSR4rS9q2XxqsU0PudIge5AlU2rjzc//PYMcciZWPc9YZl7b02DdYOdIS
         JqXQBIR9zDW8W/5ClCpc2GkfkUt5w6etz29QUS934Ai4SkeWNRba/7oNZMKW4YoRFznE
         0I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745928132; x=1746532932;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vyu59SCAErzgHc20ISxNwMVyVp/sHSdcy9ZP8BRPzik=;
        b=CeNArYatPitEm2JnsJlNGOrcdIA8ur3t8npbaAdULa6db1pmCJhyBe50fT/jjxkUvB
         Op2f4kLaVMX6H4vAixViNNUgTeLRpT4F7OaJySU9O/bZ2diqcfqzKzN0kpO/htkozghW
         nL4YzgS2iq/EbJEfvjzCyfNQqqxt6mvtyLTcmnM0Iec5BYDfML+1KtZw3f1c6JvpHbne
         1o4CIL6DudNlNcAIwT00cuv4vu7XmEYXBE+zmkKLs7wOW3H04HA3vRPmu0CFibNOQ7dJ
         zMGB2ZsdG9azA6+zD5W1gr6Zs0oDdtnc61vzkrc+X/UfxNJ3pSN4PWMlvkU+tuqG92H7
         oh2A==
X-Gm-Message-State: AOJu0YzKqSRJTvN3Nrl84ZNfDwFKZaYQvdwN2lI7K9vZTTjpfbG6NCJB
	nYZjndh/rjS1DjBT1TfhcoMCdnwdEOSu0UTS7JbJes6UlejYP/kMGY3j/daaLtQ=
X-Gm-Gg: ASbGnctehnIYtKn1x6lIEYdlK2SXKtrHN7Ki/Unfz1nPXOYRt4xPvcVV+arOA6M1w5y
	GLSQziqhAhWrBNjsljlcOlunn+kd0K7RxRlDr52TEGL42K3KJrPuPsUz3pc6hnZzLNrQRmDjz1j
	HH6gdlvceBZEUFudbnn8Jfc52xveC0ihIH4HzuA+qiZpCZaWLBFDDBxLY1TsgwmeMiD95kytx0R
	Qgj/i7hkVBIV/5wjzK0PfLTiReWAHKg3PLFLHWkD90oS55qMuN5imbJoDe7zwBaMsFlunE4wwzu
	AAS25UOBN1Ccx9I2cjVLSgReC/1j/SKq
X-Google-Smtp-Source: AGHT+IEjxITJMJSOjgo20yhY2ej5Q/o8cvs8rT2RPJsEN+5WaaJxUloSxWRBo+KO/HFJXvA1UQvvNw==
X-Received: by 2002:a17:902:d547:b0:224:1220:7f40 with SMTP id d9443c01a7336-22de700731emr34759295ad.3.1745928131889;
        Tue, 29 Apr 2025 05:02:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862e0f9dfsm255180173.23.2025.04.29.05.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:02:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250429022941.1718671-1-ming.lei@redhat.com>
References: <20250429022941.1718671-1-ming.lei@redhat.com>
Subject: Re: [PATCH v6.15 v2 0/4] ublk: one selftest fix and two zero copy
 fixes
Message-Id: <174592813102.36727.9732335212853748171.b4-ty@kernel.dk>
Date: Tue, 29 Apr 2025 06:02:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 29 Apr 2025 10:29:35 +0800, Ming Lei wrote:
> The 1st patch fixes UBLK_F_NEED_GET_DATA support in ublk selftest side.
> 
> The other two patches enhances check for zero copy feature.
> 
> The final patch removes one unnecessary check.
> 
> Thanks,
> Ming
> 
> [...]

Applied, thanks!

[1/4] selftests: ublk: fix UBLK_F_NEED_GET_DATA
      commit: 730d837979bac203c786f2c5b0707f5426275c0d
[2/4] ublk: decouple zero copy from user copy
      commit: 69edf98be844375807f299397c516fb1e962b3cc
[3/4] ublk: enhance check for register/unregister io buffer command
      commit: 6240f43b29f285a40eebeb789756673af7a7d67c
[4/4] ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req
      commit: a584b2630b0d31f8a20e4ccb4de370b160177b8a

Best regards,
-- 
Jens Axboe



