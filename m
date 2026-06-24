Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD13D9DCB
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313984; cv=none; b=JP4GSmVtyac6sftmMpmK5vOfRp+Fn44QNlsUT9tucT9O9qpEStKXA1QxJtm/LnQ7KQXvUM24pfpFFb3pHAqffH5eqb8bhj0xczHg0cXydaD7oMV8/mR+lWthk6DoIg00Gi6PuKYsWzSA17khU/4oufwRTqJs1Kmt6GDrlrkZ3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313984; c=relaxed/simple;
	bh=oVqZQJ9jmmMsFO8CXOdC79rdOg94OQrhKCJkNuqPxZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAky/rlBemhKLsaBxXbLUlgGzsBAfzpALryJlINmeGAM/OQT4DOActYVC8URCYktzrzgnYKBTozdQeh6987d+PzkrtxOr7EGWYR7av3sNQbqxelAkFEFXLyrpE0u8QCw2QeAvyeyi5RAYHWUDAT5NZt9p+lYqsOnXQs91dpRn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8vNhcin; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8vNhcin"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-806449d108aso14834087b3.2
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782313982; x=1782918782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vA9QX6ZkTA0MM5pEdSW9MiBk/GWU290NZ7cLdKoelp4=;
        b=h8vNhcinluEy90tZnLVrtZZti2UdQGwDN+TnZp4PLgnAj69ZWu0HhVnyJdm0ly9Tin
         ZlR2s2S5BdIzhPChoEHC6vpo7ZLNYjyIOJyhs26FZ718nKJ3FunaoKcScEoyIoigGkAZ
         sucikOduyIaOl1c8RacRkSBwG4QU8OY6h1kqqHllGelpV87sCdM4LJv3MvGmg8LhB59I
         C27R+UjS8CBw/fykKowYvhx7XIS2aP0jnFTAr24JcGZ9pQtb0vMh0eokfFKM5i5XZRJ8
         IdbUjFtNGFhvWG2mPXrrc8DH/XEybevyfCruqDpz8+HwNujft2CJQfVtwMkSoY9uks+f
         1BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313982; x=1782918782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA9QX6ZkTA0MM5pEdSW9MiBk/GWU290NZ7cLdKoelp4=;
        b=PUUHQqDuIin4iUGYiZsHBMHSZka6Nx4xkWaArGlEdg+yFPke6D2YzUDgw21Bxu0+bK
         qM6R557rIivjbUQdQsaDhGr70A2XuI1p7WCPDmQ+8pkAsZYiey8pIoA7ORkiCHfHCWNQ
         bO8iXwSgTmhbnp6ADL2NnD+USP20nVRJ9YfayZyLNPJRHqmC9zFI8iWDoepv0Kmfabrx
         +bUQcWIooNdE1NQbNqkYV4Ptd9WzlKEGa5fVzqLhRjFz3PF/Cg7nOKZKr4gFl6ZMIE0t
         UX0UTr5xxep2d29NVOLFJIKic20xYUvgHsY4zFaGv+8ou1R2/zl7fIFbTsVkPx2lMBAW
         vvHw==
X-Gm-Message-State: AOJu0YwYcuDJoPimzADRHU2n2LetQJ9xeB7MBa6wjmQzA0kUMCrD3dQ7
	omrSAE/VtNTIyaWBJ7yUv4y9bU5KX14FoLYyAUtf8ic8MqmPCFz1naOf
X-Gm-Gg: AfdE7cn6LMUTRxjyfCj9JxGVJOGHPcZgaEz8kFyVw/iaG739kO+zyII32W3nUTgaUc7
	PlHVHhfesoYvnGMyZCaLcJ2eN4KPu185S35sGy0Vctv7e2fORkFJfdSUCaigGUdzMJ3wUSFKVCj
	3p44cVu7hTrGmHEJSWjxcIG/Qb9Frv1fupctUHJnTw4+gZzxyaFBqMG2i3IDhbFjqHKbC+feDiF
	gQF1E9UVg/CfgVA8abNC2cfqxJ1rhLH6EhjC64+Y6xDd1cd+CXt1gM01BWePKn9P/yt0fopxYMu
	I14UI6jCYhI/P9mefycEOYEvPyOuhMbqLkyeV3+tmHZ6vF2enE9qFIuhv3CmnSqkEXiRGzGd3nB
	7iWBVLIBBd6+QNk3gjtoweq+g+56Vade3SHyikqyEa+E7y1f7hTMc50hVMBDkC6yrtPwU7B98ON
	JedIQizys8TDokrgWR4IIOLChLvC1dMV6mfVbviUodZPQ9D5VyEJsNLvI4NtxVu0ssNniUKYQxM
	vMpOtje
X-Received: by 2002:a05:690c:3585:b0:7fa:c896:8982 with SMTP id 00721157ae682-807f457c504mr35752237b3.26.1782313981917;
        Wed, 24 Jun 2026 08:13:01 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80519668bacsm37978887b3.26.2026.06.24.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:13:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:12:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
Message-ID: <ajvz98mmlJEaTNxd@fedora>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>

On Tue, Jun 23, 2026 at 10:32:38AM +0900, Shin'ichiro Kawasaki wrote:
> When elevator_change() is called concurrently for the same queue, the
> elevator_change_done() function runs concurrently as well. This function
> adds or deletes kobjects for the debugfs entry of the queue. Then the
> concurrent calls cause memory corruption of the kobjects and result in a
> process hang. The core part of the elevator switch is protected by queue
> freeze and q->elevator_lock. However, since the commit 559dc11143eb
> ("block: move elv_register[unregister]_queue out of elevator_lock"), the
> elevator_change_done() is not serialized. Hence the memory corruption
> and the hang.
> 
> The failures are observed when udev-worker writes to a sysfs
> queue/scheduler attribute file while the blktests test case block/005
> writes to the same attribute file. The failure also can be recreated by
> running two processes that write to the same queue/scheduler file
> concurrently. The failure is observed since another commit 370ac285f23a
> ("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
> changed the behavior of queue freeze and it unveiled the failure.
> 
> Fix the failure by changing elv_iosched_store() to acquire
> update_nr_hwq_lock as the writer lock instead of the reader lock. This
> serializes the whole elevator switch steps, including the
> elevator_change_done() call.
> 
> Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> I observed that the blktests test case block/005 hung on a specific
> server hardware using a specific HDD as a block device. During the test
> case run, the kernel reported KASAN null-ptr-deref and slab-use-after-
> free errors. The failure happened when a sysfs queue/scheduler attribute
> file is written concurrently. I reported the failure and shared a
> candidate fix patch as RFC [1]. Based on the comments and discussion on
> the RFC patch, I propose this v2 patch that avoids introducing a new
> lock. My thanks go to Ming and Nilay for the discussion.
> 
> Please refer to [1] for details of the failure. Also, I created a
> blktests test case that recreates the hang [2], which I used to test the
> fix.
> 
> * Changes from RFC v1
> - Instead of adding a new mutex to struct request_queue, replace the
>   reader lock on update_nr_hwq_lock with the writer lock in
>   elv_iosched_store().
> 
> [1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
> [2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6
> 
>  block/elevator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 3bcd37c2aa34..b03185a217ff 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>  	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>  	 */
> -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {

I'd suggest to document why using write_trylock above, such as serializing
2-stage elevator switch, anyway this patch looks good as bug fix:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
