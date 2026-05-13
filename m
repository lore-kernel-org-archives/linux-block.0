Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDE3AE1A2
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702142; cv=none; b=MEGMDjXRGGpBFJKtmT3/cZApsDSemnwt41feceQCCXcQCN9pFdr95BEqFrJRGt4vk9vR2wEeFxBxajUz1QBc7txfxv5F5dIl7VnO8wUYhQJYkvI3QYWs1ovmnu31KyW89F3CAMCzIre46pyhiDRk8WFVjgzlh+Yl9LCy/fcI8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702142; c=relaxed/simple;
	bh=6q+Jlew0Fwj+Ewp6UZdrRl4SO/A/6VSjk4celCdXvTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aJMEdEE7Xw5Uw954u3/vcWvAK+H9FocL6HsDgRuDID3LNDkYOwp5/B/KI2wShscfk8Qyd/QW5Mz8JWy4sip58RL0XKszVZFbA1b1KSKzlyFrU1LH7kKiB9eXXoLzCwHWztEBTR23afZme50mfA6wCjRo/TzaGIAu9w5Ix1C/tdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Huic3uXR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Huic3uXR"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de4ed0593fso3755983a34.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778702138; x=1779306938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63STWXd9Wzpt4PhrJ/B9urLFnYXotN9z6wtEWKI/5Zc=;
        b=Huic3uXRAqUq/jmsHa2NBsfRiXjoa/vPexojOpjASE6BgTsG807o2YheMpXGIUXneP
         Z/t2sWQS3wgDk4th5MIBHDd067Y1kMlVWCEjV4FO296ftCeE7RJTRHYNwpjubvg9sL/y
         eQsPuYpW1kV1+d/FTPihD7q4dApBVKwbwJcsFWrxshG5R0Xayu5Hwaw1jE/Es2NZkMQw
         FwBjiASSdWnVgovI4rGAhJ18S6KcfbOdTdVapvkk3Kq/4IPJ9nAkEo66Bwxs4rSF3CAM
         xJ7UUsc+ZBHMC7eR0L17Re+wDZw+wcOo1p6/jkj0/iS8dD/A2XRBZ2Mk6kPrE+9Sl1xM
         YuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778702138; x=1779306938;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63STWXd9Wzpt4PhrJ/B9urLFnYXotN9z6wtEWKI/5Zc=;
        b=FkIDAAg0tEni3tM4qFh/WAXafL8YdzrlkQ78arCvUq/z6+GC8+MuhDlIhFMusrBpy4
         dHDSCzY7XrjpmICKlnA0mgj+RMu4iQ9+upJIWr5kDXHD2ZclgmHGSbv0duvVuVrrP6F6
         F3aEKfh1LWeaYAwyjzPerbowniL7D7XZ+A9mD4FAiU330MRcWPZoJ5ScGG0LWVZUHqLg
         NWL/Oa4vGapeTW5mmyCpPeD7xuIchPXQbAmd5mR8N9yE1z03QnQo/3wdFACGRdKaYWJ9
         XLvLl2abE3tbJFNrpR/oaZfoyTpmfi7hnInf6RXgXz4LD77X7EnzLaahbEzZXIoZXxYT
         dLjw==
X-Forwarded-Encrypted: i=1; AFNElJ9bbZYHZ/soXfXKyyRSAmphBjjOEUXX4UxBhVCvUqTRAvXq0crOXOZHC/G7Y8YNMtxxH+1loUsM4PJROg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2aTV4NsmlrJ44bXXaM0qv4qEwE/YpwiBcs4EHztVlatJlyOR
	yArYOcw3VlhN/F1yLE/E0Skwt4gnMlPX9FPmNywAnkT+CwFQE9pNzWDGHBCaHRih83C8lbvQnho
	aw/bs
X-Gm-Gg: Acq92OGJ5wiqH+rCoc/MbeOKhtvtJ1X31JXsXMxE74sem3u4ec1u4DDZkP8KSqcSUjA
	+eJD6QftMCanbGeyCXWzpCwgJS/jdgx0qEggwbRltGa23LMY3nxMy7QVGkv34CZ6NhglHXbrAzi
	3/GJ1XsLNC0cpBfTwMOwQthO5tHMC0a80RplOzswaz3MdBlw+9XmSwPgsUiyWPBtzD8V6vCxWIy
	9mvNPE4MTsdA8JDYcXrXPm3r14B8Vsdogr4+KYNIZa0Cvh1KcOM71avm4qMCbhQJ4XNUKP36JLm
	5VhylcqaEj9asXcdaxJktH7GEuVnBzb9yNyrKpAatzDCbe/HUWbKLwtv+E/HdBVG7e5eGAKcWkt
	XK/yYrDJ3n/K/lTL8mSjq9FhGMz2X9seR/X5j/9A8V3RqwVtRFqGa+cwaAgAwqlCM+7Gx/E53lP
	djzWrjIpDo4uvcJvB2CxOllfMsh9uNLal65YVO3mTxjskjEladIdU383DO6KvRhpbQRqLheQ+Nm
	90eeEb4MwUf/A==
X-Received: by 2002:a05:6830:6ac2:b0:7de:b878:3106 with SMTP id 46e09a7af769-7e3da08eecemr2719920a34.7.1778702138210;
        Wed, 13 May 2026 12:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f3edbff9sm260584a34.21.2026.05.13.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:55:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260507050153.1298375-1-hch@lst.de>
References: <20260507050153.1298375-1-hch@lst.de>
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
Message-Id: <177870213725.543218.16808866598223942501.b4-ty@b4>
Date: Wed, 13 May 2026 13:55:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 07 May 2026 07:01:46 +0200, Christoph Hellwig wrote:
> this series has two fixes that make the new block layer bounce
> buffering code work for the block size > PAGE_SIZE case.
> 
> Changes since v1:
>  - update a commit log to better describe the applicability
> 
> Diffstat:
>  block/bio.c          |   27 +++++++++++++++------------
>  fs/iomap/direct-io.c |    2 +-
>  include/linux/bio.h  |    3 ++-
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: pass a minsize argument to bio_iov_iter_bounce
      commit: 32d5019ed3b6ff4439cb075fb275f655c8a2059c
[2/2] block: align down bounces bios
      commit: e7b8b3c5b2a65595d506ffedafac66f0a11fbdc2

Best regards,
-- 
Jens Axboe



