Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CID5huK8"
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB2099
	for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:12:32 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35ca48d48f1so1719595ab.1
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701101552; x=1701706352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH3unxJnscdPbFAxrxsGSOPFQuL0T9rOWrjcesq2Y9k=;
        b=CID5huK8m4ADNGB3CfUuSY0pSCJwsncqManZmQW2Zjcy/YvLbSy+CgioBe9NZWArGy
         UrFeCSThUX17XbdySqVHKqBkfG2MM3bgCTcznkUpe1+i8HLYTGF20wVnBGrZ20EbgEjv
         HXMiNluLgDW7vGCu1eQQckWBfuNmCQLhHIJDx0i+MXd5bafjxs5sRWo68Vh2K7f7VNV8
         S666RHdeLYUeQeGTjLXZWMj4+rfGq+1Xgh8U+l8o04PFUo5ww8+REhunzi0t1hmq2fm8
         iEifvLz9BoPdRY7Zk/Uc29e7kBWhfU9voUx4mIPCpyRVMpAKANlzTmCEdiCiOhICnwju
         VMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101552; x=1701706352;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH3unxJnscdPbFAxrxsGSOPFQuL0T9rOWrjcesq2Y9k=;
        b=wqfOEbe3jErOFkyvZs8gZptn+/4qcLXnED1ypbnWM+Yx/ROtRfEZxdu88oiVdjsqgz
         uZ0heQEMM3mUuhp8HvCd0fBG78WIJRisBNoY66+6Aq9yB++Owd/adZxGfYPkZJn+n2Sj
         +OdHj11Iwg9EtGWb14u/p9bgxzbKmxEd/bPEaYxN0j+NEBeLwcwNTEFL1WfP7UhC7HEI
         uGDrUwfO500dN7rePJZT/z+MUKb/owQEmIfPFBFXDJiDsdiSjtXXZQw+CTT2FFE+m+di
         79GpTm5V3RwEFyp1ZYCto6r8IYiRk1UQ/mO/h+2DS6dYVqfbGGFnjr7gZ2q+SLrBU45y
         I4IA==
X-Gm-Message-State: AOJu0Yzp4ICb1FP2RiSkSYZV6nVVjr4UnVK6xlmaFaIDPZAj0aiBwDkx
	5REf6tr6iS5lodh0uOHCcMULagCuzzOICVhU7uw09A==
X-Google-Smtp-Source: AGHT+IGUC8NZpvcFieBnje6P2+05mMJTdK+m/bH/WxOycB7jOsHgkjyxZxCqOxaIhJts/oI+5Gve5g==
X-Received: by 2002:a92:db4d:0:b0:35c:f484:e3f with SMTP id w13-20020a92db4d000000b0035cf4840e3fmr1349311ilq.3.1701101552005;
        Mon, 27 Nov 2023 08:12:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r15-20020a92c5af000000b0035ca20fc741sm1338589ilt.70.2023.11.27.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:12:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org, 
 jinpu.wang@ionos.com
In-Reply-To: <20231124213422.113449-1-haris.iqbal@ionos.com>
References: <20231124213422.113449-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH v2 for-next 0/2] Misc patches for RNBD
Message-Id: <170110155044.44993.6212477642918597729.b4-ty@kernel.dk>
Date: Mon, 27 Nov 2023 09:12:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Fri, 24 Nov 2023 22:34:20 +0100, Md Haris Iqbal wrote:
> Please consider to include following changes to the next merge window.
> 
> Changes in v2:
> 	Rebased
> 
> Santosh Pradhan (1):
>   block/rnbd: add support for REQ_OP_WRITE_ZEROES
> 
> [...]

Applied, thanks!

[1/2] block/rnbd: add support for REQ_OP_WRITE_ZEROES
      commit: fadf3dffe54fe10e0d86232f0a7576eccc04d537
[2/2] block/rnbd: use %pe to print errors
      commit: 70d85bec8f4c0d003db505bf35a3ec87bb1f627f

Best regards,
-- 
Jens Axboe



