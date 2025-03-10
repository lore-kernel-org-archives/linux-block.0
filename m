Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17522AE74
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614645; cv=none; b=WPeNxYdCaFM3NI733rrWKbwsWe0QzrjnbhAP/s3kQBHq0VU7O0QxklPnuO58c459wJlS/n2IEOgx7Br0h9YSMpoo1KOZH02bjLnLMRES5Ke6UEOV/WVTEKDqoccfDr0xVsl+LIh9FB5vPM9HKor81qjZrm2g8tngbtMh/M/EXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614645; c=relaxed/simple;
	bh=Nt6jGYnFerGzC4w0WINdu/ZuiGUKXT3Rri0U5ZDZSy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ODwIdborPsHp7P9r+CaNvuFOx4wI9mkJWXG3Tmgopj/Cr4proXzgO5tii7DShxv04P8qkavvyWHNHZECW8Ba8ndSKOGYt2MTPhlSmV+jBCdnooFHPkzqhd6L+t3ZHoWBFdxMvP/P0o3GnINQdxFVlkvPTDnwO/Sci9JIn8TGOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xYhlOm7P; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xYhlOm7P"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d04932a36cso42494185ab.1
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614643; x=1742219443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuvcGo7WnKEPEQ0sWQsDW7WhCqe6qPP+dOCAPRfTNpI=;
        b=xYhlOm7PRB94cUSlYVoQlsPA8w1C5S2TkGnoFe1jTfmOaUSYLQ+kj7eF5hySuPu6BN
         zSuvTxx13XxRFuy9BGGn8FcSk7/AER3JdB2djKeoa8F7hEsSHu16/KDttYLgqn6RCv9L
         /3NadeiIcSn86Ms31Bkzu3LGClJQdBNebxL2Jpm2JaihyIUgQbBArv0dypfmsROZH/w3
         Pdg3Oe6V4PfqUZCtOcXM0quXgXlQ5mKk20NZH1vI8qRNpK0iXMPx5aaFpVdjXc45Fkao
         CyAIywRH0NJelakg4O3uC/OhS1RRpe6xhc3UcDccCJbFA9wt2WyUMb3pzdTdP7xWNSHm
         hC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614643; x=1742219443;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuvcGo7WnKEPEQ0sWQsDW7WhCqe6qPP+dOCAPRfTNpI=;
        b=ConRaHsj56L3dRqLaiM96FSJov/MXUIxyqlicFn1EXDpr77Qa/vZ2P8nFcQaCwtR5I
         1u7j35LTJVoXay45A+nJHmxk/BDKTcb/FtpFc977JXKBeYpNOo/UTz7EvW3s8brCgdh3
         yICTJIXN+ZkytYTOmTYIAX1HcBh7kkTFT7xOTWGhh3TKXJeVKXk50OcdUGbxxkWTBfbr
         +1HZdWzg3ge45gUyXhWk3HEyh9c8nGzld4kTcFNVhWbnsn2Y2xfOT31LD6BLXSSfH5A3
         gxOgIMwMVuYKu9HCldYnn5ETkZqPrxmMk+8ee8T+lP7E8cGpZgTE7dRi462bR3m7PhTQ
         fyTQ==
X-Gm-Message-State: AOJu0Yz9AHpwiGTjyFjTWD3cUiRuc+nEihzSeE82Lt9SxP07nvllPbGT
	hfC9zhzo2yr1V17g1RyMz6BMbVKqB0SP52vsSbz/kvgJzYZSbEQFb4doo1ZTDzo=
X-Gm-Gg: ASbGncvemwbYXDubm1hAbBv28K1WeSHWscqNPvw2ZCRsibfOerRmDR8hT5ZeqF5kcsn
	/0aJDrG+ZySlHzo4cPG4fisUfZqnXBGm6qMHyKzTsAaGrbqaTTFiypfT5dewJYKWZhAIn/XNmPS
	E5t2qVkqXnJ1Oad2hLpEyfN2EJTgvTMUjYi/+7lffHyJuSyuA6fGw05r6zYu6aIUI43Hc8BjYzT
	9QonhA/wmPEiflHSR8eiiRwruSKRl9b5ARhJ4oGLn7CJZ3QsvkbHnmVtDkIpNF3fXvPBdd/39LG
	hj24iXjLyn9rl7RzA1RAbZxtpRe9MjraVdM=
X-Google-Smtp-Source: AGHT+IEo8mqkIPXY7WjBbBD8LR26Swh+IZa/UDJkWe2PZF7RXXlZI/YEDehOmzMngNwvJJ7XQfPk0A==
X-Received: by 2002:a05:6e02:240b:b0:3d4:244b:db20 with SMTP id e9e14a558f8ab-3d4419296b0mr143219995ab.16.1741614643514;
        Mon, 10 Mar 2025 06:50:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b511091sm21350915ab.42.2025.03.10.06.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:50:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, colyli@kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250309160556.42854-1-colyli@kernel.org>
References: <20250309160556.42854-1-colyli@kernel.org>
Subject: Re: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks
 whether a u64 variable < 0
Message-Id: <174161464217.178937.13356549396893564854.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 07:50:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Sun, 09 Mar 2025 12:05:56 -0400, colyli@kernel.org wrote:
> In _badblocks_check(), there are lines of code like this,
> 1246         sectors -= len;
> [snipped]
> 1251         WARN_ON(sectors < 0);
> 
> The WARN_ON() at line 1257 doesn't make sense because sectors is
> unsigned long long type and never to be <0.
> 
> [...]

Applied, thanks!

[1/1] badblocks: Fix a nonsense WARN_ON() which checks whether a u64 variable < 0
      commit: 7e76336e14de9a2b67af96012ddd46c5676cf340

Best regards,
-- 
Jens Axboe



