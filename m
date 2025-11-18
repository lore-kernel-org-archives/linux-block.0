Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25D2D321D
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488766; cv=none; b=P0mB9X1QdtleKdusvQRG/opOoxhNdhlbUR++ltJd6dy4jdtpi7G1ioNVkrsml4d8VLmvbbsjoROwp+/cg6AOIP7q+SxP4AhQQVNKbZhamuCl6FyQV4IUu6leZ/5181hfvUOGNhN/4viCIoT4BIohm+WZ3+y7AVoQKk+uYdrE8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488766; c=relaxed/simple;
	bh=VrX4r3Oqg7XDmSXiFxV9vElI4mhKhMW+25dZlCw+JWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7KO8xbn9nF6qKjCx3M1QxXdNY551kmwoMFtPBTiNN305Sya8dsYnKI6i7b9vXs/8lS1GZjzROq2plCQwm1VFb+ENThCO87W/ZjavB8xOsC084G+SNVn20g1eK2hbo+0qNOSp/4Zz84w6OFbMXZMdE8aFaRP3FCNHq6OMnMMpgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dfzetevM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dfzetevM"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so8739983a12.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763488762; x=1764093562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/QLhNH/Z+Alzt2I3qgU3sE8xMij5cnkDXNfdgV1+wg=;
        b=dfzetevMeRXb9dUJlXLTjVjoSVFAUvweR9IfZwABOHnh1cqAovgVCUZif5riNwKNFA
         Tcot/4bUfbkQTaPI/CmQMwrcJuWpyDW6SbmOyOrcoxlhpC7V/B2oilJT1y1pi2oyxMYL
         nk7nHgSLu5kVjaoORh4glHCzc3ltH+CMtzyaSwron2dBlEQ7qr20x46Az59oTJndVVG8
         Ij7UNsSi/PUXGO+vILIHwngbUqoAgLDLz4ob90Gdri8z0/sLn3UjwrUngbXa4klrBTJ0
         zCpabBEGfJ10L7RlsuwrLXwgcTbvdKDqxpvGu6SZpRnOxIHnpTh6GJLSmhoU6LsL7sDk
         Nvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488762; x=1764093562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/QLhNH/Z+Alzt2I3qgU3sE8xMij5cnkDXNfdgV1+wg=;
        b=WQeEMK7hmaWby3nzRPB1i8J232tSIEvbHDMt95dbOo2Mnb1VNme5WyzhIxBAaL0NO/
         40uRLzGDoA1/VsT0TRf78l5TjRhYqUIxCBGG/j5zlk7OHV2xZ6mATSNau6zf/BlqMWV5
         jW8OuMJaNLMeigxJt7Fda3/dHpaPcD5+jYY3AIyG+/lwNFWTNlc++rbmMKl4rhMxGofe
         +5BInp5zMblBmdOjoeL9jtwUyqwB88U9b/xkFT4toBwy7sS0o9QN/k9ADHyTvjd0w9Zv
         tTkNj1HZl3KRdDUhbLV5/pHa2ZvjHqh/U4ufk/cgaTIxOLNY5A/rEqzzRV3hJvrjhSQS
         R9MA==
X-Forwarded-Encrypted: i=1; AJvYcCUUIBodsszT3zlMLWrso94zZ1utyi0hrQaFffE0wBmUcsO4ZWJUl6YNZkV0itFojl9zmAj/1E0aAbAsgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaczHUB82v8DmPvvS0Fc95xCpPExEaN7ksDW8sn9M8FHwQlPn+
	SrqGGHFrsEJOiQ7Wdw9I347HtjAOt/QhkBpAAVn/nUsiNr4Hm+QVDCJy4zD1NtV45YY=
