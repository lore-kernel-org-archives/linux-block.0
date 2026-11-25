Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626037;
	b=yzJ9ZBSAf8AevUCtFz55vtfp3kqTflU+sKR352gTvusLVzp5PjeRzCUIJDQFWhodbdrv
	 G19JmLvSi10dpVYyuFDWGwcrMpY1fecUerBDWczfLkKd4kovJ1QEJCGWLtnQntNsKZ7OE
	 QrybyHNxRTYGq7Eipmy3s9CqTJF99xjSb6Vf5aNcDt7semRx4WpN2gSsYrnYjO/9v1JCb
	 1Y78fvZO0TEtkw8H5Dtrqx28R2ZNzz7u07+EyV4K2PJi9JIt+NiNv9VTwyy+UEhhXdI03
	 Dcf7vtIsG4BYrrcD7JcnMa0wanfJXbI9Nhj/38EXKKerp4+wlBEi7bvx2mMJE20UN3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=81ysONsKPZIISOGu9Pqswa58i6DCZs85AkXLBqCpQR8=;
	b=1+CpCxqhDnEKYu46CCCCl746+0wckxcDH/4RAG7pQ4LIqSW0XZOvJrDmIvS46ul+NQsO
	 n/Hi7/6tmvRkeGy8m19MA0SFPmedU5cDXjBIUO6AgiXhK02ycrn+g7CaygRQjyMqFJ4aE
	 IpBwfYvFuw/rBv2uaAFxRXwwvXfoaqEqaAc81yGIC/iK8b9IC4qZd793U79uncjAtqVe+
	 5/bBcffW3CSH97LBGnpxKflEXBGzNs6vvCHgVCM4vwaBP1ccILUUN7Lc44sY4MtMEeioJ
	 raIWIP0/Yrgn1Rqhzsf4xJITwlq6IStBcfLC/vSv/LnejUC7XBqw2PcxXw+Z3YXgAsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tB8ad5CA;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23350606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 17:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23350606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tB8ad5CA
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jZQsp3XW0zlfclp;
	Wed, 25 Nov 2026 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795626027; x=1798218028; bh=81ysONsKPZIISOGu9Pqswa58
	i6DCZs85AkXLBqCpQR8=; b=tB8ad5CAKUvTIy46PZ5XrUgsXfOuRK7dmpMROVqx
	wJJKbQqjTVN40PsvloTv2S0cQE73EShWnPT50eMq2OhR7t7FAgEop0o7zT15o44Y
	7rQXVvpJ0mHht4+6TvAOwf0xkf2m/k5NsOx/yBsnrYwqz4qHVFz1RAjuTGu8UDOM
	nLfiIQMG7me2d/WiC/H1kYr3p6HQMZxmeohRx5V6EPqv5fUKvKZmDMnUA61H/R8P
	4GAUjo0c5N1fuEZGovgTXWMOhYLMbnWNqWb1CA9uMn0UV7BzM7E2ebrK0A3yNvIE
	Fh6eJeIC6YICWcwYuAJjA/SAidbHqDDwou2UeLamqgYPwQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8E4kmIvQ8fKG; Wed, 25 Nov 2026 17:00:27 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jZQsl1NytzlfclG;
	Wed, 25 Nov 2026 17:00:27 +0000 (UTC)
Message-ID: <4149778a-99ac-4193-b06d-b032184953f9@acm.org>
Date: Wed, 25 Nov 2026 09:00:26 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: don't wait for all RCU callbacks when freeing
 zone write plugs
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Damien Le Moal
 <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261125-feat-blk-zoned-rcu-barrier-v3-1-707f65bae05a@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261125-feat-blk-zoned-rcu-barrier-v3-1-707f65bae05a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/26 00:41, Qiliang Yuan wrote:
 > Removing 32 zoned null_blk or scsi_debug devices, base and patched
 > kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
 > range in parentheses; "with plugs" leaves four partially written zones,
 > and so four zone write plugs, on each null_blk device:
 >
 >   devices                      before (ms)      after (ms)   change
 >   null_blk                   820 (805-885)   438 (424-454)     -47%
 >   null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
 >   scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%

