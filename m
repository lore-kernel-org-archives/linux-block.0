Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40D12FF6F
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377063; cv=none; b=oPR/pcJh8MQzLeV2tZIR7iQxb3/ai8NXVnJfEiMSr2Y6hdhFiY0zdsHKWvb3ipcWmDn4uCx2UavmC7X3icvFLhRy81fapsyafIEhnslxFYzvOqgorx0eWLeqJtJde3hbQmoHwpHTwDFNp0rGyWuauuk2Fz9tal2UB/bTW/QuPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377063; c=relaxed/simple;
	bh=KNGCI8iZbv3kf8bnxoKogqaCv17e2RUy4yd6YkWujZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDI9Gc/F6ZH+S32mZBb/ueVWqDjsgt9tmzRJoRk9dIHM8PYQHmLQfgaO8vqFn92SiXgwmRQ401eVMN2GgAk4BiZpfAfcra/90ZMtoHeubE1oMxNU1Sud0XfS5YqIEQ0lXUgX9uC7E7zNCFoDZ3rgSmS4aLlZoO1Ro6vttXh/pg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uDcX1KRh; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uDcX1KRh"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso15549215ab.0
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744377060; x=1744981860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VYCCFDFCEobLrI5Q5CedJLQFdsKndUH1aW4lMsa02A=;
        b=uDcX1KRh9XWzbuKFwM84w61M8odH90C03mGfDQlVr05vU7YN2MOULLAKrGfem065vC
         w7xdBLseL+IbePgX2FmQPB16eH63ras4hb5Dsn8AAYYpPvZNzD7egOSvFIWBP1ZpKIq7
         nBR2OR/DLgKskpZBXhlTMimdar4W09H80JNM3mJoLbY0yb9NcmcVlva1JDtiIUNBD8WO
         ILHPGhm2pj4kw1lOMMh0z53KJK6GFOOkGPu3uAwLT97oznWa63iECHR57tdaHzYx6jy4
         PZ3BjQnjVZukvLsMcpQsEImpV1b3/X7br7WPST3l2jw8Fp1LBQA2utN4h/y8XJx76WbA
         Y9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377060; x=1744981860;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VYCCFDFCEobLrI5Q5CedJLQFdsKndUH1aW4lMsa02A=;
        b=lSPqP2ow/LpBMnfC/90fOF3PPWCNAZrwd1r6OyxwwQlbt8T7h1TLyPWyKepDyTwByA
         40uI8uSY6amTChT1KMExK6pgSDnsc5CvNsb2sQlCTfjz9VI1B4ISy/dUamYkCXLlaPzt
         Z88pMAVukXYifJbDCT6Bk1BEQvcFOCJJ5dWMmIKp5InxEtO5EQ9JFKL4b2VFr1mGQo/U
         w/xnn5hRXgMiIx2o1xe8JH0fxtkOM7QAxaDryqy2OYA9j6PS9gK9cim7J17H9Dn21FrX
         n+tDZx6vu/sUDd3kIg/wmymFMK/vETAQ7BxTOfz+dmRKLn6PYwMYhLlZtte2sa+/COXX
         qqVQ==
X-Gm-Message-State: AOJu0YyEFSsAfDanE6zYgoFEX7U2EUyA7XYHPRfdPEt56HV58vvlIka4
	cXe7RHVmpiUOWhrD0PQsVvdbXHnULMMGw7hsty5pd70+YN7dliwtDPMek166LBKRilouvR62WXW
	k
X-Gm-Gg: ASbGncsPKpZoKv3k2Qqnnj1NR1MD3EYX2oZmOH39p3r719QybhG+eewQK/CdNfbCxIp
	3gLobsrknffcLhAp2MoTHdhRuCJRg2rVcmWu7PbEn/dhcgOu00piegd6Sg/3NCdf2Vfm7eGt/Zs
	6Sj7rmR6WSrGPEH9DBy1/9Nat3d61CgKr1hVBKxobXOOv1z9kAcpvGcMzHiQkRC2m3DcGK9Ai9s
	gAwyen8I0PF7KNJ6SZc/vUgi6GiSZZtc4FI0zk9gtMJGZJDjB9iNGOzcJiowGO7lnC8LEOCtfqP
	b7yEjoEjdpgAewBlDMbaqyimfsP5oOw=
X-Google-Smtp-Source: AGHT+IHRPHHm/x8hR/BdRBXqozk1Hoq9zXRS7ajeSoflTc7+Z07HXq3A94C+WG1ptgrg7TxO3RzbTQ==
X-Received: by 2002:a05:6e02:1a44:b0:3d4:6ef6:7c70 with SMTP id e9e14a558f8ab-3d7ec27332emr31256455ab.21.1744377059869;
        Fri, 11 Apr 2025 06:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2e610sm1208191173.108.2025.04.11.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:10:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409012928.3527198-1-csander@purestorage.com>
References: <20250409012928.3527198-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd
 *
Message-Id: <174437705869.412953.4991177928671177671.b4-ty@kernel.dk>
Date: Fri, 11 Apr 2025 07:10:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 08 Apr 2025 19:29:26 -0600, Caleb Sander Mateos wrote:
> The ublk_ctrl_*() handlers all take struct io_uring_cmd *cmd but only
> use it to get struct ublksrv_ctrl_cmd *header from the io_uring SQE.
> Since the caller ublk_ctrl_uring_cmd() has already computed header, pass
> it instead of cmd.
> 
> 

Applied, thanks!

[1/1] ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd *
      commit: 843c6cec1af85f05971b7baf3704801895e77d76

Best regards,
-- 
Jens Axboe



