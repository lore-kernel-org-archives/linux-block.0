Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652E2ED154
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874986; cv=none; b=LcZ3tozO5nhw3Iiayl10oKmtzuEPfo5XrZ/JJTxCEzYHG07BKQ0CB+KplKEJmo0BWMe0PUSn3Rq0rBM24meIu7sy2jmZvAWzvSTy3ASbYyZ6CG1rHkoG+L85Q9ly0v9sF3yVvWUi6yQM5bhU5lu2/UeKaoUolv1kRhj7F9UeTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874986; c=relaxed/simple;
	bh=cu623s1bdOx+4VnSqnuzChiFjH0jvM64sJHrEcwAaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrlH4vQRmcDPUonFztb7m3CHRQDlW99yVG0yE5sbc3wNZXG0/dhmXl/HZDiODqfTt64jgkyjUIoCGlCi3mshSAz79gMWZ3rx1HhqAXcsLpyrZiQ1WxFPVFf/oP9kHUpERPuNI93MlDNByywKIzX4VZPQEeSHb+OUb+kJMa77e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QcDH8dIX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QcDH8dIX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7697e8b01aso234485766b.2
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 11:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764874982; x=1765479782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZNwwr56flO1xS1S9sF1L+dtFjYocKmny67IwW4Ohtk=;
        b=QcDH8dIX5elujs+UyNxu+vGUaejX6rZqM5bXjQqwTLYV35rYAe71FcgpuOBa19t8ab
         INDqN4Q7zteA/h4DR0cCIbyKkOWwvxiq/Gp0TzjeLoy8PzZQkhLqxvwMnGj4KzNKYhCK
         WE4KaocAQP5m4pc3zS58mEqxGmYF/7FJxFstBsSpn63Yqxxc9Vii7bWXaoUQWLuOZybN
         hN2PiFuOcV9ZIBvyVKLZg5gHEIceNZZsASddwFRbrRfdHqM9RoIv+JWcm4esrolN55Wt
         At14rHUAMHNi8evRWR45sARbi3r+1yed5g2SSlAOA3ddnAf+NTtiYFl8HEibmvpZVxTj
         D7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764874982; x=1765479782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZNwwr56flO1xS1S9sF1L+dtFjYocKmny67IwW4Ohtk=;
        b=hD9flmnNy0fBPh1TwNF45unwYS18HSlCi/U1+QX4i2NApX4z/m9k4E98M3/TUJiwOo
         nJIlYL7ybJH4EtOuv8BD+6YyTnNdIl2CIRrv7KFlwsoq69rXgUVKAvx9ag0Oa0Z38CUt
         Z/70/CvEzffkCZJtT2SmO+YMnCm1Lvd0cQbUjWYjCEBdYUP3UCQ9iS6OhYHVsnl+eb4y
         swqakQ4jDn0SLgGKWaDRRYB6HKhcm5TXSJ102gSL7uUBZ3GZBFUTposnpnupKGAxK4RU
         yvN9NMGwfDmEp1a2lmQ1FSvmGiQYo4GTzDvAV+WxeAbKuo+Epq21ljr5YqXs+E7EuZJj
         PiOA==
X-Forwarded-Encrypted: i=1; AJvYcCViRSNedxgk0sKBVXjNZNlznY+4X2lQ8g5WLCoc5iYbfyCuyi98Vl45/l300tFijueB8BAlbT8KEfX6lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCSU3nl1ePKgdmJ6C6cC9jL4BRmXPw402lzxoQs89VRwOCUke
	TX+wArZbmlA2PUlOVDktmV0p0uQT8dmbkkAgjJ3toZX6zXdmXM2ZnZj74ddfZ7wlMUY=
X-Gm-Gg: ASbGnctFnVVRcmMxa5g/tsF4pcmyGXxykE7HM9vcjTW92sX9ewBEXIwvDAHZyVJHJ3u
	eopntj6l+yf96HxeOHAF6/TGtnWDCK8bjcwFEBiWtcdZiyEVCkxE8OEX5yOqxx+B5uHMYw7rFyY
	YkqznxfQE0qu6fUb5oyWL8wOIe1gsRlVfY3IcarWaay9qOuA0Urqjv4VMs8YLWChBT0YguKb/bw
	jOpv2iKWz7ScNBwSaKtUkOX4KYqO7L72F55ptPm0+1oTAmi7EAnDWWa8pMuZXSosvjDKBEwB9gc
	UCGLiQcrrQnpgOoE0b/1haG6x/fA+/a3QOnMWmjp+vvBiAbzAtHGz4eJSfZhWjHQ4Z32d4voCu/
	eOaKBIH1Vp4w0P/jgLEXNQkIVpZtgIATnh3dSF73DRTO6EvYIgmwbnyM3KUuC53Ns8OAeyJYFXm
	TY0hcxnoPMzbzd9i4JYwZfe7djuAzPX0t2bVn+pigwaQ==
