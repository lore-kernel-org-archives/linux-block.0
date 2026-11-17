Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883623;
	b=u6zn3ymdQQLxTwZFjkYp2RraDDdBwyUFiKgVyP4AyWVqlwnqQN5X28gChpMql+WpSatG
	 H8kd0KyHiC9boB7vcFhrz3xPmzUsxGxCuqauCdwuyWQema55PVHUfYnSZDxcG2ZqjChdv
	 ox6ghNE+6ZG4gAf65P4iYPRCFk8vNeag5LVNUJNF77oRaPDECQhJQLjw+TZYcGDhhOyzL
	 UghuUvmmp3ga/qS7pcBqJ0h2Wh9WFl3CfcaH3GWmqQc8F5cngQWxZbjQf5cS9DDUKAfNv
	 ZCRLUGs9dNB3dx2NfdPDpOhX/uEMtAppcyN3W2fsc15tdJz1tNoNMWdYzMXjtFvuHiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kppDiR8SAoyWMpIoxP3YdLOzzMX1Xx/Ex7LekvPyid8=;
	b=Kf2YogPb7FgSF+V66zKCMyPlzHpZhgX9vhS0VJbwcAyDh2xG/KM9I1Y4nF21KAM4EvMr
	 jaBH9lsnDi4UxBIykGFORgj7YYJ8xR3SgwxLm/z4jMtxyUSlA/cjqY25BWG5e6TW4y2Vq
	 BC7d7J6eSKSiMVRo1HgPh0A2aic7JVryozzNohxkOErU67jsu6DQPZMX2Uaq+40yPBzbL
	 RtOjv7t/Utg12vH4S+CMMvldPkzEOEimA3OVSwSGnmkgTdMNYdGADBKmk+AVtAwQOqZ5J
	 FZWy95Ci/EnK2THH6IBTQoWGWo2hoEWqUp/3jyWj/IsfmvMO9C4hDY+Z6g4gp4eFwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h0+Xp2uU;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 02:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h0+Xp2uU
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3791619605cso7691835eec.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 18:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794883622; x=1795488422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kppDiR8SAoyWMpIoxP3YdLOzzMX1Xx/Ex7LekvPyid8=;
        b=h0+Xp2uU1Vs52/5cXSLJ3ctFuEzm2nhK9wmRJm4sixZ63nzfx2bfYZ/B/mRsxGxSr4
         0vPyZjxvUTnHENTdeU79r6kUp9R/OUFCEuPv0Ii2a7YTZI+bdVvzHz9HwIc1E3ViyjSb
         VOyLWIkcavbQzOivw3pS5gd6cUCY79tEKeXirPtz10xznZQTBKBIrHBvcfWsscLlZLSl
         VdPaTwqEbjX/zatXzsDMU0HEawlk/SM0691GhKUm8zmZylwls9x3gnAsY23wZWLK7qSQ
         tNFwDdVSs0Gqv205mNii6J0qYVb7z/UC23QzEZmmKaAbPTj8sLy3rrUPFDEkSzrsbN48
         +AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883622; x=1795488422;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kppDiR8SAoyWMpIoxP3YdLOzzMX1Xx/Ex7LekvPyid8=;
        b=zwdCSgh9gOYC/OmMcA38GVOumlyJeabsKkWAdkk5mVL/TkLPu2AwNRJYQjZUmxeyeM
         9vxA8/teSZVhTUWk2ydQzZlsv7h6WUPNS4YgD6cmjlBWymhACBggZ/pgH6KILlOmOvN9
         xcVktw/aoWMSjPuuVuh2ZO7sp6Qpc21mvwSE2wfU6rJ1q8NXzGVEaNalspDLagoMehOz
         A2HxqoE1lF9Cemf5o3gtQcjlMXVWoL0UNiQPSND79U2/aaDhy6jzBLQ48M7qRmzZd1Mi
         Otl8NR38hcZembU1XVyMH9pnXInt7fAHiLgQUvxCluHlW798DbiK7QIx7FzGSGljAu8q
         S5rQ==
