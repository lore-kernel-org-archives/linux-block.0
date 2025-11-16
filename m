Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591021D5B0
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763311572; cv=none; b=GtPS9XmJ5UFj54gfWr4MpBaR99PrawKB7W9PlRxXuxbl7wKLKce6Q/5uuw4/cG09+svWHN3ZA15xeWqFtFoXtFqs8AdoEThChxlmcg4mm4LQnwyiKY0y3St3WYwQtRGLx/9rVpFZCQTDPSIS4qbZMpFl3L/G7KNykMrDw5zWaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763311572; c=relaxed/simple;
	bh=yfuoDhepLlty2cQq44Y6YuPK47EhADEcuShAQ2l0cjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqPXGfezH7Spc2ewg2mzY6CGwpGR6oZo+U0k7G5LQnxebbHHtKvtV0az3Nl6ibfm1xrZnZENvegsKbDb0TWpX7HHa50m4N0lt+LaZ+zVRK35f1tdsbG23wiD26hH72GVqiKkbuBB8q2w/Fwfvyg8JR1tMgIiw11Ydv2ctpVPCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JP4gMJd0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JP4gMJd0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so3160713b3a.1
        for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763311569; x=1763916369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzuMA0HqLv22fL5ouW8cGieDtH/YoU81WKUNJmbycJ0=;
        b=JP4gMJd0YI0dIQOFVkx9bo5k2J0wwsWasrBv0s25HTuMUtF12/wFwoPGboTtzoO2r+
         LeEJCERv+lzi/CBwZ7lUPygLVKzQDStL/ocV3Uz4K4JjCLTqskjb6Yru9UxddYjxfh0B
         SATBXXooLRkgXo48dAq5lTCURUSvv0IcjZhyBRyAw9dC8BhpIOfhPxKiVgJ6LY1o5KR4
         UEeIUP0VNf0PZnlPBLO+3jN9fVUmCGlSlhE1TaW/LlOHwTzO1khf3UFfSHZj+DAjGWn4
         B1ESjJ4bZry44Omxb95LaO2urRctW87EADA4/uzQORG60KJEZjCALRn3BSX11mu6RZkg
         tvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763311569; x=1763916369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzuMA0HqLv22fL5ouW8cGieDtH/YoU81WKUNJmbycJ0=;
        b=vAzkyfwDt0O/z90Bcy0h7DFGns7cRK6c+7NJfDFjnqF554RWbc7LwIf2onpTpVcm5V
         B5lAuAUFvDWFqCZv3D6OkKN1j/sjNiksrfm+74fkmI19HPbEzfRlN7nxBiD/j85OdQc+
         1XmFhGiL/ReIP4g3L5auvUax9dgXqtzjoXhFwhF7tWlQAy/T6j85O24LOh7vn06bd7/X
         hY/PTSnP+GlkgV11TA0SXy4VoKrTIcrdWql8t5QTNmIKRxNgLs6p2UT8TZ+dlL4HUF/n
         A+0S1WWU4pCRVUtLIouxWV8mRBS5iEwQDpsl/VWi3iGAqXX0xTul3rb4GR0Cct+4A1kG
         Dk4g==
X-Forwarded-Encrypted: i=1; AJvYcCW+ij3h9Zpe0SkH5Bzgn/TBJCcg/ST6OMeDGvUHq6s2WaOA8j8OvrRyb/r3Iw/7VqHxdlchZhIqxeCIYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwehGJRaS0BbakEbxTT/LNcO6NIhzdgO0Th9EUCbjtwoUdKMWLb
	zQy1xpSmNBEy4g8fZGhjABdQ/mQ757oJXXkgm8N9IBOORL7xl/h4j+9F0meWLrotPo4=
X-Gm-Gg: ASbGncuI8CSk5cUsymKVYItxnfgTMvhPDStzc6yWS0oq3IS+GBAkyDU67gmY2SkEsOP
	dMfELO5kSJvSJJ1a6F5QCHtnk7tgiv1FV0dRXs/z97debJql0LJdBD96TJLCSlj/+RFCu4yLP39
	OEZ83cjZi5UNsLWIz2W7lFQr8nJlQnORwm4BYMa0Ksw7H5gQ/nRLIiob4TDUjKdLsOxilofukyG
	2+ZnQ3YgBp1YjXSzNt+9SToqxZB9gQWawLnqJj8+x1h8AfJTF3zlKR0eKj239P5xyLoOa9BIBmA
	lba7uQ/SOpJ8uvgv0bhGnITNYVj+fZErb/rCavq7dRsf9ppgwOK2Lr/4yM0ppm/m6zj3Q5zGUvd
	CRXmydEEOIWKtr4RFrat73ZJNd0zBjJ9bzO7h0zL7QmLaxQmjjUIAspf7/Rk7yQKC3yAEFpCID4
	knd7umLFDISD8yF9s8fmtzRX8Hzxw=
X-Google-Smtp-Source: AGHT+IE5rrGbiwByjHLuKq7S9q5r3YznMONfkuzETCp/ON+jIpJvE4l43Yh/uyxNLb5/9bCltvKINQ==
X-Received: by 2002:a05:7022:ff42:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11bc1abbed3mr1532024c88.35.1763311568872;
        Sun, 16 Nov 2025 08:46:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b060885e3sm37082181c88.0.2025.11.16.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 08:46:08 -0800 (PST)
Date: Sun, 16 Nov 2025 08:46:06 -0800
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
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <20251116164606.GA2376676-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
 <20251114173419.GA2197103-mkhalfella@purestorage.com>
 <aRnqmiFmWAI01zJq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRnqmiFmWAI01zJq@fedora>

