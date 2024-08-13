Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B313AA2D
	for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551631; cv=none; b=WlJ54II8y9FHq0SlLF6RHuaaoyuUosP1sOWs+ES46ap/itynC92edxFmqXsPtOOGZOz9WihM+may0B/KU8jcueVMXnx4b5Y44JjPw9+Dh3kSawC9jWqci5gBa8niArm2W06VKLkUux7RfYrnCeaiFtvQQkgU/LPLMYcDr5so0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551631; c=relaxed/simple;
	bh=+R7ZvIeFL0A1vR3tjShD1A+1dOlGFXAXZGOKxEXshPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lu3uj4sRZ2U5AyXlDUwNGazYhGQPlXeM/UxapVsrZcxyf7qja597BGHN+pIPvQbWMxA0rAIr7uhrJW/b5tKF6sVEyMkhI10t0OF8i5zDdbWCM23mbT0kP2hx2m/EajU8Vv2E7KRTeyoE2AuPBF7GsXR7O9701NRvmIHGBwLqUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WGSgaUJG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WGSgaUJG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e316754f65so143076a12.3
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723551629; x=1724156429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVmwWifZ2w/oDdaeemnQ90F4/USmQE+NhQS+LiDIkfU=;
        b=WGSgaUJGc6dGm8txA3byLTEhkPqWDHsRPkmhlMDwLYZXx4QMRH4haWSdax0YGfHlsf
         maO88KpoVSW6x0gCfghZmOza3dNUxiy+N13Q3EW8kP8tCF0qs7j0NnvjO0bwk7IFw394
         kGxwzi6hz+4NgHhwhY6KH3EdPsBYDbF0XCVb/7MiIHVQgZUmVtLi7ZK1NOGuJbM99klR
         76RnQhirBYuHd+H+FTH5H4nVdHKNuTFxp/sGQ/P3NhOpKjQgmBe6ZbcDZd7XCGRBM78K
         UtOeyNnD8hjt7v/yJyFXjTC51CKY+1Cpoydyhpd/Kfoa/qTz7SVPQx+56c1ioj2/OTiA
         qJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551629; x=1724156429;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVmwWifZ2w/oDdaeemnQ90F4/USmQE+NhQS+LiDIkfU=;
        b=F8EGwVfxpzrVjejDmousB/hLs+NJDj7Y/j5BMnYPPS7bYHFUu3rBe6z7NW+L0XNlDn
         ZVzq3ijb/f9VYXChhdZk39RQDcgoLqHkG0yNlCw+XkRaf9SKDh8ASL0LD9U5RHQR4hC4
         oBVhsqHgKCwips0eBfwkRdhMap6XH4JkoVoEjC4hWdTTczdU0qQOB2L9uEykkqLfci1r
         koMEteqZUHlvsKyfnC/M3oiROI6K1UYB+sWDkJjuxGD4G6UdGBeOO9Ls6W+6jnkTo0G5
         eZCopTh6aZkCfr08MaRFPgFLqRkyzQWFqDI5nOIIzHZfVNQ4y1Ivnee0w+S3AVziib6o
         /yug==
X-Gm-Message-State: AOJu0YwenT/zU3eDRDZ//cTirDGYEtoyQ6tMQ6k1GCnOHvjLTg5X7hwv
	qjOAMaZeSjj0wkYqfY8s94JUJOe0kLEFKc3hpHB6WMPT50AQyK07kxEOfpGrxfcrpjZ/K1i5vM8
	h
X-Google-Smtp-Source: AGHT+IG7bLJvESP5huMIw4BJi1d0zLKnhM3L0GW/EdAWMoiyS2iFHW5ej3rTXOgb7nEV8yIb+Deo3g==
X-Received: by 2002:a05:6a00:91c7:b0:70d:140c:7369 with SMTP id d2e1a72fcca58-7125a26d0a4mr1280340b3a.3.1723551629374;
        Tue, 13 Aug 2024 05:20:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a4357asm5609663b3a.133.2024.08.13.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:20:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <d24611b3-dddf-473a-903d-39290db03b11@p183>
References: <d24611b3-dddf-473a-903d-39290db03b11@p183>
Subject: Re: [PATCH] block: constify ext_pi_ref_escape()
Message-Id: <172355162797.7496.16603864423262267958.b4-ty@kernel.dk>
Date: Tue, 13 Aug 2024 06:20:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 21:12:10 +0300, Alexey Dobriyan wrote:
> This function doesn't mutate data.
> 
> 

Applied, thanks!

[1/1] block: constify ext_pi_ref_escape()
      commit: a28dc358e28fb0738dd23e401cd7646cb4b0f7f1

Best regards,
-- 
Jens Axboe



