Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607365;
	b=o5W6EplTPjsuicLSttTLZn48ig9Yy4S+2wRUSRBHWcz7dsCMlJH0y4EG1n0SA6tAClQQ
	 ZRNX2TTxDqWVHC3FTiHM5KdtxkVzfgDlapzkqJu+jKLk1IdBAm+ofd6s9tbeAeyiIDFD9
	 tkb6GVTfwI8qhYy8Ly9h6a6ZBiNBD9PZYucTwAQkoVgv0AfHMk53hWPAmXxrhfXWQCWaa
	 8xmdIOlyL2vbEuJoxlVZVA+KgbcNG2+lass+Jsd+mU2Te/fG/+ReyonjG49/uWdOdCzu3
	 za5AEetwdgEW60XWlAxWKCEic4KP5HtcsJIvT9FtKRH3scPIWmuuQIrwyy2hJSgx5Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
	b=UcBYIdGpMD00ngYjxfDE3WSeeIFQJUqw6ppk/0Xg9YgucxxRfdwJESpvWCnFPkWIWhV+
	 8HCE+vZVu0MVwDbpGPFv1D2VarKLBSZFp4uEe1oe+PWzWuZI7vULTN3LEmdgDS8AwLvfl
	 Kf0w7FOIvdjCwT+a/HZxhpYzaQALZbSKLNZUxXSUwHtmpXSKgFzSlW+B25ZAB5iHICqpt
	 7OoikyVcBWla0zu2Pk8pyEuQvdtf9QJDyJYn937lWlad6cgv8e+S3vJ+3luDf8ZF3xw+H
	 9b5IGadtEEz9O/ArjSpphGmBb450Pkz+sfo8nfh26Ok8t/WVup3vY11D7dto74qb3yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MxhT712Z;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FC606A329
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 22:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22FC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MxhT712Z
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2478838eec.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794607363; x=1795212163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
        b=MxhT712ZOs+9JNd48QhgsCPVX4B2Me3T9nNcqh3+3RQIFoeMHmW6Wl+WlG2eszHG7G
         W4bGVTq7kOwx0uGrHE749/Tzt6Y9ubwt7FDE57ZwQZaq+3mRm8NYBnSD32+sxDnpYi1J
         dgcSCrMRfotrVHqI5i3Kbi+QCZDRMIolbVs9aA+B1iC+BwuNhGViHLF3pMd8wHVK40kr
         JLrUUdyWvqq0c1RzBf2T6Dv00FUD++njrC800eHkQB4c5nh437/q9qqnhrvfqYN5tBqG
         O8kvLa0TcHNt6kJys2AnCLSbPPfn/+e8mL6WHWyTzfXZXIDcVL1HTOm9QCxHfoUZRXn9
         yLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607363; x=1795212163;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
        b=ZPBTEY6GM6OTQos5BngHVwztH122d4qkcRVRXeco66zpEuTloCgal4pGDvqImLzpVf
         mVcHjECctQ1lfFnusCyezrjVAHB/15DHt6Sxin5HHP/hwenGd7KJ1wsuCDeW5loXcM94
         MJgF/ghrvileTCAwWR1Lx1N3RHQzc9sxE4fPz6zuMZRDDOr9zJSKdL3V66UmbcXCamaW
         i6N/RU+ur+OMS+cgzKLQyc3o3uI2gIylIV3HNWDgDIYIehamZ+sZXOJFQWPU9y3iH4XM
         45Bm92iuQPb/WiapFTpvZoWmVsVWV2t7x3XW4pbk0S9Nld0ic51imt+/z0/0JoYoTNyZ
         TpWg==
X-Forwarded-Encrypted: i=1; AL+hErF0tODy04/VLe1HHDe3pXozd3ceIMFslc7HCIZqxlporlXb2b0bvjxmx5lnia5smAXhZpKsVRAZsOupKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+L5CmoxQKlkZe9OXEjr7V1C/MiPqLVL1PjbwUyBFFPRNP9BhT6
	1sAWHGi85xHYsc4F2fMI0i6ul9SLgjv0e/cTYSJTlKrX9SMbdTW2QAaUJyaJ58sBLHdqRr4QaiF
	ShD4obHk=
X-Gm-Gg: AYBFou2Bo6NCSgm1Y5JYEx5LfmyLYlJbdYrId+hj0QKpYWIT3LOemsPlDHB9Sq33vdU
	OeETQwzA1XQ51wILO5JfkpgVzaWW0DW7zNFtLjX/TUW0QYrC5HUOna7fIv8IBCp4r0n96ykSJd7
	Fn4MMdgKvGBafp2JpNWSdjPqm7n7qvL3+7XWaPFZpGRgD3y3P0/9isKOY1xdagSpGCqsW5vQgg8
	plVHf9dFBF8MeJU3MjmWLHBsjVDF0wzkm4gmfnjbJ7+WmnCuSoTCwAG3hNZkTGMAcIIeGD5yxSX
	thoJJCcNPdziDoEr5fcIGQAtXBOYCehqnGgHCuLAq4ottzgP3MPgAT+pBWO/SRWyhHec6a7eWfu
	24gSv1cDWjCO1BKVwrDWfWj7/gOScAwN5/5KHqBLR0qroeRIhNIiOpNSevhv6e8KTB71mrZ4GYx
	M3r+LLE2o380yrojlodPJwVLr7ZP/pH8mFwyo1AdSysAynsV0sl1UBgTxq8cCwmi8dNktWqs4hb
	LEVztQpYYKQBOojI4V3mM9sgplW/61sE4xKji2RgmpsbEBF+GVt896B7gOq/5+YDvwSAl6aoOnt
	N4bZZpvT4zkOREJPj8sQURHAZqn+D0EvAJitgMQIBTJ9r5oKeXjbag0BhmURxIG9/lLqBQCfyj9
	i54vgXBDhG+UVVtOGEfa/YuRCYVnazMZmwQ==
X-Received: by 2002:a05:7301:db11:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-3796047be6bmr3147605eec.0.1794607362850;
        Fri, 13 Nov 2026 14:02:42 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm16981662eec.21.2026.11.13.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:02:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20261113110842.4189035-1-a.kazinsky@ideco.ru>
References: <20261113110842.4189035-1-a.kazinsky@ideco.ru>
Subject: Re: [PATCH] blk-iocost: Fix overflow in donation weight
 calculation
Message-Id: <179460736165.18529.16250644917025390352.b4-ty@b4>
Date: Fri, 13 Nov 2026 15:02:41 -0700
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


On Fri, 13 Nov 2026 15:08:40 +0400, Alex Kazinsky wrote:
> hweight_after_donation() receives usage as u32, clamped to the range
> [1, WEIGHT_ONE]. Since WEIGHT_ONE is 1 << 16, multiplying it by usage
> equal to WEIGHT_ONE wraps the 32-bit unsigned result to zero before
> it is passed to div64_s64().
> 
> This makes new_hwi zero, which is then clamped to 1, incorrectly
> reducing the cgroup's in-use weight to the minimum.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Fix overflow in donation weight calculation
      commit: a56d5a485be4a9d52f0d7b3ed0dc3521367cb986

Best regards,
-- 
Jens Axboe



