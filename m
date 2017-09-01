Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34146 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdIAN7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2017 09:59:19 -0400
Date: Fri, 1 Sep 2017 06:59:15 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH 1/9] percpu-refcount: introduce percpu_ref_is_dead()
Message-ID: <20170901135915.GD1599492@devbig577.frc2.facebook.com>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170831172728.15817-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

> +/**
> + * percpu_ref_is_dead - test whether a percpu refcount is killed
> + * @ref: percpu_ref to test
> + *
> + * Returns %true if @ref is dead
> + *
> + * This function is safe to call as long as @ref is between init and exit.
> + */
> +static inline bool percpu_ref_is_dead(struct percpu_ref *ref)
> +{
> +	unsigned long __percpu *percpu_count;
> +
> +	if (__ref_is_percpu(ref, &percpu_count))
> +		return false;
> +	return ref->percpu_count_ptr & __PERCPU_REF_DEAD;
> +}

Can you please explain why percpu_ref_is_dying() isn't enough for your
use case?

Thanks.

-- 
tejun
