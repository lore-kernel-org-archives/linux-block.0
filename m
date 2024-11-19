Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4615647F
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979943; cv=none; b=sOf7U3xcvtTdFzu62G2u0y/YRK5sKuqbQcnKNHrlhW3uf4SkbpV9V/9ygHRI0mYydEmjjYgglIVreW439pAn3YvsZZ3LfRY/8c47omv+jbuwmdst+AyaxVUNsRCM0n1twzmKiajgqIiRaB2+AzFBdY6sWrnV5M5iPI/dgMtycAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979943; c=relaxed/simple;
	bh=fcFb5pgT/wGDLQHySJgi6S3+O9URutYwMcnef6czREY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aEKS0eCmL9Si+FSX3aafSHnMRs/ACTzMSKp0uzeWo8z967kN7wHjvc7k32iRg4sUcouQKSrJoUhN4Xg91TPDnWGDvdUcgqJFV9/AKFfvf076BL1sMge/atMGMABZFDv3M5g3JpsrCOn9SBkaSthDqZKGE/q9tb3wLFtdGuiGfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ObDYU0aU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ObDYU0aU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdda5cfb6so34102405ad.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 17:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731979941; x=1732584741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCBBI2B/pYKCcIatN9aIdggGfrwlEtktNQUgqHZjq08=;
        b=ObDYU0aUmHKRU34QyldOVpbN9hXfWNTrUw2dr7WGCD0NADhrX2l+1Djdnenxr5/cVu
         L20bjdxwAZ2b4/MGyjOcdyBQ7Annmo8lqsGPLCNHKbwKXLNaVO3rmBFjfngjngmaV77c
         v5IRPuwLvNuRqnV3DCSnHL3N5utr3G1hHYZ7VBXgPraZZKyMLsfrFy352aQJ+NTv9edo
         gONpDrdU9+rCFy3oDXEIM4UxSyh8fMcNzUW/MhJMEBkxrerpOtiW4zCXyt7zPYAg/se4
         VrL32sAs2yPryOrgNTABu1zkL8P8owIX3E3etfLpMRolwmMUUR1lv3akAF3q0WvGIOt5
         FroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979941; x=1732584741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCBBI2B/pYKCcIatN9aIdggGfrwlEtktNQUgqHZjq08=;
        b=eRkSJPCSgZC1kA+JW+qcbseQltavwTUFbDxy+goLQCVVAZGWiB8dpPjqpEvkrxOnGY
         U75WB6xhV7vEKUyLr7r7mu1cJBCpKOHljBa2FCggtsUjkR+RfXPTi+ySp7UkH4SWx3po
         4tp2oXhP/Uoj32DJlUYhnpsJiAZYNMQK1qZAeU5RFF8VhC0SrxWti8anEGZkYtjYfVAP
         1WTgw0PU7y7SMs/hxc2YYPgqtoU1s7+LnKm4a577V1ZFZHdTQQfEbcYE9t3OcLCCypyw
         3o9D58CjWcVDD+orkhMNM1sNcjDI5IOcb6FOicpfozzncyNfAVamLIx6aIzpMsfe8uTe
         zrCA==
X-Gm-Message-State: AOJu0Yy8Ko6K8nWbbyvAApKKhGCbDk0d6tXcs39rKCd0EPvWQp2D3dD8
	bTzeRt+JURRh47jYp5AKXjvKMNmCIDP731J5YAncUAovCzQ75rThkVNgzzEx12Xv4uunrdVpTeJ
	ECDc=
X-Google-Smtp-Source: AGHT+IGbAn95/7eSmRWjf76VUqwPr+BRips6x648jiDgbvkdZw9gVoYBoZGim7noqD1pE8IuVdmlWg==
X-Received: by 2002:a17:903:186:b0:211:e66d:7450 with SMTP id d9443c01a7336-211e66d78d8mr192590245ad.32.1731979941091;
        Mon, 18 Nov 2024 17:32:21 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e7e293b9sm51770245ad.61.2024.11.18.17.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 17:32:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-Id: <173197993988.55577.13579029777446587026.b4-ty@kernel.dk>
Date: Mon, 18 Nov 2024 18:32:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 04 Nov 2024 19:00:05 +0800, Yu Kuai wrote:
> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> atomic mode after del_gendisk"), hence for disk like scsi, following
> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> cause following uaf that is found by our syzkaller for v6.6:
> 
> [...]

Applied, thanks!

[1/1] block: fix uaf for flush rq while iterating tags
      commit: 3802f73bd80766d70f319658f334754164075bc3

Best regards,
-- 
Jens Axboe



