Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1E1991C3
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503742; cv=none; b=SHF2Khwq3kzNwbicwroktJvcT2t7g9t+S5U9r/CsJSP1VKLNCam6l38TVqzAZJnpcRJFJJ41prZnEmjr3sD4GNhGKiFx46ZmIGdBNdJFnaYyRZ+0GREvtnBGmhMmKYf86bCfBDCx+vrwj0iqqvkTenygu0QrcCeOUUa/gQ01pPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503742; c=relaxed/simple;
	bh=a5EXa5AIoXgs+7OGu67HbaGGuGx+FZTfR9iFz+PH/mQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kK5CE7ds7oGqu+ipQzopswjZDMOH8qlSfVY+XGvMDk2CR1nBm47BaSOdpczRt06fMCH8O7LlBb2KJOLtDfYr3Q+RQqaaUOZgomUhqxcp9anEuUz1uHlZkGvDwNF9lTVGnwa/3sMkoza47ZQaVy/YYgYZAxPS0Dc7nHDCbmdF3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fuk1xnbq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fuk1xnbq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9a617f88cso3548265ad.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719503739; x=1720108539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56oXuAFY10ag5uJ3pg/ISq//+a8g92sraucL2mJFEYk=;
        b=fuk1xnbqaBj5yJWu0kEByURU0xzp/DUeaHY8tE3kF1KKmDJzbme0Ovw0ooaUBXxsSh
         UH8X3VAQu6/gwB2oOzssaoIp2FWtoSICwlVMix57X7O2rKwd6sL6v9glLRbRn9Vj26hb
         9Ir4A+wOOT3hWxZwwObNOuNGOODphV5h84CTvfTrTyBqBxk5XrycufAtyPap/Owty1Nz
         9BAVZYs+g4q2aUS/vYf2b2Q7qcrA/VH2qO0ttP69tFL3VB0zJ/gIKsmtLjqvXSnnk436
         WaCg2LteBKDOU/LFtcSo6cziSDKTs+pqmd5EXRBAdY2dJ3YV0WVZ5xjyYEtWz/MHGZk4
         Xa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719503739; x=1720108539;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56oXuAFY10ag5uJ3pg/ISq//+a8g92sraucL2mJFEYk=;
        b=bus0iEbD0RfFNUuN2Qne1QHiccYSYUYeyWOy0CvjxrG6Vhafqj/HmNMWsA2h1VkjTt
         502Thk9KjzXjfg4usIdNm00jVrXpbScZeUaOxvxMihilQeU/mBIcEkGY1cwAiYbZDBYF
         /S6f0kxR+S17X1bv4lHPesTiXC/GMzx2ooDrdRc4YdGQG49CWLQvqJLCUofVvsBu0iJn
         VJigbOzOtFQUlyMTMSWh6DX+j/kCXC2JVrxqnMNdnwpW2JPlKaL62pl64Zy+EB1+6w7z
         m+NgF6WTsj/gnZfdIYCeAq15e5O7P9dk+Bayes9YhCDaCGGUvaQdj285TtdigIzAs94J
         qIzQ==
X-Gm-Message-State: AOJu0YwingTNox7FKZwxZaYZwxKg84qX9CvaSD82O38OVrXJvGZtq5oc
	TBCewRIdWK6NXjj3HQMRtXvR5ybb+SqrLqBXZ9lQKsTe0ipZqFGRIgfxitYx1Pw=
X-Google-Smtp-Source: AGHT+IFbSTTfwFHFdl0iuWEaJ/3Gnh+NeRphNIwjci4f7UloiWVtdW13YW0ru1IJTJ/xGwQnMc650g==
X-Received: by 2002:a17:902:e888:b0:1f8:6e3f:9e7 with SMTP id d9443c01a7336-1fa09d94a65mr168670355ad.1.1719503739336;
        Thu, 27 Jun 2024 08:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8e06e7sm14965665ad.6.2024.06.27.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:55:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, 
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240625115517.1472120-1-linan666@huaweicloud.com>
References: <20240625115517.1472120-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: clean up the check in blkdev_iomap_begin()
Message-Id: <171950373822.862512.1110840409079088646.b4-ty@kernel.dk>
Date: Thu, 27 Jun 2024 09:55:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 25 Jun 2024 19:55:17 +0800, linan666@huaweicloud.com wrote:
> It is odd to check the offset amidst a series of assignments. Moving this
> check to the beginning of the function makes the code look better.
> 
> 

Applied, thanks!

[1/1] block: clean up the check in blkdev_iomap_begin()
      commit: e269537e491da6336776b5548a3c73f62273aa15

Best regards,
-- 
Jens Axboe



