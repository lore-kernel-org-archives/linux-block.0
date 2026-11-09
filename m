Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246024;
	b=XQorHHCyedaHa832wLK9UXfBfiDBT29y4yYVqqljvQ1a/6amK0oNPIK+4kunvZQJfMKD
	 A/nZUhWtAdaLH6Cypccks6xlajR3gxDVza38XTBwwzFgFRSZUzxBZi931rJm0+1dmythg
	 MCMhH83Pq/QAEnN3g51oQavT9jThVOApNJDg3MmrDGwxPN+V6QVGacInItXRY3AnygZGW
	 P6oGh/Tt2t50LDg24bm8BKPtE2hUr/FK0cmWX09QNfRJMgCt+j3rbQNIdtQqLIhO2pBRd
	 EQHoENrANXQUunPny2iuuzaDiQGqZSgPbg/8ICgriC4QdzH1Vr41SQbJYbrxuVK5ubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
	b=zAWZ3HBTAZeos5GlSF4XLMF7hsIaDu4CTSblKM4EYa22LsrN9LqMeTaemtK3lFtonkTl
	 b+wTsH0Xv0UuS9J526cRqpxaO4JBJjfBD1Es2PTdFQhh/uzSIjWzcFkzR1vPDl5yppMJF
	 0LU8o841SKjo5lUpviCw9sDxdaCMzdpzTncBYUY4N7WWMwq/pkB73zccDoRAr9TPTYCZN
	 +NtQD0hQFRjtqIyvHB6P6yTA0Qzb0eEY6jUetw6huwjtRJY95D3jPJfJ/jfV1pYlHF2dn
	 Ee9jwiWk53sAOdnG4bZ1giGkGf4j5U2xPX7zTRx3jWbXgq+PicKT8PBJ8npy9a2kAVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TKz+LF0C;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEE606A33A
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 17:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FEE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TKz+LF0C
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37198ed3727so1547177eec.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794246021; x=1794850821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
        b=TKz+LF0CU9ykvW24qHkHBmZANsrDxSE+YQKhzk9llLhgvgZCWOa6B2astRojinp2fl
         If3NI517QkeButaIP8z57vpRuErzEsGplyoOkGJg87a8FPDVnoh6Dxaf5WTkCSo1jtae
         Zhte+uncYMMhTW7SH8CdvesLtgDulYzRj8y+sPxw+YB1WM2aGI9quKEl4XdJAw8wli4P
         sPsQuYdTOltOGTZcg+eciOobSTr2qjTCEzL3oN0lv1YbQnRyxSp7YwhWRP3/6n1sk6MI
         tImcZetcy08pofmpnlRjZFvdWs6WX7tca0QYPnl+2LqvLV0Ur0/iq21VjvIUERffzpmj
         PtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246021; x=1794850821;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
        b=BoYH9e+loJvGwYup9E6VFhuLpw2OR8EUiEiwmA0RPeAwGtQUONIcwRF0Z2tQCrb+MF
         FZin91Pf8W6dfAAn4uzpF3PW8lV1pwlVbsO5CoBSCqshOLRB/N4fQk8hLD0ZLYHwCsw/
         zS5Q79hbNetvwjICUQ6MEkeeARG0dw4zNlkHXjEu0lw3sCNgoy8MU4/H3KJqJJC3Br17
         dogHm+js9bk5sZ/TitvbF1Oo9Dm+MADJsFy2kA2t59JoeXpWl/IAbajS7sHxh8w699iI
         YRZUGTUDvvV1J7nm3u3I3mpXhBSvYCyaF4Ci0L1h38UkTpU7In0kdjbu1SzTjtPgp2h3
         9RMQ==
X-Forwarded-Encrypted: i=1; AL+hErFl28tpVQfMsrXBQ7R6w4Vl1LZ2APDbZatkec2Jab0b+nlrE7i6nJYnu+alO1P9Pr64fBBd9+fprDcpww==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hI+tdzs3dqjEtW6zkAZuseDG0dJ1g74HlTPXxYmUF+W1T1Bjq
	e0Yo4cbs5MxSPTEEZX7Wv7rpG8v2YRVGhcpEVSgLvANXr+oxTddBJi/hYxe0ac2QELE=
