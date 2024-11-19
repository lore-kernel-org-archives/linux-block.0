Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482E22067
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026012; cv=none; b=DkojfnGifAoVmu9Zm4PVxFRA8EcULQSp9nAtfyuSTFREVAOD+7fu00eHK2FuKRQ9Ym/iswoV9minGgEGbVUM+1zrFmQR+UUBKWSDBpCFG3cqxMhg72vJw1MbCEqVL8DxeYHGy2zGd+o9TowuiMl327EkZeg8En33gDSi+Q+d6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026012; c=relaxed/simple;
	bh=722xs0nvFuWjs9/R2m8p6hGDpp9l7PFBIm2FPJL466g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e6lXKJ5jCh2lo/tbTqmJu3hGO1FSE9+o0B9PGV+cHU5bYibSNfH8BayOaYsfxgZELchWVb1K8GqFE2hHV+ko1qVvydSD7AiTO4UcBvKwK6btOjocG+h+db5sG2TOJz02y8sC9wiCMflxPPIm9Sxrlv7w3JY316SHXAdsQyfO1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ls/wXta5; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ls/wXta5"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2689e7a941fso2343120fac.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732026008; x=1732630808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow4Dl2rGHQ0YkrcNYLK7P+rSrOpzrx6eTf2P7HdF1Sc=;
        b=Ls/wXta5F/X9SUbfPmtH5wFdCjP8WzWZ2CfA9NPhGtr6EEZMeCYOvp939B2YOKwg60
         KWLCSaAT0qqoOPmV7jSYlOmAxnZqTLknGnGXLU+jBW9/SSfxhKMIB2nsf0q5lsnTw77D
         wkl7nf5UdMM6cZ5h3UoIKaGlTbYjRnQ1A6/fu025L7fRWl9cufboe+A+mRKbzFCz41hV
         URtuD8MsJ2GSf+936ZAKIVO/VJ4iOh8Ei2KBxI7hO2wJB/UX2ScdbTIkpWMgxOqLr4/+
         WwOApAyNJqeaMOhTrBb7cNurWLejT0bSzLaAMWKMFoRup6uTzXc+v+an8+BEtGfZoiWw
         ezOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026008; x=1732630808;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow4Dl2rGHQ0YkrcNYLK7P+rSrOpzrx6eTf2P7HdF1Sc=;
        b=LfY3ifhWH9NPf+Rbl1NIBfCD/trhKhFYRqk9Lac7S9CoCS2j0UR0zy4Xd7ZgV3VuVo
         +EcI9IoI6OqnTSWYgU7utDjeMVz2TQJA86lgSfQ09m/IvO7zqdKZoitV3c+SUauT/lpx
         RzjSWhTX76M6i/qX4w+MjnuxsZz4/1X2al6gg2salahdolLB1AINuRtD7cGKsdDPRKaV
         CaFFDa12e+gQOv8sL/8riYHIfrc28sKfy+zaW1Hhtf+kQSoINB7KAubG2mBQn2rMzpse
         FuNfIVZj6hD+6SNEPI6RPpxlLGPHwJGqcs8G+yiwRoGWKyv/I22JaGSEHpKVC2azfKfH
         eoSw==
X-Gm-Message-State: AOJu0YwhUqSiHAwf0qWEJZZ2fmejZU0b1CtFP7c3bgc3/cPOlQTXujM0
	+UW2UEGFjhY6L5GXmfyqQU2XsHzclRogrnwdnIGPAXkGzq9pakOAqchrbKUAWpfRHvc6cw8V09b
	Z7d4=
X-Google-Smtp-Source: AGHT+IGppwoRa6CVC7AIE6wGFY3IurArJIF/MTaVzYhWCh/UJm8hoMdstPwTIthdyvlX3kv1RdjzvQ==
X-Received: by 2002:a05:687c:2c58:b0:296:7bb0:675f with SMTP id 586e51a60fabf-2967bb07ea8mr7074890fac.6.1732026008449;
        Tue, 19 Nov 2024 06:20:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea614sm3364459a34.11.2024.11.19.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:20:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241119072602.1059488-1-hch@lst.de>
References: <20241119072602.1059488-1-hch@lst.de>
Subject: Re: [PATCH] block: return unsigned int from bdev_io_min
Message-Id: <173202600419.64264.10508287534167273949.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 07:20:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 08:26:02 +0100, Christoph Hellwig wrote:
> The underlying limit is defined as an unsigned int, so return that from
> bdev_io_min as well.
> 
> 

Applied, thanks!

[1/1] block: return unsigned int from bdev_io_min
      commit: 46fd48ab3ea3eb3bb215684bd66ea3d260b091a9

Best regards,
-- 
Jens Axboe



