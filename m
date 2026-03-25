Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB4309DDF
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444286; cv=none; b=TAQurcTaKSH7HjUK60kUQWcgbMRAw8tvuSkUCdDuFNrTED5u7LCE8ZlMkz2E6KkZkr1cNBhi1IEn31OFSdD/tGU2Z1/KIdfYiIchckMj4fFKECjR7R0LNagIoQjrNd1BKxaVVzFoydTEaocGcRWlLmUil3xiuR4uJtCANNkf5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444286; c=relaxed/simple;
	bh=F09RpDYHRBA6lYlGIBea+UAm2kBqf8NS1G+Enooo/MI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mOaHwh167wG3CZxx+GFADKWsgRoH+51KOnJrgvn6K2gvfW1yidM2PC07n6agGOidoQhjiFrIP2ZtXGM2qq+l0TvOY0tJ2aVAjaXTJdKb+Wtr892Hz+3S+0rZRgagAt+R9XBf/qTbavt88ftxBi4GKhNqYf+Xk6pocU5HtjoIbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cdpHvbqU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cdpHvbqU"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46701f2077cso691280b6e.0
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774444283; x=1775049083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC2ObV9cdMAzqAZJr551Ymm7rgS2/aiZAzUm2n00eFI=;
        b=cdpHvbqUG+aSmUmc3qJV2Q0MiySVM6o9czECLY9Tr51oWTtT0l3npK+LYJfLNbUMxL
         O01wgM6lQ7qfcFk1pvyo9iF0vAdQLTrZtb/EZwlS/fITd+wQJHGI3+miSn0bmv7vnK88
         ZD/DRQXetG6nHM5xjdIIrtkU3BtpYf4ul+X+ymRNeNT5EEehC+LUEz2ONM+trSmw5eoQ
         wFfcbQvfOlzkwUWmBgA96qug62XA+ryvinIILH6LA3iyG3Ye7wdmH0cGyyee+C39Y6Jo
         tdxZO0mbcCNraOyaCekFnMX0+A0l3vr0nU6E///dhv3u8XpyVB7JmAnG4Q1HXhRP5uYn
         TBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444283; x=1775049083;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SC2ObV9cdMAzqAZJr551Ymm7rgS2/aiZAzUm2n00eFI=;
        b=lSouBsOoyz3gPQCSLeLEo3cFVReNHpz/qUPkMTZFRuVDHSdbodvFagc/6d82XbQMDW
         sI/qA1veEwgtfLBCUfR/cdRreHLWByVwjidH2aGYQOmcWLJTkmJx789I5X/ZwGNcCB0I
         XnDAAP9SE8nsh+Gy02pkIZlG06Hw8iou2r6C154kpUAkBzCQ015jUvenEQN18lsJ41LA
         HKbmxYXhK0KqqtfAY8yRc9atZba8F3g3WqiRm3SoXqQSV2GBC7zx53NRFDuv6N7ruXss
         q5NwRzzIPKQTK3e7QnV1Sl4gx76ySlo91H0rnu1LbLxNV4ba2T5bBNOsn8BLE2ll/+1U
         aR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWvc1ElsHQDfAhA6SWUV9iACxNKKol4M5Fzz8LyCWhyN7LPDNildecp/eclsAFZw5MzTkAzPe/Mga0Ymg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DsnriHyQNQFhKtZzp0Q6EPga7Is2epLxwXx37O3xLo/LXLOJ
	UxssSg6YA8GcAlyi+ZocswlZ1iwamglfc0mu+VfhcDvCkkI3P8ij+9/tLYy1NwzYFdPMzTKly+a
	Q8THjcfo=
X-Gm-Gg: ATEYQzyvvbrUimpnqqIJT2aZmg+PHtTbhHN+kPAfVjyijCSY5NUmCSl87/UuZpkeKLO
	iYEHfmo/wweBmURDdsVnid6DdcbxPNDQqzBlv3DffKv3b2qSrhXQ6ml1I0FKcP0yPHZCJLiFERS
	mqj21RD8kDrkq3l24xdpygMvYTxJvnAWLznXqGDnUCx+WDATQjx0Nny3QBV3w729QJX5a+8t1v1
	1agpaiZDKUUQg2Kq7HdPdz2cndH8QFXyfT3CQlqc6PzGyiVpSFy4ocGLx42OshrGKvrLNHTqPmd
	NL0s9upV+jFFkBRR5c8kmf9kr/l98cLvK4I4iv3X5RhGOwDdlqubceB1ajXbb4N5MRNYdUlwL+U
	YMKzYy7t00pV8LcFkIkEObllOTWRvXWf+qV0MUMknN99BZwcZCL8Ii3dSaVcjVgaWZWtx/XBi59
	dOdf+9e3rdoOPZ5K0ZaPZhrs3ZGQiZ+V3airmpEmazigB7HoKF1j+QlNREfBNAZ3PXSC6Y4vR5O
	aXENy995imveRw=
X-Received: by 2002:a05:6808:15a0:b0:45f:ea8:4184 with SMTP id 5614622812f47-46a5bc3e2c4mr1610795b6e.13.1774444283229;
        Wed, 25 Mar 2026 06:11:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4b19csm11275093b6e.5.2026.03.25.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:11:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
In-Reply-To: <20260324152907.2840984-1-christoph.boehmwalder@linbit.com>
References: <20260324152907.2840984-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: use genl pre_doit/post_doit
Message-Id: <177444428198.640671.15773217946231288835.b4-ty@b4>
Date: Wed, 25 Mar 2026 07:11:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.1


On Tue, 24 Mar 2026 16:29:07 +0100, Christoph Böhmwalder wrote:
> Every doit handler followed the same pattern: stack-allocate an
> adm_ctx, call drbd_adm_prepare() at the top, call drbd_adm_finish()
> at the bottom. This duplicated boilerplate across 25 handlers and
> made error paths inconsistent, since some handlers could miss sending
> the reply skb on early-exit paths.
> 
> The generic netlink framework already provides pre_doit/post_doit
> hooks for exactly this purpose. An old comment even noted "this
> would be a good candidate for a pre_doit hook".
> 
> [...]

Applied, thanks!

[1/1] drbd: use genl pre_doit/post_doit
      commit: 630bbba45cfd3e4f9247cefd3e2cdc03fe40421b

Best regards,
-- 
Jens Axboe



