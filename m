Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F442FCC9
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848441; cv=none; b=cjrMTrrnnzgKwRLvYhSACKQFuXl142tQQ0mSYVMljMSEr+HYLJ8qh6JR2uMfwCUdWfUs62OozP/4MqgckBCs1UbuVA/Pd5yPbN6xfr/mRByTt92KqzuOATMe4mD1cW94XEQgTEIOK807wcIg+tUe8wk1SbV9avdguq+9f9+OUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848441; c=relaxed/simple;
	bh=ZArUxw9bYziUeO9DjSFlEmrEHR19mhW9P1kY0G1JwDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/giVPd5/0x6L1KeoEgq3rwRoHh1+SaeL4uO63eGktUx6ReVE4fibZb52MDtecmrTjJf6EdvXfTkzFZpMY/2ZQg4M1Mu/7f4Vj9ucnEwsv0HHh/XIaKm7A4k4JogesQs+1aD5qTwQZ2eosMIwmM3PnEGS03YuKY1mSNi7qdzwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=riwzQ5Vx; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="riwzQ5Vx"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ae45c58003so2073073eaf.2
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785848439; x=1786453239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esQztOvye8C0iC33tB1B7gy5m42vkTB8iGVGoL4MhN8=;
        b=riwzQ5VxP+U2XzAKTSbMROM5RW1NlJ2ZiNX+ViQzMPjjNhMNzINesB0LUb4h4PoNn2
         il5GIovQIB2uBX6mFBnYcuJW7g9gjli79fP0/erYrF8EWeI2tsMMruHvLkv9VVu0GulX
         WxkJeJzm3rZhxGnhyJm7YHEVrX2UMF+tSLVaiYBIf5QsUgWE4l4gWK5WG9OmkRvAeqQZ
         v7eFLIoS+GaX1dsbguBLQK+qV5rrmJVSmutwgQs0kct4csed3OWrrEs1d0biekYuFxeK
         HJYfSSUCF0fCVkzfzum+EXc8mitiDZAYabmPLgK74rJbRHwI2s5o4lEZESu+/1damVM7
         JxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848439; x=1786453239;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esQztOvye8C0iC33tB1B7gy5m42vkTB8iGVGoL4MhN8=;
        b=bJ6HRWgZ52bPawmzG3VBWkmfqZo3PAf70ASQq8sHPMyGFPP8/gIHStSOA62N2BQhGe
         /TLfMcUTmD15I7oGvVyfVNbyJYFq9AFRs85hy2hJSIqARy9g4N1ZYlYIW9nCzF7vOE9I
         qiflZ/0IJrp4IU4Ibwr6iNzmNWg8yLVSWycHRzmA3fPdVrs11BslygMK829AlOCCwdnv
         f5DDMjXCGC8Dz0/RcSB3TvPNNzDluSwZy6jhz5b1YCi7NyoVkUHh95075yViulJtLEpO
         /51730NtLJQzcsqwxRdS14xXUaDlf0zQT96ihN0YyEuVQE2G9KycSMEPiq++fcwoct3m
         0s2g==
X-Forwarded-Encrypted: i=1; AHgh+RqxH8mAVU/JDKLf/wjufClQpY2r7SVE7KyBXkgFFZDMT6TpUk8p6jL35k1UzFgPtiAe1TVW3gZQX9mD8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YybOpVYCrZLDtYkaKjXD/o6xEvnGJr5nYHgwcboIYeHeruqOXAr
	ioiNPOJczKlZCbCN637WBsV3kFG+fytsyBUVyKDyWy9BmHwDp/XqeGyasABGJQcfnb4=
X-Gm-Gg: AR+sD12x/kfIctqylzyiw8LUgV5ZbCfvwvoXS0+5HHZyBAi3ip3utdnTuWD6bay62zU
	GCM5VV1iPHzWmSi7ZgOcEnl4cIPPsv0spnu0DFGnedsH+oO5vrMnDRa14e9c6MrFS3tIOWGTNI8
	Mp5tVA+ZUUJ0ox99kwy1gyk5O7wfABtRb1Exkvo6b26aHSUTv/T9qdTGF+hX+Iu4SgSbeign4IV
	o20t8L9n4QJuPQYvLanp6PteTjFdyiA76lSVrg4do9FgYgG5DRH2S/TUW1IZgtTyqIoiMzKmoGK
	YmquI4lln+FakyXRIuSUUlOTTR+76Q0tNkJk3vRuxnHNbYAxYQ8r2v3U/+g4+A9uEK6BleUdMsC
	G1op0a/KigMXXr5xzN2mngoAvtD9e2EjTEhp4TC6/jXEejS0YcfzSLBy9/GYAZ2cMH7xhZ4J6Eq
	Oo9NuK7OgZrL+R6fLdkjo6RMj9hj/0XKtCj7sQMaPEP1vkSyiXvagorJrh8cbJX4pwX6Lo+LfoQ
	KQuBI9Hkz78l/VWFFkWBmwEZ2+olep3BYCWVFEDQw==
X-Received: by 2002:a05:6820:2904:b0:6ac:b3b1:a5a4 with SMTP id 006d021491bc7-6ae42f5c8aamr21094013eaf.0.1785848438610;
        Tue, 04 Aug 2026 06:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm61530eaf.7.2026.08.04.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:00:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20260804125038.740388-1-hch@lst.de>
References: <20260804125038.740388-1-hch@lst.de>
Subject: Re: add a ZONE_RESET_ALL uring cmd v2 (resend)
Message-Id: <178584843753.926496.12133768325371025674.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:00:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 05:50:16 -0700, Christoph Hellwig wrote:
> this series adds a new ZONE_RESET_ALL uring cmd, and cleans up the
> io_uring discard support and the block layer zone management code a
> little bit in preparation for that.
> 
> This command is useful to speed up workloads that need to initialize a
> large number (or even a small > 1 number) of disks.
> 
> [...]

Applied, thanks!

[1/6] block: remove a dead return statement in blk_zone_plug_bio
      commit: 858d0abdb890006af3eb81e53c438d69debf51b1
[2/6] block: allow REQ_NOWAIT zone management commands
      commit: 9451934953bf1a4cc8e88179082785f3de5e127a
[3/6] block: remove blk_zone_wplug_handle_zone_mgmt
      commit: f3dfaf68ea3691a388dcd4c86c249f4544cfa898
[4/6] block: also reject zone open / close on conventional zones
      commit: 13270876ce4eab47a218f31f0081885639011bb9
[5/6] block: remove most blkdev_cmd_discard arguments
      commit: b3c5f8d05e68963dea7c0cb9bc60e9e669b5c54e
[6/6] block: implement async io_uring zone reset all
      commit: ca8f6548e6f79761cba66ec8cb45bf026da8bf7d

Best regards,
-- 
Jens Axboe