X-Gm-Gg: ASbGncvXz90S0ZKvKcP3n5m66R6A8UvgyqboOsSE3fAgB2OGFOFyr5XDvDmud+dNkKx
	NB/B/cc8CIObXzvgEh4P0dVoRZ9T6FV8iOGNOxvQTNiwbur0pK+vnjR9mPme948iK5d4ilOTrZK
	wvyZeHECg03SiuaNDdIoJF5xuOYMdK865NlWV3HLukhAFT8oTPsF/l5W5JGqKMDu7TpG/eJudx/
	5chCdgYWCchw/6ztQsRnmDcVxqtM/ZBLgQZTHEwxkAgbxLQcA94UGK++AO0mOCoOFVW1rr2aVye
	AB8Xon+7TpfJ1WPb/MxPrBbdNvcX1WOpxb9BDr3SELOIc2g67up0wKgxGPwwZB89S5cOnCd19p+
	NXGw9bkFzcd18M1QXlT9Pa/yfqbV6OkemwYgsQhnibQqdkOaeigXzGuuXJysj1ZcFbkqaGaqtDx
	ly9aPT5mt/bQzcD3EzuaGM/2FMd6tjovg7YOZSeeoPzQ==
X-Google-Smtp-Source: AGHT+IGD0gWa9x6M7yLV70kVkIO+IopLYXnwwtqoLUIwaP1K8nEOBlPdpOs/tusHqOqOdKiSHyEP6w==
X-Received: by 2002:a17:907:25cc:b0:b70:fede:1b58 with SMTP id a640c23a62f3a-b736780a96emr1429931366b.2.1763488761796;
        Tue, 18 Nov 2025 09:59:21 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b734fda8a86sm1367521066b.52.2025.11.18.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:59:21 -0800 (PST)
Date: Tue, 18 Nov 2025 09:59:18 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251118175918.GA337106-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
 <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com>
 <aRvjQ6QluONcObXD@fedora>
 <8b07bdd3-5779-4fe4-be05-a8c8efc89f9d@redhat.com>
 <aRvv9-FZ2Q95phNg@fedora>
 <702d904c-2d9a-42b4-95b3-0fa43d91e673@redhat.com>
 <aRv7LJgYP9AVJnfD@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRv7LJgYP9AVJnfD@fedora>

