Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PqtBY3w0"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBF10F3
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 06:31:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d03f03cda9so2888425ad.0
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701441116; x=1702045916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzHdrxbE+4IR0FivfBKMmGVbB7CluWJO99FUenfBkYg=;
        b=PqtBY3w0tUezu3cxy7Th4rGbAp8BXR8YnYX/07POVHmqKl4HL13fXanUfYfLkigANX
         i6PLQm16TZ9rCMbLQXg/0PZ3gQqUFlJHG1NYwZPYJnnWd5zeKxTGRAMm4WZqzaTePpfC
         hBR7F3hbMJPydvX4SlTB/mjwcKV4BxrFZ+9wNMvF8/B0anZneBmIxSbeCQixI9eU6D06
         hrOX69VTACfiWKOZ4H2cGDlAiWB/Wy8EoRm8UG0OqlF6WKirRyPse1ZKegvGBUXyIAww
         zYVfZjbK1lG3y1fNvltarXgbnTOwbsiXDKQ2Fkct9W967K/nONrM1iQRyDnSzxvqQBL5
         Pr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441116; x=1702045916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzHdrxbE+4IR0FivfBKMmGVbB7CluWJO99FUenfBkYg=;
        b=I2LYrdN+FtiHc1iWna672y2RIQzKDfdC/wN6vod1ICVvGaEuYbYEsYun0aC21li6MY
         e0/bZrvYUq/tierKxvGo2GE42AzgLTKHz5PTlJjsXI5WK+3uaF2A95ibm0nXvFXBryXH
         EuihR6kXePMfdjqN/T4PFyitLXJu4sWDZGfXYgCrQn11ps+Ody0bCoqs9Ew/pDSj9SiC
         xO6IWFT5956CU57nht9VCfytgfB6JxDYU4bUNyItds+/8WDP4ZBVnaWmdlmHdkFnosUU
         irLk/QR1zVYPz1cdMe7cmRZ1acEZEVVt3GwJAO8qpyJwJKesPnmFhC8Pfy/u2b/IIGf7
         hIqA==
X-Gm-Message-State: AOJu0YxMBwdnpI0v+Ois0N84pdpnDIwZ6aVOl6h1jtyZCJJMoOg/xsvb
	i4vWx+LUHygJWGrzBCe6cioodw4kiyu80EPToyxh9Q==
X-Google-Smtp-Source: AGHT+IGKQel0PYSJFGjry+wiXX7m7Vold0L6JC6m5MPRl+g1ZAm9RBt78CuRt/Y4CreptAfLTMnB4A==
X-Received: by 2002:a17:902:8d8f:b0:1cf:b192:fab8 with SMTP id v15-20020a1709028d8f00b001cfb192fab8mr5528575plo.1.1701441115596;
        Fri, 01 Dec 2023 06:31:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001bf8779e051sm3372390plg.289.2023.12.01.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:31:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, 
 "kundan.kumar" <kundan.kumar@samsung.com>
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231123190331.7934-1-kundan.kumar@samsung.com>
References: <CGME20231123191010epcas5p2b775f5b179ac02c3930d2274e3225d76@epcas5p2.samsung.com>
 <20231123190331.7934-1-kundan.kumar@samsung.com>
Subject: Re: [PATCH v2] block: skip QUEUE_FLAG_STATS and rq-qos for
 passthrough io
Message-Id: <170144111470.799269.3705701982033211015.b4-ty@kernel.dk>
Date: Fri, 01 Dec 2023 07:31:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Fri, 24 Nov 2023 00:33:31 +0530, kundan.kumar wrote:
> Write-back throttling (WBT) enables QUEUE_FLAG_STATS on the request
> queue. But WBT does not make sense for passthrough io, so skip
> QUEUE_FLAG_STATS processing.
> 
> Also skip rq_qos_issue/done for passthrough io.
> 
> Overall, the change gives ~11% hike in peak performance.
> 
> [...]

Applied, thanks!

[1/1] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io
      commit: 6e2d4b77c252b6f6e47dadf1ceaeee4ebe97eff4

Best regards,
-- 
Jens Axboe



