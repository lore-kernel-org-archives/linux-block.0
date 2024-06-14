Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC8181B91
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382226; cv=none; b=O1FkbcNwdl3VfLYiEzoycaMWqugQJiYIz6wdDLoBPAOujWMO2BOwL1XZF3U6cM+ypHm2auv1YQL3ROFq9e5Y43NKgOWJ9oA12sQbKYanJ3d7ec+t2qNdV9skxD3lBVOIlkAfgVHrthkl2AOUzbW4RIa2qA9lMWIbKOppp4JmEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382226; c=relaxed/simple;
	bh=1tsL0VEqJqrKARrNEQ7BhIYxO64B/TpedUMAhGSl38Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bIc3cqOWPzlgUOuoYf8Cao2XFGNi9NC44o5ADKbHQXR5BRJ+mXniSMHf/4JZd9NySkuoAbE7FxbSnyF4efp0Br2WLcnSMN7+t+9w+JAJzynKfQ4TdF5Jb4Fama3inFbwmwRL4LKJU53LTwHP6R9vbDmJGQYBJuCnpg/7eybpfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2vUr0eYq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2vUr0eYq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso403231a91.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718382225; x=1718987025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7vaEVpmG2RwsTzAKQW5R1zRk1h3qTFZY8+hhd0hSUA=;
        b=2vUr0eYq9F8RE1Phjem9Uic5yr8vqfa2DJY/EaZ9XMswVoKsu+/9vlvuA1WO5+8MxT
         bSRQsRyrrN2XymJx15hGc5h+zjFkHw9YA5PWq0Xr7PmEhUnVCtTA7WVIs970tekAWr63
         StFj96qilAJiUAMwQbAr+iR4Y+75sfqXyFglqeagvnycR7AG49TkN7zoLbKFTJIMvY5E
         q3Y8zxL6+Cv266Pav+SrmvF0eVh4HJshBuLn63rOB225rgYOijMNRQD7STzlyF5t993o
         R6pkmYGHSs+XmvOWazl7MnMtIAU5TBcKMJzoMjLvGVtEnhj40GqWmc2SG0CNAuTBUoL9
         P+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382225; x=1718987025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7vaEVpmG2RwsTzAKQW5R1zRk1h3qTFZY8+hhd0hSUA=;
        b=Eef14CTapcfOlHCXH/EF1+ezTx33XONbW8APtAqn6GEUJC8uedc9J99/EGomQkxgQd
         pOVzLIODtUwVA8Hi6nxkShA6vbxtQL5EmNduuoFiCV08vM3X+kZaI2IyxeNM1jQl0W5+
         3GvQjFiM/Cmt292ZhqfQ/EfwQkxnyjig9caqHixecAQBGcffZiJTz4rAvZQNP+5MlCuM
         UMPKGG6R0taD9S12lUPoTcR3hfbQeV+8XYeyIN85pcdKIROFzDihAWa0G6AjuPQwz/Qe
         6LuAb59FgymW/a/Ek3q5jEohhmyMdDvrgksrC6rAbOmTtbdpJJCFLgtwjbjShHGpKQ2R
         V4YA==
X-Forwarded-Encrypted: i=1; AJvYcCV7groGby13Vk3DfngWEltARVOfrP257MIzThxosYEb0JuLUTRRZ/KBLc0RniEy/UfVhOZb9rt2undXQjXTXlc+iEki/NCdZZIJ+CE=
X-Gm-Message-State: AOJu0YzRqiZENBMywNo+ZLc3S/phdFCL+DJwm6GVSNnt8CkY/785rhd3
	c+FMwWbwoHYT/Apc4+mfQidNm5zYCMJPADsD7JWVXwE3jM/yzbWvNtsGqCbPnPQ=
X-Google-Smtp-Source: AGHT+IFalaQCW4lC0HwsXT+MgtNdWkETqGGO3S2q0czZ2zVCeyt7k6ERpmMLcUdUuPUoSdg8KrcJIw==
X-Received: by 2002:a17:90a:de14:b0:2c2:f042:d96d with SMTP id 98e67ed59e1d1-2c4dc02b83fmr3292751a91.4.1718382224613;
        Fri, 14 Jun 2024 09:23:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c46701absm4112038a91.40.2024.06.14.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:23:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
Subject: Re: move integrity settings to queue_limits v3
Message-Id: <171838222277.240089.6158080107617222931.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 10:23:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Thu, 13 Jun 2024 10:48:10 +0200, Christoph Hellwig wrote:
> this series converts the blk-integrity settings to sit in the queue
> limits and be updated through the atomic queue limits API.
> 
> I've mostly tested this with nvme, scsi is only covered by simple
> scsi_debug based tests.
> 
> For MD I found an pre-existing error handling bug when combining PI
> capable devices with not PI capable devices.  The fix was posted here
> (and is included in the git branch below):
> 
> [...]

Applied, thanks!

[01/12] block: initialize integrity buffer to zero before writing it to media
        commit: 899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f
[02/12] md/raid0: don't free conf on raid0_run failure
        commit: d11854ed05635e4a73fa61a988ffdd0978c9e202
[03/12] md/raid1: don't free conf on raid0_run failure
        commit: 799af947ed132956d6de6d77a5bc053817ccb06b
[04/12] dm-integrity: use the nop integrity profile
        commit: 63e649594ab19cc3122a2d0fc2c94b19932f0b19
[05/12] block: remove the blk_integrity_profile structure
        commit: e9f5f44ad3725335d9c559c3c22cd3726152a7b1
[06/12] block: remove the blk_flush_integrity call in blk_integrity_unregister
        commit: e8bc14d116aeac8f0f133ec8d249acf4e0658da7
[07/12] block: factor out flag_{store,show} helper for integrity
        commit: 1366251a794b149a132ef8423c8946b6e565a923
[08/12] block: use kstrtoul in flag_store
        commit: 1d59857ed2ec4d506e346859713c4325b5053da3
[09/12] block: don't require stable pages for non-PI metadata
        commit: 43c5dbe98a3953e07f4fbf89aa137b9207d52378
[10/12] block: bypass the STABLE_WRITES flag for protection information
        commit: 3c3e85ddffae93eba1a257eb6939bf5dc1e93b9e
[11/12] block: invert the BLK_INTEGRITY_{GENERATE,VERIFY} flags
        commit: 9f4aa46f2a7401025d8561495cf8740f773310fc
[12/12] block: move integrity information into queue_limits
        commit: c6e56cf6b2e79a463af21286ba951714ed20828c

Best regards,
-- 
Jens Axboe



