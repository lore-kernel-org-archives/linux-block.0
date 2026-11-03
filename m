Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716269;
	b=YKDHE4iKa2tp7iiK88Z5+1axAuNYsLZm5Jtbi0ta+AK8TlI+UqRX8jU33MscG0jJYrhN
	 ba9cmDI+ZJEyaFXckO7r3hycLEG4l5s8rrlT2snyAPF7aLcGOY8zDaHAT4YpTl09Y8ymv
	 3AtVHjq3myPYURb1ySqeK5AeUsXpCnOjVlNRuZCunNKKiRHBBbCT55f1TCIzFmQ1SyJtZ
	 RDiaxK1VxH/OOEqomXJPBLbY7VssXYjem4KSR2jh1/smwQq4HST3qHL+2AU9OAjgqzhtW
	 Cptd3Vb3pC/q26SgnEMUzgwiqrD11a0rO1f9tyjQEq9bxO2Y7nF+JJDy351nvsUE0fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Ysaq7Cyacxen/YvlMfVmj6mDX/MD0zdJpY8pywVDXcA=;
	b=1QdQDn4HjpHVneWKPYatC81BbM3sDwxan7yfILPE4RG9U9GS/XM4WcUWayIIEwsh1duo
	 vUahONevsr5YvN/qUbj7XaLSxdAW3egx+9lkivo1yGIIIVdb8loi4XnQU5EN6jg8aGq2r
	 Tlbn+Vjx0C95jBpH6k3fghEV7K3rxJpXjH3p1HqywOlBJ++jLEf06vCpL5I8GTE3To0pe
	 G5PzdRe5M5VbsgOpJ08vmJhwnFSHS9au2lQB46DyxeJiC60s15Q+OhRnqov3ayePLZvMH
	 hyW+TCUWZ7P8SZG9WxzyIN+weq6QS/C0loALnz5pQCxol6AQKy+JrLd3qHT4qaj5Zow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CM4B8dLW;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08D606D824
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A08D606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CM4B8dLW
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4164916c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716268; x=1794321068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ysaq7Cyacxen/YvlMfVmj6mDX/MD0zdJpY8pywVDXcA=;
        b=CM4B8dLWknDSMXXm5/cxWMlEVn1KQIceffMmr6Pvph7i4TYpB3NdVvYxXQKTYkAQOh
         iOpQQz51Z4hXO0in8yjlonUU7zMuU5pvfiytFDKECXOhLwq1WfOi0dbgUzTUMIWBAKCK
         89gUC3B3xYYTnxXs17POZzd70oHVL/QWRiOqftXLXvb9z6y3SmO2PahjI/uQJSfp8UQT
         jOzYJiSRf5HjvnOTgkXK34H5puHjVxugBzd2EI59KBDu0o0E/EW0zwRqQm4FycvJtBd1
         vy9v2YbHy//8axspYnA3PI82eE7dUr5L5qvFqREzA3MiaZn2LmeXp44F32dNlLocurRy
         5upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716268; x=1794321068;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ysaq7Cyacxen/YvlMfVmj6mDX/MD0zdJpY8pywVDXcA=;
        b=NG+OXsKU/pTquxSjsZTPFOOB/4HUgBv4iLljHuHK/haC8UpbcNA9fv41IAwXnWeEOj
         Rn65itFchVtI8tCxEWfLz8/kvF1tXtHDJE+on6GJqYQJ5U9h1LoK9x+ds2LvVn/znGzg
         n0enkoGBKH1MsbTdpGG59pfQZf2jnLlJipgs6BIS8IJoFbsmjNIpuxq8QEAnDHZIzi7P
         xR4AGYNptDRo/pHUlJpI9LFKgHgg4tq75wYZOrUJ/GiWhiyDKoR/UcULtnLIMnYAAQWb
         KuFfk8uznH4s7Am4SPu72Rtp7uwQCDdTwI8LXMtTQxN8bhTPJzQ7KYmXpT7aFQW+zGmm
         Hbug==
X-Gm-Message-State: APuU4Z9BwPJ76XmcDtoPagiVHxnnE9D1q6nZx4J24c/nZWMUbB931O/u
	HsvVvAMGEnjAO2NQSdB90x+L4hmFFpxULEHvM0Cpl5DTTtErIxaEygihXU9bMcq9xO0=
X-Gm-Gg: AYBFou1XTJEuhiQghWNg64shMedMN5jpQBFX16Kozb+cDa6QJ1uqOZCA2XxDS5OAwuU
	W/TAykyIdzKAdj8C7vrcAWOugPUgr3mgD/+Mn3+WitAFiKbkVpn1tIv/kmvREEl57o5Qp0sZEOV
	C/zAjrPLPxR6Bidnhdl4LmaFBhaSLYAzt+2p54mAj6Ju92ZJV18kVR+BtGJWw27kEsddj8Qfk8x
	q3rDL/sXDxtUNg+Yy7jFCOpmmixymXHoCE9wtTKVaLzVYtRbG1XAi4zFtYf6W9T0rKh/Fd1OmJi
	NujsxQJIvOX73qGazGI+vKL4tIyLxcDeCVe68NMZjlXqc9W1G2HodECuS8Q7qyAqC+CpKKKdAZo
	01ARjH87Bw7zzO8oRAARz3CXVawXVBdYT6wgONVeg0/68TLYl0lM+RL3ObCkOb2bjOZDaDbix1t
	kGXD2hqCQWMTl60ojYvGU0R7Fv6D39D17wEqpVXiT3bL4ZFnDcQsLt6fA6u4xyNZHoF5VqpOWEw
	kLztqpjw0RWCua8LXNQDyQY+6bZ2DKkGv/FjYZ+8BhMfHDvfodama6w65AUG+Oeeh34IvEvDTBv
	2WDmipQNi5XwqdRlp++HbxndKiilTQ/PqLx/AVaoSPfiqqS/ESWyV64EXEhKegfXZtG+W+hb1CR
	tSti8pX1XXYclP0kPcYt69UTIf7Vo5BKWMw==
X-Received: by 2002:a05:7022:f105:b0:168:e942:4e62 with SMTP id a92af1059eb24-1ac601d2f3amr16617735c88.40.1793716268368;
        Tue, 03 Nov 2026 06:31:08 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jianan Huang <jnhuang95@gmail.com>
Cc: linux-kernel@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20261023092611.116795-1-jnhuang95@gmail.com>
References: <20261023092611.116795-1-jnhuang95@gmail.com>
Subject: Re: [PATCH] blk-mq: reset queue state on scheduler teardown
Message-Id: <179371626714.3691261.13847962595068110458.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:07 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 23 Oct 2026 17:26:11 +0800, Jianan Huang wrote:
> We observed I/O timeouts with requests stalled in per-CPU software
> queues.
> 
> The affected queue had no elevator, but QUEUE_FLAG_SQ_SCHED remained
> set. A failed elevator switch can leave this state when falling back to
> none without clearing the flag. With empty hctx dispatch lists, a
> queue-wide restart on CPU4 would skip requests pending in ctx5/ctx7:
> 
> [...]

Applied, thanks!

[1/1] blk-mq: reset queue state on scheduler teardown
      commit: 3a9892bca4dd0182db61702e131cad569b1d71e6

Best regards,
-- 
Jens Axboe



