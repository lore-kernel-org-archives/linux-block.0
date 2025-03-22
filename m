Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8878C1E
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742665210; cv=none; b=jo2H0hJo/b2iw9I6nROH6/itoxLxW+g3aT89ozPW4OG/UPEaR2oac7mEigv9vZMIqpZdgNE+yRQMsv/I/QrTaItvez73nI4tO0//T9P6q/REUr91T4E1BWaHyQYaxMfxFl/ekea+fXnBX0qdWIcY8FPUGui4jEoJWbH96QSccMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742665210; c=relaxed/simple;
	bh=BWZs9OG4et1n2TSvXFMfLdQamlRuWKjLH4SJy6VpjwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lMQOeXypHy4+Z1lK+rgdogCfMIUJdS9hNL97GnDCLdj/Q4lSY+jigcoi8pwJlHgXruJJWLZVtKPFIRnIDzKKbw5AtecOF+yVQz2t2njwW1ijwFLT2VnFTXrkMZyteQIx9E5E5PrtP4ZVhQiVhOrTu8jZ4qVAy9fUvltZVHNkrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h50bmmmr; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h50bmmmr"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85e15dc801aso266183839f.2
        for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742665208; x=1743270008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ0ip4i6csdB2mVrH4d/ra32V+NweWM/muWAq5nV5AQ=;
        b=h50bmmmrdpuNsHVG2Tkn2qMOxWOb9aEnhd6nqv628+pRZYQleRHFjBK9BsvHBJ8Qc4
         s3bVjRGf8r/GDhWxaEdQRlGuA8x6DNnVIBcqd7V911REoMYvDh4MpHrDZuKs7+YoejwR
         MqLPwsgXdyAiJiZDn/h7Aa3tDc4And6BXr/cM79ylp0d3pB8PIU6X9pXBpgmBo83wwFv
         TQdANy5Ttnygp88SaGcWhKfibxiY8rGfMFQISCnP0ySjyCQhcNZZd7Wz0pvRhYEjBUkL
         7NGvzUfHuOQS5f4yBsjKHvvPSDBg+nf1uKRNstAtgw+pZ1k/HzBSWoGdoDwSljHcn7UN
         9Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742665208; x=1743270008;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ0ip4i6csdB2mVrH4d/ra32V+NweWM/muWAq5nV5AQ=;
        b=tJx5MIPggRUDce4GwSKTYXUghFqU2HgffdhNXpdIBV7XeyMAjGZRno/dUL6fNWCR0p
         c9kBUkzs3WhKR1kvoTiPSVrujzeZwDrieXyS1pavOPizMiQ6uaolf1N2CjSAPk0tgIhl
         dSuOYvrFm+VeFoWLGk63cPLFhLxvc3tr3xXTx1uWsbmNmRbADe3MJPw3CuJJAc84pZmp
         vL7hILmkD/F+kahK+uWbeE5iU5Pbnh3buCpFE0BlVfCK/HzYJfCR3O7h5pKh8LgWth9+
         gH4q7y8AxicAL4LhSyHPQTIvpL2AbsFVte8Eox6cYBbuiXe1xjk+QL4pUFAm1Pl4Nuh/
         vGXQ==
X-Gm-Message-State: AOJu0YzPWaSStGIQdJOClP19+yypcOOO3Ukpq+BfV3T9Pd5VhgmMEc8o
	s/plinH4VdAdCUIJMX0Dig3AcU7rIKTJOY4rlezitUplZDSYM+gO7QtxxWc4gFE=
X-Gm-Gg: ASbGncut/UzeNylL0Xsy9x++XwyIn3bIZDztvNT9g4YDCBswxQgCm1E/mxQW1zqmvfr
	G9BMKY+dOsOU6IEH9LrvaP2t7WbS/gb4yCLDLFZC5jGg0bATJi71g+8QZPTxDmaqBnKKc3nrlKB
	R4K0pzzyKpDdcj5U45NU+JeDrBpo+iOhHXtNE/kjTEw53FwKby8ta3z+nPnufPOwzicPdjoWhCW
	BvvQDF2YnLT1Qg/PZjGjl3SJcjqaitaXx/MXJRQyVhHsD9rqeEo+aW7boxYWPDdOxYTfmA4ZOcF
	v1adiNBrkL4tmc3VSQSjBUdUjZsD/G5UTUw3
X-Google-Smtp-Source: AGHT+IFIjeQDbLNOW53InplpUybB3IL5ccWLRyeUxtphMPF9esSlQ0I36rytq+tgStMh45iWWeNTlQ==
X-Received: by 2002:a05:6602:6a87:b0:85b:46d7:1899 with SMTP id ca18e2360f4ac-85e2cc58f07mr673000639f.9.1742665208174;
        Sat, 22 Mar 2025 10:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc68c15sm89932439f.21.2025.03.22.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 10:40:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jooyung Han <jooyung@google.com>, 
 Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com, 
 dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>, 
 Mikulas Patocka <mpatocka@redhat.com>
In-Reply-To: <20250322012617.354222-1-ming.lei@redhat.com>
References: <20250322012617.354222-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/5] loop: improve loop aio perf by IOCB_NOWAIT
Message-Id: <174266520675.800027.959344570613955585.b4-ty@kernel.dk>
Date: Sat, 22 Mar 2025 11:40:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Sat, 22 Mar 2025 09:26:09 +0800, Ming Lei wrote:
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
> 
> In my test VM, loop disk perf becomes very close to perf of the backing block
> device(nvme/mq virtio-scsi).
> 
> And Mikulas verified that this way can improve 12jobs sequential rw io by
> ~5X, and basically solve the reported problem together with loop MQ change.
> 
> [...]

Applied, thanks!

[1/5] loop: simplify do_req_filebacked()
      commit: 04dcb8a909b5b68464ec5ccb123e9614f3ac333d
[2/5] loop: cleanup lo_rw_aio()
      commit: 832c9fec8e2314170c5451023565b94f05477aa7
[3/5] loop: move command blkcg/memcg initialization into loop_queue_work
      commit: a23d34a31758000b2b158288226bf24f96d8864d
[4/5] loop: try to handle loop aio command via NOWAIT IO first
      commit: dfc77a934a3acdb13dadf237b7417c6a31b19da8
[5/5] loop: add hint for handling aio via IOCB_NOWAIT
      commit: 4c3f4bad7a6e9022489a9f8392f7147ed3ce74b1

Best regards,
-- 
Jens Axboe