On Tue 2025-11-18 12:50:52 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 11:35:56PM -0500, Waiman Long wrote:
> > On 11/17/25 11:03 PM, Ming Lei wrote:
> > > On Mon, Nov 17, 2025 at 10:42:04PM -0500, Waiman Long wrote:
> > > > On 11/17/25 10:08 PM, Ming Lei wrote:
> > > > > On Mon, Nov 17, 2025 at 09:24:21PM -0500, Waiman Long wrote:
> > > > > > On 11/17/25 8:34 PM, Hillf Danton wrote:
> > > > > > > On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
> > > > > > > > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > > > > > > > tagset, the functions make sure that tagset and queues are marked as
> > > > > > > > shared when two or more queues are attached to the same tagset.
> > > > > > > > Initially a tagset starts as unshared and when the number of added
> > > > > > > > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > > > > > > > with all the queues attached to it. When the number of attached queues
> > > > > > > > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > > > > > > > the remaining queues as unshared.
> > > > > > > > 
> > > > > > > > Both functions need to freeze current queues in tagset before setting on
> > > > > > > > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > > > > > > > hold set->tag_list_lock mutex, which makes sense as we do not want
> > > > > > > > queues to be added or deleted in the process. This used to work fine
> > > > > > > > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > > > > > > made the nvme driver quiesce tagset instead of quiscing individual
> > > > > > > > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > > > > > > > set->tag_list while holding set->tag_list_lock also.
> > > > > > > > 
> > > > > > > > This results in deadlock between two threads with these stacktraces:
> > > > > > > > 
> > > > > > > >      __schedule+0x48e/0xed0
> > > > > > > >      schedule+0x5a/0xc0
> > > > > > > >      schedule_preempt_disabled+0x11/0x20
> > > > > > > >      __mutex_lock.constprop.0+0x3cc/0x760
> > > > > > > >      blk_mq_quiesce_tagset+0x26/0xd0
> > > > > > > >      nvme_dev_disable_locked+0x77/0x280 [nvme]
> > > > > > > >      nvme_timeout+0x268/0x320 [nvme]
> > > > > > > >      blk_mq_handle_expired+0x5d/0x90
> > > > > > > >      bt_iter+0x7e/0x90
> > > > > > > >      blk_mq_queue_tag_busy_iter+0x2b2/0x590
> > > > > > > >      ? __blk_mq_complete_request_remote+0x10/0x10
> > > > > > > >      ? __blk_mq_complete_request_remote+0x10/0x10
> > > > > > > >      blk_mq_timeout_work+0x15b/0x1a0
> > > > > > > >      process_one_work+0x133/0x2f0
> > > > > > > >      ? mod_delayed_work_on+0x90/0x90
> > > > > > > >      worker_thread+0x2ec/0x400
> > > > > > > >      ? mod_delayed_work_on+0x90/0x90
> > > > > > > >      kthread+0xe2/0x110
> > > > > > > >      ? kthread_complete_and_exit+0x20/0x20
> > > > > > > >      ret_from_fork+0x2d/0x50
> > > > > > > >      ? kthread_complete_and_exit+0x20/0x20
> > > > > > > >      ret_from_fork_asm+0x11/0x20
> > > > > > > > 
> > > > > > > >      __schedule+0x48e/0xed0
> > > > > > > >      schedule+0x5a/0xc0
> > > > > > > >      blk_mq_freeze_queue_wait+0x62/0x90
> > > > > > > >      ? destroy_sched_domains_rcu+0x30/0x30
> > > > > > > >      blk_mq_exit_queue+0x151/0x180
> > > > > > > >      disk_release+0xe3/0xf0
> > > > > > > >      device_release+0x31/0x90
> > > > > > > >      kobject_put+0x6d/0x180
> > > > > > > >      nvme_scan_ns+0x858/0xc90 [nvme_core]
> > > > > > > >      ? nvme_scan_work+0x281/0x560 [nvme_core]
> > > > > > > >      nvme_scan_work+0x281/0x560 [nvme_core]
> > > > > > > >      process_one_work+0x133/0x2f0
> > > > > > > >      ? mod_delayed_work_on+0x90/0x90
> > > > > > > >      worker_thread+0x2ec/0x400
> > > > > > > >      ? mod_delayed_work_on+0x90/0x90
> > > > > > > >      kthread+0xe2/0x110
> > > > > > > >      ? kthread_complete_and_exit+0x20/0x20
> > > > > > > >      ret_from_fork+0x2d/0x50
> > > > > > > >      ? kthread_complete_and_exit+0x20/0x20
> > > > > > > >      ret_from_fork_asm+0x11/0x20
> > > > > > > > 
> > > > > > > > The top stacktrace is showing nvme_timeout() called to handle nvme
> > > > > > > > command timeout. timeout handler is trying to disable the controller and
> > > > > > > > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > > > > > > > to call queue callback handlers. The thread is stuck waiting for
> > > > > > > > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> > > > > > > > 
> > > > > > > > The lock is held by the second thread in the bottom stack which is
> > > > > > > > waiting for one of queues to be frozen. The queue usage counter will
> > > > > > > > drop to zero after nvme_timeout() finishes, and this will not happen
> > > > > > > > because the thread will wait for this mutex forever.
> > > > > > > > 
> > > > > > > > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > > > > > > > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > > > > > > > semaphore for read since this is enough to guarantee no queues will be
> > > > > > > > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > > > > > > > semaphore for write while updating set->tag_list and downgrade it to
> > > > > > > > read while freezing the queues. It should be safe to update set->flags
> > > > > > > > and hctx->flags while holding the semaphore for read since the queues
> > > > > > > > are already frozen.
> > > > > > > > 
> > > > > > > > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > > > > > > Signed-off-by: Mohamed Khalfella<mkhalfella@purestorage.com>
> > > > > > > > ---
> > > > > > > >     block/blk-mq-sysfs.c   | 10 ++---
> > > > > > > >     block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
> > > > > > > >     include/linux/blk-mq.h |  4 +-
> > > > > > > >     3 files changed, 58 insertions(+), 51 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > > > > > > > index 58ec293373c6..f474781654fb 100644
> > > > > > > > --- a/block/blk-mq-sysfs.c
> > > > > > > > +++ b/block/blk-mq-sysfs.c
> > > > > > > > @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
> > > > > > > >     	kobject_uevent(q->mq_kobj, KOBJ_ADD);
> > > > > > > > -	mutex_lock(&q->tag_set->tag_list_lock);
> > > > > > > > +	down_read(&q->tag_set->tag_list_rwsem);
> > > > > > > >     	queue_for_each_hw_ctx(q, hctx, i) {
> > > > > > > >     		ret = blk_mq_register_hctx(hctx);
> > > > > > > >     		if (ret)
> > > > > > > >     			goto out_unreg;
> > > > > > > >     	}
> > > > > > > > -	mutex_unlock(&q->tag_set->tag_list_lock);
> > > > > > > > +	up_read(&q->tag_set->tag_list_rwsem);
> > > > > > > >     	return 0;
> > > > > > > >     out_unreg:
> > > > > > > > @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
> > > > > > > >     		if (j < i)
> > > > > > > >     			blk_mq_unregister_hctx(hctx);
> > > > > > > >     	}
> > > > > > > > -	mutex_unlock(&q->tag_set->tag_list_lock);
> > > > > > > > +	up_read(&q->tag_set->tag_list_rwsem);
> > > > > > > >     	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
> > > > > > > >     	kobject_del(q->mq_kobj);
> > > > > > > > @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
> > > > > > > >     	struct blk_mq_hw_ctx *hctx;
> > > > > > > >     	unsigned long i;
> > > > > > > > -	mutex_lock(&q->tag_set->tag_list_lock);
> > > > > > > > +	down_read(&q->tag_set->tag_list_rwsem);
> > > > > > > >     	queue_for_each_hw_ctx(q, hctx, i)
> > > > > > > >     		blk_mq_unregister_hctx(hctx);
> > > > > > > > -	mutex_unlock(&q->tag_set->tag_list_lock);
> > > > > > > > +	up_read(&q->tag_set->tag_list_rwsem);
> > > > > > > >     	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
> > > > > > > >     	kobject_del(q->mq_kobj);
> > > > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > > > index d626d32f6e57..9211d32ce820 100644
> > > > > > > > --- a/block/blk-mq.c
> > > > > > > > +++ b/block/blk-mq.c
> > > > > > > > @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> > > > > > > >     {
> > > > > > > >     	struct request_queue *q;
> > > > > > > > -	mutex_lock(&set->tag_list_lock);
> > > > > > > > +	down_read(&set->tag_list_rwsem);
> > > > > > > >     	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > > > > > > >     		if (!blk_queue_skip_tagset_quiesce(q))
> > > > > > > >     			blk_mq_quiesce_queue_nowait(q);
> > > > > > > >     	}
> > > > > > > > -	mutex_unlock(&set->tag_list_lock);
> > > > > > > > +	up_read(&set->tag_list_rwsem);
> > > > > > > >     	blk_mq_wait_quiesce_done(set);
> > > > > > > >     }
> > > > > > > > @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> > > > > > > >     {
> > > > > > > >     	struct request_queue *q;
> > > > > > > > -	mutex_lock(&set->tag_list_lock);
> > > > > > > > +	down_read(&set->tag_list_rwsem);
> > > > > > > >     	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > > > > > > >     		if (!blk_queue_skip_tagset_quiesce(q))
> > > > > > > >     			blk_mq_unquiesce_queue(q);
> > > > > > > >     	}
> > > > > > > > -	mutex_unlock(&set->tag_list_lock);
> > > > > > > > +	up_read(&set->tag_list_rwsem);
> > > > > > > >     }
> > > > > > > >     EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> > > > > > > > @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
> > > > > > > >     	}
> > > > > > > >     }
> > > > > > > > -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
> > > > > > > > -					 bool shared)
> > > > > > > > -{
> > > > > > > > -	struct request_queue *q;
> > > > > > > > -	unsigned int memflags;
> > > > > > > > -
> > > > > > > > -	lockdep_assert_held(&set->tag_list_lock);
> > > > > > > > -
> > > > > > > > -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > > > > > > > -		memflags = blk_mq_freeze_queue(q);
> > > > > > > > -		queue_set_hctx_shared(q, shared);
> > > > > > > > -		blk_mq_unfreeze_queue(q, memflags);
> > > > > > > > -	}
> > > > > > > > -}
> > > > > > > > -
> > > > > > > >     static void blk_mq_del_queue_tag_set(struct request_queue *q)
> > > > > > > >     {
> > > > > > > >     	struct blk_mq_tag_set *set = q->tag_set;
> > > > > > > > +	struct request_queue *firstq;
> > > > > > > > +	unsigned int memflags;
> > > > > > > > -	mutex_lock(&set->tag_list_lock);
> > > > > > > > +	down_write(&set->tag_list_rwsem);
> > > > > > > >     	list_del(&q->tag_set_list);
> > > > > > > > -	if (list_is_singular(&set->tag_list)) {
> > > > > > > > -		/* just transitioned to unshared */
> > > > > > > > -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > > > > -		/* update existing queue */
> > > > > > > > -		blk_mq_update_tag_set_shared(set, false);
> > > > > > > > +	if (!list_is_singular(&set->tag_list)) {
> > > > > > > > +		up_write(&set->tag_list_rwsem);
> > > > > > > > +		goto out;
> > > > > > > >     	}
> > > > > > > > -	mutex_unlock(&set->tag_list_lock);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Transitioning the remaining firstq to unshared.
> > > > > > > > +	 * Also, downgrade the semaphore to avoid deadlock
> > > > > > > > +	 * with blk_mq_quiesce_tagset() while waiting for
> > > > > > > > +	 * firstq to be frozen.
> > > > > > > > +	 */
> > > > > > > > +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > > > > +	downgrade_write(&set->tag_list_rwsem);
> > > > > > > If the first lock waiter is for write, it could ruin your downgrade trick.
> > > > > If the 1st waiter is for WEITE, rwsem_mark_wake() simply returns and grants
> > > > > read lock to this caller, meantime wakes up nothing.
> > > > > 
> > > > > That is exactly what this use case expects, so can you explain in detail why
> > > > > `it could ruin your downgrade trick`?
> > > > > 
> > > > > > That is true. The downgrade will wake up all the waiting readers at the
> > > > > > front of the wait queue, but if there is one or more writers in the mix. The
> > > > > > wakeup will stop when the first writer is hit and all the readers after that
> > > > > > will not be woken up.
> > > > > So waiters for WRITE won't be waken up by downgrade_write() if I understand correctly,
> > > > > and rwsem_downgrade_wake() documents this behavior too.
> > > > > 
> > > > > > We can theoretically provide a downgrade variant that wakes up all the
> > > > > > readers if it is a useful feature.
> > > > > The following up_read() in this code block will wake up the waiter for
> > > > > WRITE, which finally wakes up other waiters for READ, then I am confused
> > > > > what is the problem with this usage?
> > > > I am just referring to the fact that not all the readers may be woken up. So
> > > > if the deadlock is caused by one of those readers that is not woken up, it
> > > > can be a problem. I haven't analyzed the deadlock scenario in detail to see
> > > > if that is really the case. It is up to you and others who are more familiar
> > > > with this code base to figure this out.
> > > Follows the code base, which isn't special compared with other
> > > downgrade_write() usages:
> > > 
> > > blk_mq_del_queue_tag_set()/blk_mq_add_queue_tag_set():
> > > 
> > > 	down_write(&set->tag_list_rwsem);
> > > 	...
> > > 	downgrade_write(&set->tag_list_rwsem);
> > > 	...
> > > 	up_read(&set->tag_list_rwsem);
> > > 
> > > All others are readers:
> > > 
> > > 	down_read(&set->tag_list_rwsem);
> > > 	...
> > > 	up_read(&set->tag_list_rwsem);
> > > 
> > > 
> > > You mentioned reader may not be waken up in case of r/w mixed waiters, but I
> > > don't see it is possible.
> > 
> > I don't know if concurrent calls to blk_mq_del_queue_tag_set() is possible
> 
> Both blk_mq_del_queue_tag_set() and blk_mq_add_queue_tag_set() can be
> called concurrently with same `struct blk_mq_tag_set *` and different
> 'struct request_queue *'.
> 
> > or not. There is also the blk_mq_update_nr_hw_queues() function that will
> > acquire the write lock.
> 
> blk_mq_update_nr_hw_queues() doesn't add/remove queue to set->tag_list, so
> I guess read lock may be enough.

The reason blk_mq_update_nr_hw_queues() takes write lock is that it can
change q->hctx_table. We do not want to miss hcxt in queue_set_hctx_shared()
called from blk_mq_{add,del}_queue_tag_set().

> 
> Also blk_mq_update_nr_hw_queues() can be run concurrently with the above
> two helpers.
> 
> 
> Thanks,
> Ming
> 