X-Gm-Message-State: APuU4Z/ihixKe53USzSfVpyIQRsiAbZjCHqQ7nBHWsCO0BObcP50Kmb4
	l8rfyIAfZ8d3Ty1xZ2FI8+lXGUIOMltxURR8qc2Kig7eufNRaHZaS9S2klxJRkmT+n31mxjZB5n
	n+1glMG8=
X-Gm-Gg: AZFdTZeV9J5CCYs4iVTycn1VWAdo3kty6tTi/x0I5sRaR7CHw25BzBQbvhMXqD50Vv2
	U6VjXlv9w7MieKZZePpQuUOaTyRTRXsNT0VzeEepxWpLha7CsUbpOTP1P48jtYAOoFJbMDRif9B
	vrBdY5KXxB/vvGj0h+PwcKTTqwN2N4/qW++P3ndLKl3y9s8vrNfGwDMd+4WwS/XdRvrHtgMnW0U
	MZ/6iWLxBWSZNdbI6kQSpUiINBES+FGptrdlbqliAWBVLmI7SsBw3mRxPli+R0QtMxzjpgilXda
	GFeVI5GjkvRPe161422Wt5Rt+ZrNZ439WFoDazVaNioEHyjof4wYqc0Ou5u8dpaWl9/5ZxzTgY6
	iBsNeHkZgerostrK80R9jJR3w+TAXTLhgvfRrZqqfsxiONV5eJr4GLAl3A0kcvOC4nsfIJU9X3X
	M6pBYOFqVpT2UDQVmk7bANpbpuIvOBI85Fq32KSY/GjtIdD6Ck5SLWi5OC+LXwbYoCze4dWl+Gw
	qRcxoH1xKgs21RB0If1mSLnk0Fq4AGH8CVpFdE5blq6dKunTInCtqyyYtHSv/8BrpSmaDC2nuRX
	INRFFaqm6MISYFvIQr156iiy40HdNqangzmwuEDh4ih5ypJyHCFQqEXNu5wRNe9Es4DKfd76kGB
	Pi4H2nPebEsoT3g==
X-Received: by 2002:a05:693c:4146:20b0:36f:551:2bd5 with SMTP id 5a478bee46e88-379e16d093cmr11774287eec.32.1794883621530;
        Mon, 16 Nov 2026 18:47:01 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm37856627eec.26.2026.11.16.18.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 18:47:01 -0800 (PST)
Message-ID: <3868f992-20ee-4b04-9416-40a5a333cc27@kernel.dk>
Date: Mon, 16 Nov 2026 19:47:00 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] nbd: Defer request transmission to a workqueue
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Eric Dumazet <edumazet@kernel.org>,
 Aibing Chen <chenaibing@cmss.chinamobile.com>
References: <cover.1794865298.git.bvanassche@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1794865298.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 2:48 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> The NBD driver transmits requests over sockets owned by user space directly
> from nbd_queue_rq(). Hence, sk_lock is acquired while blk-mq holds
> q->q_usage_counter and set->srcu. Since other kernel code acquires sk_lock
> before fs_reclaim, mm->mmap_lock and other subsystem locks, syzbot reports
> multiple circular locking dependencies. Socket lockdep reclassification, the
> existing workaround, introduces new races and module reference count leaks,
> and does not suppress all of these reports.
> 
> This patch series fixes these lockdep complaints by deferring request
> transmission to a workqueue, similar to the loop driver, and by removing
> the socket lockdep reclassification code. Since requests are no longer
> transmitted from a context in which signals can be pending, the
> partial-send handling code is removed.
> 
> This patch series is organized as follows:
> - Patch 1 fixes a missing wakeup of wait_for_reconnect() callers when
>   NBD_RT_DISCONNECTED is set.
> - Patches 2 and 3 prepare for deferring request transmission by
>   simplifying the nbd_send_cmd() return values and by no longer taking a
>   config_refs reference for each request.
> - Patch 4 defers request transmission to a workqueue.
> - Patch 5 fixes a nsock->tx_lock -> cpu_hotplug_lock lockdep complaint.
> - Patch 6 removes the socket lockdep reclassification code.
> - Patches 7 and 8 remove the partial-send handling code that has become
>   unreachable.
> 
> Please consider this patch series for the next merge window.

Something like this _really_ needs performance numbers.

-- 
Jens Axboe

