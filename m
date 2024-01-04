Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3392D05E
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mEC5prSz"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so164962a12.0
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409856; x=1705014656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV9sBgewrM1essYp9cr5t+TDKLcXvUh196SO4iTd4XM=;
        b=mEC5prSzEcwcUxUrAkZ6slUIrYbVLr1YDQtU6iAiBxjSAcwDzaJ3ygOvOlcvgdhbs3
         o6UfRt7saqTfhpxsLsjo3Mupy4e+BeqtKMq1el86A0HzTyVqgO7NEksSJUhuGw8TPwpx
         LzBJnPsJ6uU94DjfyaAaQ6x21BpbYgvJhMuueFnxYCWUxDybpbWpEi5RO1OgoDWjBJ64
         h0MVne6bT33v3QqRlvF/hdA3jC6wsdSAn6rW9iYDUdsSlUqqlDSXmHoQXmlV5E3hHhN8
         us1v4uSRC0ERkqeeveUT8IRGYobAWdxyUKmPRgnXj8arMQPHeUINOtV+AGY0B9MFIqBa
         93PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409856; x=1705014656;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV9sBgewrM1essYp9cr5t+TDKLcXvUh196SO4iTd4XM=;
        b=jJ3HPqKJ4A/HgxiqwVTbJcIbcBuvE78UK8rH3nH3JWVEFSi6uXXIrkv9AUyOlI5nQL
         zZtIt6a30FYxECWphBwJ0PUyYD2ONs0EmIeF5OJVfhYs58B9NdLh9yEJna14SOJjBgGO
         hdEX/iMCs/reCVaUP2liYr18JAoxCsHF20PxP5pmEVM7XF1p7YVR4nwIzezBSa1jJWIh
         PlzBq+8vwCYn8xQfH70Faxm/E88Fj0ywVwI5x36GtP5SP2A2oszhoeLxyLnvDWHppGeV
         PEps+8+lgogF6g+Uhoy0QwfpULtg/c5v4GLlc0RvSu5FsTl1/41cF4RnKnjerxPyNUX/
         zGbA==
X-Gm-Message-State: AOJu0YwUHNmG/1NhQLDHePfMVcSIUMslr35qnUjm+3unkqdj6Z6wWQto
	46SDYxifFO64NDGAcY1RGIZ/tyNE2mF32Q==
X-Google-Smtp-Source: AGHT+IGSlyuRXt2WyHS0bl5EMx9PV2pHPItk7wvVG+81gZ87DGoNE5KH2fl4t7vkCBg9Z8YNX9eeaQ==
X-Received: by 2002:a05:6a00:3a14:b0:6d9:383b:d91a with SMTP id fj20-20020a056a003a1400b006d9383bd91amr2570809pfb.1.1704409855663;
        Thu, 04 Jan 2024 15:10:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20231219012833.2129540-1-ming.lei@redhat.com>
References: <20231219012833.2129540-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
Message-Id: <170440985407.724469.13796728189031441181.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Tue, 19 Dec 2023 09:28:33 +0800, Ming Lei wrote:
> blkg_lookup() is called with either queue_lock or rcu read lock, so
> use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
> retrieving 'blkg', which way models the check exactly for covering
> queue lock or rcu read lock.
> 
> Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
> from blkg_lookup().
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
      commit: 393cd8ffd832f23eec3a105553eff622e8198918

Best regards,
-- 
Jens Axboe



