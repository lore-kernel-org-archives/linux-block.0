Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976809;
	b=uqRPDX4dIuI+O2xwxvumFyvNXXtRDScsYvMUMtyRr8vBothvrrf18eFw0S1HJIILfLBg
	 CJKRG/vPJI13Sa005bOwWaOsHFOQ5zOgqhaFvMb/l7ZuNZN5XV11xyoGVVc7Tl/RYCEPJ
	 JTDfr//TXTLR8m9uXIMxkvQnEzlOXxV0PsLT2jjh6Ma8Gm11smkPcaHoytDQYTzwrf9J4
	 u7l1+6l6oMyJb/uelDnANopLNeIsBpmVReVNC8EMxQFltW+joR2oG7v8nihKMKBCiZpxN
	 keBPj0Gcap6IyJb6RQkb7RjxO+ae/fnr5Qm9fb6UFUUMWBq6tZ2+zwVlOqnxTV/SEiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GN1ctYdu3EUQe1/lEquYp83ZVHfs5WVqmLcymUKrlys=;
	b=sPyvDNq2Na9KpnjGZHjJyy7ykhRy8BEY62k/x33Rgc3K8aDvoYvWa0koU/uLUN/FxyQI
	 vau6nD1HQsqsngcovTyQ5NLX8yCMUPeulQPZvtBTx/PbFpK9IR8GIMt17Ok6ITH/7+ZZJ
	 IJzQ9SLcJzOiyBBvwizw2LgKFNNDr50SdJet/5DKG4xOM/Vyolk5/was+F0NG4j6IpA0N
	 f0qgThVNH2Oj2QXIDGOj/ZJCWAQqCaSDJFA3FddtFbfR7CuZcH4d7mFcV6P95Z1Vq6Z6e
	 +i0cW3AaGSyTfs7ixcrESxhJrmbiwxpfB+bumhDibm6hPr44EYba1VZ3GdzreKfTW+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0JMncY6;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C703606A32D
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 14:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C703606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0JMncY6
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e795af1d4so628624eec.1
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976808; x=1794581608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GN1ctYdu3EUQe1/lEquYp83ZVHfs5WVqmLcymUKrlys=;
        b=M0JMncY6T8XNvj0f/MxqRny1YMMLJseZKz2GUhqxUTztxXyVjGSXoxNERzuk4Js5Yw
         cpnZhQQT/S6gr38IRypreTRFs/3sv0RQBTOTTGksOM7JWmwKYnSPfbSzWup2SlOyKOUO
         BAk2Mlhm+2ME35OmXV3FlXNVaxzBrSOOII4nR80hQI8k1qTxcluq0hJ0U48TgoqFSmyd
         BPLRKQoxO7Xw4SyXB3LSVW20pkVDvRMXWPs8/kZRDyCp2Ea5I1J/vtcde8zFznr710Y3
         72oc9vCrAaBevfdv+MyqVLGDg204fzslE31/l6lMeYo7JHJco1NPv5jZ50AkoftEA5KA
         y9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976808; x=1794581608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GN1ctYdu3EUQe1/lEquYp83ZVHfs5WVqmLcymUKrlys=;
        b=DQqy0y2o34nsBgRZZkSWrMnB95m4EmMGCH8wMZxfFokZgY8fO0QKvtc+TB2FMgN15y
         +6IeF8L9FSMrYdby8kIH2fLxKzkXUlHLO/go3dRbhgLcTfJDS+PuzBCMQYh2aD4jpakA
         8mDGvAe+UsDX9HvuHv2mvhzP2RI76I72+ZQO26hEHK50moIIKqI2AVaniS37kHatxRpX
         6whQEDbpBxEKhckMizWXcPPzPjzOgmD5yhPVMrErwiWqDvzVEk5iTa6F4/TPdwuWeQKF
         L7ijU5gDHa+n+NU+rHXmIgPQbgrKf+5BYYdYYExH263BgdCfVmnj6vBZNd6e2oCaval/
         9Y+Q==
X-Forwarded-Encrypted: i=1; AL+hErGe9Sw9vRhHKwqV6JWrGYitYvSqcMHaY3z077rlQoYw3q8TwFJ+dTaHU75D0z98Mva0oyYBUiTkwM/W9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pCD+rGkYKuD6dW95hi7yWOWO5Es9vUcJ2ubF4lSqHBMDAzK1Y
	WtxNoySuodJ4jqSOv1LyWfiDUfRz3oV7lafxmsF6wwleUgF9S4I78QsY