X-Gm-Gg: AYBFou0dc9Mikgf8fSoR9oc9J7xhQiizUN7fBLOcVsywU1BGC1dh1MONc6c9KvQK4SJ
	Y2z6OXr91l7PvfNdZGYowIjJiyKPztO58NJWjw/u91W8F9GYNse2j+BVT+AwbDiZZDHNQ3uDZLn
	+Z/fXQb16HtS4vKHwO1qCywqR2uqffx88HEk+Y77wU1Kq4E9NKV5EF4FMtctfDh24BLhs9wNPQ2
	mBUfitdfMYehc+YKyKb1h99QNlpdKi1XzRhd8VE56uKqT2bsA0XeIizlqhSgqnLWomjjPe00SsF
	Qt3wyskGauCc45IcOzZ71X4C76PuXKlTOUwB3MF5qFrIDmNwQqiGrOHvh8C9AiNAqTKaN4DTswL
	Ays6eLLJXY2EjpAgILqq+TogGV+vup/4k15SEd2qKZ4xEaQX6lNBoNr7TpSl90pm6SPt7f2sudM
	CKabnlLaxkQavFi4P8ZyT6S4aPehbyORdhg3GoTFuqxV66xvwHyPcw5WFDhjTpImFmc2JCN48+M
	9O3oFMZ+ZmFU/NWu5NFeFcuKVu2IgZAbrpyjUSHy4ofzyqa6olX69o83JF/G/FNH/C4TlHFqCqr
	n7GDeq5q84/I8oJDAFol4btviJOe/fxwfsrB7Hm7PeDZwCbUW+SQkox5mZnhgiueaxfCoHYzNZ/
	ufR+4UljRKjSZ
X-Received: by 2002:a05:7300:e9d9:20b0:36a:2f6c:490e with SMTP id 5a478bee46e88-37508f421a2mr245104eec.6.1794246021164;
        Mon, 09 Nov 2026 09:40:21 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372656187f8sm13250129eec.5.2026.11.09.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:40:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
Message-Id: <179424602031.19772.15096346833030118942.b4-ty@b4>
Date: Mon, 09 Nov 2026 10:40:20 -0700
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 23 Sep 2026 16:06:01 +0200, Christoph Böhmwalder wrote:
> This series contains preparatory changes for bringing DRBD 9 upstream.
> Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
> has in the out-of-tree DRBD 9 code. Doing these steps separately and
> up front keeps them out of the much larger rework that follows, so
> that rework shows only what DRBD 9 actually changes.
> 
> The patches are a file rename, comment and internal cleanups, and two
> higher configuration maximums. Defaults are unchanged, all existing
> configurations remain valid, and apart from those limits only the
> wording of some log messages is visible to userspace.
> 
> [...]

Applied, thanks!

[1/7] drbd: rename drbd_worker.c to drbd_sender.c
      commit: 40059d1813d8834cf4779b8c9c2faa80b4a6a0a5
[2/7] drbd: modernize the file header comments
      commit: 4df3cf912f90dedfeee025b1fb34b6ecead7c8bf
[3/7] drbd: raise the socket buffer size limits to 128 MiB
      commit: 80869ca32c8969eeb857f4d1a3f959dba952109a
[4/7] drbd: raise the maximum resync rate to 8 GiB/s
      commit: ebf0023b636ad47afeb13ece37123507d27e131e
[5/7] drbd: replace the drbd_interval bitfields with a type and flags
      commit: 6826d3b194b1e01128fca6e0925a8afe72b7cca9
[6/7] drbd: move the packet name table to drbd_strings.c
      commit: b87ef682279fd67600b92eb83d10e70b01eccda5
[7/7] drbd: rate limit log messages per object
      commit: dc2ec1327db41fb8c7c0ae5a5e29654b6ca3fe17

Best regards,
-- 
Jens Axboe



