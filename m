Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342D23C4FA
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006135; cv=none; b=qgIJ5IdZK7Q3AE9cD6aZpPArwhjudtxoUPmHxqnEXctDrHpkdAnt73cegjDFySdYyT4/t1aYbr7qbOuRwCzawYKDfpDe1DF2xTVRK1QbSbNqeYB68PSwww5Y3HvN74IVu4GIVcr9CheybohWPXuuUh/+HGFbVF2NvVCgAuewDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006135; c=relaxed/simple;
	bh=Ba1wp77lCda3xImzlfWQFaJinBMlzcqwOuM1hd6v0v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7cqpyYAeFIqqtOyqP1hZlJK+8yXWU954drxxuuTh9cmzWZh8srgkP0v6qvoJcOq1wJqRufkA8c2yGRM4WTC7czrMAcS0XXGAxSjrK+LctBzdZnC1UwJJp1yvKWymq0uQRHDVCFWWzh2/ykb1SZTJS4llz1FNpFSHTjLEefOyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d3yOvq+y; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d3yOvq+y"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983bae80so4005517a12.0
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764006133; x=1764610933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WppdyCSciz9HWrs/hR0oDV7k3a6Trk+vQz3os79KrFw=;
        b=d3yOvq+ySrZNxOT10H1UZj6Oc46Gm8+AIposbjuhRjdAHwlO4qavYZYjCkPe1Al1d1
         zH1vguTuqnjcysQC09PgxfgX3B6HFY2BPJhVi0r36g8CvC+up9XUPq/U2Hw5bsM4rfsm
         6VDTjUADT9TtjmsEcfxlJ4WD+vM50kuVU9OyOhmNEmfoIPGy39j3/kHt6oiBsGm0/xi/
         YYGdKRl9enfiSsWj9F0LbppsFJKOemZK7x3yQ5g6wM3VpEt+1G/iK1WZBYQF4olhb1Cl
         yO2hTsEYGT464UUbUYNTRILc0NFPjbhxoR+uggpbqbVhw5MS1MFCES64vJhmdce5N87z
         jqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006133; x=1764610933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WppdyCSciz9HWrs/hR0oDV7k3a6Trk+vQz3os79KrFw=;
        b=omDwle8vp21YEjEIL5xP0efjsFqsDZbvT9wW6ERq0dusTi3N74QoFTHYFjv39635qS
         lfkuBFRFqsMeeTRMNvkCQB19/M92vYFyKSeKESYwPZGSCYxNsROpnF8YE2R5vNkK8Ddr
         2yB8y1jnzRiFnUFKuZhyfOG//9JZGTpHMvoGegPgnGOfWbVYVRRNgNgLIYqTrV1lNV0J
         JLdfSmRqET2kqCTH2UAVvT6SBTyRi4y/2MFg5utEdiA55Z+F/+vWwwpbMvLfvou31D38
         OtcNEadJ4d/WADvzCzszAT/tihe4ZxeU7+svnspax3jPh350d/nE6mSoLK2E8IvWE66v
         8uqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjSmlE6t2pgGTZWvtXKV8eBebV/uqKTUdjGwXw2RYGVgP2sDAP+7lYqse3tTw5CAe65Q5VW7MyhO1aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyzk9+aSH5uBWavIcajLTtPGKaVQNukICmxI5vjSXqdjVolWWc
	iizCS/3zc3r4PLnz1gIIVRWNlKWphDRxUD3H1MXhfZgeDcV7ZulOls1j3yTC1WpzQiA=
X-Gm-Gg: ASbGncucRr8JW7no843XCPMx6qxjOdMGvpSveMF+RGiMwJx3G/F9yhuZ5+l38P9+F66
	VzLsoVX94rKai7I2ge+9EHrcyAIWGboM4IVYepkoQwhsEGHbRNCYJwhDUWg7cLZHIAdQlT5krJk
	s7+TnZn/FA08WI3vYytjRIPMWqT03J1uOpiMY9kwzl4+X/Tq5QpMAZS22VztDP47wCvF7pWQstm
	QGoPa0YIqk/NFA6YVwKeE6TI1qXJvS5ctKLuHV0T4GqO5yeeXpqolTMs1qq0j07wTOzHmayW+QX
	kR+uGsLSmQNZ0O0JfxaRiOV5Qe47i1nHbWVmeVCCqcPeXLYvy8dJFQTy8Kd+up0I6k2GF4UUKZ8
	bGUFAQ3oiWgMlCSKvZ6aBRZmr92pcjnyLmnkNXuBWBNpBWZ/3prOwi5PBCeP5ozAkkGNpHZn7eo
	iEHSX4Tfi0hFlSlpgRlvTG0hqBCh4W6Qg=
X-Google-Smtp-Source: AGHT+IG5QYOBjAVVFMK45Nvn6OfeThSH9HuJ61Oz7/6lURBggYPzYHBApxq+nzxrdnDicnCGqIRYGA==
X-Received: by 2002:a05:7300:320b:b0:2a4:5028:3433 with SMTP id 5a478bee46e88-2a719fb6c72mr8386858eec.34.1764006133064;
        Mon, 24 Nov 2025 09:42:13 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2a6fc3d0bb6sm75866424eec.2.2025.11.24.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:42:12 -0800 (PST)
