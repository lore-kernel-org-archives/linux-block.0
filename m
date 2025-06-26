Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5172E4274;
	Thu, 26 Jun 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950196; cv=none; b=mjQFkMgl00u4VvJc/6a3ayBvesldvQ4Rd+yGptH20Gj4GrVjdV9vbBWOkgHeOPhadHUbeBni+T0RLMrfx7oLK1YqqGtZ2TaJyNJMNjU4x+utkcYb6s2g9ccI4vah5tCar71ylIPQxGqHQACh+ta64RRvRnoqZQ+eUjoRpx+XoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950196; c=relaxed/simple;
	bh=6CeW+S4/D6fZHkSRPpxgUzedB+YluwdwJ3dOum/3VgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6RE1TqSfPjh6PwUlpyAl9V69T59kzMRddCX4tF2aL3yt/+zF6nUmLxFVun1il09YV57qCD28KfvSx8i+9RHHuLE7l7NhA+/oKDcg6ulvLUa4DsId76+UWTyEuS88IQCjpWazlhQUluO0UCGhX7debnn66tHvFepkz2ZGZyCrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RURe2n0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RURe2n0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D0FC4CEEB;
	Thu, 26 Jun 2025 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750950194;
	bh=6CeW+S4/D6fZHkSRPpxgUzedB+YluwdwJ3dOum/3VgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RURe2n0WUcLkbPFo5bsO8MM+6wrgrQF6LuC0nV0AjnRHmyp+nRFwfeyr/SMtPVKrf
	 UfErcbyOv2CZBll3x4ztQ7cHd5GFjLS4eGuITB9XfNQkXOv3kU86lFGiqBtgkygp8I
	 /OdnGY746OY+FZD7eDK2+NpoPTp5quPK1877OucMUNmy3RzeL68MbFsl7cH2+KWz/c
	 fIDp+AaFWJA75RtcNg2Rau3GUD+UhWrQ4a63a694hf9d5N+WOQ969/fhk1db6iebXw
	 fQhjgCx4/42ITpZB4sMFel8uLJ7wQ14bk2+VSfPD97J7IfA6HQhlBZTCOy+maKAbLB
	 PjnXw795t2xRg==
Date: Thu, 26 Jun 2025 17:03:12 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 11/27] block: Protect against concurrent isolated cpuset
 change
Message-ID: <aF1hMDVJcXKda_cY@localhost.localdomain>
References: <20250620152308.27492-1-frederic@kernel.org>
 <20250620152308.27492-12-frederic@kernel.org>
 <ef9bcc7e-a726-43e1-a51e-47093589b01c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9bcc7e-a726-43e1-a51e-47093589b01c@acm.org>

Le Fri, Jun 20, 2025 at 08:59:58AM -0700, Bart Van Assche a écrit :
> On 6/20/25 8:22 AM, Frederic Weisbecker wrote:
> > The block subsystem prevents running the workqueue to isolated CPUs,
> > including those defined by cpuset isolated partitions. Since
> > HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> > modifications, synchronize against housekeeping using the relevant lock.
> > 
> > For full support of cpuset changes, the block subsystem may need to
> > propagate changes to isolated cpumask through the workqueue in the
> > future.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   block/blk-mq.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 4806b867e37d..ece3369825fe 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4237,12 +4237,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >   		/*
> >   		 * Rule out isolated CPUs from hctx->cpumask to avoid
> > -		 * running block kworker on isolated CPUs
> > +		 * running block kworker on isolated CPUs.
> > +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> > +		 * here.
> >   		 */
> > +		housekeeping_lock();
> >   		for_each_cpu(cpu, hctx->cpumask) {
> >   			if (cpu_is_isolated(cpu))
> >   				cpumask_clear_cpu(cpu, hctx->cpumask);
> >   		}
> > +		housekeeping_unlock();
> >   		/*
> >   		 * Initialize batch roundrobin counts
> 
> Isn't it expected that function names have the subsystem name as a
> prefix? The function name "housekeeping_lock" is not a good name because
> that name does not make it clear what subsystem that function affects.
> Additionally, "housekeeping" is very vague. Please choose a better name.

Perhaps. "housekeeping_" doesn't match "isolation.c" but there is
already a whole set of APIs with the housekeeping prefix.

Anyway, this will likely disappear and be replaced by RCU instead.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
