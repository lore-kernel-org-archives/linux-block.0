Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396569;
	b=GpfwzZZrXWJWh60FXOvzY2wfd5EKObi1m5/0dKSKeO5IVAUlCBqXeB2kqJzW+2wAWLql
	 6WgnWwL3rD/ccIVIkAb520LscNxNspdKatQIeW5aI/xlwFscjbnoqgdi+kkyu5yI0+Ckc
	 JKfyqnynOPnhvVDiGWWKVNzunaVIXkRZh3Xx5E/U3ymFUiEGsqO2FW3DMg2PPYtHhfksm
	 uoB/fWO/x2FaMDkQY8keGb2RL27XIIpSZkrS3bTVSOFslekO8796mMhAuPphC5WjNLDdq
	 SdxneCSJxuQeR1qQuB5EOWrrY9d9NAlDwavxrc623vXEhNdYq8UsBW4lbcyYViNhi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zTtDGLue5JqVxGOZgA8LDHzbFgoJeRKQNOdcqpXnAX4=;
	b=ObWwzvUznwQoFnZmJ3mG4nb7gcX02nWDhTfrlfxth/5L8Tw2jdSwpEngx1bLQzWsFd8X
	 13QuTk8IvXDvRkVglq+nRqs5vJdMBeedf6KuwHmQRuYunlv3rA6/bjgrsNUU8bV0EAioJ
	 bJwENC/MihGi2oav3e4P3bQzYHMAIZY0yNxO2gIvD10UslAgAv/87miFU5MPs5lcH1jb5
	 MIXnSNTO1Mw7Zc1Lo52gjdZ1AfIGUZOfpoAP+ofDsNEmbKtRC7hJdStrzGEQFO1ZaqWdT
	 /X4jFVxHXyb9aPlVcusaVLLhY7OVgN+n8XLYoKAwUmiPUr9hAly+dQ+ZZDX0wrfHBvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUDKoIpN;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E3606A326
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUDKoIpN
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48fdea35dafso1163640f8f.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 03:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396568; x=1795001368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTtDGLue5JqVxGOZgA8LDHzbFgoJeRKQNOdcqpXnAX4=;
        b=AUDKoIpNLkyrldLXbo1ZDQ1otgEI/vNPvbgblUzXsd6GUuG+ssKADFJTm4mlhZLfJB
         e0CNjY4GgiUGS5jDBQyVQSHuSoQ2xik0QvLToaSnKfCajJXiXpAFTASAyXzWqqXoyUZV
         nWRI+54naZVSG88MTcp5WqQYt6GrzkXg5B8mXAgMl00pNfuU6ik7YvPsb7PQQAyRXXyH
         6gwhKSE2aZ4d54dBSrJ8JCAAZiEpQ/Y540Y6Z5QXH01WZj9+RblibfioYVpVKsUriOGn
         NQDqfm1zpSO1wMEvcDmpupAWl9kaPtrtMZP73bdn6nJIzzPWEbtwFbB8pS6Ln9PgbGXE
         /How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396568; x=1795001368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTtDGLue5JqVxGOZgA8LDHzbFgoJeRKQNOdcqpXnAX4=;
        b=hqpr5WmK3qUnFqKJQ7JGFjGw90eXMZY/3PaVvG4tnosv0s+Ezy0ad3i6NoxwTAKba+
         01vXYuW9U+n5cb1FHJHVxTLyNKnFTj1ZdejBdi3YXt8KaIWpWfWFQdAJKNR9BGqXsSDk
         j8Z6XcXU/deC0sEWownVyG4/18iGbWvzqYg6spE+zW76tTsHmw5B7IK428SPjWzCtJdw
         66uRl/xHVcrz73s87LlJEPxlrT6cP5rSmS06wnVx7NEwp3dGltLQOUpRW6Ydw6oBssqO
         MapBQQ/b++5cDDh43aNfPc6Qm1csBv6DaZ8q9kF6H7d/RmfgOAliEdlmpPdjsGmW6dSr
         +7/A==