On Sun 2025-11-16 23:15:38 +0800, Ming Lei wrote:
> On Fri, Nov 14, 2025 at 09:34:19AM -0800, Mohamed Khalfella wrote:
> > On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> > > On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
> > > > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > > > tagset, the functions make sure that tagset and queues are marked as
> > > > shared when two or more queues are attached to the same tagset.
> > > > Initially a tagset starts as unshared and when the number of added
> > > > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > > > with all the queues attached to it. When the number of attached queues
> > > > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > > > the remaining queues as unshared.
> > > > 
> > > > Both functions need to freeze current queues in tagset before setting on
> > > > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > > > hold set->tag_list_lock mutex, which makes sense as we do not want
> > > > queues to be added or deleted in the process. This used to work fine
> > > > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > > made the nvme driver quiesce tagset instead of quiscing individual
> > > > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > > > set->tag_list while holding set->tag_list_lock also.
> > > > 
> > > > This results in deadlock between two threads with these stacktraces:
> > > > 
> > > >   __schedule+0x48e/0xed0
> > > >   schedule+0x5a/0xc0
> > > >   schedule_preempt_disabled+0x11/0x20
> > > >   __mutex_lock.constprop.0+0x3cc/0x760
> > > >   blk_mq_quiesce_tagset+0x26/0xd0
> > > >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> > > >   nvme_timeout+0x268/0x320 [nvme]
> > > >   blk_mq_handle_expired+0x5d/0x90
> > > >   bt_iter+0x7e/0x90
> > > >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > >   blk_mq_timeout_work+0x15b/0x1a0
> > > >   process_one_work+0x133/0x2f0
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   worker_thread+0x2ec/0x400
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   kthread+0xe2/0x110
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork+0x2d/0x50
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork_asm+0x11/0x20
> > > > 
> > > >   __schedule+0x48e/0xed0
> > > >   schedule+0x5a/0xc0
> > > >   blk_mq_freeze_queue_wait+0x62/0x90
> > > >   ? destroy_sched_domains_rcu+0x30/0x30
> > > >   blk_mq_exit_queue+0x151/0x180
> > > >   disk_release+0xe3/0xf0
> > > >   device_release+0x31/0x90
> > > >   kobject_put+0x6d/0x180
> > > >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> > > >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> > > >   nvme_scan_work+0x281/0x560 [nvme_core]
> > > >   process_one_work+0x133/0x2f0
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   worker_thread+0x2ec/0x400
> > > >   ? mod_delayed_work_on+0x90/0x90
> > > >   kthread+0xe2/0x110
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork+0x2d/0x50
> > > >   ? kthread_complete_and_exit+0x20/0x20
> > > >   ret_from_fork_asm+0x11/0x20
> > > 
> > > It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> > > support owned freeze queue.
> > > 
> > > Maybe the following change can avoid it?
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index c916176bd9f0..9967c4a7e72d 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > >         bool dead;
> > > 
> > >         mutex_lock(&dev->shutdown_lock);
> > > +       nvme_quiesce_io_queues(&dev->ctrl);
> > >         dead = nvme_pci_ctrl_is_dead(dev);
> > >         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
> > >                 if (pci_is_enabled(pdev))
> > > @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > >                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> > >         }
> > > 
> > > -       nvme_quiesce_io_queues(&dev->ctrl);
> > > -
> > >         if (!dead && dev->ctrl.queue_count > 0) {
> > >                 nvme_delete_io_queues(dev);
> > >                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> > > 
> > > 
> > 
> > Interesting. Can you elaborate more on why this diff can help us avoid
> > the problem?
> 
> In nvme_dev_disable(), NS queues are frozen first, then call
> nvme_quiesce_io_queues().
> 
> queue freeze can be thought as one lock, so q->freeze_lock -> tag_set->tag_list_lock
> in timeout code path.
> 
> However, in blk_mq_exit_queue(), the lock order becomes
> tag_set->tag_list_lock -> q->freeze_lock.
> 
> That is why I call it AB-BA lock.
> 
> However, that looks not the reason in your deadlock, so my patch shouldn't
> work here, in which nvme_dev_disable() doesn't provide forward-progress
> because of ->tag_list_lock.
> 
> > 
> > If the thread doing nvme_scan_work() is waiting for queue to be frozen
> > while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
> > will cause the deadlock, no?
> 
>  __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   blk_mq_freeze_queue_wait+0x62/0x90
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_exit_queue+0x151/0x180
>   disk_release+0xe3/0xf0
>   device_release+0x31/0x90
>   kobject_put+0x6d/0x180
> 
> Here blk_mq_exit_queue() is called from disk release, and the disk is not
> added actually, so question is why blk_mq_freeze_queue_wait() doesn't
> return? Who holds queue usage counter here?  Can you investigate a bit
> and figure out the reason?

The nvme controller has two namespaces. n1 was created with q1 added to
the tagset. n2 was also created with q2 added to the tagset. Now the
tagset is shared because it has two queues on it. Before the disk is
added n2 was found to be duplicate to n1. That means the disk should be
released, as noted above, and q2 should be removed from the tagset.
Because n1 block device is ready to receive IO it is possible for q1
usage counter to be greater than zero.

Back to q2 removal from the tagset. This requires q1 to be frozen before
it can be marked as unshared. blk_mq_freeze_queue_wait() was called for
q1 and it does not return because there is a request issued on the queue.
nvme_timeout() was called for that request in q1.

> 
> For one released NS/disk, no one should grab the queue usage counter,
> right?

Right. The disk is not visible yet.

> 
> 
> Thanks,
> Ming
> 
