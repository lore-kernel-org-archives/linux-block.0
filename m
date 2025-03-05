Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FE2046BF
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217112; cv=none; b=AP1EQNo6PGy3aZ9Y/qAVqhmPt+s23w7Hj+IAeJcqm7vGbkIj+142gOdXwZpzYxy9kiTfbLPJi8iNBaGv7OEIJBrJpMBc0XS1leai8iCrE63PwU5Bu7Wruw822PXS+q4pyQ3t8s58EWBJCBnLWvo2UaVb7oB7J1C7SqYCX28eWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217112; c=relaxed/simple;
	bh=AnJYcyyPuSQ4pNrFrYAJyHf2ljozt32xk7TDdF8nbVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cz3VoKMDujD6R9x4o6yEDAsDjky6W7XcWSZwNYZ1drQ7ZX+2bqQqpNPVt2dZkYmPkrd0XLrijR9pv5MbRUhko5Im5HJiCOMVOI2dvFUTVzWokSI7wdSRvYuPrKygsmCuJVoSzSx0JXWOhnNMtDdqbRkIP3ZNrYnUWKlpuM/a95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iELWRdRC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iELWRdRC"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so582815ab.0
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741217109; x=1741821909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=iELWRdRC3yglom12TSoFzTShH7ez6cj5DJdLwQpSMiCr1tpPRtvFGeejPnRu7U/bhy
         VLGZtGdbRNGNTFbt3UZMv5gblgZatnMJHyOmPVunM6IBx7PCKmiRHCwkmB2X9c9kK+i/
         WW+JqpkOMWi+51XeZbwKSS7AfratUMT0euXzAHdV/IFSos62bu+zbc1N8Q8HggxPcDfy
         ptRINXruGoTn85heQ2xEK2ZPR7sp+PS8Ru2FE6DUWlNgK1PHPYaThECuaOFBZ1qGFsZx
         /qfwcyOjf5at5fV4BpkgETZrVMXFQDV5+QlQwij2AP/NV73hakGO/NZlpjNRpY8pYN+i
         +yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217109; x=1741821909;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=sF9Q6s8tlh+7kQn886Jk2nOtG5lye3sfxhC3q+JPsZOZWIBN+p5hGxtgYgj/Yvqdj1
         w5sGaT7FNqz/JPBHoOtqdLpr9spU314v5aipfjn4j1YFcTRt6o7cLOZKTF1cM1oohelk
         rEJT29sx3rqsjdtHvxAFVzpGb8fO8gywAQOi88UP8nNgMP8tRaqilDzLXTo5FeN2+A1y
         QviM6CrW1BURjrSuiht1A8r2qZQQMfDegDEmTXtX+QxCbe+5zWHx5+YJWgVNCK5DiBGZ
         KTwhu+oqi2OdaUaa7HFx4MlgX41Aitk7aqRGe1oi1Afe3Up2ZOz7wnwa1GsAfoEOp+uu
         0sgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhdXlKkpMd7mSmLVbSxrv/QhpFWdqgdruxbHyvJcYUqwVDebxSi3n8K/gHIFqKY8mnkhLxX/Ntwx1kIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6FwybWeD+M82d12eoKjVdTywNPexD1GSIwzdPow5movJPRIA
	JsD+Zcpk/06DL1k4C0OTWSVsVCaCWY69WiTQYAeL/OcCjdqX+STgLWKY/92suSg=
X-Gm-Gg: ASbGncvZrfDvsMeaykTnIeE+cx/AA4ffDOq5TlAaCUT9MbTLj7ho5DWufvULo1FYlvP
	1QxFTgRTrhkUn/04RTug03fCKkSoCMqFuF9kP0KphKz7QczqnGVsADMsc5xYpd+FrD4r138BT73
	tmtFBReEuS1xSTWysP/pcYPj/MUMoExNlCKTD2CUk2+0IMU6U/hANHM1bP3eKWvu4/DlPUjhwhy
	12pzgVW8lHkqRy1ayaTqvn+WAh5wUkjFwtNvMauiFUKspVnn9XSN7Pmuu/bN75r80VDm7LqWs6f
	AgBcyPZMBbR6xphe8ZmAk+0EzU3r7XxZhVzY
X-Google-Smtp-Source: AGHT+IFw7DOF2AlpkNGRt5nKYLzCwHXDlYJ9rI13bHT9B8yZEwsvGPw15V0L62f7x6TiXP73rO1Krw==
X-Received: by 2002:a92:c26d:0:b0:3d2:a637:d622 with SMTP id e9e14a558f8ab-3d42b8c1c5bmr71442235ab.12.1741217109024;
        Wed, 05 Mar 2025 15:25:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df3ea9sm17360173.27.2025.03.05.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:25:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 vgoyal@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250227120645.812815-1-yukuai1@huaweicloud.com>
References: <20250227120645.812815-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix lower bps rate by
 throtl_trim_slice()
Message-Id: <174121710777.165456.10255728984898278903.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 16:25:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 27 Feb 2025 20:06:45 +0800, Yu Kuai wrote:
> The bio submission time may be a few jiffies more than the expected
> waiting time, due to 'extra_bytes' can't be divided in
> tg_within_bps_limit(), and also due to timer wakeup delay.
> In this case, adjust slice_start to jiffies will discard the extra wait time,
> causing lower rate than expected.
> 
> Current in-tree code already covers deviation by rounddown(), but turns
> out it is not enough, because jiffies - slice_start can be a multiple of
> throtl_slice.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix lower bps rate by throtl_trim_slice()
      commit: 29cb955934302a5da525db6b327c795572538426

Best regards,
-- 
Jens Axboe



