Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111081F7098
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076869; cv=none; b=TqghpM95BnSUuHhWfmkokoNVSQpmFnYY8suTfkwJ92RN8oHoVuWm9Ib9eBA3GhNpNuIAvk9CPpAs+1hFvg6er7HsQ+ETgGK9ws1PEBpi4eh9W8pIY5oJhRSHlrfnl42R/811ZJdQb45mC27buMKNxLlYcBNLv2UJuv1Vv5HCRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076869; c=relaxed/simple;
	bh=tghHpoTI+qc1YVssA1JPagGN31CzECAZDIErhd0wH1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLhneUAO0W5RL8D+RhYpcxaKQDOYhQKQqLng6sVuhCr/3CRRfxBmAwwVihBNOvg6/fhh9NC1jzDO2eM5815bj5YdlwrscO+nA6+KK4Q7ohMrnss5coOM324v7Dzb0/gVslRTwMSjS6bSuGAvTIF0N++QgZNbcLejaDWN5VyYaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yWfmC+ow; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yWfmC+ow"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f4f9ea26aaso621678fac.0
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766076866; x=1766681666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD2/dLxmoGzHyTW9YVdxWUphYDP/birxeNCzHK2BRII=;
        b=yWfmC+owMUPFCtwK6GKVRNnHncI3P/zJw3JWoWujzAopenODbFfoycntsZVtHwJ1um
         PyemU9/MKNBbaYy0bbftOmKou2QDzN4RvIZYXXWhdRKSjkG2DQaRhikLYAUyoSNMETfG
         ohSBiZ8Luvu7Y/jqBTtGgU1AYfvngwf2/y/xbPSzwajw2FQZU7Kb7pfY5V64AhvWqIjE
         Sa3W2KkKlvJnS5vjFUINfMQ6uIsJrJBfygBe2BECcykysC+DQQ1szYQHJc3HjEtt5JVI
         gjCi3xorwy4blcIsj3snN8ndsGG3RRUo5yyLvzuFVy0z5r6JJZHZsTLf8+NqX1faQCdL
         q/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076866; x=1766681666;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yD2/dLxmoGzHyTW9YVdxWUphYDP/birxeNCzHK2BRII=;
        b=gzvIrF9T2ccw29I8JFw57JhdmIvYdXOrCOflOnGgYjdCND5l2O2tT91Cb90ceuoPs4
         Spl1YwTavb5HBn/qBQv1S3lOAlBfspFxzeylLvkZNga/yIC+2Uh9CI8ixgTyLTpTcVWl
         q9q8Lcptia4ONaZu0SM7tW25YzwDJLIJ7U+TNVShEhJqm+MVOeOeg4UZ6dc2LGcKUODF
         TDEYa0jsAGlOFjFLryC+LdlOfK0ZuUChuy7p7arg+rWZ70EFvZA7pHzWVocrCgh7Fsgm
         LbRcB0LXly+rH8accSa8S/fl987Jrx4ooB2Fb99uqOtaRXoXnJ4ys7YSc33mAAyCQp25
         zpmg==
X-Gm-Message-State: AOJu0YwOVIQVnKTBDA+K7hIQm1dlbRGiNDz6aqA92SJEUR9q4fqYu9Je
	LUI101HUVrtplSjT+fBAA4IzDV9RqzIy/8ZEn6FX1pBeSBVLBxIzlHZr7qyXKT0zJ3o=
X-Gm-Gg: AY/fxX6Nl+hhJaCVTMeLtc9aCVeQ5+pZK86OwY+rnFFLT/M/MWufC9jgQRnyREMYYJu
	s6YDqPBU/uzKecwfeGvAONzEloKidJQRzCXflyvZuDNT8iKLjSqGegn26+SN1GK7vdQBb9+VSAR
	O/2qjFKievVlE2lB3Ntx323SzMF4sdTV5hIq/DCNtw/WYjBXi3abAoqP/q4MbHSbLFxVUMSPU4Z
	A28UuPpSCPYiOJDidIjfwYvEwNZs0IhrkgmAu3cLlZJ7ujDMIUpcN7G9UqGucAWZhqUg/rlxVPQ
	+OA6LSqz8kbkSsltU/4N+QbqVP/Z30lfdKTmV1jO8jXnCgneoGdyD14DHPBznRMwHgleNItEaED
	nH5sFZh+2Ad6Zl6/gcBlhWVIHvMickp4J3YHzufrz6XF+AxEaPq2WqUyhdPYw+t22IOLTIigxOT
	JnZQ==
X-Google-Smtp-Source: AGHT+IHDxNHW0bHiWcgFvnxwgdoQS19Y99udeDGQOHU7ZUW+fqU7RGC0jxJ/sTKG0mU4D9mIGJiUTA==
X-Received: by 2002:a05:6820:1687:b0:659:9a49:8fde with SMTP id 006d021491bc7-65d0e932cd7mr59997eaf.11.1766076865947;
        Thu, 18 Dec 2025 08:54:25 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17fc25f5sm1936800fac.18.2025.12.18.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:54:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stanley Zhang <stazhang@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Subject: Re: (subset) [PATCH 00/20] ublk: add support for integrity data
Message-Id: <176607686430.264355.9361744176497178325.b4-ty@kernel.dk>
Date: Thu, 18 Dec 2025 09:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 16 Dec 2025 22:34:34 -0700, Caleb Sander Mateos wrote:
> Much work has recently gone into supporting block device integrity data
> (sometimes called "metadata") in Linux. Many NVMe devices these days
> support metadata transfers and/or automatic protection information
> generation and verification. However, ublk devices can't yet advertise
> integrity data capabilities. This patch series wires up support for
> integrity data in ublk. The ublk feature is referred to as "integrity"
> rather than "metadata" to match the block layer's name for it and to
> avoid confusion with the existing and unrelated UBLK_IO_F_META.
> 
> [...]

Applied, thanks!

[01/20] block: validate pi_offset integrity limit
        commit: ccb8a3c08adf8121e2afb8e704f007ce99324d79
[02/20] block: validate interval_exp integrity limit
        commit: af65faf34f6e9919bdd2912770d25d2a73cbcc7c

Best regards,
-- 
Jens Axboe



