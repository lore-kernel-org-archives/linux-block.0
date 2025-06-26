Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CF2E4260
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944937; cv=none; b=bZhmvUO7e5fgM6kkcVt/K1TpSIC9D4pqB+mLLZDA5dWHCk9tAgP1es3vTRoRaXxxs3pwzgiEp5Cektne2B8nGdE7HDDId3nIgwrcAZcfhqIFltgQOREGh8IT5W+yGgJAobLTepQsRF+dETztj65TtcNEJF+CELwoDw43YiyyMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944937; c=relaxed/simple;
	bh=gKKaDAzbwu0t9WAr6t2qt+SAU06c23rBIx0cx7YKEEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jeKa6sHh4sRHjQAt7MJyZV9vewsgvNlsIIEcVh9BGd7VYD5NP1W71yG6uakGGeT05E1bOFSxY4WVHuqPRtI8VahxQa6ComBFZwp7tDk+uOnVEiVp2Rfe8p6iTQhRVpFAEGjsipkTzzeBi/bIpczvyczpwQb6uCIPbwKbxqAv9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NSxaTAv1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NSxaTAv1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e97cso1060765b3a.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750944934; x=1751549734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB2BjJNaYfvMYTmRHsLGeW4DEX75zKlRhSl6YusKzi4=;
        b=NSxaTAv1NMJ4NXBAzQ5ExrDRAcjOoESpwIF7ed27EnbvFA497q5SBPhw2MNUTYEVgx
         H1MKxtEJ2IiHWvbb4GwGwt5PeNuyRZzixmB83DV+lksecaViUE7Q0YK7nus4fBk/8rA3
         YMOLr7wbLAqNdDECg9cLvDcMFmxlaS4DWu18JX6wK4gynd9uz0mrZTUeYhjD0ukUf1gm
         7qD4wgsBJVAQg/kdDhzNoi1bOB6/6l7fXJDNzNZppMHUX2tNAhIHHucTDoyWow3jnlvU
         SXlGE3KB8iZSdR5JqmGKUVtEXIbV24gC4sxw7keCErsAAY5e3tvOvykJvnryS0CrA9sH
         T4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944934; x=1751549734;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB2BjJNaYfvMYTmRHsLGeW4DEX75zKlRhSl6YusKzi4=;
        b=U6fLMCQxunFyJfy9w2UkTpvu78A4j0NWx/WEvwqRpcqOn0+XEc6eF2YAkrs/CCWHHW
         8yN4SLrFgYs2NlCASH18uSvgpLfqjaN93S5sDulHZz/3y/HdjNnELDNpL8lLQfgnXCNE
         LTMDSrjO/lntDUSpwvxTdIcMdB91OJb09cidUGze8CgoqmRUCsJ9vVgkPhzYjCMuF/BU
         cR6Tiz2WCrl6IDICo8PSVVt03dT/BvUzXdAU/oVWJT/BilxS0t7SCQq+X5l4Y+0/8fMA
         k3KEmoS1Mc5PmFZ838szj6LCD8XzAe+efjdaqiHacmbL8vjiquOSlBR/PvhQHoFhRSuW
         aSVg==
X-Gm-Message-State: AOJu0YyULKPmkC23UO1XvvByygfsmdv5DE9q04QOXsnGjh9HzaUpbwUE
	HlvaC14u02PgXBJ1Er5sQNzMapvYAJmQVotA0YJ8xYAoobpzNwe7GimP2zLoL5rt0V3iuwzEjDN
	1MjHH
X-Gm-Gg: ASbGncsHBfVo27jjHnEr2V7n+1VdtEDcQ4TX2JAt5Vq1AdOMuCQv4cL+9KeaqIUE1k5
	q+6V8MyAi9/tW4j9tcXpvYGzfTIsg4Oj+1h36hy7754ZNe6GbDgcMSm/Juff/Bv1Zx5BkSwc3iL
	fXat/H/8t+awnT2DxLqwgxRBtgGiQPAcz1DPHNNAR4Z83b/4NUVj3e9sk8IB6vEvpKZv0VDrmuw
	x3ir2OMJnYjOs28NOl29s0BJgozvW6cOuWnjYHukptV2L4ePlr4Ao8GKNk3hyQ5UZikyYgTTy1E
	Nln9TtpsqRHoZemD47bpG1lP/r4eeSa6M/kh4hA4SagU9XYdItNbVblFS4uW/QcK
X-Google-Smtp-Source: AGHT+IHbDHnnL7Qib/5LnTp1O6udd7OHi+3VudHX8LC/AZnXbPgHftnUwuhWcOERJ0BGN9Bni3zDFA==
X-Received: by 2002:a05:6a21:648e:b0:1f5:63f9:9eb4 with SMTP id adf61e73a8af0-2207f31a871mr12423546637.35.1750944934314;
        Thu, 26 Jun 2025 06:35:34 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88732a8sm7259526b3a.175.2025.06.26.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:35:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: ming.lei@redhat.com
In-Reply-To: <20250626022046.235018-1-ronniesahlberg@gmail.com>
References: <20250626022046.235018-1-ronniesahlberg@gmail.com>
Subject: Re: [PATCH] ublk: sanity check add_dev input for underflow
Message-Id: <175094493317.208674.17738618324239565418.b4-ty@kernel.dk>
Date: Thu, 26 Jun 2025 07:35:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 26 Jun 2025 12:20:45 +1000, Ronnie Sahlberg wrote:
> Add additional checks that queue depth and number of queues are
> non-zero.
> 
> 

Applied, thanks!

[1/1] ublk: sanity check add_dev input for underflow
      commit: 969127bf0783a4ac0c8a27e633a9e8ea1738583f

Best regards,
-- 
Jens Axboe



