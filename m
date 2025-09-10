Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C112D6605
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503803; cv=none; b=mjsOzhXucTXFLbev22RE0PX2oA5M5gK0ZQvGE0mx4KjhafFlzjjze6bkBeG8qAGr50smHXwyC719SnsKvzD0HYfxxCfplMxjePw91P7Cpe3mVtoXd5lCSd4ILERPYMKjnAZxTQP1/PHQqIXEwteL/k5nA1Xm9ynCyWdnjDiklw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503803; c=relaxed/simple;
	bh=r7oyqM25Rv6UNG3H4S4h/UY1G2EHf11AKE/M9IriSVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nMU84IR+49dd1WeP0JMUOXU7t8SyBq3EWJtgcxkjmwkjeBucPMjjxOXBAKv0oyyn+TqdsDL07TVWZ7IjW/8gztdHbnPVaoqATsBfJAAXNY8b7tBg5WALgzxswL3mx8UkTm3URIJZahxxzpO0oehFeb+62F8P4+URnTZ2TRZpAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ppKmTRep; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ppKmTRep"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7724df82cabso7562740b3a.2
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757503801; x=1758108601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdgr8V+lWooEJEpjFk6RgEs1J8LDzR0QLCG3DojQRoI=;
        b=ppKmTRepcjyb/FsTrK1LSO/XsShRhrc7zXUptHFERoz0mmjrDfR9RJDzjN5X7AHOCv
         mS/janrXyKZ2+GXrDEpyuT4ObzEgq4STmyLjHTWT+JQDyAKK87EufCwHf+BCKfWS+Qkt
         uJLHYoltjWseaF2t87a6OL3/CjIigw6grkoek89DxJmI5LiGOUMkxHNwYWUcP8fnCEF9
         YVMyz74S/haE3DxLHZBVC5Tc6SGYw3EHuX3wVObKEwMcFovqtsyTcQTpb3GkHpW5iLeA
         ExP5AEMKhk48EBETU6mtasqad9p8JAU5+ANppQNJ0r3KbCb9+PTRKIJixKro+L1B/xDT
         f0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503801; x=1758108601;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdgr8V+lWooEJEpjFk6RgEs1J8LDzR0QLCG3DojQRoI=;
        b=I+u6dvyLmsAXYi9aYFSNh1Dacx99bXyhmZ7ys6C48Y2YOVMErFxMlZAC1+NjrE+DLN
         cneWzFC1VkPEEybmLol+5CwQDZ54BvNwrvOMKm8wMr3TZrqaQAkhhmHXEA1nrU0yhTIS
         o82V9kbbfGk0zCeXFri3jbzBHaP1RJvvh20YwZei1A0v9ajZ7V5TpsNmSKvkaii0qCvi
         1Ok9hs/uTW2lDbUdvfgcyVJsKQn98Xu/N+VORHKNZst700tIT9plXDLyjZfLhOVlP8oR
         kWn/8i74wn5rK7saO34g9ROatY9jTxQnmhbHO1F2erC245ILGuKTbtvBeT1lm0RI5/Pe
         GGAQ==
X-Gm-Message-State: AOJu0YxK/ur+1aRCKw6k+Gwnb8UCdNI5KMs1TSTez5wEzuB+R1pQfEC5
	Y1042i7lDMVUXTJS8dEwVLUtr2o86eRwa3FO8KtndRcqlHWYFNFPXP0sdPK6dIwuHzFw58XiEwB
	2TdYb
X-Gm-Gg: ASbGncslonOUti63XafBz0wEhtzQH44uFGN9riTwLGAllRd886G62kH7HNLgve/XLtc
	B4ymZ7n3H73nJ6b5drhEajaXyf7Wkb13LbjLkPPTXeTxyv+Xl8Iy0WQ3KSX+PZUVVdRvprgTy+L
	JyRjtqCqgn4VSXVBaZMGcdXLeRnLlLKJCEXEic3yhkcgHHDGR+ECHUSeeg6Wi7zVuHL/P/Fu4JR
	tY+CzkfnQoRLRz3itkxPpRurfGFudUg+gPL0XLCvXa1yn1CseLwhH6Pv86tsdWhUqUOP65qRA/X
	exIkTFMm3ri0DTaISYg3wk0P6a+MYd8azBq6UeB4rqBGm/CoQCYoYiKlVJYheuoaR0xn/Cntq1W
	3G2UubV08IE9BEvyBF++jfd966g==
X-Google-Smtp-Source: AGHT+IHqJjR620pJipMMNQmLWBVZ/pTemczUKvgbeUD9ETTgnx52MIwaJYp9qC76TJj/X/N799m5Rw==
X-Received: by 2002:a05:6a00:4fc3:b0:772:5487:c37d with SMTP id d2e1a72fcca58-7742decfc03mr18272135b3a.23.1757503801207;
        Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662920b1sm4964965b3a.52.2025.09.10.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:30:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908184542.472230-1-csander@purestorage.com>
References: <20250908184542.472230-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: consolidate nr_io_ready and nr_queues_ready
Message-Id: <175750380033.204398.14564992598850434752.b4-ty@kernel.dk>
Date: Wed, 10 Sep 2025 05:30:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 08 Sep 2025 12:45:41 -0600, Caleb Sander Mateos wrote:
> ublk_mark_io_ready() tracks whether all the ublk_device's I/Os have been
> fetched by incrementing ublk_queue's nr_io_ready count and incrementing
> ublk_device's nr_queues_ready count if the whole queue is ready.
> Simplify the logic by just tracking the total number of fetched I/Os on
> each ublk_device. When this count reaches nr_hw_queues * queue_depth,
> the ublk_device is ready to receive I/O.
> 
> [...]

Applied, thanks!

[1/1] ublk: consolidate nr_io_ready and nr_queues_ready
      commit: 97e8ba31b8f1b743c918bf31586cdc272376226b

Best regards,
-- 
Jens Axboe



