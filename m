Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A11305062
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773594; cv=none; b=UYd7mwSprTt8E+A9+PtAQQhRIIWJkrK5AYwaA3IuQvv7UCP7KBbPZ2dU+4fKyF+ouTNjM0XBngYV1/kYgIACcR+9wwM/C8JE8hTbknkUsFMwQBilCu58dgebzxI/+HvVy0jSCr419hAKQXM4OIgY10ZHcky7rcJv945NVZKi5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773594; c=relaxed/simple;
	bh=jtuocc51/h8t/wZRuBjaL35U96u5f5lT/9VylZ9vxu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BMke1Ee1Y9Wap4g/+aTxxA2CNdEOqboc2ve8TvzS4rbwemxSp+Ad/i0rZoVlsc6vvJvVHMVEu5lSCqTSqs3Itvo+ZScKSPbnV/MEcmni29aM+6ZNpRzKgl5oO5a3llOojUJcCgR840fEajkplZgvNR+YOFN4N22mUzmZrFgr0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XDNHa9K8; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XDNHa9K8"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6592f1f55a8so1511757eaf.2
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 06:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773591; x=1765378391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwNBgMdZ5LvjnOkhly2CXfw1sKpyPR39td9uqnzg65o=;
        b=XDNHa9K8dXawKVk3HqH3nPwcRRFOiYIQHeAip60mTS8WG5HOc2F4lXTum7aNrtmDeD
         +6HNDeLJuX2gsahKbi7VrNoRHJoOAuiVTXWjpKPG2v461QPUe4b6ChUTF3hhaKuLG2NX
         ivIz1WT0+XmVVfJdThnfd1LRLShwK2KeL9Hhb3y1jEWiI+K3lL5/IwZm5vf3FbSwsxHm
         Lwyk3Qh6GAhrxX++fnkZYaBhnG4bJb2xT1YpNYoC4SuQMBAIujaatCrS+7m1EQ0qKk1/
         hLX+KpMw/fApJx8eHcabUL+7qMvmqi3pI0D0LKbQFaBrKstwytWCXVt1EyC6D0ApAJwg
         z2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773591; x=1765378391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwNBgMdZ5LvjnOkhly2CXfw1sKpyPR39td9uqnzg65o=;
        b=HJPpv+o/gMtiapbPy6sppnfiXnQCSECGIYQWR9W+4OG6ZCihWMT9SD7oMsUW8tnZl7
         34+dyAg05YvnvIWsYLUwxusJ+5ZPiUvorJSr0UHO4kLn/4DRIIGMxyl1FPtefAltNrBT
         zTltg6kflaaN2DqM4e30usXhwP6vovCxIFxqO297sQlr8lwFT63KEDCCXd0Mwt32VUO0
         2cxCFkk5AAh7WZJcIMJp0uH6wo7v2sz5oHv8KGnd5fDqYULwg367FvqIGKGkjgpbQp4E
         7ls4BcW8hHvdxVQ99ztcXt7xurDF6RDHB5uSILDaYEo368gCRGjb5BAMWEXk8DZPNtxt
         ZrSg==
X-Forwarded-Encrypted: i=1; AJvYcCXgqRWhVil3UILkoZAvUlPMesjmc7m1uqm5KpHx3PbOYhcw1HsNLnPcS+ec9+v6BNxRnNYUHpJKjHF1Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQogTSIpFS2z8BurTUqEB64lMu9DJde4Hvio86uf3pzQEoVxnx
	NxK96HRv2hDgKt3xgaLbQFsZa/VYy2bpAqRHhklxLuhXkCZCsN2WXQ7TEN0c5aqd0NjBGPsAkOm
	BxRe+UJg=
X-Gm-Gg: ASbGncsnxLVe92QTlhUezHb+87ivQTzJ3vc+7kzaPLALJDl2NxN+V9fOtJARCvCYZek
	0h3rhsg7537nHO17TXsYjuUjVcHoHIkUmcbIYlQLZXOywAvFaOeSwPC4+AptoLMVjhQxWy9cV5h
	v6pE8AbKYAFMLmFVBWjIZdB+4dsDUrLKzv5a41a5JqP36RV5p6zLK9gEVtAyiPn3zVRYRAIWsVW
	fB2MrVttWgN60eatB/yyLqfkJ/T6EQkTULjXNJeBx9ffeDxO4xQXsaZX9AJb7bKlwwwIGLSuAzN
	h4wooPJA5q9PDuFpEhXz3njcPtzg5z1ijsekynubd8nBQySz84QLwwi0vbFoyFRyfXAa4e2mKz6
	eiu8jVSSR38Js73ngYS4IKuJTssW0++GK8dlzXlH558/BowpI7UjWzcesAbEKa1VTXDqmDsvi+W
	M3OQ==
X-Google-Smtp-Source: AGHT+IGX9FYZokhfHs/lgJIZQiuLd04h30UfBxWKsqLgkGdXjaqr1fhjzDqwLN8usJ8dqcVEodZl/w==
X-Received: by 2002:a05:6820:4c15:b0:653:827d:1abb with SMTP id 006d021491bc7-6597264d955mr998702eaf.2.1764773591501;
        Wed, 03 Dec 2025 06:53:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, pavan.kondeti@oss.qualcomm.com
In-Reply-To: <20251203-blkmq_skip_waiting-v2-1-aaf38fa5883d@oss.qualcomm.com>
References: <20251203-blkmq_skip_waiting-v2-1-aaf38fa5883d@oss.qualcomm.com>
Subject: Re: [PATCH v2] blk-mq: Abort suspend when wakeup events are
 pending
Message-Id: <176477359034.834078.12163250354684501835.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 03 Dec 2025 11:34:21 +0800, Cong Zhang wrote:
> During system suspend, wakeup capable IRQs for block device can be
> delayed, which can cause blk_mq_hctx_notify_offline() to hang
> indefinitely while waiting for pending request to complete.
> Skip the request waiting loop and abort suspend when wakeup events are
> pending to prevent the deadlock.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Abort suspend when wakeup events are pending
      commit: b1e5c96ab4a011763afac033f6660cf1eb499458

Best regards,
-- 
Jens Axboe



