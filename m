Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E77D07D
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346973; cv=none; b=lon1fAReFwL7BJoWtUApPH67yCbO3fflzVDqPr18f1ZiaPPQrzKEWouKZjWaNSzviTUTjj7CvGFKNYXkrcFaHHshjjqh/piq9Jm/0NxFXQy0KW0x1pGZB5srcX5vFjgdR6mHre0c7470mK7vvWlUahbWWAz7eB6R9O7hCJ/KNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346973; c=relaxed/simple;
	bh=F+9fpGjgGeq6MI1YByL+VhqEKSllSRlX7HiYvt0dtMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jqN7Kic4UG4B+1JnszWhzhfmxLOLu5QEjYyn+EjFjKotFPcmjVwQ2BQMZIjjpeU0Eg+e0xi8LY/uP+6eqW+Olp7kxUbKAVOkaWlpP5pHmioZrBu6KfZBVOALQbrNqoPIs3rG93Ah+WpvrBc+Ywyf3CC8/kmqjNnVztvTxJC8vqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nRi5eqnN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nRi5eqnN"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4330dfb6ea3so7846935ab.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346971; x=1764951771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLVY1fshHl9pfg8ldxf618jddcGHglnyC/9t/w2wDRg=;
        b=nRi5eqnNQyND0Xs++Jz4UqqcMqQBbtMu7XgadV8A8Hzj0go1mumJlxkEvi956CbgX6
         M8wEOyym9MTA8aek8dKd7yPmtPfZtessFoCyKpk3snWaLL1pHP6+rq3k3yI+q9YJhLAG
         545DeEp3gCCEAhTtjCI95YntKV+Nzotuqb/HazXwTySCrFGYiIAT7PVYhYJC1s7k4EcH
         q3yJXEpwrwkpgBD+GaTD1qZVnLmCB5zRuiLDYwd653/I3+yJ/zQxLioHNikVQ9FznIOk
         Jfkg7v2BQzQsc5eLqZZ2qM8tUDpYv/f4aolCh+DotgLdaxC0piHagOWYNw9HrUhKAKND
         fxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346971; x=1764951771;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLVY1fshHl9pfg8ldxf618jddcGHglnyC/9t/w2wDRg=;
        b=awd+CQrH5tHWMrkEXWO4w2JQdyTTF3PgY+IVpSG6NYZoL2qBf+HZRvZduDvbSJnInc
         gPhvqPEuqmtVCgjKBHfRbyR3JXDgHqz7OTe+Hk56B3whuBzYevNpz5H8PAO8IAuvz2ny
         LXMhCqJdVj59OEf/PTeyi/RwZmnkY3Vtuh7uPT1DgHjZPqmgr5R2wV5/DgLZ+z0X3Nl4
         8jz2RmA36RmZZ9/+IjjNb7ALSQ5Ydhwq8bvRXzTeZra3URnONugtxl0KYNSSmCqx2Ve+
         tJJ+bFlXyevkz9Ph7vQ5oTM2VYqNWeVsZ7zI29BqplC1kAmfgtkWol2RCKpu8W5HQ8Td
         QqMw==
X-Gm-Message-State: AOJu0YwwfHxWx2qjbpmUdI2Bigix2CK0USf5RDxx0SkZ+8Zwx2tNrjb1
	5SH5R9jqOHnxqp2GzJrLHESkOxlYRaXuKoSg3fKq9o8uVZG7KQZDnnFuo6Ebp0a9+bEfgqSOIsh
	8yeou
X-Gm-Gg: ASbGncuSHMIMmQp8ETKuG20Pngzvj/3cydYUT5MGOcBMZexCd9XOBM0smVoNq1JkNAs
	ZPu7nzJsc22Yk1xMcH+Dl/sxUy3ArR7DaZ/e1zvTyq7oi9299iExHU+f7l1fnqkbhftDcLErW44
	w/J0JxNq7oGx9JihdBib3TaOMv5Bs/SRmnvn9e25t5rbJ1j0EZ9IURWsfmUo/263hX8aMZg8k59
	v8L6P8d/C6AyXIecpkN3RSti6cu7h/7znd8lnrMJOBp+wc8cywezpNE0IlwCxSGYlAz1fijv5Ee
	ks9iX22p8SssAJOUxRc59rsxgjRG+qsdKUKaQdExlWzze7SeYj8Bjpn0k0tLWaqAQ49D0h4b/gq
	DE0ELEuaAMrR9b5w2uZV5194HBLtoeFmcJiwbBv5mHPMLh0ldMHgeqoD1wKvmDZcC7vPvOgMoV2
	fX0iQ=
X-Google-Smtp-Source: AGHT+IH4nSldHSSclbu6g9v71EHfLTh5hJYlQet4vJfgMRLAQtH3UKNDEImhdyK7H2OQsiwuEa5hew==
X-Received: by 2002:a05:6e02:16cd:b0:433:5736:96a2 with SMTP id e9e14a558f8ab-435b986a802mr197550485ab.12.1764346971035;
        Fri, 28 Nov 2025 08:22:51 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc78113esm2309257173.40.2025.11.28.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:22:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, 
 hch@lst.de, yukuai@fnnas.com, Fengnan Chang <fengnanchang@gmail.com>
Cc: Fengnan Chang <changfengnan@bytedance.com>
In-Reply-To: <20251128085314.8991-1-changfengnan@bytedance.com>
References: <20251128085314.8991-1-changfengnan@bytedance.com>
Subject: Re: [PATCH v3 0/2] blk-mq: use array manage hctx map instead of
 xarray
Message-Id: <176434697021.231521.5489082187956014838.b4-ty@kernel.dk>
Date: Fri, 28 Nov 2025 09:22:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 28 Nov 2025 16:53:12 +0800, Fengnan Chang wrote:
> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
> an xarray instead of array to store hctx, but in poll mode, each time
> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> introduce some costs. In my test, xa_load may cost 3.8% cpu.
> 
> After revert previous change, eliminates the overhead of xa_load and can
> result in a 3% performance improvement.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: use array manage hctx map instead of xarray
      commit: d0c98769ee7d5db8d699a270690639cde1766cd4
[2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
      commit: 89e1fb7ceffd898505ad7fa57acec0585bfaa2cc

Best regards,
-- 
Jens Axboe



