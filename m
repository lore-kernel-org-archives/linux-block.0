Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A181FBEA6
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776127; cv=none; b=nRAoHxrEzkCaSvZEEREh3v43/QeYjdPncdU1eRBSrPnaLAdlYI5a2/zeR8lXTXhEZ1Vpmcgi7OZHoEnD1SnOX+7bXAFbqwwqpZH5SA0jLwQUAaiLINkrC1MknrMyjJ4qAszpnQ7esTrrIaRQsAwOFQADrhc3hjfmUYStrLkHWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776127; c=relaxed/simple;
	bh=DCVoOID/Eo26RLJIzNwO0uxb/ZzWFqzSqVJ8lXgfAdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aU0BGKxquNrwF6rZDZ5Xs78yJouP1NQE5IyIEtXNavjIEEoOKYB75GVMNwYi42V7YOJmFIdSYKXUJeluOuJ4n8w8aR4wXRxnBE8+lzTw7PbOrTQwmzf8Deeql3COOSi6XtMfykpEo41xNmP1FUwBYyru8TPdfGhlE0C1tkp+5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UCyJo/Hd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UCyJo/Hd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174b3429so553648a12.2
        for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755776123; x=1756380923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jmo2rFrxd05ORfC9zMMUKgxwpji9Bs0jmLtRYiOa2Tk=;
        b=UCyJo/HdMwvpb8KCQhf1Yf7DmB/Xnc2Mb71RYX1XcnCQ0YofrDQDprLO80uAAUbBjl
         4Nfw7td8/WJ7mUc4kWhOy0Br7Ajrwe3PTeVJEM4noNUYpwAcSInVwuwNqEI65PVXKpAp
         i1DofSk3xvp+IfiAV03PmJ5kgavdEfKr8SyR+e9WDWoFq92nuifrgECwD6SXrcftIRtK
         B109S2QIA5/GWixkrJozxZxUDJlyLXkXr+MIteIh1PPnz3lfFk/BePVI0qXxevrs8DQb
         5xa2Ayd0wWig92H9TwXKxAmj9Ax9YNi2JB1oEy2hv+NSq+tC0wPHfVarlG9Vfv+3w8VN
         KuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776123; x=1756380923;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jmo2rFrxd05ORfC9zMMUKgxwpji9Bs0jmLtRYiOa2Tk=;
        b=YzV3idQBBuQ/yJmlmaptZ5EhgDEmeulgm9f0wkWCvjwlR7ys7i8xknWDLvMV9J5EU6
         9f9axHoipdmYAm80k8LDNYbOpCkMd23ERSLnrjrxd/VnvZ3qX6zsWEl9pP4EbRt+s9Dt
         ZTGeRjzzOvlK6Xo0nKjb+ebTDCDY9tcSnEnjcTQGek7Xvwnll4DHT04SNb46JybMCBHm
         7xbUN8TcqKHDwY8Am8spoJlI/4xGSKW8Y+rhjs4vyeshbjczNmM7KfvQ+6yuUIPdTy0V
         YJoel8YlD0/KJ/NCo2ocathnz484dOj4Nq9E6Qd82TB/JZkJ6U55IBnuTEU9JdGOxRz6
         CtkA==
X-Gm-Message-State: AOJu0Yz1iPYg+jDXjprMgtBQ4oIS5hVKMEkzMreYSavOkZt7jIaGxZTb
	THorXFusTGdLrW8oVwqplSjEMVsEQCL1v/PGzFWStjU8Uu0F43cxOQtoXkEFURrSMRA=
X-Gm-Gg: ASbGncvz/RPT5Pk4ad6s6kMcj8zFLFEFX5gpZZ4UvWifH7S15iEt96aYyLgkb5QtN9k
	DR/sxJfWMZBP7h0OYtFqgDfYzH1DJxSxpJguKLHMK8rVGLhO+AAu3k6Ul+ZWXTRjEo7dGL4i5oX
	vzf5IXrBlEEn4WNj3vKxmilUIf4q1Al+K86IJHwxsEPrYnEG1JSXVh6OVOShJ8ThXdhd4szrhCf
	UpYiuEQultRYn5Ccei9GU0quo6dnVOju/bNcmPbnHgKWtwfTQyEWYe22nTOOrFb1W6ucsnbGaHt
	uIJa+hmtet26uHPFoKiKCO9Y/TGJjLz+oEEg2rn633h0Q/6MdnOUletZq+/W05IP7ntHYH/ES1I
	8Fa9VUmttg/3udPpZoBc8Orxhog==
X-Google-Smtp-Source: AGHT+IFP4dNS/iZCc3keECbQmIs5Herx/LkoR9vNmkPpGyxTTd6c4VZvToxt34P8BfotGvApmXJ6Pg==
X-Received: by 2002:a17:903:1b4e:b0:243:b39:285f with SMTP id d9443c01a7336-245febf6c3bmr26549685ad.13.1755776123316;
        Thu, 21 Aug 2025 04:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed3783a0sm53504225ad.66.2025.08.21.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:35:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20250815131737.331692-1-ming.lei@redhat.com>
References: <20250815131737.331692-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
Message-Id: <175577612238.613330.8561738508743354282.b4-ty@kernel.dk>
Date: Thu, 21 Aug 2025 05:35:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 15 Aug 2025 21:17:37 +0800, Ming Lei wrote:
> Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
> running nr_hw_queue update") reintroduced a lockdep warning by calling
> blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.
> 
> The function blk_mq_elv_switch_none() calls elevator_change_done().
> Running this while the queue is frozen causes a lockdep warning.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
      commit: 2d82f3bd8910eb65e30bb2a3c9b945bfb3b6d661

Best regards,
-- 
Jens Axboe



