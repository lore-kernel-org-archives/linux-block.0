Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B23376B0
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589910; cv=none; b=Q5d5j5jPUWt9aLkSJ9Tpd9p6insF8Sv0Oa6WQK0af6RObC5L6u4SbF/nTdyNc+IxXj87IcEdjbWg7UuKaGj+ds7Apa76SI8yWBABKa06Pyfo0NiI5p22pVumHkAwnJx+76Rl8JKU8tucP3X6EaMH3NxOgOfox8iFFofhRP0XsZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589910; c=relaxed/simple;
	bh=RmjPdOoSLN83hdmAOBaQ60Ic1/65Z53zJZ8NP4f3+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCVvPeuUbPIpnPcyzhLXlibpZLU0sTsmBFQlwnypgd9TBixtefju7r+kg+eohvzpCoz7AblO9meMVL+LKVA8w72xy2IEB+jK8PiQJmIzmR0IaQS+h3luztC+NbTZ7cPmvz8VNqRxityhh8AffU+RYwbPn2suiuf93dpnb4vxbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SZIbsb4u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SZIbsb4u"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so74144845e9.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769589905; x=1770194705; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=SZIbsb4uqLo2GtuIKPa3bbLA7N6dH7jjl6viB/R0/10DmYtuzJlEe7d0Lgh3AsecRy
         Jb04vA7E9/uLgkJZj1z+cgSxI3Pw1kEmK8VTCRIPmIz0NhYj96oATGrLZoy7Q77sTuDw
         mGjKnzWQTVqorHggE4D4U6/8Mf1kmcypiioWs0sIzDr+ORIOuLY1V6G4ENM7uvS7yfSs
         ZNvihc9rHZx9imvV17/9Oe01/vYcd1kY83/3Hw76N9KkKngapUjdwLQYcCYYynsVx+y9
         1Jbevjw8z6Hb9P7DLqp8t2bANC8o9Q00TSBYdZxWguV1RtcG2SS3gAKfvOKvJZxcgBXk
         4HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589905; x=1770194705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=ByNNvyCK7DHzu7ADXbr08ANTNJKkE/lpbAvMK8lceL1EOJHMi0aLi+I8TQjNYU2GAS
         z3yx2TJqnjlp6lDrPcmRrHkJ/N8D5X26YsIWDwI1Tyv9Ye4pccc9Zyzb8Q6focEkgcBb
         aIkR28hJukbZdy8MQ99lTA3WKoQpiH0rzywcI8oTT+NhZm6C1BjTy1fdAbSpvPl9QdeQ
         6LTY+qqNOfdFRHE9RnAv3S1wQcZlkTav1MNs+WfKrfTL9s4sFIVYrqUuW3PLoQ6RQlhk
         rrbtPcK14NUscTQF/P71Zm6p0q0WHJusyQQ4KYOLeY7UxHvE7znZYgJvtr+w7A0GpbuA
         Pw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXN6KSgkzA1zOIBzj+mBbde5lWwfiKWdht/jqlJVRZ4iD8kfrNpmE5rZazBzHQMG+ZitwSnrBVdM+XyOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YSGQGfJ8HeoO/6NgUHf4+WFAuyGehBNfGpWay3ZoaPOceEpN
	FhjTPc6FQkD09bxmSbGzl1u/Ly21qyPj//jd/Vl8pzdRrOqNrZi0H57hOpV2HpIrML8=
X-Gm-Gg: AZuq6aKLB1GdYhExmlyA8TETEyOV87jgvyJMntMpfSR2zUnl4Xm0F5HzV/HypuRAPi2
	IMNZZy9O5I3dLZWsBi8uSbLpRgOgBsE9GDwJzfDnp9sFgwuvOGNvOb7GjVo8VRKbM6mDpvKvsVS
	91jpn0XYfY7cVm5D+dQYRfYtoBG+e/sR3/gF2N/wk0xSvvCQ4wpScoaieP5H2SBkQXZPEviy/7n
	WGDBQyvkBTZZQ+xFin7z/3lYt0RYFMzZs2SuB8sreV1ZM9dpfcG6SEzj/kR16V2ZtwJhxI6fSnI
	2H1GAR57T3n3sEEZGYzD+caeFV6zaZQKmBk1IB3snxurbG1XX8m3CEhh7R79Eg1ELCtKC8ssxrK
	4ofztVSnSw9+HWqLB3/Yw4d7hG8lsqJ81XqWgfblcgZLDaN34kgjh26hYgZ1NvWQ9lo3msgE3cM
	+CZk0Ow6vOb+h6wVkxW+QE0ZOL
X-Received: by 2002:a05:600c:4e12:b0:480:6873:b2f6 with SMTP id 5b1f17b1804b1-48069c557d0mr54819185e9.20.1769589905328;
        Wed, 28 Jan 2026 00:45:05 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm121124905e9.4.2026.01.28.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:45:04 -0800 (PST)
Date: Wed, 28 Jan 2026 09:45:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXnMj1phN3TJZkNz@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXizUsfywjtIIN50@localhost.localdomain>

On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > runtime. In order to synchronize against memcg workqueue to make sure
> > > that no asynchronous draining is pending or executing on a newly made
> > > isolated CPU, target and queue a drain work under the same RCU critical
> > > section.
> > > 
> > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > workqueue flush will also be issued in a further change to make sure
> > > that no work remains pending after a CPU has been made isolated.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index be810c1fbfc3..2289a0299331 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > >  	return flush;
> > >  }
> > >  
> > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > +{
> > > +	/*
> > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > +	 * in the same RCU critical section so that later cpuset isolated
> > > +	 * partition update only need to wait for an RCU GP and flush the
> > > +	 * pending work on newly isolated CPUs.
> > > +	 */
> > > +	guard(rcu)();
> > > +	if (!cpu_is_isolated(cpu))
> > > +		schedule_work_on(cpu, work);
> > 
> > Shouldn't this in the guarded rcu section?
> 
> This is what guard(rcu)() does, right?
> Or am I missing something?

I am probably misreading the patch. But I've had the following in mind

	scoped_guard(rcu) {
		if (!cpu_is_isolated(cpu))
			schedule_work_on(cpu, work);
	}
-- 
Michal Hocko
SUSE Labs
