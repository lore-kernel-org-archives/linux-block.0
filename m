Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A361272813
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545351; cv=none; b=OOdMfjofcwnnKpPmWXYyD/ZSJG61PzgAh+pnpZmodUF2o0JvqTHKfOnZ6yiFqqBge42b0AKFFYZrq9f1IOfpIzuvx7YGldnYbsyKcQ1PkjyCAs4HVD8MnYt50nwq1albIkYcEzlR7q+7rF08BpNydaKqhbPi5dJacX07REFEcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545351; c=relaxed/simple;
	bh=GofE6YTi8tDd4PMF1fC8EH8gml/Iskji0dOAGmGHAcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E/P4ScysI5W4DUHIFsWtGq4mesj6ft/TTMEefJLu8N/xXrzqyHncPRu5VewIYFniZbNnWOWPIMfCaDYxIJ9sM16MWPlo/0HnbjaWqGi2o21Xuy4fr7JVGcpzeYMOI6d7xTVoHM4YAi2JuTTU3F3A8JEqGuhoV2jC4dNVYY4/zUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eaidjNqQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eaidjNqQ"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e56ffd34dcso20735775ab.1
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755545347; x=1756150147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7bmdie7oJNYJv6zSbaeL+FRnoi5z/k5uNxXPJuIDdU=;
        b=eaidjNqQn3WaUB5kcvE2yun6SOu3JNgQogjs5qx2aEYMnReiFA+CLc0p3kOPoswGMt
         Npmk5L2W7KxB+t+rJUtMxyz9dc3TVyB4O0AQxBNcqrSEwfp6Z006Io32xI9rrU3juHOU
         4wVkRjakRB1Wc9+aP9e4hM4O99RSunA0O3PsdgYge6Vid6zrSBKpI+PrdzTF/iU4Tel7
         0RCrfPUO7nRCAtdm6jw2SJp+zwmHRWa73docSBL7kLRfaT2wkGOX44hciJpS0bks7nl/
         LCVPPnWm1OHVbbBMSqS201Nhol/rEzc5l3Fz+UAmWlKX/YzxhPHzzFpQ3D5n0dvuV42k
         C4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545347; x=1756150147;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7bmdie7oJNYJv6zSbaeL+FRnoi5z/k5uNxXPJuIDdU=;
        b=IbDpfyyQJq1mxHg1CST9SBEunWBqzMWVDUxVQuvEywfTEkZBmBFT3iaWGaJDBhbak3
         v8yKB7zIY9FtEIAgs+BGvh0wesCpNxEkylEgUNc5WP/puQb8pH39Ib2xSWR9CdRuN1DZ
         TwyW4qGycCM5/QBXAikIuCq+K4QX4ZUrSKVeBq/qXJLMbZ43t9bbNu7up8pID4oCxyZZ
         x/uEFF7DQ6Uh4HmlWf1zjJZDr1IhrMxV7EUuT7m0lupzEHlu6g1hgYcLImnXH3yhTiXr
         nKpv0TTPs1qmSZ8I5G9zE8y9pr/h1p8r1r/W3FkX3KKxcMbdpmXUXc0Lapbh68dRGJkx
         WakQ==
X-Gm-Message-State: AOJu0YxAiWT+FJ3IOHCq6c1y8riil6y+ZxOO2cOZ6SGCYxNVSv54yZOz
	2x8he5C8mxQZQmMsni//FYyBSGM7tqRQk+qdNAuUO3/SEkFhqMn+AwgM/85Q3c7/WZ67S+eciAK
	kzOdR
X-Gm-Gg: ASbGncsSM7XEMSkp6Bapbw/Zf6eFY0FFF/46mVe05qf34lS1JC4gao1izJNBZ0gcjTT
	0+PRVyU3yCZXWfxj6FlIwXwWLZZ7LnRRZraccpDbcR+KUQY2ay/g7NmQi4wQznGyxVXse+FZmoB
	syZ5kyH24U/PaBcx4haHawzcb5sK2oDsJeFTBaugyep1WM2sffqLewbEXt8VQ8QuDbwhlwC17M2
	PFyqK1ithdJmWdmPcVo0YeUvZ5XtMqJH28mF56982EwrKfCbMpy0hgLn1fUQnluKk+6a5xhumz2
	bh8JdnbJsI3Uc5Jsm3feXtuvA9y4XDS7qqib40iiWofLYfV8VHju2CQHUp25/HZG3nf4WSmL7qJ
	u4yqWNZSdLNRguuSzR6aYbu2aTE9EBEsOUNw=
X-Google-Smtp-Source: AGHT+IEOeTuyHNg9HdfWZxE86MnRDmkjD0AIkZgjMitSkMds+oqvGQoyvNjBGtO1h67OZWoewPUj0A==
X-Received: by 2002:a05:6e02:12e4:b0:3e5:5937:e54c with SMTP id e9e14a558f8ab-3e5837f0706mr207297135ab.3.1755545346761;
        Mon, 18 Aug 2025 12:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f8936sm2854232173.83.2025.08.18.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:29:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250818101102.1604551-1-hch@lst.de>
References: <20250818101102.1604551-1-hch@lst.de>
Subject: Re: [PATCH] block: tone down bio_check_eod
Message-Id: <175554534587.130800.1528683742261585412.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 13:29:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 18 Aug 2025 12:11:02 +0200, Christoph Hellwig wrote:
> bdev_nr_sectors() == 0 is a pattern used for block devices that have
> been hot removed, don't spam the log about them.
> 
> 

Applied, thanks!

[1/1] block: tone down bio_check_eod
      commit: d0a2b527d8c32e46ccb8a34053468d4ff0c27e5c

Best regards,
-- 
Jens Axboe



