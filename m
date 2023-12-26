Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C74F8A3
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X6D4l90h"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36016c6e19eso78695ab.1
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608130; x=1704212930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTpKLeikOxvCLN4rFxqGbc8Hn9jtGXezRCP/6OMWxRw=;
        b=X6D4l90hKybxiMkxFu4e35yiPlwp7gRYz7y/aPx6YpStAUQt7egHhtcpTOU+ZS482u
         3u+mIJSGgBdnI3+Ndp6bo9/vqBocFIjw9Kd2BFiAS2ARq5gtqTC/MZNc/N752N75D4MP
         9TSjjruR17DpPk+/Jg4hn9y/bwuLd+/poSe86tvzyK/+VBe7CfcC8IL4p4uXgQHJouoY
         S3P912mhMxHA/Ln6uXoG3mNAMWq5Pbt5FFDyyoaV2uwLVbOW7cISX8C4KIbiYlOqAqxZ
         JQHqumsLTTMejPaMeedcNkdEqZ/SK9C0/dobYWfZZKNlT4Ss0LL2MgX8XesXczCKHwEl
         WY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608130; x=1704212930;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTpKLeikOxvCLN4rFxqGbc8Hn9jtGXezRCP/6OMWxRw=;
        b=GtDlwPWN4Oz5HC2HcBTkGAX5VaJ3UZUqJV2zkAnacsxTOh2Ya/PhUJ6Q8peFWBdweg
         1o+U4L4U2HeYI9MpohSckOdvH4K7PKjBT1qGlLvvrzyUn5KHMT3RXpGAtIcePf1J7EDJ
         XVG5Mxp4vb9Q+4EvFQ2oh0742cmJ+YOZx/IBSAz6nFnnvTDzl/PUndS+sjlnDi9XLM/I
         Oxm9w1C2SaohR3z/KurBMhSOGBMV1w5Q/Q7WsaNT7s3w++FP3jaWkDQPRxIghG/14INN
         V3dElNNJWbHkiMyewzNdXnkXkMw9lV7mabuURYTY0YQXIMZdJPhGCPydRqiquJGwWq+y
         CnGg==
X-Gm-Message-State: AOJu0YxQ1LX5E24kNqUSa+wcNKJ0JDqCfm51IeeIiO/SBSCvE6z1Rjxc
	6Qqa1f6HIyt/cgrHpVJvgGbbQ15lsdK98pY/IRptEG9oHnFAIA==
X-Google-Smtp-Source: AGHT+IFf+Ngg2DnolKIiGT4XbN43U4CtNke0ZBBMVnNL1EzmrKiPt2YEY8TG+TucrYW9O+u740vrZQ==
X-Received: by 2002:a05:6602:1606:b0:7ba:c23b:8d63 with SMTP id x6-20020a056602160600b007bac23b8d63mr7096462iow.0.1703608130746;
        Tue, 26 Dec 2023 08:28:50 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i17-20020a02b691000000b0046d18e358b3sm1607879jam.63.2023.12.26.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 08:28:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20231221070538.1112446-1-hch@lst.de>
References: <20231221070538.1112446-1-hch@lst.de>
Subject: Re: [PATCH] block: reject invalid operation in submit_bio_noacct
Message-Id: <170360812950.1227834.5021588083175023177.b4-ty@kernel.dk>
Date: Tue, 26 Dec 2023 09:28:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 21 Dec 2023 08:05:38 +0100, Christoph Hellwig wrote:
> submit_bio_noacct allows completely invalid operations, or operations
> that are not supported in the bio path.  Extent the existing switch
> statement to rejcect all invalid types.
> 
> Move the code point for REQ_OP_ZONE_APPEND so that it's not right in the
> middle of the zone management operations and the switch statement can
> follow the numerical order of the operations.
> 
> [...]

Applied, thanks!

[1/1] block: reject invalid operation in submit_bio_noacct
      commit: 1c042f8d4bc342b7985b1de3d76836f1a1083b65

Best regards,
-- 
Jens Axboe