X-Gm-Gg: AYBFou31XlWkh5MpnjdocLikmHDsxDE3ZaQ0WbQOgtROQgI8gjWhzLxGPfqrJAKCvwS
	M5OrEQybWVGRs4o+Xl5INjRTUgZ3vuabC1lM3Bm5kVh8wXg658rCqNEKWLwPegcopLj5tW2ckO2
	RG3GaeDuu0xjyCdh4PrAbwXmbW2z8gfRfvpJa7lzZlajGhgtRBmjbsJztOeWO2Xcme9gx6H0j9I
	9pYlIqfiOXwt2X6fXkdjzP9s1Gd/3vyysWGieGoqPt/Cneqb2dvaMtpILZjeI8crJx9z9I6VKiW
	J1fgAztC0wBA1cc0InHKkOypSZtT9L7nwqPXTzd5suCkyCHvV8tf9NrCAgOzTD4BuhHx42cjeDF
	lTt8GJGz59Gy1Fq/GnZTBRvUggMBrHH9ZFT6Qm8T6V51COTANCdw8AWR/28VmmYWeKs0BGaRg51
	ktM1OPtcr0PBT1kE+A8CClFlcf29WX4iq2m2lB4HePavj52HD0VcgMDU4RpemwNWMAvGnns1O5k
	jRjXFIMyMkGhshc1P1ulFhlW/jw5Oul8YvpfEBjxeDAAlj0ozodUd+ZShIDgUpSWniGPFRbqd4k
	yXG6woCEK4crJDNkximAx+9MEM2vvzMsEYpldquCcB0G41oegKkK4QZno4TV55EkK2NT0CKWx5C
	Huk3Hk37FYUVMw5WmqEVYgwBGmj4PpoMI
X-Received: by 2002:a05:7300:8a99:b0:36d:dcdb:70c5 with SMTP id 5a478bee46e88-36de713aa2cmr7899614eec.20.1793976808137;
        Fri, 06 Nov 2026 06:53:28 -0800 (PST)
Received: from fedora-laptop ([120.229.31.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm13164532eec.15.2026.11.06.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:53:26 -0800 (PST)
Date: Fri, 6 Nov 2026 08:53:20 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: socketpair@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ublk: don't take ublk_ctl_mutex in DEL_DEV
Message-ID: <au3p4G9oppcTSLfd@fedora-laptop>
References: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
 <20261105-ublk-del-gendisk-hang-v1-2-913a91a4314d@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-ublk-del-gendisk-hang-v1-2-913a91a4314d@gmail.com>

On Thu, Nov 05, 2026 at 12:25:06AM +0500, Mark Korenberg via B4 Relay wrote:
> From: Mark Korenberg <socketpair@gmail.com>
> 
> ublk_ctrl_del_dev() holds the global ublk_ctl_mutex across
> ublk_remove(). Stopping the device calls del_gendisk(), which syncs the
> filesystem on the disk. If that filesystem is stuck, DEL_DEV never
> returns, and ADD_DEV and DEL_DEV of every other ublk device wait for
> ublk_ctl_mutex behind it, until reboot. This happens with the server
> alive, and also when it dies: the release work then hangs in the same
> del_gendisk() with ub->mutex held, and DEL_DEV sleeps on ub->mutex
> uninterruptibly, holding ublk_ctl_mutex.
> 
> DEL_DEV doesn't need the mutex. ADD_DEV is done with the device when
> DEL_DEV finds it: the device is found by its id only once it is set up,
> since the previous patch. Claiming UB_STATE_DELETED with
> test_and_set_bit() lets only one DEL_DEV remove the device, and the
> device number is freed under ublk_idr_lock on release. The mutex also
> protected unprivileged_ublks_added: make it atomic. ADD_DEV still
> checks and increments it under the mutex, so a decrement without it
> can only lower the count, and the limit holds.
> 
> A second DEL_DEV of the same device used to wait for the first one on
> ublk_ctl_mutex. Now it sees UB_STATE_DELETED and, unless it is
> DEL_DEV_ASYNC, waits interruptibly for the device number to be freed.
> The counter is decremented once the device is removed, so at the limit
> ADD_DEV of an unprivileged device fails with -EACCES instead of waiting
> for the removal, and the limit is never exceeded, even if the removal
> never completes.
> 
> Reproducer: XFS on a ublk loop device with an external log on
> dm-linear; "dmsetup suspend --nolockfs --noflush" the log device, write
> a file and syncfs, SIGKILL the ublk server or not, DEL_DEV the device,
> ADD_DEV another one. Before, ADD_DEV hangs on ublk_ctl_mutex until the
> log device is resumed. After, it completes; only the DEL_DEV of the
> device with the stuck filesystem waits.
> 
> Signed-off-by: Mark Korenberg <socketpair@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>



Thanks,
Ming
