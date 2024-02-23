Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F5225D7
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699609; cv=none; b=gCiep8AAhxZANuegfm+AqXVHtqdHJOrOZmAxz2JX3TB8o2Q+kElYkH3Hbt8J7SJqlzqrEShwtmjOHf4WISTtakDae01HEG0E5Sk1b3m3uqg+U6+BUE9Fv1RKf6GV72J2dW+6gsL3OySmK9pNugyGlBX6PujoiCbU1bScIJfsKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699609; c=relaxed/simple;
	bh=Mt1B9Ji47lzCrOOPWA7S+MJtKTeUuc/gx8Y/yssgYr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jucnFZn8o8ozuIQHYWukQvop3hWTXg8zP6oMS9CFtSUuAFpnUfwnwUhAJmcQLsC//WoaKLs2xbfqp5kmUurrUgYXyKWrERm8lpkCW2ONADBSjsMdzM2xKKwoYXSmBw2lbazVYNWR4sycqrRY3RIlQBzDcL11Fr01df5dqLERYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G9eBRSqI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G9eBRSqI"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e33db9118cso276409b3a.1
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708699607; x=1709304407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1MeBTQpUH7LY28h3Y8eqPCZpbMXd0Gt2ZHaY0D3V48=;
        b=G9eBRSqI9Coalqi+vdZINYU6WUS27LFE4ub3BFGaCxVAqsO1aQyh1OTtXtL6jjcOUe
         8pg75STt9vHs+9OLKvtY9J+vjQMKBq6HIgz4Kxfxu/lrjQ9SGQVZtArAMJavCNq+oIBo
         mb//ZjbTOYv2G3vVjRKBTVe8PNKa7MLpafyMLzvJ+VZabAf8WHZUOIHKGtvW/YkzXK6H
         +7PABVyqkWCXwokDQUS7uZmYorpy1P9jU4sg4KIoENbicAjDRlL3VhmOKYJdUnVJDYeK
         Gs6qwzPhxyPvEY1YdTrjIzqxQx5QgJT47mzuj6bYw1yPRbroMH3v9vsyNzk7aLeF7YGF
         e9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699607; x=1709304407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1MeBTQpUH7LY28h3Y8eqPCZpbMXd0Gt2ZHaY0D3V48=;
        b=MZieVmltygl5/mwGBSLPQvy+EJ7DHa+fFLuwEZTvpsqXMKAPWgrdNtbuf7Zql6S0Pj
         uYNdcWSC0pkb8+NOKbIde3rKqSxmJWTTNxbVsDXTSX3KgKck+jDW8U3bOw9QRl0YGP2V
         ghUzlW1xmaxH9mIcvIIsFlLNzYbYFb9l2kHJPJVP29L8fqUegDJOhtMWtRUMz5hv7HbX
         ZNO22WuTZxXC3c6mi82oMH1gKLg5EHI6wl4NZDdQTlonOT4CEAtfJv+aUyzp/2GIwy9G
         S5TH3vqVAD+RxC6wdOdR2bEgyx+KTMed9p93aWa6r4crgrQd/KdboFx5SNMo8v7kJW/K
         SQOw==
X-Forwarded-Encrypted: i=1; AJvYcCXvVzlSkegIR9lMqtlQXCgtFGGNWojbZj/2JkjsCrmh4jVwcnDPip8/8f2zPVBJeLcq8jDHhnNYNKUpph/nEWCg18/xnuXPOi48y6g=
X-Gm-Message-State: AOJu0YwLGO3bXwGABnbFC1hJUgsgOiJTxRyQ946HJUGA8pQxHChU2Mw7
	fTpOUszdVg8gTxL1KfnYdjV3zsBpyKQu7FQacAXP/6ipTQVnHOyqfDv7OSFaUkw=
X-Google-Smtp-Source: AGHT+IEtp3zS8kcrVaMAPfEaY3vM26FdkfQGqjIjERKuZq8/CcH61Rby2r+bAd13RdEhMxoqmwq8jA==
X-Received: by 2002:a05:6a20:3d01:b0:1a0:debb:f150 with SMTP id y1-20020a056a203d0100b001a0debbf150mr85090pzi.2.1708699607496;
        Fri, 23 Feb 2024 06:46:47 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7649:34b6:d6ed:9c67:70ee:2f8f])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7808d000000b006e46df9f1b1sm9127924pff.9.2024.02.23.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:46:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai3@huawei.com, linan666@huaweicloud.com
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240221090122.1281868-1-linan666@huaweicloud.com>
References: <20240221090122.1281868-1-linan666@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix deadlock between bd_link_disk_holder and
 partition scan
Message-Id: <170869960618.48825.8696438313079266889.b4-ty@kernel.dk>
Date: Fri, 23 Feb 2024 07:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 21 Feb 2024 17:01:22 +0800, linan666@huaweicloud.com wrote:
> 'open_mutex' of gendisk is used to protect open/close block devices. But
> in bd_link_disk_holder(), it is used to protect the creation of symlink
> between holding disk and slave bdev, which introduces some issues.
> 
> When bd_link_disk_holder() is called, the driver is usually in the process
> of initialization/modification and may suspend submitting io. At this
> time, any io hold 'open_mutex', such as scanning partitions, can cause
> deadlocks. For example, in raid:
> 
> [...]

Applied, thanks!

[1/1] block: fix deadlock between bd_link_disk_holder and partition scan
      commit: 03f12122b20b6e6028e9ed69030a49f9cffcbb75

Best regards,
-- 
Jens Axboe



