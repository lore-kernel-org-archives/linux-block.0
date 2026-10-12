Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906423ABD8E
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831082; cv=none; b=SxzC0bhakoc5tCIb5ScycKtdswZxayueatvtXKAz5LvZ6xxL8XrmJLXZe7ISt1m7noyDV6EEchgXsupt8AsfM6HvQFpjA2bKxAv6Q/FEJDJ3WkQh4ZwE62/tyguE6P/4ynMKgQQsWB0TikSFYoAxQSskwT1vaJO8veaI+psNq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831082; c=relaxed/simple;
	bh=tV93B2USbWXjjDndwiQAqRO3pt+vPvH7KAQSCxUonWM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/AhgoESjrfgyIfnzfqjvUlZSADOq8Cflil0P/fHakh+cQxOQHJ+x2GTAYmnZVniNB7beTavUFfjNzKr/F3ydh6KJVokpZhkc/SBC/pMbIZ+V+DLJhVtUDziNlBykxQE7cL31w43Q+5wuLaxT4NbtkW5hqQdJ9ABbhHZ+pk/v8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kWE3T0e6; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kWE3T0e6"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1433e7b057fso1505172c88.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791831080; x=1792435880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCiWRkzKBlt1QS3CoF+R9/K21AAXjdQ5fMMqNpuft5k=;
        b=kWE3T0e6peJc0+CAnW4iUJdOOsMw1/vH14krHqomruCKhaAaAzqRor9o5u2ZUdSQ6k
         Ep0I84FLdi79/fVA1aSSsGEZd0I4/mSqvJ74eBNCfPKeA6bBXetYQJ364DyNRjbYGp9D
         ITxUHYdFM1ySOL8E/67BVi8PDxtKfnNF+MPVXocQnuZtAMKUr1xLZGSaedjn6lFlhkoO
         Ovp1YhARaADzjFet+xiuK/YIP0PaBbC1aTvu/qA6KYgle7VcnYysD9Xkd2JtoTe5t6Ly
         VcdaqxiHpjPdUE+HTsFVHXHmga3p8t3zOmb96WlCy2dJmOAykpzEMbBQKVF/AfW4Z8F0
         83nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831080; x=1792435880;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCiWRkzKBlt1QS3CoF+R9/K21AAXjdQ5fMMqNpuft5k=;
        b=C+QjDZ7i1VIZ1Y/RpjSiqlsDAfJkCaDKNu+65cWxZh7htds71mDp/Mc3fhMPPbrk3B
         DA6YScNi0T2HGnBhP00ei8wYs8JFaRPmyABCB5L/KcwrQmVNWaQH94EQo0SePj0SxL/T
         8o2pgPCXi597JEu23uXljzkk4vgNOW9wq7frwS6I2ewWtrAEnEVX9Y/cjTyVLSCRlbAQ
         3Kv2neUnGcuqaacg57TAcFpeAr+7adGGsV7KlPVuK5nZ5MoHoz711xLXyw1lJqfqsnNQ
         1KSyZ+zuD3Ni4v9Yosw+UYW8rn6O6Ryx276BMcIZTQV4T7CmZJXSJF4ON9oYcRk0oC+w
         ijpg==
X-Gm-Message-State: AFq9FYJxFoScdvYqj9slVfAt9Ud6gYVkGqBD4drg/lXiHZlPLCMp858z
	pJGRqAqzfaY4r/h9Kwbz+OPtU/8UXng+3ytVfpbyzuH6pxs31JYbsUINxjL2viGzYuE=
X-Gm-Gg: AYBFou3koCVgnI6nhR/x1PDDvBATSRtijGmAsv6DA47df3E3FaIIKJ2FINlLJ31qCwS
	CMI70wp9jqy/LE0YetNbdXYO6Pm3oFgFwroec9aN8GGRDm2mCRaHLuXz9UwjLFU6u19gx7UpRR+
	/TcanAobf1FcNKl7mb+A/C4Ih762X8OumEEL27zIqHXSbHKwzm7PqPLprqLBOQ4f3WgMmP3yOql
	LKFMnix1yVx4dAihikYFnNoT5NbrWLodx9owETSyOYt7Gz5QrCtWSZ+oAN8SmKHPULVBEFyoCZp
	v32lO7NRdT5oNywLLM55rH4tGPIFgs9JeM8x+5pJUHN/kD7SIbHuQFwlU1cUuJlz1i85RGHZMZV
	6qks96HJod0XrD2a/ESzXhlMyBpxdf5Y49/VE/aVldo8l6RRzYHLcy4tx0ToRZt0brQPEV3CkWv
	0zAld1GDcnTEppBL6tKyj/6JojHRftirBiMtjv8YN+8/k71P37GQQmAMZ2s7t9wGXMqHF46Pvzh
	JIaIPhgDOPtCGCiRI0E5U8T6TVLijVQjrkFoxjOreAmi6Ax7bTH3w0DFQ==
X-Received: by 2002:a05:7022:296:20b0:175:c19:93f3 with SMTP id a92af1059eb24-1750c199477mr4258063c88.38.1791831077751;
        Mon, 12 Oct 2026 11:51:17 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm41738221c88.9.2026.10.12.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:51:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chris Mason <mason@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
References: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
Subject: Re: [PATCH] loop: remove support for swapping loop fds
Message-Id: <179183107703.215281.4436365988182227970.b4-ty@b4>
Date: Mon, 12 Oct 2026 12:51:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 12 Oct 2026 14:47:08 +0200, Christian Brauner wrote:
> LOOP_CHANGE_FD swaps the backing file of a bound read-only loop device
> for another file of the same size. The comment above loop_change_fd()
> says this is for installers that want to free the original image and
> for HA setups that want to switch to another copy of the image. When we
> discussed deprecating it in 2023 (cf. [1]) we found no users at all:
> zero hits on codesearch.debian.net, GitHub code search and
> cs.android.com. The only things that exercise it are strace, LTP,
> stress-ng and blktests. Everyone agreed to drop it. I just never sent
> the patch.
> 
> [...]

Applied, thanks!

[1/1] loop: remove support for swapping loop fds
      commit: d4fabede1da0be116fd4cbd34ffd275e394526eb

Best regards,
-- 
Jens Axboe



