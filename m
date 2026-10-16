Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579F32692C
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124287; cv=none; b=TFbnAkDVWAsFPLb1jBipa7JWWuw6WH8i60t0RhzrruKVRbiSQXf+2cP+/trVsFQkqNWiOEClM8VJAoILdcgUJtbx1316UJGfY+f99gdNRy833hVmaf+lhDcIvhIvZ0HzXnHsPeP6kft3QD9qH0bqTuTE0Ug+ZHH5KxEsvFcVsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124287; c=relaxed/simple;
	bh=bszKIuYos4/4nZ7PF45CtUCaMdKhDYhnKMxRNu1coKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNWkyhJrEs/Yu6w07ClLAni4cqN9EBGbei2a3PIbFjLjb38EZhHTwxHwleEcc4JYdaYmIE7YCEiwIFZgAp5IKYLHQ8ByEtpl+vL8pj+VT19ogD7Y9SoVpde6LW1KCBYxmYjZvSqg22H0HUrUAgrzSHYb3MPQ1y3Ir/ZdwKAMMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE1pyWNZ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE1pyWNZ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28d7c729fso1240591b6e.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792124284; x=1792729084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqgNfUlX3mCkm0/h/3yH5iAcgC/iBbjyQr+ygOjQ+Ok=;
        b=hE1pyWNZ4KQBhDLFo3yvBKSwwEacqrgNrEydNfl4DuDH/efNZgO8NDZ1JNG415wNZ+
         j9/k3lS3tCMFsifmIx2UE/IY7f//5jCBhE6VSWvvD+HWYo69GL1Vfiol3FgHFf/kJZj6
         daTMa5OShAORdxj6wYdL/q4HkJneDqKha0+KXk9f8XPflFOAQiKS1H6YXJ9MVTDvz71Z
         QxhMQnME/6raXr8behqeHfRmR9Ezsi/bti8PHlgjcyv3+3pxJ5MNVF5t66EYWLnbTVN+
         UYbmySp5uAab4C3vX6VO5OzloHZIcCa4ZqpFDsVTlN/lpl7KTnbtMjIXCeJQTxr+gjkb
         WEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124284; x=1792729084;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqgNfUlX3mCkm0/h/3yH5iAcgC/iBbjyQr+ygOjQ+Ok=;
        b=APnbKWmLGjMJLMhmw1wO575YgZy7vDqAGimx3qL85v7g59FuUAi6fT8JsQnhhwn23t
         XlmYXsyYDZqpajbLz2GC+tlAb7mKXTdJTzVlUc29WZwzHwyO9neZeIPQ0YRzfgDsDfJ6
         XGzqIaBo6cm8vVrM8R7n6tDFfkjuE83Pd4qElNn8u4OYfFWGOpJ+rLd5NFgOpXKGyCd/
         U+SUP/mGd3YOLDxr5rKrNYVjZ7n71FtsN9IBykXa2QlyCsy/HmIlf/JbmgJvbH1WCx0K
         7vFt8SgQ0Yxc++JxqWoJhqlF4ulSprNq1nlJC8X92AjglZuOu+kxylLHKif0eHPdQ4oj
         D92g==
X-Forwarded-Encrypted: i=1; AKwUvBzf7hik/6YuecrfdhxcPrAN1whnzECOfuljpS6oF+GrYPcZrF3cCkI198oUvk0NUI8WPTAEeZj0DWSwtw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtvuxzLHU8IoT/YX2Tr2W123CFwrehyKkq3k9xaAEJNESYbepT
	goCPPIplUys09CmrqBje68WQEp1d1gvf9fVlpBM4JZ1impMS/KHILflJ
X-Gm-Gg: AYBFou0IXHa2ffg4c2PLRDO7TcFcy4R5XmpAPAgO4EGozfmw1fAFnImlMYQ6r46PXF6
	4BpYLA1DEmmy5cZO2pdJoCsGtWNlqFuRupEH2mJPSfVevbxdXYt6Q3YeX0AhWnsNrxt4OzmKI2+
	7aEl1hX8nJGhu2SlEnj+GvundxTz9ZxQim7Q2/D3vgWvgn1RdPHlJ5/z5eNecQgiWLbx12baf1o
	zwQgpPt+5eblRV2PRJ/mGADxPw4hOsZjrLKhQatyCTkUes+iLpdPTmnF9kO1yHKTE+1vUnEA8hf
	QqVCbLq/SsBRNPJHnQ6H9RN0dy5nyMVnJ1WBhqrACgR1hcfB6t4RWfhGpmPoWRoXZWFGxf7TizR
	ShAKjlNXnlhLj9zbiBwaNWCrlMQCbYU9V0kMLoaCl1kiZQLSPlBwQQrLy/fU7+XcM6pd6LdVlMO
	aqIxBun4bw+KfrRqU2a8uBG8cVdKN4Z0qt9b7B4lxKqZ/ySJ1qp3PA0ScC+W/DNWW2wF536mK03
	+MdLqL7jha7F3+yzgrgBpdvPp7PnTZjX6RBF3My3udafSoeS4ykKYm/xppca/V7hLuzgy3kfGEl
	KTf7G6i7GSDDiw==
X-Received: by 2002:a05:6808:19a9:b0:4b9:e65b:8c33 with SMTP id 5614622812f47-50c54177b94mr21799531b6e.33.1792124283942;
        Thu, 15 Oct 2026 21:18:03 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c163591sm643029b6e.7.2026.10.15.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:18:03 -0700 (PDT)
Date: Thu, 15 Oct 2026 23:17:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai@fygo.io>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <mkp@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: share one tags_srcu instance across all tag
 sets
Message-ID: <atGlc3-aaLfIHJH4@fedora-laptop>
References: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
 <20261001-bug-blk-mq-global-tags-srcu-v1-1-e8415da10d1b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-blk-mq-global-tags-srcu-v1-1-e8415da10d1b@gmail.com>

On Thu, Oct 01, 2026 at 05:17:50PM +0800, Qiliang Yuan wrote:
> Freed request pages and flush queues are handed to call_srcu() so that
> concurrent tag iterators never see them disappear. Each tag set embeds
> its own srcu_struct for this, which blk_mq_free_tag_set() has to drain
> with srcu_barrier() before cleanup_srcu_struct(). The barrier waits for
> a full SRCU grace period even when the callbacks are long done, adding
> 1-3 ms to every tag set teardown. Drivers that free tag sets under a
> lock make it worse: ublk does it under the global ublk_ctl_mutex, so
> deleting devices from many threads serializes on that grace period.
> 
> The callbacks free memory that only blk-mq owns. They touch neither
> the tag set nor driver code, so they don't need a per-set domain.
> Replace the per-set srcu_struct with a single global one. Freeing a tag
> set no longer waits for a grace period, and each tag set no longer
> allocates per-CPU SRCU state. The read side is unchanged. The only cost
> is that a long-running iterator can now delay these frees for other tag
> sets too, which only postpones freeing memory.
> 
> On 7.3-rc5 in a 16-vCPU VM, with 1 queue and depth 16 per ublk device,
> median of 3 runs (5 for the 16-thread null_blk case):
> 
>                                        before     after
>   ublk DEL_DEV p50, serial             3.45 ms    0.17 ms
>   ublk delete 1000 devices, serial     19.5 s     14.9 s
>   ublk delete 4000 devices, 16 thr     19.0 s     2.9 s
>   null_blk destroy 500 devs, serial    9.97 s     9.25 s
>   null_blk destroy 256 devs, 16 thr    5.15 s     4.30 s
> 
> Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