X-Google-Smtp-Source: AGHT+IH26241l6Q/yokZ7U8z1pSwtQVJnt6+RwJRUNGc30R9za5E0rovz0FeljZNndRz6VFmAa7/zA==
X-Received: by 2002:a17:907:3cc2:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b79dc73cce5mr759963766b.32.1764874981679;
        Thu, 04 Dec 2025 11:03:01 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f449ba82sm195018266b.22.2025.12.04.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:03:01 -0800 (PST)
Date: Thu, 4 Dec 2025 11:02:58 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204190258.GA337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204181212.1484066-2-mkhalfella@purestorage.com>

On Thu 2025-12-04 10:11:53 -0800, Mohamed Khalfella wrote:
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.
> Initially a tagset starts as unshared and when the number of added
> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> with all the queues attached to it. When the number of attached queues
> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> the remaining queues as unshared.
> 
> Both functions need to freeze current queues in tagset before setting on
> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> hold set->tag_list_lock mutex, which makes sense as we do not want
> queues to be added or deleted in the process. This used to work fine
> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> made the nvme driver quiesce tagset instead of quiscing individual
> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> set->tag_list while holding set->tag_list_lock also.
> 
> This results in deadlock between two threads with these stacktraces:
> 
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   schedule_preempt_disabled+0x11/0x20
>   __mutex_lock.constprop.0+0x3cc/0x760
>   blk_mq_quiesce_tagset+0x26/0xd0
>   nvme_dev_disable_locked+0x77/0x280 [nvme]
>   nvme_timeout+0x268/0x320 [nvme]
>   blk_mq_handle_expired+0x5d/0x90
>   bt_iter+0x7e/0x90
>   blk_mq_queue_tag_busy_iter+0x2b2/0x590
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   blk_mq_timeout_work+0x15b/0x1a0
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
> 
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   blk_mq_freeze_queue_wait+0x62/0x90
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_exit_queue+0x151/0x180
>   disk_release+0xe3/0xf0
>   device_release+0x31/0x90
>   kobject_put+0x6d/0x180
>   nvme_scan_ns+0x858/0xc90 [nvme_core]
>   ? nvme_scan_work+0x281/0x560 [nvme_core]
>   nvme_scan_work+0x281/0x560 [nvme_core]
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
> 
> The top stacktrace is showing nvme_timeout() called to handle nvme
> command timeout. timeout handler is trying to disable the controller and
> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> to call queue callback handlers. The thread is stuck waiting for
> set->tag_list_lock as it tires to walk the queues in set->tag_list.
> 
> The lock is held by the second thread in the bottom stack which is
> waiting for one of queues to be frozen. The queue usage counter will
> drop to zero after nvme_timeout() finishes, and this will not happen
> because the thread will wait for this mutex forever.
> 
> Given that [un]quescing queue is an operation that does not need to
> sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> set->tag_list_lock. Also update blk_mq_{add,del}_queue_tag_set() to use
> RCU safe list operations. This should help avoid deadlock seen above.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")

Oops, this should be v3 and I also missed Fixes: tag above.

> ---
>  block/blk-mq.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..ceb176ac154b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_quiesce_queue_nowait(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>  
>  	blk_mq_wait_quiesce_done(set);
>  }
> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_unquiesce_queue(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>  
> @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	mutex_lock(&set->tag_list_lock);
> -	list_del(&q->tag_set_list);
> +	list_del_rcu(&q->tag_set_list);
>  	if (list_is_singular(&set->tag_list)) {
>  		/* just transitioned to unshared */
>  		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		blk_mq_update_tag_set_shared(set, false);
>  	}
>  	mutex_unlock(&set->tag_list_lock);
> +
> +	synchronize_rcu();
>  	INIT_LIST_HEAD(&q->tag_set_list);
>  }
>  
> @@ -4321,7 +4323,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  	}
>  	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
>  		queue_set_hctx_shared(q, true);
> -	list_add_tail(&q->tag_set_list, &set->tag_list);
> +	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
>  
>  	mutex_unlock(&set->tag_list_lock);
>  }
> -- 
> 2.51.2
> 
