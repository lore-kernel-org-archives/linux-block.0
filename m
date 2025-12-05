Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7252F9DB7
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938864; cv=none; b=bCbfkSKKzBG/R/h9HtitxdF+gP5VfIS4HsvWXHXGQSqmM9XChtvWGarlMUpizvskVU+wYeD4WkKiYvspg7mNY5SXkGgrIVROYd5hCYfBTFX4Gk9Y6W3eldKQMPUd2Ck+RLLWcxpfZgZibrhVqGIiSGpXQfadmhCLFfTTyeQ72mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938864; c=relaxed/simple;
	bh=1Jg9NmacE9LsGyXBJyfg2Ouj9aJ4YSh5Lse0xoSV6yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwy2GzbRlrV+0uPxxk8g8bgbDDU6i+QRnTFLOulrIRf0ypCQ8XOtfDZAWhkazoXsj7ayGMY5i6y64K0N3SPNtEmttzXF99OrZFhFvyl7ZnV0/ctZo1W58zfGCCVVvMoeMJMhxzbd/ZLVu97mT16nafR+VfU6VtKJEn3KTz7LFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Wou9w6H4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Wou9w6H4"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso1055467f8f.2
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938858; x=1765543658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3KnzE4q/ojWtIWDJgtZqbXhEGVxWeob47PpNOMF+tY=;
        b=Wou9w6H4b5/CXT0ZFRAuv1QKMFICpLUrVDAPC49YoJzQnMtmFPFJ+VJBBVe5XL7oTK
         MH/7kDs3fOv2OUwguX8annSk19ghILSs09fZO4apKme2kXRsJa03zHam+vWMWR240hRU
         wU86lfRmsZwK9UrEhWO3qdZfGg4vwa76qLiU3BzQvU1PpO7OpMHWGkRhcUWZ/f8Xs+L8
         kxKhSoUJT7xZQUDJJuV74gt1ccld3/TzLMYc7eWnyT2TLiKRbgXUFF0ugA566g7sTIql
         t+DrmbwO4KR9TRfwlsKRkah0pwH8D7FMeSSUHOtuTCSV+z0HcoPowLFwP5cPHXASHu8n
         gwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938858; x=1765543658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3KnzE4q/ojWtIWDJgtZqbXhEGVxWeob47PpNOMF+tY=;
        b=Y3aQ9ZvJgVrY2xCj+/q5oj/7Ze4ZcZn3PfmuKV5f7WD3TfqfxVgdCOLEGULXY81C2k
         uprNZKnFuVzi+fuLoVq2jRO5YhivXIoSk4VxOkh6oSo23CMLQLympsHc2G9ewm/Aez9B
         j2vsZhXvK6Y5nOqPPuDxI539VyKgqqUFM4GKE4ssQ6bYzWtGkvmJL0RO1YX61wxFj0ys
         CrRUdinum2LAtA/31hYKteY3teKAl/G4I/jI4dewexmclZjidEMi5KL6nGtI049mndQs
         I+cePQsbDCLd6WzuRW7guTm03tfpA2dNwpI5u4DBDMFc2YabgEnti2FY6iV4OD1sl0BM
         w7/w==
X-Gm-Message-State: AOJu0YxELZiflISVUuhmzdHj5mhvgxLH94UgZ+RnH+jCzaAxX4cxrOvW
	iqmcW0usC8KmEXcCMgqPUETdRiQB8Nvvb9Nk7m3QpdZoTQ5ZWuosM8D93X3Dtaha7ZeW4jLJZEk
	Ng+GA
X-Gm-Gg: ASbGncsGp8qipBvsAJUmtiZif0D43kzHNZRGXRlj6O//06IQ/0VTqBSqRWxyPRuZwYn
	mkXweWt5zKkonBrnityYCV9BX+zjHsK167DvmWTMmZHCfr5k8KsnFwqtN2QkZEbdeyOsXNbeXNP
	XcXQG+G1s/RWOrW+bp4CO6mQn8jTd1AEAKmFkLA2H7BOfTZJgt9rptY5ejKV9SfmPLQS0cJRmww
	CQfqoZPRI6Wfb2gAhECm90ehEtyrmrM5PqnyPqhLa/DCmAZfbFhN7NMRy+CQuOWL2zUOnxQ00H5
	4PvJm61drKa1NaWVp4Oy15KHP8mWdCi2PECqp+8rT85rO03bTNYac4HpgfjSej1bv656dGSC3p4
	vcBsnb44wyeRLkwla/FYV8KaSVsYBH1bR0thsFuAtY8deBNVsu2+qcT0UCOZXsrScEzqS63FCrz
	lARg5BQYZ0mCNnGBwJub8cbDaTHUyJ5Z3609vO01W5TH7OF3/aSAVWb/pBU54r3VzUkhvKTYYve
	CexenOxGJ40IA==
X-Google-Smtp-Source: AGHT+IGaWxYceWXtStsm7djIS4X72O+lBE8OCsuzdG306BTsyJOfRJXcAa/pPKkYe3cDyGJq7yQA/w==
X-Received: by 2002:a05:6000:240d:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42f731a212fmr10072733f8f.30.1764938858052;
        Fri, 05 Dec 2025 04:47:38 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:37 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 0/6] Misc patches for RNBD
Date: Fri,  5 Dec 2025 13:47:27 +0100
Message-ID: <20251205124733.26358-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please consider to include following changes for next merge window.

Florian-Ewald Mueller (1):
  rnbd-srv: Fix server side setting of bi_size for special IOs

Jack Wang (1):
  rnbd-srv: fix the trace format for flags

Md Haris Iqbal (3):
  block/rnbd-proto: Handle PREFLUSH flag properly for IOs
  block/rnbd-proto: Check and retain the NOUNMAP flag for requests
  rnbd-srv: Zero the rsp buffer before using it

Zhu Yanjun (1):
  block: rnbd: add .release to rnbd_dev_ktype

 drivers/block/rnbd/rnbd-clt-sysfs.c |  8 +++++++
 drivers/block/rnbd/rnbd-clt.c       | 18 ++++++++-------
 drivers/block/rnbd/rnbd-proto.h     | 18 ++++++++++++++-
 drivers/block/rnbd/rnbd-srv-trace.h | 22 ++----------------
 drivers/block/rnbd/rnbd-srv.c       | 36 +++++++++++++++++++++--------
 5 files changed, 63 insertions(+), 39 deletions(-)

-- 
2.43.0

