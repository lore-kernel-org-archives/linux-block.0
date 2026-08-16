Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BE32AADE
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846005; cv=none; b=qU9p3hYEV4xtP00uIvv6kwXCpcc4/MGkWGtYhYLoBrFkq2+gS0GuTNf1ghPPus23JClVp1ItD8ivbcDl5yS4DjiyQTaqEJWE73M9teEqjLfwVLAA2UZcyNzaGFv6TysqEwcj7w/fceHX9AB2+zyhiwf2R85BkqyF4905Tqfi3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846005; c=relaxed/simple;
	bh=JkecCN39TV2tGnE18fR85oCcOFaUlCRT0w1KWtgefyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XKdHHzJWEkOwtzqGZJ4kgN+bA8Dht4Z7Lq+uN0SnlW+0tM0OqNjkdObtQ9GWrYnIk+1xFowpTVyib/uRcVyTbVlX/WwDd7rIsHDAjeNCy+GkmzEdtfPYcLda+D6C12uneeN87hrzT4RjcpP3ONQGr2o75neYB8lWEIeB7fFECrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=w5kO0NiH; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="w5kO0NiH"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ac83a09781so2092541eaf.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 19:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786846003; x=1787450803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4syZnupfeiaiVy/aoJKcs95uuIYW7u09soiJyOD8q4w=;
        b=w5kO0NiHjpB5DbKFI54a2vS6E7ZW88i6k3VQuTnBMjmPjuQc/n1KjnTsaXquFBXYNE
         gDJzniCiDdTNBMmMsCUhLncd6zEWHQP/0q0uKrObHiWOFtfLocVdsAZXP02efcZzZoiH
         XCN7dhsu6ZNnDLagYDItbDxhdGlyMAhZcNYapqNCcx+gkrZBbxBogWmFKB8NAPTAuYYH
         L/PcGKjyJu6+nchKJQtbvFsIO+iPDwvskQdqJpeXnzeKjuhYO6b5EKWDPd7zXV07t8Mc
         +LkkRdzG7VRKUAdMx8O2iOYloFqqQZ2zf4LZESrEiOG0Tzfo+OArjjCvzRboM3b8kgKo
         y5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846003; x=1787450803;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4syZnupfeiaiVy/aoJKcs95uuIYW7u09soiJyOD8q4w=;
        b=i2eqHYqF/5ZvV5X/ymhaaw7u9oXOLJoH8VZ5Wu7YWVEDJFZRub/gIlTSvtOfiCogiG
         Y5wry5blgJhRUNHS6qeLGUMjA2fb0Mo9FWl8bFFFJcOP0OSH7s8wLa/k5cG4TLgd+P1m
         52zE13cJnXD2YyDjl9cxrO7HpqgZZHIU86lLy+0aCwP1qoSUE6dFoelaw8bqRGOh6l+e
         oTZVw2HwJPHtlnALaRjgV28bgb/07bigFcQbB/I+1TNjzq80z/eLSN8chTPHMF9nGPye
         Ykhxs/U5+P8Jb3CyvKzlMGKC5JagbVghHaMGI3y6qgCwC1UKjRuh3jb4oE8G7fcJBt0F
         pLNA==
X-Forwarded-Encrypted: i=1; AHgh+RqPhjCxbaQQr8L8skaYf7KGChdZ8tBQCNeIMfVu0UImu4k7ihq9Ct6UGwj4Cnk7Sesqq8/pBMbfmgOHng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKXrTNgJcjCV/KGe2BNrgij9jGqWckJkWj3RBA3+liT1CWLVO
	O1MkKN35ZpAcbJDsC4EQKlNjdjvVSB34ccW4W07h7kOMMzotpWsdFR5tvcPUn7uf+xdK46ChI+n
	la/zJIbA/bw==
