Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1E1CFEC7
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875052; cv=none; b=Mq5L/Gmrphix/ZWtJQMNYovo6a0/ylcIqGDf2B4+v59EFXffYHZAXMXl9J9wCV+rcja+EJ7WbzTjhS5IkrIoKtLbBLQY3jQ8+KGGm5TN3mP3tEJhyKo0GgP6OTUvFqdApg0lVOu+a2JRhS9rYiuPOBeH4A9v2Qk9Y9apEZzylic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875052; c=relaxed/simple;
	bh=36nWme8y4GZ94wWNug6vyCXS0wdvEP/HfW+1E7YCpRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EJLzWeY0S2tOA11jzisYezJAXK9QfiMV+isbiV5goaCXShMVn966TGQlhh1/xqR7JbMia0cJH2h90jzWx3R3F/x0QRJvk2d7maHM+C6A499xSRTKITkY9WuTCip1q0xrtYM7BVZ5XYZ4FJioUZh4ZJ9Tpvuwxb7NdHP1YIoKy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=taTGbIF7; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="taTGbIF7"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a2759a1b71so33621405ab.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727875048; x=1728479848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRW4Cz/ZHbTxTOnb6ZoyufUiDwCoy63jco0zbwWoTDE=;
        b=taTGbIF7EiUE3jZ3URAk+jvyHeVim7xQQaRKn/zR65NBAQWKIUMYdfxiZy0KTvwJtt
         SnCYzkb3g1dGoOK57Ub5atfiySbTLC6hqNl3+3WaGhcUst0iuMfo+AAr1gWV1owl5Z3T
         qCEObT9Ic+lU441t+f0eFlwZB6XCX3j5KmeSYrk31kO8JfRhljVuMRuBnE2lCdbav7sZ
         VgX0eoxh4T471MFLMQR5I67Ji7OsRef5o6FKMMFucWBLzyd9zrVYPz8nl5VeWiO6DdFn
         ytkMHqPkmDfkAhGdFW4af1m+sL9FsjehaQD+A5dunq+3NC3ZCrUn1a9/nZ4UYmzoIxY1
         QoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875048; x=1728479848;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRW4Cz/ZHbTxTOnb6ZoyufUiDwCoy63jco0zbwWoTDE=;
        b=lRCLObP0prlcfVoa2e0xzocDbHhyLlOnfTSZ8YZehu0+uAjWlRNIgeUt/m6Wyb4Zid
         VxAk/9VoNvAym8+HGBeKa4JYwx7ETORkUtjp1KZibaCe12ni24rjFNvA23v52Y+/EhrH
         rhtGkIv+e/PXnFtM61tCdbw7GxFVh2oP+4XsvxCg1KkbMFNNEcBWLobMzG3k6YJSYC/J
         MGkeaa7jv98t7mFt9Q6J9cFZ2Z7wdnLcGr28ovdeZB5jX6m1/8ZdOcuxAXcZNvsJTGQ/
         XTJAJqFpDQVnXHohVnoGe2lbOQSTIv58XjmkqSEe/Wf2Fwn/ADdVsHczrla6yypZJaVi
         NEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrJ8s4eLfLcey4dJYu74pck/AyeLyCLoPVtsiqA4cbt9feBScUK9SmVPYw8JNPxZ1TtWIF93nRe6A9KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznKcs2wEW3MSPqEavxj0RwhferzVNWiAGR8HVs1mgjTMgD1wEC
	Rmblt/bCZ/kbJGXxWZvesZAJGVqUNMGTKBrmzqjU4jGHqZn/XVBOJ/9RIbH+fkFtwDaPF5YcDhG
	AEkE=
X-Google-Smtp-Source: AGHT+IHuxaPoCYtm3L1Gav3Ro6gdyVRIy6bPAZVe7gjGl0fcZClv9KzDyZ1fxfNnKo1x1TzHZQxr+Q==
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:6045:f8bd with SMTP id e9e14a558f8ab-3a3659156b1mr26379705ab.5.1727875048142;
        Wed, 02 Oct 2024 06:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3678e3ea3sm3490625ab.87.2024.10.02.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:17:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <Zv0kudA9xyGdaA4g@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq
 disable/enables
Message-Id: <172787504695.64996.11187205888353360431.b4-ty@kernel.dk>
Date: Wed, 02 Oct 2024 07:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Wed, 02 Oct 2024 13:47:21 +0300, Dan Carpenter wrote:
> These are called from blkcg_print_blkgs() which already disables IRQs so
> disabling it again is wrong.  It means that IRQs will be enabled slightly
> earlier than intended, however, so far as I can see, this bug is harmless.
> 
> 

Applied, thanks!

[1/1] blk_iocost: remove some duplicate irq disable/enables
      commit: 14d57ec3b86369d0037567f12caae0c9e9eaad9e

Best regards,
-- 
Jens Axboe



