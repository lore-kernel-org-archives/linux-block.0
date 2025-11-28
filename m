Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511F7D07D
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346852; cv=none; b=nNtYqIuk5GDfUvPDEZA0xk/lvcQzAOxgfQAdpKoVuDDcKWqO+FeSM2GmiXI9zq81De7ue0oGoXO0zYgXPBzXs6z/MyB5pQu8cxdoRgd57bV9l5w14mugET5G74FlwJUTDM4Ks528jDMlItMBCEGFuPcjJRNXHpkhjjWXnOOPgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346852; c=relaxed/simple;
	bh=TTGnVNoL05rfY/4StUV45Y2YHSBj5pxNNfRVmDLgnno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpFVb2/zOxFqDNQMfjC/2/rQikfAV4PF4PwG7t7Z6uWP6MdhoVX6pG2UXHZ1PHBImIzH8E1khUjd4EutwtktoMVNoHiRqVdZtkivWvg6xgjsmxIxdtkbPjUU+nCUEJqVs2A6qbjsAv+6ya/c9B7i5fAfrwBcuoWlmDvAaa8AHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HC06JHey; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HC06JHey"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-948673fdc47so83591039f.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346850; x=1764951650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDtuIZhhedeaTpP6ILSWi5nn7tdjBkfBwrzkbONpRXk=;
        b=HC06JHeyl8AD/cEPlPEUWRnqIlg42a6N/tbq5P9E4NIFkGVW9NwvfXJz1h5EubVPCq
         BdI8N3wSH+ioipJh1pU9rm1ZcSF0dEN3uhJNidLDwTSgMvSsgm6sO8yScxHzaDLl7Nx3
         MdctnfdWT303lscANMcrNWEnu0GWyXDOv3dPQezmfzy7n9zBbzE41Lt9ojyfangse3xl
         e7sGKvRhPizqkGfu86UMm40fjEmxqK2adGX8sDTQOOUIojQ0eOe6OvzeMDMCPlqmPD8j
         mKxKKVm8oH2llFnsh/yEvMsbV/EPejVxQBEQo3EXEPfss/WYczPwJWNBBEv/2RMXs6nP
         YZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346850; x=1764951650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDtuIZhhedeaTpP6ILSWi5nn7tdjBkfBwrzkbONpRXk=;
        b=lTp8/aDmaueX4kQScX6CQ4cgZFLxy7+M8aank3uDj5FOFm/aIkbB8i534rOAambhUi
         sImi5/LS3kwV0x202LOU1+1FgquQQ45IfpbSUQ828UP7zIbKKYx5cew7kzK+ABNinzjz
         W9rc/sQJKEnnDszKc9PZmyv7TE63+7vvJPnY2qJU1b3nYNL4AROkAnI/0hV1Zw3yY3FW
         nLQZE0dEjRhuWd6XZrxGQaWnVlHk61WsRpfeHABdt1+jrfptArt7r/I2dlEwFcixoXY9
         1Ceq4WJuMNwkTAG596+0tLb2YmEaiiDsE9das6eHMHzFQpV1KMwzbsUI0eCInYAyLYu2
         FR/w==
X-Forwarded-Encrypted: i=1; AJvYcCXf+t0BneT41DAeF7Qni8NR72MeJ+2QkZciG53qo/VVkrgjn5zf9/v60qiINVvHJBofhmPLS9Y9IeeY5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLbP8PBdtk12woIiOIUEmYbcmKg58xSQOACsr1GgZJt19XrJK
	Du/ymSVXHQ9xDmcHcwYDLAsFC69tYVXbHf+YPKiJdWtoTttKu6DOQJTFTGLX9BkIzeA=
X-Gm-Gg: ASbGnct7ElDLmkWa2QXpBHPgPhnB2Uu5ppL/ZMFhNmKFdBMH85guKAjuUPOmaOvoZm4
	aIVO1zTurWWBZtqErBbdiJlO90C5/feObHIfg7qDgmTCgPPDh/JjSWYg9VK69Il+ODp/2pKDgiM
	vCHzpVbLP6HpWTYk0JF2mF6kGgcZY8qrm97HYAVo5m6ZYqwXBSloBwMpd8ryPbJqRLtGVI01RX7
	n8rcjLct2giKQXrZk5GQOMKbL7c/vz1Et/lbdntywo3V8q78RahXwQyzVCSfPjxmXSgvudYLekr
	ondKDI1GYC8kR3wyl6EJih/ArG9AKzNFh5B+m0pQplA4xpE7H+CeyKQNZsAjHTBgtr8IXdYnuCN
	flqdKBZ77SfSTcx8jeyO4+zCbExt5+vENebGO3aMsyGIV1j5COFLrhblwjYUH6fViz91Xp/NEDS
	FVY9gFpsyG
X-Google-Smtp-Source: AGHT+IFxfNit2W+x+cpb945o8Bt3X/NolTu7nxMnd4mflJ+sUIpe1JLmevPzSowBitK3wXS6pMjjHQ==
X-Received: by 2002:a05:6602:26d2:b0:945:a01d:49c1 with SMTP id ca18e2360f4ac-94948a09b92mr2177241339f.11.1764346850051;
        Fri, 28 Nov 2025 08:20:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94990d5c6e2sm215727239f.10.2025.11.28.08.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 08:20:49 -0800 (PST)
Message-ID: <c0e60e0c-42fb-438c-9d15-5f62567c1963@kernel.dk>
Date: Fri, 28 Nov 2025 09:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de, yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>, Yu Kuai <yukuai3@huawei.com>
References: <20251128085314.8991-1-changfengnan@bytedance.com>
 <20251128085314.8991-3-changfengnan@bytedance.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251128085314.8991-3-changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 1:53 AM, Fengnan Chang wrote:
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0795f29dd65d..c16875b35521 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -999,9 +999,20 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
>  	return rq + 1;
>  }
>  
> +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	rcu_read_lock();
> +	hctx = rcu_dereference(q->queue_hw_ctx)[id];
> +	rcu_read_unlock();
> +
> +	return hctx;
> +}

Should eg blk_mq_map_queue_type() use this helper now too?

Note: I've applied this, so anything beyond this v3 should be an
incremental against the current tree.

-- 
Jens Axboe
