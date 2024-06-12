Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3D250EC
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211672; cv=none; b=aXhGhK4SkENuGZzBo6UlI5xg1mj8wQCdz0hSlLaNA5GIzvYB87plFLIBMBw6pIwqpw/wcQ7dqj7IXEJfSkdvxq8utbd4r1vE+5e6Ep1R6mgBTUAezQ1zWo45lj8yMu3Ge4oMuwcf4hQwsCYUDn0mZlOou44v2l9Nz9L62M2hqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211672; c=relaxed/simple;
	bh=wfvnKuTEuK82D4wpedQLQ1gILbKz5VUimIpfPZTTOO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mgCZ3wxlueBhemZmpY8mseSLT2r0oE/VQyTCMqmrT6DXI5nCGQjpeYIRnmQFglGLNCY2sQu6J+Z3vOSJANxO1++jwcgxjmEqNweY39PmVUjgd3n0CswCGGXUPBjlmAZxt+um4aDzKAuuuYBXLUN5/v3Fr3PgGHu56l0117eFKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1hVt9mrG; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1hVt9mrG"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5bad42fec2dso5017eaf.2
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211669; x=1718816469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hksk4wAbIz8bSZzaWxnZT/zZszVoyi90hMirDssVrE4=;
        b=1hVt9mrGZzKQxJ/7WLMz0Ys21KR3z1e9Lj0hWEiiJM129/zKQ6Atd/CN0QHgepfD/h
         BLb5tlUi0PqBPSItqYqLUD7Al6umJQestI2JN0leN+LKb6/wjvVmEFDkiG3jMXdYow9L
         8319A6aiNUjPCweOdkIqIkkUwNgCa9J8ASgN7yaU9buQj+1PjwOz+yHcfXeomE0Yl3ux
         nYlLZNasuSdQLCofgXvPiy0EBwQ6giQlLo/mxsg4Urxv1y0Ax+TbADuAjH6t/RKrSjHZ
         2yn1igRbKfTr4mLzzzmivxIoPkbJn7BCKOhhqB/Py+2AudZYYNfMBP1vkvbMAxYjyj7s
         ERfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211669; x=1718816469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hksk4wAbIz8bSZzaWxnZT/zZszVoyi90hMirDssVrE4=;
        b=LkL3s2AK05mchUcl7ypXNnASABbjjpkiRljr64PIFmFT4BV8WclmvezGJGGXPJ0Ozp
         22psUw1j8LwJ9XNOLAvZTkOY43BRplSjt1CbEmpxILIZGd2uYdADssywfqx2z3YlUXVi
         SZsep5ivxj2lryJ6UfhCLwAT2zwrmuGV+f/03CQZt52lR88/SRiGPMQ9M7TPNK8xx70q
         rcosQwwdsjEKdr29cnhtSLisbwEl2rYWEcIzSQVKFbZrb5qqhPHOmn2lzSRISN2HOqGY
         lz0GVY5OPv2TDPULt2jmXwQbQ0XyjztZMw0Z/9rKekP1wnE5Oepnc7ThBN3j0HdYI9W0
         iP3g==
X-Forwarded-Encrypted: i=1; AJvYcCUSvsMb9OfgJQWrNAnmplDybYrKcypqdGk+IgssVpD7zp0y4RP3MuoCXHrh6iN2zLXLBTK3jEjQS0IYyO3tQX5A958h0LHFUtMLlH8=
X-Gm-Message-State: AOJu0Yz6dPseutQmdQHRlOrtjxp2dLRt93n0hvAUMoQ/ozVSAyQrVPwq
	6vZ1LBqhbbqebPBrkDyTQAGqgfiKa4oes6zFq6Dw8i/tThvlyDpYEO9DmONLSTaewuE91h4PWah
	O
X-Google-Smtp-Source: AGHT+IEShVwbkX8uANOzA7Y6++m3AdDkF7i2edh/ZcjLmOq4mCjGmcRKppMnpDEeIrhOSy7IAhNZyw==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr2474760eaf.1.1718211667997;
        Wed, 12 Jun 2024 10:01:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e03d5sm2464036eaf.22.2024.06.12.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:01:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240610111144.14647-1-anuj20.g@samsung.com>
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
 <20240610111144.14647-1-anuj20.g@samsung.com>
Subject: Re: [PATCH v3] block: unmap and free user mapped integrity via
 submitter
Message-Id: <171821166696.49890.9778377661533135590.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:01:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 10 Jun 2024 16:41:44 +0530, Anuj Gupta wrote:
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
> 
> 

Applied, thanks!

[1/1] block: unmap and free user mapped integrity via submitter
      commit: e038ee6189842e9662d2fc59d09dbcf48350cf99

Best regards,
-- 
Jens Axboe



