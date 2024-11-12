Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04420C460
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447802; cv=none; b=fDAczhRa/WntZkW2sstZLuwDEpeS2nP+yHC/7g2bIQUbBY0xNJ3oAT6PhIm77hs22//zXeH9sUZzuOxyGsjAY2KSh9wmvW7Hz910lqFIs7A0rK25cPr0VOXdSDpc9vbx2jg2AZTfYWnspcmbFYcyUZtP3a7z73ZZhtIoHdWywjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447802; c=relaxed/simple;
	bh=J+RldWsZqsESI2PuHeRabDXgnmVLtr2MD+8L5LtDxY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jw72sNeP5fSWtDG5i/ug8esQdlCgaaIC4dp+P+agomZqu+ZzNLz+PZThjsHOQqEyOseh6I/Dk1Y9MbGPY9o9SJdjPbwJ6Vp7bvMKN79BVST9rg/eYotn/Dz34nlowgO3T8lck/jLiqw2qr1ngtHEox5Xs2wXp/KupcZvmnzPlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dUzpt4r8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dUzpt4r8"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-718123ec383so3570885a34.3
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731447798; x=1732052598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGtSC//+KuLVSTWwwIoXtxU4RZI/DGnC9v/9JMzPnU8=;
        b=dUzpt4r81/uMZiH7uAneonK6a96UxOXwMNYG/4D2C7FmHhTjfhtxzseLMrhlJSafYC
         6DcF2HJZqFwbGwRvsZJ9b4WGx42/H23nmsL+VMvrLLbaMa45b2770PFMO3kLlHF0cD9t
         oBSl2g5p4XacL578cbKF3vAdr7n1CSOVa/zTsGAl82LCEQZjOVx+DjsKhO412/eXfZSA
         TDK/wr38oHhmfWvj6QZiUIkNz+ehK/Xp7SFPZvZUFpIxHOC9zAUeJIE/QO6/TOPlihHg
         EM7QDpe/JA2J/7o+PjmXYWmu799ncMOOO+qtd2oLe9jy/UjPwvhdXnxMOUzAXh+ftqv9
         GVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447798; x=1732052598;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtSC//+KuLVSTWwwIoXtxU4RZI/DGnC9v/9JMzPnU8=;
        b=DOD82VBkz4FJ0pQUJznIH9ExsbI0f9UvtgncOkmxyTHJ3EwZmR0npGvfWJLtICO848
         DGGuuQvGMpNEzbQUy2u8bZwPrxZ5r7gzdOZgrqb6Zost82ByhWS239DvaGfWtnwFUpyZ
         ++qRDi5TabdXAaC8FFaxtlz/3TPd9hGbUpETbBN2m78WyI7i1O7exob/3drVmMzqV9xy
         UjzrzI8CuJMNJ91GzcMcp4KrftPExsx80/fxERhjnvXfgxrGy7g59GXxWOt0f92FAA9M
         AUWRwRvmygqGmy0yQovTaHN33eptnVTTiyk7B6Pt/1ddhWvUGrnJB5dOx77Z19nC1jHh
         HzKg==
X-Gm-Message-State: AOJu0YzMEiwge6nFsmR0NkHvE1u/s8DMirez4DQJxx7RMLG8VhC5dfLM
	S+oU5xItg5mbsfhc8Y6b4k6g2ZNe8TjurpPkvEZtsnhUfgYMFtOpUkqkMZG9grL4RpFYFZGAR3n
	OfxA=
X-Google-Smtp-Source: AGHT+IHdA1/BLcE+I0xAd42S/ugK3+MkiErPSWS8lopm+4vQfH1OaBpVpP2E7ccFbc0W+eDDTRko5w==
X-Received: by 2002:a05:6830:b88:b0:70f:716c:7d4a with SMTP id 46e09a7af769-71a516f6a54mr4411368a34.27.1731447798267;
        Tue, 12 Nov 2024 13:43:18 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a6009dfb9sm81837a34.61.2024.11.12.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:43:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20241112170050.1612998-1-hch@lst.de>
References: <20241112170050.1612998-1-hch@lst.de>
Subject: Re: remove two fields from struct request
Message-Id: <173144779750.2202563.2182339299519835938.b4-ty@kernel.dk>
Date: Tue, 12 Nov 2024 14:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 12 Nov 2024 18:00:37 +0100, Christoph Hellwig wrote:
> this series removes two fields from struct request that just duplicate
> information in the bios.  As-is it doesn't actually shrink the structure
> size but instead just creates a 4 byte hole, but that will probably
> become useful sooner or later.
> 
> Diffstat:
>  block/blk-merge.c            |   26 ++++++++++++++------------
>  block/blk-mq.c               |    5 +----
>  drivers/scsi/sd.c            |    6 +++---
>  include/linux/blk-mq.h       |    8 +++-----
>  include/trace/events/block.h |    6 +++---
>  5 files changed, 24 insertions(+), 27 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: remove the write_hint field from struct request
      commit: 61952bb73486fff0f5550bccdf4062d9dd0fb163
[2/2] block: remove the ioprio field from struct request
      commit: 6975c1a486a40446b5bc77a89d9c520f8296fd08

Best regards,
-- 
Jens Axboe



