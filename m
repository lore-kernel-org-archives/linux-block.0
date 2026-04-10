Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022725A640
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783712; cv=none; b=dchh+R5uE2Uue2n/p4njs4XjJWx2moif0AxpI6mJjcO6loAsLcsUNVWKr0weggJ18qMM2wB4tS7ePGCW0EVUtzaNltucO2zMtsxdpVsUgHV5IGOrwXN8mrpVvIZkVVN9W4hLPGkXppoAzep9CI+b3dvXoXHESqW4gD0bvGlqoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783712; c=relaxed/simple;
	bh=m4Yi57osecIiTWh+0I+we3v7gFLIWpBPiW/KU08jI6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lHRU1B2Aq22W764N7bUX0XM2hUhKCV+J8MlLw8CPfXNFZAk4MrlTvm0Edd9IN7M69PBIghUFM6qrlfsH+xFd53x9a6lbCw9iD2SGakcYDTHo1dtS1ieNUx5vk4iMnMzpawgtOlQ6Ot5NA58Ube6zYHkEi6o/1K2UBjM0bfp6prM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IEFSwPqq; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IEFSwPqq"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ce102afb0aso1925317eec.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 18:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775783710; x=1776388510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v20A++p3c5A2QfXVs+msD4rW3k/PdvQwN9FO2tpvwc=;
        b=IEFSwPqqOsEZeoO+pDC/mhR3A9pNGGEpGE7gpZIsRMfvxpnzOusOZ49ZuphYAX1Mhb
         AYn1p0kPU4f7ypxKymbExKXBXdJDJON2NDEoJckqiVISr0JODaAa4pWKRcExx+XrJVpl
         Y1o5vGjNTYkEnsPCCMSmJ3GtzZTWAotDkzmie69a4veW9DPTCqyu/0do4lur5bcP6BB+
         xnDbMax+CCT1crbmUunmuRnwZ0O6giVVvcn4x+DnkIUEBKfxlVQf9CvgKZuepVkxvfLT
         aN3By7bFSCk5VGjqM7q/OnNWauFX3IewwpObkw3/X+QxPkEcZZnmG4ZpNCooUYa1eQk+
         M8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783710; x=1776388510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4v20A++p3c5A2QfXVs+msD4rW3k/PdvQwN9FO2tpvwc=;
        b=dUuSPAHt9OA+FEqc3UytRQHXQv0DAbmEz2B4twDUtC6Tk/0bEZv/5CJKSRMqSB9Jxc
         NwAoiAP/XcwpDtxowyMiwRiBRNocCP6SjhDe6WKWvi4CcbEvaYRiTiBra+Tnf1Rglhuq
         3n65HNSCDdc4dfnnbU9mN93+ToaCULAiw/QEifwwKFHtB2zBBvzDY9tuETZuZBGH3iTZ
         LiIJo/jxP+SQVCJpYxMAkiHnWsvjuWF94jq9WhYrEaKP6r5ZRIoxRyqOLE3qrvC7gtde
         d/mqp9R5PY61mRoU1CY57NIAYXnNbalaLgAylsN51KQC9uDlJDxR8cPPRqVlVZ5fEHGZ
         isKg==
X-Gm-Message-State: AOJu0YwHNAQheXnksfjSpstOpPuaejtcdevVHA8x3NCJOZ7ulunAV8u2
	DcRjHkmPph1XGL+JmhYCpkV5avv5y+YDw5A4JIbMWepvtBLUBdy8MDJaq7BbbaJSXpo=
X-Gm-Gg: AeBDievr1aWKWWcWHQpoctRaU2wRNMZEKBSuOxRBeTyhUlXpWjH8FEAm+t/n8IuAYiH
	99N65yanMswgkD22KmixJSUYwvoqHP/1fhqpkqOn62EXmyYOmLWn40k0nXG/0WBN7vc9Npl4Ul/
	Cywg8UlIH9F3y8y0wYe8zZp45bL6U3QCCP/evjz8lSPd0Pu9eke/4OF7LUEL1x7rO/WUlgYhnrQ
	RfKTO7le9OA6hb4uc0TzqJJJ3rjo2GtSzCXuxjm7sk6+ABSlm3FbD8NVyBQ7x+QTPx5jjj6UCDM
	G/4u/rVASIrvzFaybJ8c6NbcMZRHH27j4dI/1sngSv7aBoF3mDASxkeG62FHQ1EIrr13STc+mQD
	lY5UqKSLiNhOdmFS4+aLeGx7R3cf7jPq0R3nn8u63YjILin4k0fnorhR1jrT/sntlrTLAaIL115
	HfReiksQz5qess7e6by0YLQxJHr4b9CWrFzBfFFFXqeL6h7IgcX14tiwm4SDhAmMCX0BW0WLvDQ
	MJ1/kEJrrz/BcG+Yi0N
X-Received: by 2002:a05:7300:724f:b0:2c0:f84b:2455 with SMTP id 5a478bee46e88-2d588e82bb0mr697594eec.19.1775783710344;
        Thu, 09 Apr 2026 18:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:873e:380f:e9e5:ea98:a905:9cbb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d5e43sm2030271eec.21.2026.04.09.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:15:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260327090032.3722065-1-hch@lst.de>
References: <20260327090032.3722065-1-hch@lst.de>
Subject: Re: [PATCH] block: refactor blkdev_zone_mgmt_ioctl
Message-Id: <177578370947.488890.12081575405414565541.b4-ty@b4>
Date: Thu, 09 Apr 2026 19:15:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 27 Mar 2026 10:00:32 +0100, Christoph Hellwig wrote:
> Split the zone reset case into a separate helper so that the conditional
> locking goes away.

Applied, thanks!

[1/1] block: refactor blkdev_zone_mgmt_ioctl
      commit: 539fb773a3f7c07cf7fd00617f33ed4e33058d72

Best regards,
-- 
Jens Axboe



