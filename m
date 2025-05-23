Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152E14286
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014957; cv=none; b=WI+qyPSa6IH355WouqV0uw8OV7AkH+XmIKSpV2+pJkoyFvydPIXR3c5hymS1gonpyVqae4UzDfTU/t7ZfG82vXq4QqAglX1xbwHd7L/SYSHZyCWvGobZzb8Hv8tSXQWu2gLpRRTuvCYWxj6qSsDmwQUdM54tvgdtfFQ2SmCe0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014957; c=relaxed/simple;
	bh=Q/RfzMEAM1jsmL97ghm+FrIezM1n6ygb2tg9kj65aY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUUrG2CQOyfvYG7rxxZ83UmO4t+g4xwZCV2vAbqRiLG2FZBJc+atI5PI9D2R7x3F6zOO0C1rVJlH2oo0QvS9pfbEwiqaIE6wNY24bQpqXOvNPP/exxj3KD2cLfGRs118oxBZbk9Qdq+FugnVWtei5pZuCSBm13G/HzGiaJetI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iU4uScQv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iU4uScQv"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3db6ddcef4eso43415ab.2
        for <linux-block@vger.kernel.org>; Fri, 23 May 2025 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748014949; x=1748619749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMjeUvyJYRtc2clXd44STATSxgW/K8ZGNpeT/CBL3vs=;
        b=iU4uScQvrXkJEn6JYVYAVZLNK9T0B6knwjAGoOzciPZb3oFt1HSlhpnDd3Lb2Bi8Hp
         at1BfLuueM+h9wi5prH3m6DJ3v+3E4Xqcp9LEofuTJ8p2BKbThVamJ5PT4OVGNRirzOF
         UKU7renRo+ZBQ5m6Zyo5hq+hgfXhkS7AWm+hREy8fDyj0jq4cG13wGWYwxUiEzrC+4XK
         E/LpLfIxhmG47XQUBoygpCeNDLrfntNhiyQpfsoU/n5WXEQGDeoQoZ30ggWPIktJ6khK
         rEbKExnUDX1Ax9aOyY7BQgqMMyLLFEKcNFyBAJUhRzdsFQ9g4EHlcy/DZStjohVVlOm0
         grBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748014949; x=1748619749;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMjeUvyJYRtc2clXd44STATSxgW/K8ZGNpeT/CBL3vs=;
        b=VAKaWp9oXk4D2ViIRSgu5WQEvaV9DCBzBnIfjH2TvrS6v1Dn2iY63x4IAaEHWVklc/
         eGMGd1qXE3cet+n5cCBYWzOGtPmtExaXYIfersy3JMT+yF8nUCv5Gaavg6pe2yic9jqg
         m0MHfCPeCzmyqcKZskqiROfrNc/ZTtHvnWcL1NC3/LpLo8KI4EcQToMhbyxvn7HNmMC2
         S+l7pNqypwE3o5LYMLbaihtse7EdY4KzkUO3sZc/2fB+/HCxghnpzqaW5RLOt2JqCyMt
         C/AgHXn3nNxebXENKKER7LrnBIag4W8CFWT3kgIobOZ0b5puKAfx3cVzU1d08XznfOh6
         zqdA==
X-Gm-Message-State: AOJu0Yy+5lV+d01fN2dsO2F3z7GcDFk7p2C/6VZzKVj+Pa5iyTSoWUtE
	SMw7F4YIPzuqvR4FkdhajQFlHwalozk+RDVGkIhPhv+AGCRiV6YUELgXkhRlH2geyhQ=
X-Gm-Gg: ASbGncus/pmKvjfSclLOVXxM6Grzf9HSGrA55pm9faUIB0Qz1QqLj/tL+vGWIcR/XNf
	01ygJzk231YzyTScEjch3xQQr8OXlS4ryD/XaRluORJ5DnQriIpY1Qml3IEK4eYPB5H6kADJ6ss
	Rhh0aQeBqTw22hx/4H+fktOANc50jE0p3+e9ecMtbCXx5Do30U44WJP6yKfxxR0q/qCvkTlcJKz
	4v2o9oZr30Z70KLtCfxCGi96MfBQGCsB9fCnrxjCw+PY6BCv4KHKr4zkNPuJOjDTVJX6da7+SXG
	p43cqhEWycRGGhY0I7jCpmzEf/id9TnCWj8oMzli8w==
X-Google-Smtp-Source: AGHT+IESAojwOmI4T42Oe5Z66XJxYSmkU+ZqUT9LeASL45gKTxZ7H8bkJCP05mSpFQr2VU35rmp7TQ==
X-Received: by 2002:a05:6e02:1745:b0:3d9:36a8:3d98 with SMTP id e9e14a558f8ab-3db84296deemr347006325ab.2.1748014948848;
        Fri, 23 May 2025 08:42:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc61a37082sm33408935ab.49.2025.05.23.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:42:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, Yoav Cohen <yoav@nvidia.com>
In-Reply-To: <20250522163523.406289-1-ming.lei@redhat.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] ublk: add UBLK_F_QUIESCE
Message-Id: <174801494787.1281037.15642733985471233789.b4-ty@kernel.dk>
Date: Fri, 23 May 2025 09:42:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 23 May 2025 00:35:18 +0800, Ming Lei wrote:
> The 1st patch adds test case for covering UBLK_U_CMD_UPDATE_SIZE which is
> added recently.
> 
> The 2nd patch adds UBLK_F_QUIESCE for supporting to quiesce device in grace
> way, and typical use case is to upgrade ublk server, meantime keep ublk
> block device online.
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: add test case for UBLK_U_CMD_UPDATE_SIZE
      commit: f40b1f2670f084d2879e4a125a75ff7788ec67ba
[2/3] ublk: add feature UBLK_F_QUIESCE
      commit: b465ae7b2524170cb14fa25dbcb84923bfb1a0a9
[3/3] selftests: ublk: add test for UBLK_F_QUIESCE
      commit: 533c87e2ed742454957f14d7bef9f48d5a72e72d

Best regards,
-- 
Jens Axboe