Real zoned drives taken offline on a storage node typically have
partially written zones and therefore still have active zone write plugs
in disk->zone_wplugs_hash at teardown time. The reason "null_blk, with
plugs" only improves by 4% is that disk_destroy_zone_wplugs_hash_table()
frees those remaining plugs via disk_mark_zone_wplug_dead() ->
disk_free_zone_wplug() -> call_rcu(), which still forces an RCU grace
period wait for every disk that had at least one active plug.

By the time disk_destroy_zone_wplugs_hash_table() runs from
disk_release(), no RCU readers can still be accessing
disk->zone_wplugs_hash (the function already iterates the hash table
without zone_wplugs_hash_lock, assumes every plug has ref == 1, and
frees disk->zone_wplugs_hash synchronously with kfree()). Nor is
updating disk->zones_state needed, as disk_release_zone_resources()
clears it immediately afterward.

Have you considered unhashing and freeing the plugs still in
disk->zone_wplugs_hash directly with mempool_free() (keeping the
WARN_ON_ONCE() checks) instead of going through call_rcu()? Then
nr_zone_wplugs_freeing would only wait for plugs that were already
queued for RCU freeing shortly before disk_release(), and the "with
plugs" case would skip the RCU wait as well.

 > diff --git a/block/blk-zoned.c b/block/blk-zoned.c
 > index 4c58892961912..2e61a9f23b270 100644
 > --- a/block/blk-zoned.c
 > +++ b/block/blk-zoned.c
 > @@ -724,8 +725,11 @@ static void disk_free_zone_wplug_rcu(struct 
rcu_head *rcu_head)
 >  {
 >  	struct blk_zone_wplug *zwplug =
 >  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
 > +	struct gendisk *disk = zwplug->disk;
 >
 > -	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
 > +	mempool_free(zwplug, disk->zone_wplugs_pool);
 > +	if (atomic_dec_and_test(&disk->nr_zone_wplugs_freeing))
 > +		wake_up_var(&disk->nr_zone_wplugs_freeing);
 >  }

If keeping wait_var_event(), this can be simplified with
atomic_dec_and_wake_up(&disk->nr_zone_wplugs_freeing) from
<linux/wait_bit.h>.

 >  static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 > @@ -745,6 +749,7 @@ static void disk_free_zone_wplug(struct 
blk_zone_wplug *zwplug)
 >  	atomic_dec(&disk->nr_zone_wplugs);
 >  	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 >
 > +	atomic_inc(&disk->nr_zone_wplugs_freeing);
 >  	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
 >  }
 >
 > @@ -2149,7 +2155,8 @@ static void 
disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 >  	 * Wait for the zone write plugs to be RCU-freed before destroying the
 >  	 * mempool.
 >  	 */
 > -	rcu_barrier();
 > +	wait_var_event(&disk->nr_zone_wplugs_freeing,
 > +		       !atomic_read_acquire(&disk->nr_zone_wplugs_freeing));
 >  	mempool_destroy(disk->zone_wplugs_pool);
 >  	disk->zone_wplugs_pool = NULL;
 >  }

There is a regression here with CONFIG_RCU_LAZY=y on rcu_nocbs CPUs:
call_rcu() queues disk_free_zone_wplug_rcu() lazily, which can delay
starting the grace period by up to LAZY_FLUSH_JIFFIES (10 seconds).
Previously, rcu_barrier() explicitly hurried all pending lazy callbacks
(via rcu_nocb_flush_bypass()), whereas wait_var_event() does not, so
removing a zoned disk with pending callbacks can stall for up to 10
seconds per disk.

Either:
- switch disk_free_zone_wplug() to call_rcu_hurry(), or
- keep call_rcu() and conditionally call rcu_barrier() only when
   atomic_read_acquire(&disk->nr_zone_wplugs_freeing) is non-zero (with
   smp_mb__before_atomic() before atomic_dec() in
   disk_free_zone_wplug_rcu()). Combined with freeing remaining hashed
   plugs synchronously in disk_destroy_zone_wplugs_hash_table(), that
   preserves lazy RCU batching during normal operation, avoids
   wake_up_var() on every zone free, and still hurries lazy callbacks
   if any happen to be in flight at teardown.

Thanks,

Bart.
