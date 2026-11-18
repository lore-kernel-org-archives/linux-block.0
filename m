Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018073;
	b=b7Gg7uEOTjVz/uWXO0M9Mfx7w56dz77BexhcY0G0k1ln8lbBkmdjewQAe3Ffl9zLN62D
	 5afj+x2p0lDEDi0Bi1Rck0XYwua4yXk+s+uFOXeTdSXAl1rkbX8489H5kkpagBxga8lkL
	 pnkD/qBhp45geu6VH8v1rfi/PDLKNXWUAP6KWgx0cUBwJfypLE/hh1cfOdXlaLKn2BygP
	 iMBsNUF/yZ31K2QNkPnc0UbSYsQ3zQI/Nc4HAYn36rMYD3ftHsHtTs5iGbwlZdDGobWOX
	 ykTY2T8oRmZwHM43uKP52oPhmQ8nt0KkXX2AkJhgqv6dy3KOALGGWFoMXsF5sUe+cWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Sq9RmYzcNH9B/wayIUueB9ggWDiYP1P/tLsuJW/Tbnw=;
	b=iYnujVDsXPZukawxypAsyHDUB9mg4gxXRY/mpvLErn0CAv8C+HPcC+Z2muQJLB601/t6
	 lZJe5QNskLr+dYZrUE99NFF2umtZMSUUzqFRZyriY3jaTUBFKxM13kKxJ+jrUBccJlEzm
	 zraS7ljwh4cpqwfGsvuhf19lVBZXPSECYspy2NhdlAt4SY3svl+XuZEV0BWKEuHXhgLjS
	 1j12yVUe6wR8XDzg5TnvZoF38vvGObar9n088GTwcyAXT5yHMHJAduQ9Gjepr0RfTTDWt
	 ZcCr9g6gTAx9MScJMMk7ADebMs6UFmvfm+QjHwzQK4W6eJB7X0eSb4zthHdQeZ/YK8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dTgR1f3o;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521660A2628
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1521660A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dTgR1f3o
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-71ad1db7e31so1502555eaf.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018072; x=1795622872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sq9RmYzcNH9B/wayIUueB9ggWDiYP1P/tLsuJW/Tbnw=;
        b=dTgR1f3og9a0vBhrk79J1moJmlLMa/Fa6bpbkeW9vt/uz99+uvVA4CNebGriNhtftB
         3KScmsBDYtIouXo/NWiqMm5BqyXTGIO+u4eeRjaVUfcuM40shyAyRSXMCOkPd/cC26u1
         WOnHUaA5WQg8bQYexiUTpf73CbV4aB1kjJPhR3IiqikKxwcGjkzQP8iZidIuE55TfjYN
         C3ZM0ZYPIsNXrb1Jj3StcFa1N/5OsDo8WrytQXXoTjfJLgwJighHosOeOXNt0jL4rQQZ
         1NNE9jBw5/3sC6M2pYKyQIJddk8h/QOYHo2kWVRymfltt/Q/RhyBVcOaWuRehwkYH7o/
         pAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018072; x=1795622872;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sq9RmYzcNH9B/wayIUueB9ggWDiYP1P/tLsuJW/Tbnw=;
        b=Rar7uyfXI188AA2pt1krdMzA9bsD3NQF2rqLHduU7eeQr19xgzi3vSUxcUM56AKMgt
         Gx5gMjfr9+9/7qXPnR/UeRdboHQ718JR4Q7Vyp1LcQ07GOr+nu83RbXjCfyIpNhi8dqv
         S66rBglHgaVz83Zax/W1kMb16D4ysz2uydWMo70rusOEJFkP38xpU4o9EoaU3rMPUOhD
         1uBShwinl13BSJH8J36x3X0dVAaZCqe+171I77ivb9f4O62+w47TAM0ZMqZG7aODWn0U
         05JF+mevpIUmMdO7eoA3xKEKyHvGKXc+y2hodqzs43F6Rl6o6J0j0Rwoa5f3ADgJYq3o
         KIPg==
X-Gm-Message-State: APuU4Z+qPuYeBCAuGVUo1RpcI4c887Zz7PpUodjeeH+OgcpPBMdfvxuS
	1SiQf62xpWo7qWAlWOL2o+wLikjz+fb3KYg45KZ/YalhJuIuTgUf2a9zf4UllmxkLds=
X-Gm-Gg: AYBFou1GxD5T7ZzYzKdIVkdfVqotvgkEG8SzpCWknBVnLH4SjKPdjkjL9N7s1h6Y841
	eKHOXNB/hmPuAvIW7YNz//5ve241uYobrHFzS4nnVffIawKGi7kPkqdjhUQmQEKvNec1p1izXOo
	xn5XJBtfAyRuLMEg9NL9NCxdoRtAeryh2YRox6tR3zsCC46korejLs+s//psED5se4tdSzKBO0l
	aE5ze7FXCD6AnAUG3R41H/2Hz/NpQh9gwnO7/dugBlyIjrhiRKIyyT8js7ep1VctNToF5VgJY1M
	spWB9PV4vn7Ky1TyFD/gZh0gjpx5DVOc3CaIJHVhfjC7vWbQHtYF4/kFgdsNnHSJGM0k48hRV2/
	/kLPAUffprcpXakLi/UlANNZTYSX/KhcJdxohflAornFRdB/I2K3WLCIvUuAU1nkFK9SuFeoY2c
	4/HAyQvGjfF2xHkt/iK5U4xTHw7en/yMdz06hannDNo37DMp4cILR6jW/mlj5krZLSXv5y2cu5K
	JMoLhsqwub6e4h+H1rqvwjEfaWvRT3+k3lD1NqA1oK0R5KVTXcaSGOZ0+BD9Xl+6cH3wL8KsYX4
	IP9nJT+31E+vMCyXeQTQ4he99algpOjAHd78W1ddIhggaCHblxdZES9MtOnCDi26woKe/bjUTKU
	2tW/L2+Wu8+N2z2Olnmc90MHRa7jZ5GarvzZS3rNnT9ipi5gDwBk=
X-Received: by 2002:a05:6820:308b:b0:70b:930f:9a9d with SMTP id 006d021491bc7-71b028d29a7mr4357375eaf.31.1795018072097;
        Wed, 18 Nov 2026 08:07:52 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org
In-Reply-To: <20261111215838.103356-1-haris.iqbal@linux.dev>
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
Subject: Re: [v4 0/3] block: delay support for error injection
Message-Id: <179501806989.17649.3138860274842922761.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:49 -0700
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


On Wed, 11 Nov 2026 22:58:35 +0100, Md Haris Iqbal wrote:
> Error injection can only fail a bio today.  This adds a delay_us option so
> that a rule can hold a bio back first, to model a slow device.  The delay
> happens above the driver, so it tests the code waiting above the block
> layer, not the blk-mq timeout handler.
> 
> A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
> are not applied to it again, even after a split.  Christoph asked on v2
> to avoid the flag by allowing a delay only together with an error.  I kept
> delay-only rules, as a slow device that succeeds is the more useful case,
> so the flag question is still open.
> 
> [...]

Applied, thanks!

[1/3] block: Reject unknown status tags in error injection rules
      commit: d239710cf3e6bd5fec66766957c3752d9cfbd2c5
[2/3] block: allow error injection rules to delay bios
      commit: 6bd856cc99963b786cb530141745ef733de76cc3
[3/3] Documentation: block: document error injection delay feature
      commit: 5a29cfaf51105039d156dd8a61d2783e8b653667

Best regards,
-- 
Jens Axboe