X-Forwarded-Encrypted: i=1; AL+hErFCY1MAxHSuAP5AbsRS0NzP8ysml2Vi/7MqiFrcUk7N1rQHN19RGaM7XzcO7QcxKUCB5fgX+1431cn/Jw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/k5UEy599YdzVqpLgNaLCW8p/pmeelqg9DHeKxVZYngSt98eoy
	cqUWa2r1bBKGg1FpT+bHfmMLSrvaL4/G7D4oCCZDsu4bCAbMlz+ovhVl
X-Gm-Gg: AYBFou0pi9zXZCHIBlLfc65sPUaGrpm50TWfR2g1YgJJNhQiqQzNP/ZRuPFHfLWuEYT
	W2CNUEI9tXuH04Ojb+ffDrouSSdWtTadGf9b1DCnUpBGgx1we6nYdSDILcAxyQT5yvfAA2JGcqX
	G0wvjD9C+x+SOtZQDGyZLZi50X4XSuIjWPmeyIHpPrwl3wVwyAtUuqV/m+Al49OEOhK/w3IZRMQ
	OoJCfxFmFGPRrsMlf9dVizWnZGXNepRN8Me+GLHc4sk2zuTlCxoSi6b/h3Iy/q1CvEXg+HyKrhG
	OpnN3oVVdwMyY7XzjfZT6SqhkRpgfJpCccWmffTsI9FHJQWkp6TQEIDw/CDzBU7OY8p/2qdc1GG
	rVPBZ0axX83oR1zRVpoheZK/tRl6XjZlrrS1bzQXFKVlVwPZUT3SyZbfjzkHwUTQc/vmMtqoQDL
	QeA68TYGUIDH8MnVkDKVBoqmct/Phu+GgHkoD/AYXqgLw5i22+wabvEyIuLvMK4c9Jn2SJUYuLU
	S4BzUN0hHWG9IiakFv2VzUxo5umPJuSfDDMZ3V/FsxWzt32sBYxvBBlE6CmgBOactxShiuLPdSE
	uQS63eJOe5Tvbz2Lg7U6b/pP4TR+060=
X-Received: by 2002:a05:6000:250e:b0:48e:75f:477d with SMTP id ffacd0b85a97d-499c4814a86mr3885367f8f.7.1794396567358;
        Wed, 11 Nov 2026 03:29:27 -0800 (PST)
Received: from fedora41 ([2a01:e0a:1058:7c30:e315:b955:cb8b:b86b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm10536016f8f.22.2026.11.11.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:29:27 -0800 (PST)
From: Timo Joannin <timo.joannin@gmail.com>
To: trintaeoitogc@gmail.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Wed, 11 Nov 2026 12:29:21 +0100
Message-ID: <20261111112921.306969-1-timo.joannin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111101919.215767-1-trintaeoitogc@gmail.com>
References: <20261111101919.215767-1-trintaeoitogc@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 11, 2026 at 0:40 AM, Bart Van Assche <bvanassche@acm.org> wrote:
> Moving nbd_get_socket() makes this patch much larger than necessary,
> which makes reviewing and backporting it harder. Adding a single
> nbd_reclassify_socket(sock) call in nbd_genl_reconnect_sock_cb() right
> after the nbd_get_socket() call is sufficient. 

Hi Guilherme and Bart,

Thanks for working on this! I'm currently fixing a possible deadlock
in wg_ratelimiter_uninit 
(Reported-by: syzbot+72fceb8393e04ce876d9@syzkaller.appspotmail.com)
involving cpu_hotplug_lock and slab_mutex.

My one syzbot test failed because of this lockdep
false positive that this patch addresses. I applied Bart's suggested 1-line
fix locally, and will see if it resolves the false positive.
I will be submitting my cpu_hotplug_lock fix separately.
I am looking forward to see your v2!

Thanks,
Timo Joannin