X-Gm-Gg: AR+sD10OfaprFwNGI56GcxiLRfipQkd8UHoJtDIqxCyRY7TE0FeMXxtm3g6LtbDjzyO
	n4ecVPJvy2tWHlY28ksoSmcGth/a9l2ruE9fIPo7VTkPztXlRkMeWwRAVu+Fq0DgksaKml230AU
	P47x3RibW9WOInGcGtq6fWVQHxk1deSni430G5oaEf/xFfPen4HYTYVYVkes81Rblage/Jdprwh
	kRWLojWD1qxPrzYdOyPYZW2nNr9XoEEQr+K4fxlT3pF53WMZfMqfHsP3SggitLTzFbBg2yv23P/
	BKXeylGiBc6RNXsI3SJ48NaRJ+ZDDK7CsR0fStLuu1NCR7roCQPxAPyJIvWgKWJRMobcaRDXqIb
	9YjAV0wD3JuRpDX8KOgtPDEBZLeJnOjJro7JTghjgzP8jGV8M2UPUz6IEyfVPo9TnLRvyywAS2G
	GZdqcg+iF+gIwwWriUiwyOj7ANcYZRKREu3LvJkK26j+4Uyy14sJHHt3aXsildrSynq5pzHg/EQ
	hFSjDCLRB2ns9+uqkqJvgY8X3df9mqvryiulzssxA==
X-Received: by 2002:a05:6820:4d07:b0:6aa:e7f9:fa68 with SMTP id 006d021491bc7-6b0d7dde466mr9079465eaf.11.1786846002959;
        Sat, 15 Aug 2026 19:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0db1e9f89sm5686279eaf.9.2026.08.15.19.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:06:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, hch@lst.de, yukuai@kernel.org, 
 Yang Erkun <yangerkun@huawei.com>
Cc: yi.zhang@huawei.com, chengzhihao1@huawei.com, echo.chenlin@huawei.com, 
 leo.lilong@huaweicloud.com, wangkefeng.wang@huawei.com, 
 huawei.libin@huawei.com, leijitang@huawei.com, linux-block@vger.kernel.org, 
 nbd@other.debian.org
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
References: <20260805122930.57647-1-yangerkun@huawei.com>
Subject: Re: [PATCH v8 0/8] nbd: eliminate queue freeze/unfreeze overhead
 in connection setup
Message-Id: <178684600077.2049660.1440871140596873147.b4-ty@b4>
Date: Sat, 15 Aug 2026 20:06:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 05 Aug 2026 20:29:22 +0800, Yang Erkun wrote:
> This series eliminates the blk_mq_freeze_queue()/unfreeze_queue()
> overhead that currently occurs during nbd connection setup(nbd provide
> ondemand and was using in AI sandbox e2b[1] to mount and attach rootfs).
> Each freeze cycle will introduce a RCU grace which was significant
> with multi-core system.
> 
> time nbd-client --name myexport --connections 96 127.0.0.1 1234
> 
> [...]

Applied, thanks!

[1/8] nbd: simplify find_fallback() by removing redundant logic
      commit: fe247030f1ce74e6bb917e219fe152270613073d
[2/8] nbd: disallow NBD_SET_SOCK on an active device
      commit: 04d8fb23e520419a283dd53c1d9cdfb7c5b1705e
[3/8] nbd: clear queue limits on disconnect
      commit: 0fdee7c5fa886554503001cecea049f053237381
[4/8] nbd: remove queue freeze in nbd_add_socket
      commit: 285908f554fe32d9ca7cb7c3a03a05144faeb461
[5/8] nbd: skip queue freeze when setting size at device startup
      commit: db285268df7948f6edbb7c8bb7cd02da3ceec6b4
[6/8] nbd: factor out a nbd_genl_foreach_sock
      commit: f8d21c590e55d629abed675554b186291ac08915
[7/8] nbd: remove queue freeze for newly created nbd from netlink path
      commit: a9d414b4a15c69b5389da3ec08f23e9f2926c52a
[8/8] nbd: add pre_defined_connections module parameter for pre-created devices
      commit: 326d49039c10b65522ac7277b19b9b5c42ed1aeb

Best regards,
-- 
Jens Axboe



