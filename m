Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80803803FD
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708535; cv=none; b=pepI2KOEctsnzhRHrOqqyDGFEbdTyfrpE9MQDEb0JxVYbieCtdXzkCpyFBqQy13f+i1HIL9VUP1vLL/I1W5jYeH698M+aCqRWMLB3MJztkHMhT2VQ3pWhAZ/x/6M1Bu/9+2xCxYV5aAhPOzSfWAzSSqvqVCPw9aRWSHuYLrfGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708535; c=relaxed/simple;
	bh=f6F4EhoZj24324+puTq+VZPbBYEeEx8oWAhGk/ajc98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DntfCGB3c6+oSWKQ/KHjAc07cVAYGxkCojrFQshgn4xfXPsgZDPMCzreBqNicv+fa37Gc9VI0+DXQfu7jZCAVSylX/4yUhWcYMrs3HFkrlm2DEGDU59E589ER/a9P+IkjDyAwznz8KlXM4piFMVzcYo9kV0VlGShrqJAbhOc8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=guhKttLA; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="guhKttLA"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so4799029241.3
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 03:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772708532; x=1773313332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7ZYTi8iN6rB74yV+/RNBu/hYWTLbR3VP4Gi1i0glgU=;
        b=guhKttLAgm7IYvv4/QQb9uGyiJoYCRA+OWBKTS6SAhq7fsf90CLJK7YJRByyLMhsB6
         l+1JVkIS6WhL3lG8KMNJEL96k7c5vGdHaXEfsG5pmybJkEW4PW7IiGX6pq+e/C8UzcPX
         1/AZId9kMMGk11wwuuLDuvwDQOTRNNLksGZjTuj/0TC6zU5M9JUNm79kRTQs66eKdRTC
         kXRbbETzd0/fPRRvc8x3T3QL9I4BkcERIlqGDpM8wU6a0hl6FvzU7LsXotUWPfKPpB4Q
         NlOyHfEam7i6/PgkCFUKNEkVvpOAEKwZN1aFk787dj9ujHVxtPWWO/WGtVoLo7ATqwts
         VvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708532; x=1773313332;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7ZYTi8iN6rB74yV+/RNBu/hYWTLbR3VP4Gi1i0glgU=;
        b=k7mkxBI0P/YgIlKPiN8QgwKIp77QrzqBbH/3FnQIMJBQgojIn8+wDpgQXM4BcHsW1Y
         UrShh9W+bknh4rz5fr9a35bdE1wFgHrpSoBqxG7OonXajET0A3OxJE4lJ9tqZbP/K5FZ
         x2eCzyOUMwUJ4AS0W0sp3rIT/Z+yU4EYresnkVqvyGYpZ2voFIJUKjL6Ic7wzZotgWjh
         1+K9kxnNw8fdjxLyPl9kLMGcX5jlhSOi04pegLLnrDJKl5Fgnvrcn9hnMotTHxPTSptR
         +4L24KOOH0LQAB5tImTq5AwMlqbw/kIjUwLYD4q18QAwnja9tsLNsiQvn3XtVIrUh4rD
         55Og==
X-Gm-Message-State: AOJu0YwSz4bGdC2xDD8yEK9YYDEj74+zM+bJLORANgu3ZrsQG9YpxCli
	NP1Lx3Jb35m5aH8rtZoIu0d/CiSCyQffejunN1K5g9HGiZQKy7Q9xFMLievTMqlggoSFdMnf2Ct
	O3ncBKSo=
X-Gm-Gg: ATEYQzzCMWJloBvCG1BQ5UpuXrqrv7zdERlK4uHNbJXeQdudFBInhd0L9M/J3MIkLpU
	eo8HIaDUgquruGqBIy4bI1X5XQQiiFLR6cBUwI4NIZRfE1zXATStMRX4qrmEAvdwPKDsWQyt8o5
	V5leonSaq8nZ8FUlQDngshasuLxubShQG08NmQVsf72oIqkksgxVKw6FpFFwm9PL+XhvHTaDCFO
	O7UuSXCmuZShFqHXVhSY47mUIT5m5u+/L0n2f5bdD4E2yZj+OUSkk21ukEcjYdNkRAJG8FdYGMj
	gESEhpkDAemSTIW+6CGF/blDPhIDPWXFPxhb+P1C5zKT9u9tQ8wUWG7utMuUNVRYrIr2UDpokRw
	XB1tj/NtaoTUUMbG/Udy4tVSWXWZ++MpTpp+EFJFgsVhKyyIHfiVUrtYoqZ40akyzdw9dC0gkG4
	26wKdGySBtLgQWSZLZQuT3TgH1JkHS/Fusbs4QXqfY+5eCtx3LOX+f65EsJr/yzECCqVSXTWqFt
	QcgcREt1kq94ujt5jqdM6mNJB/pq66OA1K5xYnV5/VFt/UZbsQS3w+N
X-Received: by 2002:a05:6102:2912:b0:5ff:a606:3d08 with SMTP id ada2fe7eead31-5ffaacef938mr2403861137.17.1772708532335;
        Thu, 05 Mar 2026 03:02:12 -0800 (PST)
Received: from [127.0.0.1] (syn-071-043-216-131.biz.spectrum.com. [71.43.216.131])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffd1d8983dsm602937137.8.2026.03.05.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:02:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20260305031550.1161328-1-ming.lei@redhat.com>
References: <20260305031550.1161328-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: use trylock to avoid lockdep circular
 dependency in sysfs
Message-Id: <177270853112.429313.1522541861812895343.b4-ty@kernel.dk>
Date: Thu, 05 Mar 2026 04:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 05 Mar 2026 11:15:50 +0800, Ming Lei wrote:
> Use trylock instead of blocking lock acquisition for update_nr_hwq_lock
> in queue_requests_store() and elv_iosched_store() to avoid circular lock
> dependency with kernfs active reference during concurrent disk deletion:
> 
>   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>   kn->active -> update_nr_hwq_lock (via sysfs write path)
> 
> [...]

Applied, thanks!

[1/1] block: use trylock to avoid lockdep circular dependency in sysfs
      commit: ce8ee8583ed83122405eabaa8fb351be4d9dc65c

Best regards,
-- 
Jens Axboe



