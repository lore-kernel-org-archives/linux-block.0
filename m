Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82C2D03D
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SoigoiMB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3fe03b6b7so1609875ad.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409852; x=1705014652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lknKVOkhMF3UwLM2jmHBbFhZi6D6f1SR2EFugA5PMc4=;
        b=SoigoiMBchKUpjXUpQRX3NovgWeZrvMNsc5ocrF/38BJw9fdXqLDBjTI7/42ctsZq0
         ASAYwgIZ/rOi+NfyrnRiMmS7F+eLk5ftKKmSTLEj/Y5IybyN2YwZc9e9JCD2XRjdZMd0
         BBU+ec8bOkjG56KFGE1WrQOuJG7kdDMin3QW/ZdNSIr/OEZUnFqCtqPLdSoViA4VJ785
         Ayh3ZibSUdQuq/XGmowiaAbl4B495mlhzP/72Qj+3Bqb9iy1zRBwxvzFrzLaTx8wcOra
         OF9IO2BV6B4qE4Botv20+1tQsT30AQWXzemOGWQ0JQOBwQRjOi4opTdQSJdZng6+aCJM
         QzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409852; x=1705014652;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lknKVOkhMF3UwLM2jmHBbFhZi6D6f1SR2EFugA5PMc4=;
        b=M+oDhUSmOegmE7ftZgL1Fgtego3FXNoYGcEyXnlKdUNLAj1PxFoOKO4F7Rnigd4G9K
         sXbDHsjSRJJyaQP3IxKhOgKTPGbWtxBTtQtB/UvQHktWIEdE/Lr1HjHPdWvKI2VUjyxN
         zbK3n67qhIealZTThuf216wfkUKoyHhb8zbVVSMqmXc7vKupzivRJRAoGbfe6rFEhQb+
         pNa622riLdJcaSGOD6h1l2HotzO0aH63mCsp/o3u70beHlbscs+wVY6RzzHeQQZW7uuP
         1LgZEFebjFFrcX7FfQ46ZiCRfXJsg3iqhI3n/kl25bC2oppsHoN9op7wJT7M2kLHybPe
         OFGA==
X-Gm-Message-State: AOJu0YxaVtTzKb96viu0g7YOL9KRzpxQq9s7rEQO9gCWeKIlWanCaxQL
	AKI9rntzXHNab9l9/613yniwzHtSI30DcmkLwcxYae9B1hRz2w==
X-Google-Smtp-Source: AGHT+IEdhIEZ7cDb7VuZnJySn+lAkCNK7grLgAcsv3m8oWIWUlw125H7EeYLImNj+FhOyImZ1MqIhA==
X-Received: by 2002:a05:6a20:1596:b0:199:274c:2008 with SMTP id h22-20020a056a20159600b00199274c2008mr1742780pzj.0.1704409852659;
        Thu, 04 Jan 2024 15:10:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
In-Reply-To: <20240103081622.508754-1-hch@lst.de>
References: <20240103081622.508754-1-hch@lst.de>
Subject: Re: [PATCH] block: floor the discard granularity to the physical
 block size
Message-Id: <170440985168.724469.11500155379934497487.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Wed, 03 Jan 2024 08:16:22 +0000, Christoph Hellwig wrote:
> Discarding less than a physical block doesn't make sense.  This fixes
> the existing behavior for zram before the recent changes to default
> the discard granularity to the logical block size, and is also a
> generally useful sanity check.
> 
> 

Applied, thanks!

[1/1] block: floor the discard granularity to the physical block size
      commit: 458aa1a09939a56e044768013c86b5ef06e1c4f1

Best regards,
-- 
Jens Axboe



