Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDB21CFF6
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995761; cv=none; b=uwK9UCl/ydYxJBHnkmDH0fSGVahFHtuQmDIOoLeoL6UXg+ucqHew2hjHAgEMIH/8/36t9e0aCyjDq61n2+QGJAU38a2YGOZeH4yY9zM88+qXOWC1uEMGV7DcTYL5c0TDDi23y+LDN12N7JZ66R2iA186ZfeflOIk1jUs02gkXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995761; c=relaxed/simple;
	bh=UJCl2cQMgRX+GlJFrWuwmM69d1vT6AAGxPT3QehxXfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KpMF6uRf/FxFRDF1sBdLokkhgGO0Ma8dzAiPKg9Yml8OxYwVZGvJ8/yFTxzryN6HvUCZJGnkSHMiWQP8LjGp/rH6BQy8DZyxZE4MdlaiBROYFodvUv4E0ulbsnPh0t1C3PLlYFIw0l2/6JGeBilqWe3g9Pwp9fCtCEzDHHPVUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wYFZElsf; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wYFZElsf"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-87999c368e9so17401739f.0
        for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 14:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753995758; x=1754600558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7W3cWn1TbHQC90X0PU0aixh2SgsR358GmA1P3kMX4k=;
        b=wYFZElsfhJ6JEqeBoNUeXpTiO4ezO7v8rKmF7Dw/FLMbHzmov0kblA1oVVBzshtjDp
         QEM9LND0XIiF+9Ml5CIhcy2t1llTG8b6xi6veThjx8UJ0JwDFLPEs4Keot/2NLKRPTTB
         lK7q/CUd3I2Y3AGRZCp0YdpKWQZdrMJ6G1q6WTZmVJ92ZqRhJAXbY/QCexAB1Ds4jZWG
         rosENgDJg2/gGZ4HFe1ewU90/fUsCSyuqLysDZWaMZJ/E1oyaMyMgZLYh1GLzJYo9Klg
         qNGbUfvXbE0wpGfmITNV7+njkwNL5IKA5J13KGRyTe6b14wNeK6yWtqXRl7H1IAbdnME
         Mbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995758; x=1754600558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7W3cWn1TbHQC90X0PU0aixh2SgsR358GmA1P3kMX4k=;
        b=loUKpy1Tn5eiafR1FGHG2e541lgvl/pV6q/qnYTdSaTOwvKrX3ILXYaFxmTbyS2NJg
         TXeFIO5BNmX1POaxIOKbWaPYS042nBldherrIfHI3YO7Da/j8wXaPSR+eJjdO4EldazS
         5fsX1nTOj7i5B5qaqti4Xb4Os7uB8fW00cbNw1M5Uw9xb3zrQPw0VPd++fWo4RoMA4jx
         ktqxqlyH5E+agghWnBCugz6h+93De9Ax/e5pt61vkVkQuBJJD+E/nm7wBEEwulyWCiIf
         zKG9ggrAX3Li/z5wpXo+5yoofMxIeQ/fEnO6YiLZ9IORIobqwWjZzPOmju8gzLRYrihp
         my6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCTLlweES20Z6ienl4PjVHsW9ItvOG4yMzzD2rxPaSw4ttnDYgILWx9H0hJSMrj8Fcnan3A56XV/WTxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypdubwnsVQuU6NsJpsISZKgNxWU0p0JbWI1ak7SxICL5EHwqWH
	rCCVTz53M6D9iWLTXB+/rDmX0o1jy7+yPpmqzPBGAGVeNQXpgHJsB/QPRhKRs5Nw5OY=
X-Gm-Gg: ASbGncvxSktDalAw1MXZ3pfFsiEMVJD8xZJI8HvOHKaDEB+Fqkv/ZSGsaKNBoSaxLL9
	EvXQlb3PsFO7ZZHqKABFCULmExz63kmblA98uLQBdFDtpcC4RU3p7OkixDqc5oVxPeAyYjGHfEF
	mnfcGCI9ZPThSPprPIir4T2PvaLvT4hkBIVY8TkMNkgFGbr3RZER9aL2Ys+DIuiR+bJXF+2TmP7
	Q+zdwThONAb9AjVwENy+/VAIHbQYEW9UF327Zfm/2l9QDoJfVI+6El22pQS7w0MtAV+KD4dtLcs
	uADbu5E6gfDCM5nuThbg69CM3Tw4ke7+4SsOUHgzzFMPXdnVUKt9m0JUJmvv0tsKEj0WY4Iuoud
	qIYgwedGbOUnB
X-Google-Smtp-Source: AGHT+IHIk2jE1Ye8sV1LTSszrfrw4cpyaap4oxaBCtWVjJTdYAbBjCk4wWmzF6JBbrHYN0imHYh4Qw==
X-Received: by 2002:a05:6e02:f:b0:3e3:f914:d774 with SMTP id e9e14a558f8ab-3e3f914d892mr136903565ab.17.1753995758487;
        Thu, 31 Jul 2025 14:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55df201bsm752208173.109.2025.07.31.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:02:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: anand.jain@oracle.com, martin.petersen@oracle.com, 
 linux-block@vger.kernel.org
In-Reply-To: <20250731152228.873923-1-hch@lst.de>
References: <20250731152228.873923-1-hch@lst.de>
Subject: Re: [PATCH] block: ensure discard_granularity is zero when discard
 is not supported
Message-Id: <175399575696.610680.7413167868031729595.b4-ty@kernel.dk>
Date: Thu, 31 Jul 2025 15:02:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 31 Jul 2025 08:22:28 -0700, Christoph Hellwig wrote:
> Documentation/ABI/stable/sysfs-block states:
> 
>   What: /sys/block/<disk>/queue/discard_granularity
>   [...]
>   A discard_granularity of 0 means that the device does not support
>   discard functionality.
> 
> [...]

Applied, thanks!

[1/1] block: ensure discard_granularity is zero when discard is not supported
      commit: fad6551fcf537375702b9af012508156a16a1ff7

Best regards,
-- 
Jens Axboe



