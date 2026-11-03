Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716285;
	b=y8Zu4RGoobTzvONFfFuGWnu+vk6QnhbiBEqH8Pjyt9AwJN0hdU2bEqs6p6eyQok/FqUM
	 +jGxTrZQ4PG/83nPQL6V+MJ6zC1Qd7vdUf1HgxGQN/JwiR6xIau7w6xMk06MP+U7l6oGr
	 AozEZe3fqHgB04avAf/sSax52e8dJdf8G+y9mX+nWPKhI9aXNNLSs+CgmIb+dDRIj3q7Z
	 nU+ETw7L0Po/FXA1IAyP4LzpnLnc9Sx1tqLYWM09Ek9pu8AzX2xOe7Bz1SS1nwos714MB
	 ziWZRNhfX5iE/C9Gg4hDF+VkI2CqYERIB62vsAwBdrELZobznC1tqN6ZxSkfjFVoIHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=8V8dKjtxkMWSm2f6XmuG8tj/FFGpuDNeGHGqW2z0R08=;
	b=aT0KkgzMXYK2/ly5FtdUxXDfi/16K/RxJI0ssw2JTyM4HkWKU2SQt2R1Ij5nLT/4WGyc
	 kUGfir2tMaCwrbeWdN13AKcoEtKyJ+3CB1yLHTb5au6HZBXcgp7V7JOvgNpBFVmFohczT
	 efyYq4EkiBS30B+Xmuf4DIIzlJIv42ynPjZFGMPagFOsbk26mJXAEUSUoOs6pOJgYyIkt
	 srB8+ZFMi79oBUlhVtaIVbjT/yIUM6YQ/7l/UhNxAceWWEXPrk4OtHarl/er8EbQfq9nB
	 pF2qPv5r6WfUc+sVErNHDU3NrEBV7/WT13TGa4PfCjrDGQZaXJjtowf9x9DMzAsDzfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WfglxMrn;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E8606A335
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B0E8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WfglxMrn
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae18eb9b69so3127128c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716285; x=1794321085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8V8dKjtxkMWSm2f6XmuG8tj/FFGpuDNeGHGqW2z0R08=;
        b=WfglxMrnCCCQb6+e0ckLHUVEr533fxpsv00mzMsO0IkgVt455m0b7O62nVRLnxMckA
         hEWGyq+lsykATqEe6fcewAUP5E1+TLanMfCYb0NqK6u4TPRXy+/7dFDj5kD8iA9uzNeu
         3fjcOtX0aqx85pB1cM7kRQI+H6rnMtODVYfcpnNM4gYwD2QyHc1zRMMcQAit8CxmksFY
         4Mt4F19J8D9T7xJCD73O2A2f0qC7yFEHvXxkK4CPjJQJ9YzH2IJMLl+jWHzeXP8cfReF
         fgnZ07lEuIPueJbSHC66bBE4MdOdfZQRRvDfOHoqqAyh0vkgihszXpglBlebIEpjfN9R
         Ux+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716285; x=1794321085;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V8dKjtxkMWSm2f6XmuG8tj/FFGpuDNeGHGqW2z0R08=;
        b=e4N2m/QTmVzZnz3BUjxWbqfjhclN7aEPKFczY3095gQsDHimfvdXOYOwEV6gJgJQpw
         2r8lnyeFr2uR7+yoV4hsaZZquHYIOKgu2sGYVjDX4ZIaoXtmXBhX18J0rY2xmHp7t3M4
         j9IZRSgA0Ys6W7K5Fz9Pv0i2SsU73Yy4tTOs4xZE2LhlcsOzbjv3G91O4z4NVhRTTZKA
         gw2u+UjoyAk6Ao8SNxdlU/YWXMl8SXonbuIZfn0sTeqscb3P8dKoiPMeP3VTESEB1Ax9
         u+MYmg/JGn/0DkLLEge0F6AVQsmRcSuB9IXd15laPnLH21gOKZIwe5lPHUhh5KndMUWb
         GUnw==
X-Forwarded-Encrypted: i=1; AKwUvBwSPCFWT2HTFT4al50BULNmsn8fdLCSF9TL7115wuseoPpEUb+fLQeKBJdMg5IQltaarrmX0X1zzUOTlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nL/pTNgJ6n3b7gj6Oxkemj8a46agq27qwAlw7drqyod8tg491
	N0B4YXuzn1XUsVLFXtOglVCsKSQ9vLpfpugT/fHNfjUk7/cmfSvoYBiE8Fwic9TAsBo=
X-Gm-Gg: AYBFou000H/k57a7gIMV3MyTmdFD7KvWMdlMNuFLhGH7c+8s2ZlaU0zALF9I2sQ8I1X
	DXUi2sRzsmmGUCsBBUsmqoYdzajzopSSRsRG2+8oyGbngLbLVLW5qRkBb7riXKwZjo1CQ6NleHi
	ER0rObYQs3xzZj4feEpMMZE39oIIAENiDEroaY2sjgnAI258mGNZRW7RqY7aHF+0jZwAv3t6NbU
	OUBUkqwZhRiXmNn9OHO+OpANZ58i0R/msYc8gNPrbMXLackRKukA51W6Zb+qg2XuOGfpdsBmypV
	aGW5s1loRnExompF6JiNqXrPUHN0Ua5IJ40n0m6y/z5u3879CZWTYkbmweW+vUA4ziFU4jkyCIf
	a/sFtGJaGVYviHP+VfjDXgTniL27uvDARfOGy07XDmj4UVdRFSX2Gy5HTIgdv8k3mcRf9gvIQ1s
	BHn6Wxr8JBpnSL4H8qCEKYlqQyFpNpCNiqasg72sb47UDIFVZyEQU2dTkblguurM6gbQGT7+QIx
	oW3JNeKPZhF3gPL2mpKQvdJhU27roD6RdZkCoWCF6YEW2tQ+TezZMtbEfBWTs+OL2ljpBUFWuXO
	4yTxnEZY+/BJNxccYICiZjuFb2ZMVjVZNk7eGt84jKfmW4ZlmChQApHYB5cv1njzUyVCfN+e3VP
	vK5/wa0NXPywP45eD1HsA2fU3HKCakGeAqw==
X-Received: by 2002:a05:7022:88:b0:144:fb31:a597 with SMTP id a92af1059eb24-1ac6069cebdmr18479029c88.47.1793716277896;
        Tue, 03 Nov 2026 06:31:17 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <tom.leiming@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fygo.io>, 
 Reindl Harald <h.reindl@thelounge.net>, regressions@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261031044141.5569-1-laveeshb@laveeshbansal.com>
References: <20261031044141.5569-1-laveeshb@laveeshbansal.com>
Subject: Re: [PATCH v2] block: only serialize elevator switches of the same
 queue
Message-Id: <179371627639.3691261.7215818828022045102.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:16 -0700
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


On Fri, 30 Oct 2026 21:41:41 -0700, Laveesh Bansal wrote:
> Since commit 4ff58d6bc9dd ("block: serialize elevator changes for the
> same queue using a writer lock"), a write to queue/scheduler fails with
> -EBUSY whenever something else holds set->update_nr_hwq_lock. That
> commit takes the lock for write, and it has to be a trylock because of
> commit ce8ee8583ed8 ("block: use trylock to avoid lockdep circular
> dependency in sysfs").
> 
> [...]

Applied, thanks!

[1/1] block: only serialize elevator switches of the same queue
      commit: 603523fd54664f17630f742229166278568c3ce8

Best regards,
-- 
Jens Axboe



