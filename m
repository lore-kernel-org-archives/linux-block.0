Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2E429023
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162808; cv=none; b=Li9KWZ06u6TjPnU/WQXU8KijuTqq1U+27RrUMUNO/Mg/B5cvHmQBqmxiJFaMk9xHk1nsjj2Ba2RD4lGN2qDzjbcJLE5HcH9AZjt/g/pHF88+FGjwMwC8Bc72BqG3EREPLH8SztFpgBwD0H8kqQplrW2gd/enz66HGmZyt3c57mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162808; c=relaxed/simple;
	bh=VyO1K79Lz34ejMT0RHkHWjwNTUH5wwxamzJDiRSmZnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c5MPmKcYZDXby95vpHTn6k/oY8avdKdWsy9Itfp9BztCrwHLPOImiARl5M/IHAjIzOz4UuVieyD+VKIek20E6omdsv4mpq7hYStGgt31T+Cl9Piik2ChKMyw9NV1zFXCqMYCp4fHA8okgWXgOClZ4QRa6Hti3bHlj0uCFSHmuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LYqZNsxM; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LYqZNsxM"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14373bcc010so933685c88.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790162792; x=1790767592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZx9PcFPLPyFZXmzdAzHYZv/7DOWsaDCWE/opqxmW1I=;
        b=LYqZNsxM0CzNglFjgXoCM4jQHdPeGBBB/d9Gm/sOlfA/vvOaNLwP73ugor9iyywAoW
         XWYkhBmS5Nta1ziJ+BaznfEPAvf87Ej2qdA9vVGED25ukTMykG1MHX4VJYEGrlmc76Fb
         53ibtNZCjAO2oPR1XpmgT7mfaepqXcLLLqWeh1XlgZs0eR77LMx5KCxWAcJHC1zshnOH
         HphNnkUzFXy/pUSGXiAEZ3wiBUnPBE3Pe1Cu1zvl1LqyvrExwsm4WTi4ZXapBj3Rllic
         VmWdMeU0uZfJ52B8H5KPXbiSEwG/PXpcE5mRIfY6kymQ9KLZfyszQ5V+jXKJ9vwsQkl9
         HMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162792; x=1790767592;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZx9PcFPLPyFZXmzdAzHYZv/7DOWsaDCWE/opqxmW1I=;
        b=dqRKCWm9hu3GkglKsBxT3gRS/Xs2MzmaWYTXN0M6TnLP8L94TV9OOpoxyF53jEEhRC
         O+0eR9/oKpdXqFyEyFR6AXw+iBYzf1pTUWlKDjLCvJ/681skDhacne75D0raST6v5Jnh
         R0UCRWpC1Eq3el5v6m1RgrJER+pGfCOVANeaqQeC/FgvOaddDjABVPc0slapiBHPuWdS
         B8H3/utGI/BeUfZe917HPsHLlPMPeCUowbvFBNgegLLlNmO26y8qIYFDD8VRwFJrs6sY
         HL1N9r/a2gRJ7J5cQahJKTxO2MEQnkxFAxXkweLEhirRoP5wYg9hMo+IpVVQYZTnwfqg
         RDBg==
X-Gm-Message-State: AFuF++kDFJH30uDChP4Pp5JoQHAQEE/v12/VjqHMdPBD0mIE2SdXeNo3
	ARqVRLTniGDP2nxbLA4Bn6sMYah/HoM+t8Dlo3KrTs4h5ZyU8PjRwjqzWJeZkdsIP6k=
X-Gm-Gg: AYBFou3bCstP1PghENU++qBvfR4lBIIeg4y5iGJLm2nyGJeRCr0CDzGnBxPtwTO8TP2
	tQJK6d1iqQOC/04Cblo9oWFN4EwvGw1azBjDoiq199DLEkjHy8sl9w2f4tWJI/ITUFQiQzkdF92
	koW28ahhzpehCrpQa8dYSDJ7oFpF0Jsk/voDgz+7rE8YiSGgqOLoB0hY3jopksw0riCIukSvzUe
	ZeQO4k72fQ34WMnECtmEWO7+pFgFvBu/AzzjR//O4jVz/tYW3g28Qa0vNTi+6J3smKDFRzzOyAA
	fhMSlN4kHS9HF70+nLEPBw3KuFBp5NdHAvFEIFTjJsMTsXDsEOmQVggZhfEp2Fwke9k4F6rM9t6
	Mm1gMLC9UTKOkuvh1wxA+mCE8D3hu3SoNL9Rso5mVNhtsDcfL5hLSRVWylYk7QRENJjM1Vu7wsO
	0Ja8jWP/XmxBjC/qCZMBysxg1dsGEKs9wLp+K8WUAEkB4nKZi0K19kCfY13NAPJQy9cHekaWM2f
	Ilf8a+v4RFTeFNgnclfFn1HJpp50ZIHA/rPcSXt+KqJolQGVNQV
X-Received: by 2002:a05:701b:2084:10b0:144:fd77:5b0d with SMTP id a92af1059eb24-144fd775b37mr1346059c88.2.1790162792417;
        Wed, 23 Sep 2026 04:26:32 -0700 (PDT)
Received: from xps16.local ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9895c1asm5703590c88.12.2026.09.23.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:26:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hare@kernel.org, hch@lst.de, Keith Busch <kbusch@kernel.org>, 
 Henry Hu <huhai@kylinos.cn>
In-Reply-To: <20260922172711.1573186-1-kbusch@meta.com>
References: <20260922172711.1573186-1-kbusch@meta.com>
Subject: Re: [PATCHv2 1/2] blk-mq: set RQF_USE_SCHED when the operation is
 known
Message-Id: <179016279175.19618.16478906134020595721.b4-ty@b4>
Date: Wed, 23 Sep 2026 05:26:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 22 Sep 2026 10:27:10 -0700, Keith Busch wrote:
> The cached requests are allocated for one operation but can be handed
> out for another. A passthrough command has RQF_USE_SCHED cleared, so
> using those flags for a subsequent read/write bio will insert it into
> the scheduler without ->prepare_request() and frees it without
> ->finish_request(). For kyber, this leaks the domain token acquired at
> dispatch and stalls the queue.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: set RQF_USE_SCHED when the operation is known
      commit: ab6c756f28c741d704a7c3e04814bfc3adf6f818
[2/2] blk-mq: allow cached requests to be used for flush operations
      commit: 9d2c70986bb7838c1c441a93bda415eecb52f3dd

Best regards,
-- 
Jens Axboe



