Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291197FBA2
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750815845; cv=none; b=XtAcHXQPXrPcJKRYFerMquq97AgVW4wHMEZXHbhSkMMBapz9usogxMzSdmhyMCPYkuXoEYEwNB7N6oTaEexwn+VGJm1Y+LUWX1jMvfe8ScMLpLP4yE47UdZDm+MhFlPy97Pm3eds2LKuf15IRMLm1BVo6fzHiQnGStpRkQ2oRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750815845; c=relaxed/simple;
	bh=qHr4lua66RMHDKJ45Zc9ZwWWMzvkDHarOiXGw3nxvAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLQERw4mzhdEiTrvjMlWemwQN3Bb6yYInnwVxwSTELuSe4HiBkICRHVNDnLXwZxI8rRiVCkV8NSwQzGHHPNSh9IEzSN1YIe69C1ycJbxN2V6LF0FRfYn5c3HWvj8i02T98xT7VGwpR9t/GeBP4y73aDgyLqo5yyQ583tXTXgyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=DVZnWA4Y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="DVZnWA4Y"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2353a2bc210so53890905ad.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750815842; x=1751420642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIsP3rIT20WkjzGLGzVyHnhUMjCoAAIVWQlR2AtO0K4=;
        b=DVZnWA4YiE7k0Fd5BR4LXSJ68Oi0bixKA5rotLroCt+PB3aT+N8tWqm+4EG7xI/Zyz
         GyydobGdzzMNTDG4VkZjLJwtS0Ru9eSAAOoAM+m99uKP+rmPk68WQdHH4o7g1gbUawN0
         5EaWP9EsNSzXevjXAW9SB0lV/P9OJim1HknaSct7XvXbADeNYUGkEPxXeKSLdun7WHoV
         pb61oNhmUqA0mQ8/RpijuRlWiWCo9bK4B/snx/VBfzSS3bC8Uav9PgO+CbSdG56icY0R
         HxIHgFS1uy/XntGGQ8JeQySp4iWHeth0oSEkyOs/Q6ZOB4koskzczcaJITlR8THXzgg+
         BGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815842; x=1751420642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIsP3rIT20WkjzGLGzVyHnhUMjCoAAIVWQlR2AtO0K4=;
        b=v3Kzr9LfONM7krZAauLCzWI4jiEBD7nR6hYDp246nDRGawN6cU3Xjv/IKjNy5uld7L
         XIBYt6V5GpVCg2yQjGJJ8ZhD+Nqsi+CB2lhZb3Bjy0E9Gi4yhYEVAzijHrZOglceiZb4
         Y5f8Pl3Px5ZmPA2KC83+00L1p8JHDg9WGtaLOKVErplTFhvGwfwWg3gwStdiSyV9gCPF
         Ozxy/7sjF7Q4LIgFdfyAAYv2qF7XATUYhC39kyQ7LaVzhsa9msrTBj6gmJJQwuhS9vGs
         /mSnJCy4jVvkCei1D/U5rN3m8rSwCOSDK3sgjMOmQQyny/PYgRB3mm6jIA52FRjJHlwT
         akVA==
X-Forwarded-Encrypted: i=1; AJvYcCUijslgTqj0HXCA3Uzg7apRm5DK0rie1VLVPO5Jbch6glUPLPUp45P2kuJN5b0CBya1tnALyGFa15GUug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcC76NGbZwbE6Pz/OUc7awqkoufQrYv/yNWI74SNXQ5GcCbqbx
	vPjkHfyj1gZw2hYvYATfAEfkJGZNjjcEuZmL5gmQWaALkQKCkRE9xoViJaVcPbstboQ=
X-Gm-Gg: ASbGncvdyt/KjV6YXYeRtWODB7PansQrwJxERGX7XMw4bd72UJzq6r3l43iwHkGdtfi
	UjdVS+2Hn1LnN5AE4sklpOszSRVRQ9jY5ht7IW8L4FFScEfrXLHqLXQ2wQ+wUvp8/ILbFIXG30K
	RPgQCZ3MPJrO7W0bqwge51m/tHEh32hxm9qEcyYqNd+q7keXzKKL9bcg+caBgM/QDlYii701bh3
	g33/IP4HDbm2vNisR/D2YRTILCTLgGvS9rbP3vl8SJ5VoIedEwg1XcDTXH59ul+h0+jpPDlz200
	xA2t9jRUPmyN0yFKHpALgPepVqSQYlfBnoB1zMJ/xzka1obTIVRKnUqKGTkFRx5CkHI4imJwNNG
	sot1yJzdBBnfiUb70ArDiqM4FV1xQbrY5GvjiBiy7AA==