Date: Mon, 24 Nov 2025 09:42:11 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251124174211.GQ337106-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aSPYT6JuQLCE3E7K@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSPYT6JuQLCE3E7K@fedora>

On Mon 2025-11-24 12:00:15 +0800, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > tagset, the functions make sure that tagset and queues are marked as
> > shared when two or more queues are attached to the same tagset.
> > Initially a tagset starts as unshared and when the number of added
> > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > with all the queues attached to it. When the number of attached queues
> > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > the remaining queues as unshared.
> > 
> > Both functions need to freeze current queues in tagset before setting on
> > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > hold set->tag_list_lock mutex, which makes sense as we do not want
> > queues to be added or deleted in the process. This used to work fine
> > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > made the nvme driver quiesce tagset instead of quiscing individual
> > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > set->tag_list while holding set->tag_list_lock also.
> > 
> > This results in deadlock between two threads with these stacktraces:
> > 
> >   __schedule+0x48e/0xed0
> >   schedule+0x5a/0xc0
> >   schedule_preempt_disabled+0x11/0x20
> >   __mutex_lock.constprop.0+0x3cc/0x760
> >   blk_mq_quiesce_tagset+0x26/0xd0
> >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> >   nvme_timeout+0x268/0x320 [nvme]
> >   blk_mq_handle_expired+0x5d/0x90
> >   bt_iter+0x7e/0x90
> >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> >   ? __blk_mq_complete_request_remote+0x10/0x10
> >   ? __blk_mq_complete_request_remote+0x10/0x10
> >   blk_mq_timeout_work+0x15b/0x1a0
> >   process_one_work+0x133/0x2f0
> >   ? mod_delayed_work_on+0x90/0x90
> >   worker_thread+0x2ec/0x400
> >   ? mod_delayed_work_on+0x90/0x90
> >   kthread+0xe2/0x110
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x2d/0x50
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork_asm+0x11/0x20
> > 
> >   __schedule+0x48e/0xed0
> >   schedule+0x5a/0xc0
> >   blk_mq_freeze_queue_wait+0x62/0x90
> >   ? destroy_sched_domains_rcu+0x30/0x30
> >   blk_mq_exit_queue+0x151/0x180
> >   disk_release+0xe3/0xf0
> >   device_release+0x31/0x90
> >   kobject_put+0x6d/0x180
> >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> >   nvme_scan_work+0x281/0x560 [nvme_core]
> >   process_one_work+0x133/0x2f0
> >   ? mod_delayed_work_on+0x90/0x90
> >   worker_thread+0x2ec/0x400
> >   ? mod_delayed_work_on+0x90/0x90
> >   kthread+0xe2/0x110
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x2d/0x50
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork_asm+0x11/0x20
> > 
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> > 
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> > 
> > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > semaphore for read since this is enough to guarantee no queues will be
> > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > semaphore for write while updating set->tag_list and downgrade it to
> > read while freezing the queues. It should be safe to update set->flags
> > and hctx->flags while holding the semaphore for read since the queues
> > are already frozen.
> > 
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Sorry, I was supposed to reply to this thread eariler. The concern
raised about potential deadlock in set->tag_list_rwsem caused by writer
blocking readers makes this approach buggy. The way I understood it is
that rw_semaphore have this writer starvation prevention mechanism.
If a writer is waiting for the semaphore to be available then readers
that come after the waiting writer will not be able to take the semphore.
Even if it is available for reader. If we rely on the readers to do
something to make the semaphore available for the waiting writer then
this is a deadlock. This change relies on the reader to cancel inflight
requests so that queue usage counter drops to zero and queue is fully
frozen. Only then semphore will be available for the waiting writer.
This results in a deadlock between three threads.

To put it in another way blk_mq_del_queue_tag_set() downgrades the
semaphore and waits for the queue to be frozen. If another call to
blk_mq_del_queue_tag_set() happens from another thread, before
blk_mq_quiesce_tagset() comes in, it will cause a deadlock. The second
call to blk_mq_del_queue_tag_set() is a writer and it will wait
until the semaphore is available. blk_mq_quiesce_tagset() is a reader
that comes after a waiting writer. Eventhough the semaphore is available
for readers blk_mq_quiesce_tagset() will not be able to take it because
of the writer starvation prevention mechanism. The first thread that is
waiting for queue to be frozen in blk_mq_del_queue_tag_set() will not be
able to make progress because of inflight requests. The second writer
thread waiting for the semphore on blk_mq_del_queue_tag_set() will not
be able to make progress because the semaphore is not availble. The
thread calling blk_mq_quiesce_tagset() will not be able to make progress
because it is blocked behind the writer (second thread).

Commit 4e893ca81170 ("nvme_core: scan namespaces asynchronously") makes
this scenario more likely to happen. If a controller has a namespace
that is duplicate three times then it is possible to hit this deadlock.

I was thinking about use RCU to protect set->tag_list but never had a
chance to write the code and test it. I hope I will find time in the coming
few days.

Thanks,
Mohamed Khalfella
