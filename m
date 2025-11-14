Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5362D662D
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141664; cv=none; b=uVRIUa7S1AuKC9pazdZUdnGW1I5VccppMANFu386jTWU/JW1r22gMA5Xn68HX8+hzUKxjXq1k5XhhvuZk+oy/W5dEQK4Va7gP4kp8xFAuYLUifG1q893ufLhJ5hbSGpcFV8crlomDdc5gAQMWLrepCbbspsYIkm+lMPA4LOJzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141664; c=relaxed/simple;
	bh=nLz43LnRd+kA17y256sY+WJKZEzD2uhppj+PkR0z9yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHuGnw2Nr2u0xbFJutu4uq+ZWTTfkUUjiRETNBRjnL9Va0sbkHSV5EkEHuapFvookUhb4vwCOMsrL5+n5vzGed5xJOw6oLtxTBVFVa5PhfnAt23bAi+yg10kenImntjUWLayyUd/5yxFQZNOM5iuZgJ64G8JknFez2depOdEOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TUKkzspe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TUKkzspe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2010180b3a.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763141661; x=1763746461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxEoFbzQwfAmuQdYnQsCZazVU2iXkrM1iusny5D0ajU=;
        b=TUKkzspeJjTakJJXhlfDGyDdpysn7pP2C1c1gDCitm0YNlqO6OBl5lFoO5uOI+JH7x
         ikyWdI8M/NN3XQzxo+KBpspp/6lHHPdG6GAH4PXiA2feRU08fJg7i9ikckZBjFNbRt3X
         Q57YsgwDXuhUa41IWhwJwuNaz7ISgMexnCntlnDmoTg1ulFmjn4A8wGNfWbQ7j3lkh+F
         3662B9MxMXM+EK5kgppPJjAtJBv/4i4RUJIGGETlV0a77ZTKwNv3pbbvcV0l+Zq65j29
         Upc24lVx4RjVFBKpkqA3Q8puoofDc/GfVTvNCyofKkh5c+xDmjsn71/2vut3MZMiN9Cw
         Dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141661; x=1763746461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxEoFbzQwfAmuQdYnQsCZazVU2iXkrM1iusny5D0ajU=;
        b=Y26pAIz5YDI1H5JrmYsbea0N94+S0+15AkCCH5k9NfYHCjfAKWmTjEi76FMLB6gO3R
         Whe9LVFgkQPL18z2GkdxqbuiMJTzq57/vLUMYfQSBPd27wdwgPgAE6nqwp/wj+ShP3+F
         IOvrZAkuP1h+wOhYZo5A/Mw/P4r7pfwcgI2BGA8wZGPVji8U0+tY2eknEAe5jvKx06Ro
         r2NQNvP9TKzwcGC5jTqTaUR/Xv1F5dmliVdLuFObRbansLd/1yGDfbpQRjRkvL8nQwOB
         1eye+4yT4unei7fkAgjrvyokqx23dKXtCid015/G/Ssjw2VYVOWBuH0FgMo6LDSgQ8jp
         5heA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQNW3gfcoKdO9ivRO5A18Nbyju8gSeTAKa2CvxP5ZSGjNL3R6OBQjRpacjs35RQSBRuhonhQk6D0tPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uH2A6JizCEvaw6fCS41lbgTkxDi0z96CQmM7EnvK0ncuffV/
	svIMv61JAGKDK9178hztSIbzRaKLXZ1mIv/Ujbo9pOjmUQGo/AXoRbF/Sa2oDX59E/0=
X-Gm-Gg: ASbGncu4ZvGaKgZ8m+Eg4wYDrBzct6MxLB5sru82kP7lT1MWxv62xIeVc73iq/F/BiN
	/QcIjFJ0JZfV+mOZfT+yJsQCjiz4vxoM6VFJPC5PADCSnSzxCP3cZ8lEg9cNJL5AdK3NnU9m243
	XnCq7/IxfCsttvDWx9xBSRV0H+rWZVOBscols6aX9zGZUMVY/QHPRdmzs1Oa2zeKqk3wfT0/BHw
	8s0Du4lFpNcWhSh22ysSejvhIrZD66gezMXMjva69hn4NVNPwmgwKU6aregQfpRq04OYrLHjdZ8
	fWhsUakPJdO8g7M0TF/WzOj3c0Cd05KSR7myMajYKYGJU/laXR/C0DfloISs7u5mbRSrL3s7dfS
	Vj6A5c6JE3+vZqgdLzQyAUnOb8Qn6R1Z5kn3d6XAOqE10j6PZbob5SpJ3UzjFZObl+oro45Ss/z
	s8MCjL9bymvYySJqkkuS4l5B7OwDkT3iZC2ANHrXn4Ww==
X-Google-Smtp-Source: AGHT+IHDaJWCuyrcAQ7bh/F0PTreqc48q+/8A87q7fLc4R6puX9/rJVN4MbbzRVHyhCNNkpaJDzXLQ==
X-Received: by 2002:a05:7022:619e:b0:11b:38c:5370 with SMTP id a92af1059eb24-11b411ff1c3mr1214091c88.20.1763141660782;
        Fri, 14 Nov 2025 09:34:20 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b06088604sm12363461c88.7.2025.11.14.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:34:20 -0800 (PST)
Date: Fri, 14 Nov 2025 09:34:19 -0800
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
Message-ID: <20251114173419.GA2197103-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcVWtE4fHCe3jjM@fedora>

On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
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
> 
> It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> support owned freeze queue.
> 
> Maybe the following change can avoid it?
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c916176bd9f0..9967c4a7e72d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>         bool dead;
> 
>         mutex_lock(&dev->shutdown_lock);
> +       nvme_quiesce_io_queues(&dev->ctrl);
>         dead = nvme_pci_ctrl_is_dead(dev);
>         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
>                 if (pci_is_enabled(pdev))
> @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>         }
> 
> -       nvme_quiesce_io_queues(&dev->ctrl);
> -
>         if (!dead && dev->ctrl.queue_count > 0) {
>                 nvme_delete_io_queues(dev);
>                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> 
> 

Interesting. Can you elaborate more on why this diff can help us avoid
the problem?

If the thread doing nvme_scan_work() is waiting for queue to be frozen
while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
will cause the deadlock, no?
