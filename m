Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C232277F
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781895; cv=none; b=dRaal96RaVsORvQ9+3ibdzotxCgVohyJ7EBIAgfKKTqEbIpQGkgLdFllxfHiZuLZGnFGM0GQV0FXiKZ+/PXdaKxivUSFI0iEdDzOdrxYKu+DQoBCmc+wzjX5Nrvu1KPACJp05QoVyyI+PwhGIJeqHNL8U2/cOSaDivmAGhwRYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781895; c=relaxed/simple;
	bh=3ZQ8fvIjR0VDpzCRTAArVeBjFDzk3nDf6+Hb7sGdU7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OITO6wFkEfuiY1N49KITMbWM8T2pAofN3cfp/Uag6EH/f3uhX6qUa8HA6IpwOd9xBkQ+pE+urOmKKp2aKcuKyPGySQONXOqhCgCEMBuoHPbxQWRV8TGZ+/dCB+cBUXFFXIm39TeEbK9mDbCt0+KoYwnGQZOa41pBrmeYumb99Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eJSZtAwj; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eJSZtAwj"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432cbf3fbso76507239f.0
        for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755781891; x=1756386691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qL/kcTRAUROT+PP1JVZ97Mc+Zo0wX2QEXwuGnexfPeo=;
        b=eJSZtAwja0KhC/Svg8ZQTeWavDuo1iZ+NeshoKUiF3C38yS9cWySDRl2EOqv8cT1ob
         te3Xv40BsoyK20ANz7sbWNLdnDQ1Azsod0q8X3kiVhsqQFXifeKjP2m2mSBCadOaIZsw
         dDtwwqRaQC8cHUfbPhk5gOkC5SRRTBmCGxoMsCtTcF4QMA1gTqgeJds+IORbsbRA5XxP
         sQFRh19dBkUGzfE3yJCDMF+v4CVPJt4Lsu69j0CgnnuwcFVWsCdyu7lVUWI2hFKrOXEO
         s6X6GTSP7/NpVmp192XOYUFMR0De43QZ7R7Ik53rNO+4SvLu4tkLjPKDWiRxKPcvIp2h
         +Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781891; x=1756386691;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qL/kcTRAUROT+PP1JVZ97Mc+Zo0wX2QEXwuGnexfPeo=;
        b=Xbc+gXUqq3eCZwDV2/EFTyA4w8fCm9atGwIg/ymrzyXSWM2oEQl29iAGcgbOc2RhE/
         hGqmZ2flWqJL30yDJqLWLCNN97QR3FLdEJYEKn+1n75kZaHlyO+K473KI+/9BcbkjIXY
         olyRjeLWgdpqEGQV7be3/Ce2DvOuDCmryx1i60arQBELhXA/LXebC/8EmndMjJrRqZnQ
         4TutfI8XjqYWbms5qjBJQkP1BGhff8MYlRfZHb86I/HZkJwN99qaE+6VHq3gE9OqTDO/
         gVaIb57LsT/jWA23n6PB9ApFQP+g5C1S67sih/dHYv5Y50/qzJQ5zTNYISdlBuSQLZB+
         ZgJg==
X-Gm-Message-State: AOJu0YxNUz68us5AVY+79Z0wu+r82HuDGZVS6tqbyMGs4MRfJirmIZ7X
	jkEF5iM5XPJDJGkWZy1G26mLFR6WwN0g/3WfzsgbA0e4XDG+FDlrZZO91jseiqdrd5c=
X-Gm-Gg: ASbGncsvo6fvI5J2B9xMt5/TDFxDFARwYVDscwBDW2og74i4ZMXyh/A1UQ82OA06nXe
	dOkozq7O0/BRwPPnhOwF99Cs8cBMv/skYw8mh84I8JKSycTbkBJdHTOricZPcS/xQdJ3yUciaaG
	w2wVb8GjIP7dRswqjt1Hyt3O74ggG0jUA2PsvPFQ54iCvBk4DPUKXqa2sTXRt5xD+tSbSZAjSIg
	aoBwJ2if5LtGsOc/XdQLn0KE4EzLFhd2NxcW5sHvVEIf+WqRWruhx3yjhnyVuhFTGUAFb0nhkTo
	gbeaLAmLNB4soO+MYLWvaIa7nvcfZoMLWFyPjuenas58UbuBXmIlG8cKiIh0FeyGTCBUs76TCzc
	HserNhIBucHmo2g==
X-Google-Smtp-Source: AGHT+IFLioDQ6sghKlmYNhj+Uo4ALtrAB+xS1QYrxQjdIwXuVfPDpajNFZzQKFk0vBIn+qNg8aP35A==
X-Received: by 2002:a05:6e02:4515:10b0:3e8:cd52:4ccf with SMTP id e9e14a558f8ab-3e8cd526232mr4822525ab.18.1755781891361;
        Thu, 21 Aug 2025 06:11:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e66f66bbb8sm44710415ab.24.2025.08.21.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:11:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de, 
 shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
In-Reply-To: <20250814082612.500845-1-nilay@linux.ibm.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv3 0/3] block: blk-rq-qos: replace static key with
 atomic bitop
Message-Id: <175578189034.623211.15789507272079107763.b4-ty@kernel.dk>
Date: Thu, 21 Aug 2025 07:11:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 14 Aug 2025 13:54:56 +0530, Nilay Shroff wrote:
> This patchset replaces the use of a static key in the I/O path (rq_qos_
> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
> is made to eliminate a potential deadlock introduced by the use of static
> keys in the blk-rq-qos infrastructure, as reported by lockdep during
> blktests block/005[1].
> 
> The original static key approach was introduced to avoid unnecessary
> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
> blk-iolatency) is configured. While efficient, enabling a static key at
> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
> becomes problematic if the queue is already frozen — causing a reverse
> dependency on ->freeze_lock. This results in a lockdep splat indicating
> a potential deadlock.
> 
> [...]

Applied, thanks!

[1/3] block: skip q->rq_qos check in rq_qos_done_bio()
      commit: 275332877e2fa9d6efa7402b1e897f6c6ee695bb
[2/3] block: decrement block_rq_qos static key in rq_qos_del()
      commit: ade1beea1c27657712aa8f594226d461639382ff
[3/3] block: avoid cpu_hotplug_lock depedency on freeze_lock
      commit: 370ac285f23aecae40600851fb4a1a9e75e50973

Best regards,
-- 
Jens Axboe



