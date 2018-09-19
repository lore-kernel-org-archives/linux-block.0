Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:34494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeISKzQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 06:55:16 -0400
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
To: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <242969d0-1370-b342-025d-a11b7f59d28f@oracle.com>
Date: Wed, 19 Sep 2018 13:19:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180918101946.13329-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

On 09/18/2018 06:19 PM, Ming Lei wrote:
> +		unsigned long __percpu *percpu_count;
> +
> +		WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> +
> +		/* get one extra ref for avoiding race with .release */
> +		rcu_read_lock_sched();
> +		atomic_long_add(1, &ref->count);
> +		rcu_read_unlock_sched();
> +	}

The rcu_read_lock_sched here is redundant. We have been in the critical section
of a spin_lock_irqsave.

The atomic_long_add(1, &ref->count) may have two result.
1. ref->count > 1
   it will not drop to zero any more.
2. ref->count == 1
   it has dropped to zero and .release may be running.

Thanks
Jianchao
