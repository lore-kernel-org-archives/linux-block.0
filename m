Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0F2170B2
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022060; cv=none; b=Ds+uQ1LTPvE4C54kZt4NQc+qE7chzv4iXD4Z1fidfRVoM1Sy/zDMSM1bFu/iXYz6em/cmIaPtl7nroQTajmXvfZCbHsBVFtyJeOvVG7zfcZDZokrfVHYapZsjPnd0vtIi2EtXf5m3ZtsBwflqT+DcLAf7GLMzLPCCzaBn3DgZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022060; c=relaxed/simple;
	bh=hv9C51HwlWtOyl5PkOmhBisURfjT5kkvK7Ix7Aq0wQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r+UbHYbwGg6Hz9dJBdjOV/N7iqqL1qBOS5YcQzvjMXn9WjfzuOkyqyh/v0co2HSzYOLyr3rObOhw/ToJNSqrYpYJPxJPqO9TQQVSKz+y7HZ50TYa/Ynh5spxlpW420YpMTNiCLj8pW9DpCn+hM92VNaPvCz6nUbUioSG6g5aj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jvQdNjQp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jvQdNjQp"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-718066adb47so999002a34.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 15:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731022056; x=1731626856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WnWqwK9t70JgCc24ZAMW/wCoGuQtUhjWvayipWZGVA=;
        b=jvQdNjQphPdesgg6uqk7uyPP7FkTlpA06H1RQROTsyQoMW04EeVhG3wVOAF88NBi64
         IJXAErNhDZn/202fKsml2cVuZqonQZ1GxOT1JWX1UoO7Vb6nJadPZXyhXUJZlzZ60S9j
         hTX5V30mRGmqUIkGdlgZJ/gnO6y3644zVBTgUJ4kBzx0dzLx4tmM4a7tC+T+0iak1q4H
         PztXPRyEuw9aQNpsMEFqEOcRLxSBIIdZNC240Mj4PvAHRDZ1F1tEUelYVHfemhVf5ptj
         SoSLal8oq1IkZcN1r3Jq07oVFgPU6t6fJBpdCil+b40VCNspy8SqBK6dfWXekReB7YSv
         32qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022056; x=1731626856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WnWqwK9t70JgCc24ZAMW/wCoGuQtUhjWvayipWZGVA=;
        b=JkY/m9nBkO0W0BjSvRDBL1gVKh/C6gVoYccgfwx3QiYNGmZRwT5lTnAzOoNujLikh1
         BUxfT5Y8CgTUP2TJu+wUKl9NpMLVZyAmnvLhwyt3P0CCnVOKGMLoao1Q7qVbgbLHvlww
         h2JMALgFG6F6JuJwNL1t/Catof0UGP4Hg/paCTxXg8tgGUxbx6T2HAaURVm4AMGlLMef
         1cnnUHZc/dNGLzjotpq8Kh2D15CfMkF3C83aXTD99fVzD7QLEkgppuIedTRbJD6mUIDc
         etulFdcvu7LBN9aHO3g8HvWw/ZngLYiQG5Y1W/8uAZ5CiIWKN2X/CjTxhzVHxUaVvVZy
         jhWA==
X-Gm-Message-State: AOJu0Ywg9MNDdxasqDKGIPp8GxNNOoPYNbljOa5ftddjdgLCBTmtBEdV
	ttteUnLDyWusnsM/Rb2LXUqZ4u4u2hfit9VyjOB3/b8+MrO+/fa8ukFY3oC8kdNawecagjECrKt
	2UoQ=
X-Google-Smtp-Source: AGHT+IGyYIqTuYbajAan5NZyCPasIZzSVxfRuQGSsTkDwoqpweEn1BLHUzptxf5l1TPvjDwD5dZIfw==
X-Received: by 2002:a05:6830:2aa5:b0:709:4757:973 with SMTP id 46e09a7af769-71a1c2860f9mr1083633a34.23.1731022056541;
        Thu, 07 Nov 2024 15:27:36 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643448sm2107935a12.52.2024.11.07.15.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:27:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
Message-Id: <173102205564.1016704.12158859510789956148.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 16:27:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Oct 2024 21:37:16 +0800, Ming Lei wrote:
> The 1st patch removes blk_freeze_queue().
> 
> The 2nd patch fixes freeze uses in rbd.
> 
> The 3rd patches fixes potential unfreeze lock verification on non-owner
> context.
> 
> [...]

Applied, thanks!

[1/4] block: remove blk_freeze_queue()
      commit: 54027869df83aceccd18c4a799b263a2b318b065
[2/4] rbd: unfreeze queue after marking disk as dead
      commit: a471977780cc8ba809f84e3e2289d676063e7547
[3/4] block: always verify unfreeze lock on the owner task
      commit: 6a78699838a0ddeed3620ddf50c1521f1fe1e811
[4/4] block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()
      commit: 357e1b7f730bd85a383e7afa75a3caba329c5707

Best regards,
-- 
Jens Axboe



