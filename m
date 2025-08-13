Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FA200BA1
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088342; cv=none; b=nOYiyquU1ncCdyzXzhQfH+lSXqBV9KKWX8oQn15DxRwDcXdvP3vMS0SDmtoz2bhU7bmrhQgU8cBiMnts3G1iSes4rUhz2UlSXHWNQ3NEKgsumdnSX0i6Tm2K5RRjL5YPeH6R0TPLv+VM8t3zkgu9DeT/Ga2CrDzqSVNQ61vGHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088342; c=relaxed/simple;
	bh=z4v/k+xEazihCbibG96JuAuBlCh9t85TYi3nbMjXIcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qX/IQj2DOjsnobRVxIOxpsROgYUq3hs4wQ6GdkOlwTRRyp6rNrrU3g9iUUR5ZcRbziUUSZ9TmXiMAmEFEBy1pUC8PJaQpDER6ng4Nn7G+TLB+8r17TmPuSQkmO8oLoz23rtGKgVLflWIbqxTUYEGA46k5l6VUVyQFWUBHgN2CdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AkyiuBeM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AkyiuBeM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24041a39005so41634895ad.2
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755088341; x=1755693141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOOchsUjzM3+ZVjtt7sbhib6V5OcY3gPPFMR9Tn6POs=;
        b=AkyiuBeMgQiurJxbPmV5NB6ixysB5Te/bCM1j3Jiy2gRqukqfng6yaoZIRbcyZi6aI
         rXptZDTv8q9xkG2Ec+f2eiyPYcKTADoKIhbQIKmvyQmrRIyV8RS5uG5nugqTrssmYxWC
         AIUDwSGEPXteuc8JGHBqFfsrwj54Sk1N47/1o+48UUpWy1+mqzvqFo+SCWeg1yrK7DXP
         t21SToUsrnbun2Kq0IsNzBmp5MzChWhH85M8+DILV8YeDSnQGgEtxFJEK9uRckUFt+44
         jmPJv8+nBZ8tdIl/q2H6TAY1sAppXDlL/eGDlaSUFuULlopmTbHnlZKLAhJUWU+r8qTp
         b/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088341; x=1755693141;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOOchsUjzM3+ZVjtt7sbhib6V5OcY3gPPFMR9Tn6POs=;
        b=YRCH1nV5vjK39MZ4CHvCLHMi/gfPbs62QnjtT1Mw12HaxkrReOutTKTihjg7unzDu3
         pBG8iqLlBo/VjaeQTOO5kISaIGV+Eel/+yaLvAkgJxDlcjgAOTP1kSmlzMnXVQ+vrCiH
         oSTaJU0WMnGElHLw4MdEs+SnbHo22el2MYMrOVR7kfVCBGHdbCCyYLUKHPXcAeQVJUF5
         Z+AicYG4JOUtaP5I4Kt/cRPXpVDSw9LzXlGhZuMSEM5UJTzoI3z+i846kd/V23Huwuni
         jaXUINimYIdMJMA9Htl+4rB5uFvUIvj9zRdNDkuD5sBgFo5jxIb/1CI/v8GtdRKH/dBg
         wfGg==
X-Gm-Message-State: AOJu0YzvWEBrCyU0fDLjMmcIhF+x/9zKPtfda12HKoFJCEEjmBSmzl+A
	v5v5WwPfC6wrLlhB63XobkyNnocFBF9BcXGEAzwmvTd6ZfbJVxHnhFRc7rYPoK43a2s=
X-Gm-Gg: ASbGncsqrnsJn5Tso+0TUhr9tTHUjGaG++2L5hqTEXIlvqcLiUd46tQkwxGhCIF7j4N
	8BrcBrfOVgQ+kqAM0Wbp2TjwhxiwGwRp3JT4EWbjtFfCIxQ+dNOdGcNqdCkFX8ha2YOK1TO2yBj
	q23eZnIqW4ydbDqVlVL1dVexb0pBreunipyZp1DamvLAj+Llw/vmUCznZoFfmzrQTWqVj+BmKvp
	i7pX0OPhrxDdbGA8SVqRP9yePOHUTf95m+wSYLnJ+Rz7uDpRxU4HNDCWKNItqpbfKtXu1z8FJRJ
	c7iPMhOPOqSe6YiD/Aq+yvHuKn0WcVX8DJVUHHQ3NSYXIk1P29vjBVpzgHEPglISL4ruNHj9Wk8
	Q/zg1NQEg/cv3Wb1/6fG7uvlfxg==
X-Google-Smtp-Source: AGHT+IHT5scgbby93gh1/cl+pL0WzlubhAl0HAVwY7hiL1W8RJkliPiwTa9RyjSOretmT7Mzh/VLUA==
X-Received: by 2002:a17:902:ea09:b0:240:9ff:d546 with SMTP id d9443c01a7336-2430d0b4c7cmr38502445ad.6.1755088340685;
        Wed, 13 Aug 2025 05:32:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232553e4a2sm82418a91.4.2025.08.13.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:32:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Julian Sun <sunjunchao2870@gmail.com>
Cc: nilay@linux.ibm.com, ming.lei@redhat.com, 
 Julian Sun <sunjunchao@bytedance.com>, stable@vger.kernel.org
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
References: <20250812154257.57540-1-sunjunchao@bytedance.com>
Subject: Re: [PATCH v2] block: restore default wbt enablement
Message-Id: <175508833916.953995.11740099334208966785.b4-ty@kernel.dk>
Date: Wed, 13 Aug 2025 06:32:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 12 Aug 2025 23:42:57 +0800, Julian Sun wrote:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using
> q->elevator_lock") protected wbt_enable_default() with
> q->elevator_lock; however, it also placed wbt_enable_default()
> before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
> in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock
> was removed in commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()"), so we can directly fix
> this issue by placing wbt_enable_default() after
> blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> [...]

Applied, thanks!

[1/1] block: restore default wbt enablement
      commit: 8f5845e0743bf3512b71b3cb8afe06c192d6acc4

Best regards,
-- 
Jens Axboe



