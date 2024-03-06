Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB715132494
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733858; cv=none; b=j4WD7hZ3mWeDQaLyzrLV/qUZh24ayRbGr4Ob7MiTm63q+TTBPhZMGzW1XyHCWo18rZ6OfjeEhTvcht2gbSQk5e4DDAbZh+x0wxEc60A0FeqqpA4P53qe0YnR3liMgwU9U3AmCfk62zM9NuR8TjHvtV0u8YYXESfpqjBDDOz/URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733858; c=relaxed/simple;
	bh=T0s81Tx1CDGK7sy8PGa8AWm4ZLGE2Uqs2IBbaGMOOCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3OILCnVSm+DYZZsFcScjsDgZwCymwZIyO4UpoaMSGgZbbu/6pa2Lz/oaZ9caFCilSpCVC47rhbbn9A9nHlxhN3Q7Zo9Chq/YzF7O1DF3cj7mA3XC2PAl4SSwxIr4dLT/zNkcuP57YekpNbyW6HKt5qeMscjL/D6/RUyJvIvnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=x2AJ4YkG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="x2AJ4YkG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2614299a12.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733854; x=1710338654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+YBoOXcmEaodcQB2eW9zOPeevzURByDqXAI9NhYKMc=;
        b=x2AJ4YkG7xbg2DUvaZKReC8Ezj0dW/hH1IRIUzMNWvOvt0HSYSlYaT/p6Jtmwl6rD8
         N0N6T1+XN92getB/JbeIhwXTGwB3Bf1PQxgRjCRk6S52+C5QcIKS4J1ZzsmuAPHLp7Xl
         h1KaaHc/fwKjQDQDPIKGhRRlW004Iepn+cBL82wYCvcxguERigZBODCeGZTfLn57I0RA
         0xbZW5hNz2c3XCPehfUVSx5dWkWSOKzptKiXDoQ/GwnCu/VFy4b5Gm72ZAmbeXM7N2X3
         UyV8m5dEFJXoLRoNWPBtqco8wlGrSnjCcl05neaQM6QG2K2nTmTMZLDG9sGJimJ/EBoH
         zThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733854; x=1710338654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+YBoOXcmEaodcQB2eW9zOPeevzURByDqXAI9NhYKMc=;
        b=WgMOeGYJmH9pPLp/RmtyMctcIS8//dXEbGxSotN5BFJ/wY0juAI6+Jlc/gsl81NTLq
         DqrYbSHxplt1t79743f2rUH+1aHbmym6f4gOxwtpa4hishCI/eEs5ShyD8lCZo0xagi3
         sYx6VL/AnqomizHjG7eA3kuBy+BxXqLpv4gyC1ocqyZqtMRYRYX1ARxYkEfoGx0LYZaG
         Mui1/Z9SacRiqf0qrb3+Z80ZonlQKTd1nIFBVEH5yUg+Sukqvpzi2+lbJ6wgmKP6AbMK
         ehW7poE7+3Du2r4PEeWPJyCge5KnXdoydleIW/6dUeKfYdxETv9FCtnaZnCfW2znCF+N
         49tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7t48f/Toc2tIE0s7qYImFxWDAxC/ghGrRdsoJSd099nOFWdE5HgYhIJH9qSYbzv8V6x+8D/vUumE+A7+EWnrg2wazulsfmWGtW3k=
X-Gm-Message-State: AOJu0YzXF8euRSiNG+NXSE8uVOmprJBAgUCqp0mn0j1FurAlQ4mamU88
	HuwrVb1blTf/ajvZ+UF49TZvW0iw5cpSHOcEqCMmxSUWkWLQnAIH9DRKDdpogcY=
X-Google-Smtp-Source: AGHT+IFqTbA1RssQ9CLqFuQ0Vl0lw5IbmtZKf3aPPx9rduNbs8A5uIcf+/fvfGwBCbjm5RD3JH1pjw==
X-Received: by 2002:aa7:d714:0:b0:567:48b9:e9e6 with SMTP id t20-20020aa7d714000000b0056748b9e9e6mr5920495edq.42.1709733854315;
        Wed, 06 Mar 2024 06:04:14 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:13 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH 0/7] drbd atomic queue limits conversion
Date: Wed,  6 Mar 2024 15:03:25 +0100
Message-Id: <20240306140332.623759-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Jens,

Here, with the Reviewed-by and Tested-by trailers.

Christoph Hellwig (7):
  drbd: pass the max_hw_sectors limit to blk_alloc_disk
  drbd: refactor drbd_reconsider_queue_parameters
  drbd: refactor the backing dev max_segments calculation
  drbd: merge drbd_setup_queue_param into
    drbd_reconsider_queue_parameters
  drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
  drbd: split out a drbd_discard_supported helper
  drbd: atomically update queue limits in
    drbd_reconsider_queue_parameters

 drivers/block/drbd/drbd_main.c |  13 +-
 drivers/block/drbd/drbd_nl.c   | 210 ++++++++++++++++-----------------
 2 files changed, 110 insertions(+), 113 deletions(-)

-- 
2.40.1

