Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146FA6EB66
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0LNjm4PU"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3606ff777a9so4102455ab.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705074551; x=1705679351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M2ezCZGRfnmAxL/hY8nisbjoZxKUoYjhz2vkfYrIu4=;
        b=0LNjm4PU9lH5K/JXGKZwaC1LoRHlE1yQ+b0Ds3VrHMXYRZtZDbIIsasTlyHFhmhAJC
         +9DDZvhQzxbLcSGr2SyMz7GTiP2Z7Kdd4h6fnKcovASnTeDIokEdTwZdm+VONxtb3Xxf
         2zxSv8raVMYOJiUM9JPkr1Jj6VsjtzTb8Q7Y0AcgpiF80lcNqaGf5H8SuR/Yk8KXVUOE
         TEh0WdU950tWb4p3r48ekab6UKkRfKtDRkKuZtQAkcbjBpOEohegx571xS4DJois5OLU
         wA/mWnX5zSmN/rzkX+bJT46ivT0uMpH1diGwxs7qrr/y6SGV/PkrBQNlqjI4ByKVG2Lv
         /h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074551; x=1705679351;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M2ezCZGRfnmAxL/hY8nisbjoZxKUoYjhz2vkfYrIu4=;
        b=ZT+Ak6OJRhCEWsE9BQrC2r8ESrQvzsSjtI8TO9/z+XY3UFZamhVJefhH6WqbMRWGAk
         N9EhP5NYsuQx/SGaGdCev/kSK3fGigenWMBuLVcL/xQlqmI6ChB7P8bSIoRoH54j8PER
         SNGbhFufvAMM5/RgQYrWxp6MoXJz7dngmqQKeZggp0qM0w8sE3Pg+I6eGG20RfZ0UAYe
         CG68Qo27dcR+CIGmif0sWsOGMcRbOyC4pynFysU2fnDdswcw4Ie5p0T/Qe9j3YZt1Gq0
         MmrRJ8VPcLRmt8eWsXwS06pGDJ4HO3YQXtvMlZLGoGBePDaBkuyYp7Aqnrxt8mFWDAQK
         pFtw==
X-Gm-Message-State: AOJu0Yyg5VCVazLgd9j4k0zjoD2Xn4xkhddfIjpuQphVTVyedc0fKyLi
	Ts7NetfsTJ+PNSKRSJThsn9Y4s00camxSiY+KnZCLbxzoAIH2Q==
X-Google-Smtp-Source: AGHT+IE+PUBWKFhDNq7VuctZY9Z8FCMPFa07xX9QsvZp4BigHz2Zae4oUJiySCDTy/RqVUOAFKWehA==
X-Received: by 2002:a05:6e02:1a2a:b0:35f:bc09:c56b with SMTP id g10-20020a056e021a2a00b0035fbc09c56bmr2458698ile.2.1705074551136;
        Fri, 12 Jan 2024 07:49:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j29-20020a056e02219d00b003600cf4d4c9sm987558ila.39.2024.01.12.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:49:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: David Jeffery <djeffery@redhat.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>, Jan Kara <jack@suse.cz>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20240112122626.4181044-1-ming.lei@redhat.com>
References: <20240112122626.4181044-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-mq: fix IO hang from sbitmap wakeup race
Message-Id: <170507455034.2246885.5860299137041483473.b4-ty@kernel.dk>
Date: Fri, 12 Jan 2024 08:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 12 Jan 2024 20:26:26 +0800, Ming Lei wrote:
> In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
> with the following blk_mq_get_driver_tag() in case of getting driver
> tag failure.
> 
> Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
> the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
> blk_mq_mark_tag_wait() can't get driver tag successfully.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix IO hang from sbitmap wakeup race
      commit: 5266caaf5660529e3da53004b8b7174cab6374ed

Best regards,
-- 
Jens Axboe



