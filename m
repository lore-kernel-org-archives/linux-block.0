Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEE377566
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124321; cv=none; b=QdBweMdOOhcjEB58nQnvrLnlGRJTQqVk24Sh0Ro1Qq1TsGAweUk+U39WJlq4k/FPpbybPdBGKZVrRAQdGL/f8Or0uvSjpY4SGXtdHZodKyCuUGVs6mHxf+QMor+1JMBtZVfxsBABRo6ItlkB15NSndRiAGKNX5TeLrKgMKadQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124321; c=relaxed/simple;
	bh=SAgAlVumd4bSNcq7POTdK2o5SfAl7K4HhN0qAdrkl68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4ybYLK12Ysxkzze7A0Nh0euJcMrhbLeKXimiiLjiXMbMyO6HV+ibutQYlvrUaZoH49/H8JXtyQkuZgT/I+6Y4tkJw7Ph8ztqmOQFQia1XHeMKdyPHe+1k7ZMzzXo/bHpHV2zSoM2nFkzK2elBfo5axMIRmL1JwD/hC1GASA2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI/LPUma; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI/LPUma"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7fccba9c675so909836a34.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792124317; x=1792729117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4MYjMxl4nk9/tU0R8Bn0SAxgenA02VkldF0zXaf2oQ=;
        b=PI/LPUmaQqkqDv81HV68nr3ejn8LYdN/bZYAn52zawy1agZ3fNb/UyQrRK09FowflA
         bqcfqxCX3eyucP87tlb+uEc9uB5yJjR913gfskFyTY1+TbedrvKCV5U6X1LV6gH2LS8t
         RNCp944+uVSx2Sy7hXZsjXr2Nao+AeW0CMFMYwvwGvBuUKA74gZPl0kWsLw3dWfSIvgd
         k6XscpJDZ9uCQZc86tniyYws5XyDSBjap3d6RIklnpkYFcVSgRtultdYFcehYRzUyMKv
         addTjdbDNmHD+TMCnB9J1Djvj0CTP8fNPYXJTA/RWdhdtj3PP9ST65UrUW62/Gq5h5en
         Zn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124317; x=1792729117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4MYjMxl4nk9/tU0R8Bn0SAxgenA02VkldF0zXaf2oQ=;
        b=WYnAnzpmdEG1xoI5hRQNKR5fb6CyqNT/zdvinIGTkwBIHtEGOPUD5vYG6aaZ8iXTj8
         MrrCgoNpv50y3R4oL2PHZTpZazZor3+GgOgMwXyQEbQm2o2A6ISm39UWUN/nrMGH4Yvz
         Y1qAvs6XyNPlT4kn9HLtO9pYcwyceAlROsdpjeJkD7TfbqNiWCwyNq3//YcyaN4NJnD4
         MSKYOiRnn82jGJCSLxRIfMp9RL/9nJFAgk/pcy9gjJk4sjLi/czBjdFFJ6/xSfvFR3ZE
         FeoLkYbru6uDMLFASFJJYzNyEesJlsDPc1iZTV4ViZabXuPDyKh0fsApdzFaGeaK+PqF
         41EA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ56GCYvAXNGV19PhYBKtCrF40H+WqXNw/kvTvvmV+PKX60rIxCMRJ3Bk2EFs63DtFf5hpVghP6cLabw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIwrhZqADOUjeFE7z9uqFoItnQ5ujODGijW7YO07Jud/ry1I9W1
	eDxV1Mgp8LpYsel2yo+1eHWlRApL/3Q0tM9UUHZD/0NgbYa+FK3CAFw+
X-Gm-Gg: AYBFou3jDucwdmbJ9kOpeeKWhv8DgJ1M5ps3d4XYT8qlA01FBgC9Aey34VXbdDVfwyx
	CMsg/u8uWqFczXtSifIHvAjxQwbdCRe5ccRNB92BO/L9KYJ5nVgQVTOqzy89MPMsHJhxAotiuVT
	b3j6fS0doF7rmm4XJqqapsJOiMzX1vGmBrTHuiUOFcqO5PZqlh5S5nbD6MsQzcgRU+SqRJjVwt0
	SG49wx7s+RxSHHhhIowpkJUB4BfW0mqHwqNAELpNJbD2NM+CFyOPna1vNYZ8v/9KSyrYQ1q8qWH
	oQTa3P/tpOZcTN918TKUksLEuHsO6tknp/jkOnp8c1wPny8W927OsnrmP8d6YsXvnOuQL1flPfi
	+JeyKpFll1ZTwKmDS0qvNojBhY8B7Y82nsZlArsVf/CxreYNaXbDqB8T7qrQqlGtsF4wwYm9oLw
	HE6BkVkKBmOOHZjOEH3bYV9OvSMEmK5sWLCa6o91n2RUQlG2c6pOmzuG5XIoPLBBEHawB0CIidk
	yRcL3OJ77+6MI1YJ57OjdiKsB29Z22ERovqv28/26Hba+K2sY32EDDBzQGnN/noIXH1PvN+aFkt
	jZc=
X-Received: by 2002:a05:6830:a20b:20b0:807:2dcf:5353 with SMTP id 46e09a7af769-842020f96a0mr949776a34.35.1792124317643;
        Thu, 15 Oct 2026 21:18:37 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a111dda4sm849120a34.1.2026.10.15.21.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:18:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 23:18:30 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai@fygo.io>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <mkp@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: drop the tag_set argument from
 blk_mq_free_rq_map/tags
Message-ID: <atGllms8KX7X6Fk-@fedora-laptop>
References: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
 <20261001-bug-blk-mq-global-tags-srcu-v1-2-e8415da10d1b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-blk-mq-global-tags-srcu-v1-2-e8415da10d1b@gmail.com>

On Thu, Oct 01, 2026 at 05:17:51PM +0800, Qiliang Yuan wrote:
> Commit 9ad8e5af3279 ("blk-mq: Pass tag_set to blk_mq_free_rq_map/tags")
> added the argument so that both helpers could reach the tag set's
> tags_srcu. Now that the SRCU instance is global, nothing uses it.
> Remove it.
> 
> No functional change.
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
