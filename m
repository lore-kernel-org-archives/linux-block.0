Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96D29C351
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345069; cv=none; b=egau5MN0jMy++zutLniYQONlCuqxzuQtZGOl4RlNdCJa2361sxf8XeZQ5gl0cccQZ0IuL0Nv2P5nG7+Um0fGObk55LqBAdc+XNcWby+7TlBK5FRoSDFOwSdN9vevxMsHyz61VZWBUPM18Mizg4BXsdgOkydRvG2dcHpI/t1pCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345069; c=relaxed/simple;
	bh=CsIPvAXmZAZ+fvM3rL41DaVWNzSMVbUulEqcP7Yq/A8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2ZHG8FZWJFRL3XUYuJXClYzGqngH/uhTjr0cne+urxUhO1WkfOr+qdfjURkANkGA6/MInhaL7F1xb+kaN0X3yXhvpJgpZFzRmvIwWbrgqJGN7CPOQztSOlMD9tj5bXage3vH5srNFa2sXFeX2oICX481T2RNu27ojNnjFle7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UPS2QLib; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UPS2QLib"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9387df58cso9891653b3a.3
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 21:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765345062; x=1765949862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn3LBvC7zLUxb/SCOQFQjYkYFXRvizJWnamCq6WRwY0=;
        b=UPS2QLibIbUGX+yvvV1QotUaY1lTUCXG7ZAEaEk37O0V2eBAZ+03oT5evpXZn9bd1i
         jxbOTxzn/AzP2ybTKdPG9ww5f3/vln0CpPBXhuj691FUk78SPN2dlh17w/atr0aNqOtF
         MqPdKhpj2DUllrkLqyvToSa4pYRXjUKDve7GpGrNzbq5XhllBNUpiirZYHbuSC3loqt6
         OXZE3x39hZeqapLdNfTQr/pePQJtVJ+9sCPcxfc7KiH/6BcwMHuiduul1kTBCq3ZYC1L
         BpEqSRF6cRHQRkfhQG9OMFlZ35VVI1Z9OsJVYSc+V14m4ZBTqB0/8rppcgnDM1NZXBbl
         qH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765345062; x=1765949862;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hn3LBvC7zLUxb/SCOQFQjYkYFXRvizJWnamCq6WRwY0=;
        b=NJ+F/xDKfFLGcgv1INeOLm6H8e1MMCbNIqzcEAGrFGNhehxsV5yD8LqBp86H8IO0fy
         /ZwCW4jBdYFX5Wlkz0Tu5EKOeeuRbiL1w19xYyCxlPVPAWsskzY6Vq8WKiJnlgEm7X08
         Z2U2mBf0U7mslqvQjuwaINWaDN4zwUHNxezN7C2Jq2GVMNm67GBdYjsGq8YnIm17E0Kb
         TjZPnoAznxr6nXU0/r+B6TA3wAsgnGFeiobwPPlcm9XKCH1MJyFRud9Dl/Q6JY9MW1Jh
         NE3ISMxIZ+N4lt4BlXRmEEkU/AQ3PBEblBcRpRTU2GJSW1fbwDpT4atg6yO3C29KypC8
         zLjg==
X-Gm-Message-State: AOJu0Yymc3Z5TglmaRY8xMZxwVQijIaAKyTT8642bNUIG5ILhubvFDVT
	fIll1SFLVwMcxxnAPswclyupEAi5EPLgAQW25LEZsG+aAaKKtN6A9vJNvRrVLguUs4mbvXgP2tB
	mRYK1RgxVMw==
X-Gm-Gg: ASbGnctsYY8LnrEpxgHNc/BPx5YDXhoCadsVcmK/FPDpw97KwzmluJSYBwMYk2Q/0Oz
	pzDTKjdEwjN7Rp2WhvBzGivGGP1Z9EVfL/eaHO21okc4ABWUylVlXDnzAXxlQkVM+4VfOXS5ew+
	K/nJzMVzsQkMZjmh8urmZR/8YojNKdXR1GJbUpA8kRJfUU4C1I0p9I6ltUfCRdfZAlAGQHrd315
	LautWtj4Uap6h/lEDuYpw6aDv6G5kmEd8M9n9zhzDBVf7aN4BFieETjlDK6H1MQCyu0+xbwugcE
	Q5BdV4/+2AdG6xdP52gGwUUGW7O5843GCeyDXwlGh4H06P1Krasy1TkYq1n04fHCJxvwg1cRO+m
	pJBrZNdu5xvWXUlwNAsl7MUsF6lXV/8iHeipZj+bVOn8Nsvkv3N9oieT/aM1yADym2HIunCfzYI
	0GTo2MXLWHxdg4UZxjbqiF09N4XPNu6qIj+Nh+YA==
X-Google-Smtp-Source: AGHT+IGevQ2kn0futrNSS9/kQWVUenvdnX1av6YlEKOQZF/7jeBAKoDIw4HvnRZiHoSBGdpvOEVZsQ==
X-Received: by 2002:a05:6a20:7f87:b0:34f:ce39:1f47 with SMTP id adf61e73a8af0-366e288910dmr1123725637.38.1765345062085;
        Tue, 09 Dec 2025 21:37:42 -0800 (PST)
Received: from [127.0.0.1] (fs76eed293.tkyc007.ap.nuro.jp. [118.238.210.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a1caeea7sm16682779a12.24.2025.12.09.21.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:37:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>
In-Reply-To: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
References: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: fix cached zone reports on devices with native
 zone append
Message-Id: <176534506042.363990.16692802689901355633.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 22:37:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 10 Dec 2025 03:10:37 +0100, Johannes Thumshirn wrote:
> When mounting a btrfs file system on virtio-blk which supports native
> Zone Append there has been a WARN triggering in btrfs' space management
> code.
> 
> Further looking into btrfs' zoned statistics uncovered the filesystem
> expecting the zones to be used, but the write pointers being 0:
>  # cat /sys/fs/btrfs/8eabd2e7-3294-4f9e-9b58-7e64135c8bf4/zoned_stats
>  active block-groups: 4
>          reclaimable: 0
>          unused: 0
>          need reclaim: false
>  data relocation block-group: 1342177280
>  active zones:
>          start: 1073741824, wp: 0 used: 0, reserved: 0, unusable: 0
>          start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
>          start: 1610612736, wp: 0 used: 16384, reserved: 0, unusable: 18446744073709535232
>          start: 1879048192, wp: 0 used: 131072, reserved: 0, unusable: 18446744073709420544
> 
> [...]

Applied, thanks!

[1/1] block: fix cached zone reports on devices with native zone append
      commit: 2c38ec934ddfe2d35c813edea2674356bea0fabe

Best regards,
-- 
Jens Axboe