X-Google-Smtp-Source: AGHT+IHoDqUOYTCnE2gceYTiiXbnq2K/SlA10HDt9RUO5WPvnN8jozjol3hPLkjrrrxWz9hN/gbLRA==
X-Received: by 2002:a17:903:f90:b0:234:e3b7:5d0f with SMTP id d9443c01a7336-23823d5682bmr23697475ad.0.1750815842318;
        Tue, 24 Jun 2025 18:44:02 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393893sm119389915ad.25.2025.06.24.18.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:44:01 -0700 (PDT)
Date: Tue, 24 Jun 2025 18:43:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aFtUXy-lct0WxY2w@mozart.vkv.me>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
 <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>

On Friday 06/20 at 14:47 +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/06/20 12:10, Calvin Owens 写道:
> > I dumped all the similar WARNs I've seen here (blk-warn-%d.txt):
> > 
> >      https://github.com/jcalvinowens/lkml-debug-616/tree/master
> 
> These reports also contain both request-based and bio-based disk, I
> think perhaps following concurrent scenario is possible:
> 
> While bdev_count_inflight is interating all cpu, some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet.
> 
> cpu0
> 		cpu1
> 		bdev_count_inflight
> 		 //for_each_possible_cpu
> 		 // cpu0 is 0
> 		 infliht += 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
> 
> 				cpu2
> 				// the io is done
> 				blk_account_io_done
> 				// cpu2 inflight --
> 		 // cpu 1 is 0
> 		 inflight += 0
> 		 // cpu2 is -1
> 		 inflight += -1
> 		 ...
> 
> In this case, the total inflight will be -1.
> 
> Yi and Calvin,
> 
> Can you please help testing the following patch, it add a WARN_ON_ONCE()
> using atomic operations, if the new warning is not reporduced while
> the old warning is reporduced, I think it can be confirmed the above
> analyze is correct, and I will send a revert for the WARN_ON_ONCE()
> change in bdev_count_inflight().

Hi Kuai,

I can confirm it's what you expected, I've reproduced the original
warning with your patch while not seeing any of the new ones.

If you like, for the revert:

Tested-By: Calvin Owens <calvin@wbinvd.org>

Thanks,
Calvin

> Thanks,
> Kuai
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..2b033caa74e8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1035,6 +1035,8 @@ unsigned long bdev_start_io_acct(struct block_device
> *bdev, enum req_op op,
>         part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>         part_stat_unlock();
> 
> +       atomic_inc(&bdev->inflight[op_is_write(op)]);
> +
>         return start_time;
>  }
>  EXPORT_SYMBOL(bdev_start_io_acct);
> @@ -1065,6 +1067,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum
> req_op op,
>         part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>         part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>         part_stat_unlock();
> +
> +       WARN_ON_ONCE(atomic_dec_return(&bdev->inflight[op_is_write(op)]) <
> 0);
>  }
>  EXPORT_SYMBOL(bdev_end_io_acct);
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..ff15276d277f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -658,6 +658,8 @@ static void blk_account_io_merge_request(struct request
> *req)
>                 part_stat_local_dec(req->part,
>                                     in_flight[op_is_write(req_op(req))]);
>                 part_stat_unlock();
> +
> + WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))])
> < 0);
>         }
>  }
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..94e728ff8bb6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1056,6 +1056,8 @@ static inline void blk_account_io_done(struct request
> *req, u64 now)
>                 part_stat_local_dec(req->part,
>                                     in_flight[op_is_write(req_op(req))]);
>                 part_stat_unlock();
> +
> + WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))])
> < 0);
>         }
>  }
> 
> @@ -1116,6 +1118,8 @@ static inline void blk_account_io_start(struct request
> *req)
>         update_io_ticks(req->part, jiffies, false);
>         part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
>         part_stat_unlock();
> +
> +       atomic_inc(&req->part->inflight[op_is_write(req_op(req))]);
>  }
> 
>  static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 3d1577f07c1c..a81110c07426 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -43,6 +43,7 @@ struct block_device {
>         sector_t                bd_nr_sectors;
>         struct gendisk *        bd_disk;
>         struct request_queue *  bd_queue;
> +       atomic_t                inflight[2];
>         struct disk_stats __percpu *bd_stats;
>         unsigned long           bd_stamp;
>         atomic_t                __bd_flags;     // partition number + flags
> 
