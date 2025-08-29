Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E913A86C
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430493; cv=none; b=YkB5kuq7hLig6F4Q+sv9SJJhldLxr2nc0ZBO92p+hwpmYhL68BOrGMtGosyLRAKsxeu8Z56Tsn5Me/D68iTxF5wCOzzAd6YD1Y6XM0zZ1lZakigI7dvodncr3DzPNliVXpXiryr/Vid1LJMVO99rlmfmOftGEgpCdVv9rO4IWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430493; c=relaxed/simple;
	bh=kywewJhBzkEeU9JmM1KOSPbIlPvGgrtxNgTrvxj/I9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JojsS5sFK9kc+B5XxjEP4/JX0+sz4f9UOtS2+rj4UnhwFMjQte4yee0BF51QBM8RJNavo1S4vMq88i4nLR048cl4yHKkRd42LEfuaw+Q40cNlR2SfUpIGMooCmzumUXnQgC2xHfp7IxPt5Km/LaSzHzGaiXqFp6TqDOvj112brI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=stNuJaqJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="stNuJaqJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e09f58so1637307a91.2
        for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 18:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756430491; x=1757035291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpNVaz6OUqZ2em6Bi1B4ft1XYkYbpydHX070suefs0Q=;
        b=stNuJaqJVFcxaiCfbuOe2mqSPg5Mldz5W++T6v8KDGcGZNmYr0KBnTx/vICgRfNjZ3
         XP/bFh3jEUanGF9qIZSfv1PYJ2avXxi/EA78X+czo95rxglaKlcvGVJmplqNPOzI5Ayg
         S44g15S/qmM1928HOJwIUD5pWVVRPhssK5+sIZ5HDrOAiAplBvuzedlvS89Owr6f41MZ
         AJ73tW8/os3HwYWe0DJ81NjUfeuBigSVduHq4bgwURTvAEYI8KrPzz4437pl2kFYnzZb
         U1qqOk3LAsMm5MJc/X328BWsLDp1RZETpl1Z+8hkOA85IiZrBsvlCVaEpYmQLub7GrGl
         eOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430491; x=1757035291;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpNVaz6OUqZ2em6Bi1B4ft1XYkYbpydHX070suefs0Q=;
        b=AMKPoLLqeaXtkyhAnp+9rf1yA5RQFo/x4VYFYFDOLgP6jrEsh5KX1K4qxa+29JmUyp
         5S/QVEcFg27ILL0Py5b/YBz/SO9wGli1qprLjL9nJ9Oi/TxBkaI+n/xbbXRcop+OX8ZZ
         4qfWEqjUAtUsTLReXlh6IhmvqXUR/pfWo7dIdEsIAkzsLJXZGbPh6KxnY3E9lHtQtO2j
         s3vK6Q+SE5Jaqdb7yBg2OLalbt8S3FiI9XAaLLkigO/tvl6GE7pQU0pFX752qXb9A1G9
         Fvp2EnVIn1e8ln7NWzQ3vo94tJu53xvXkd8hTWpYRqR8Ep7Q5b9E6IuROYr+JvFcI4TJ
         gycQ==
X-Gm-Message-State: AOJu0YyDJJUPvEPq60b4GTaSLDS+zcKdxQT+0G8GUUNgSwZx4JN3nxsp
	7glgUHHI3u+Gf2jiAvQDSc3bZWfZ87KPWjmMVGjoSED4gzeilWjCCz9rz9lyGMHk2WkHdRWNwgk
	izQn0
X-Gm-Gg: ASbGncvTfAPBsmhJ/S+IbY5v0bXouRMTOEbutHQ5FoixsooOWFjVtaTgrMC/4W4KPd1
	HX3JekCQEmzrlbldzj/mw6LoMBfrxPzXbXbORHHlNDqWZWTuVa2w3hCuEccOBo3IkwNXzwvHjcH
	tKhZGjQ/IRRwndd5/ir4a97Kw22ndSlli17xTaekMSPvJRTQpLGmEYgXpb2JylbYhI2WZsDE6iF
	3eJI9ioo6csnokHrYornkUgnLVqMiPhc+G1CL3QsCprQi7hxug+p0q5+qV7tIu1udC+dEHn+HRE
	z/0VnAjZ2OY0iuW10J82OU8Z9QgAP1hapN9El3Ro1am43JXz48ZgxdF1yJmD6jxpgKUIAwKUEBg
	f3Cyv/gMYgVwZf6/QTZtudLRF6Q==
X-Google-Smtp-Source: AGHT+IEoZ+rW2yM9Y7xcu5Ib4LvqJhe4PEBZKDxsu1ySasC8nfEp4c2enLVkZT3rmAK2Fuslpc18vA==
X-Received: by 2002:a17:90b:57c8:b0:321:29c4:e7c5 with SMTP id 98e67ed59e1d1-32515ee6a8cmr33199682a91.7.1756430490736;
        Thu, 28 Aug 2025 18:21:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f59e29csm6505917a91.12.2025.08.28.18.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:21:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, jianchao.w.wang@oracle.com, 
 linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com
In-Reply-To: <20250826084854.1030545-1-linan666@huaweicloud.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting
 in blk_mq_unregister_hctx
Message-Id: <175643048957.32759.11740311974610130180.b4-ty@kernel.dk>
Date: Thu, 28 Aug 2025 19:21:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 26 Aug 2025 16:48:54 +0800, linan666@huaweicloud.com wrote:
> In __blk_mq_update_nr_hw_queues() the return value of
> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> fails, later changing the number of hw_queues or removing disk will
> trigger the following warning:
> 
>   kernfs: can not remove 'nr_tags', no directory
>   WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
>   Call Trace:
>    remove_files.isra.1+0x38/0xb0
>    sysfs_remove_group+0x4d/0x100
>    sysfs_remove_groups+0x31/0x60
>    __kobject_del+0x23/0xf0
>    kobject_del+0x17/0x40
>    blk_mq_unregister_hctx+0x5d/0x80
>    blk_mq_sysfs_unregister_hctxs+0x94/0xd0
>    blk_mq_update_nr_hw_queues+0x124/0x760
>    nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>    nullb_device_submit_queues_store+0x92/0x120 [null_blk]
> 
> [...]

Applied, thanks!

[1/1] blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx
      commit: 4c7ef92f6d4d08a27d676e4c348f4e2922cab3ed

Best regards,
-- 
Jens Axboe



