Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20227E06C
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635087; cv=none; b=crgqT1T9l/o98CZ8aNYaud1gVXa0BWIYWMfE2LRYSu9KjrZrSeFRtSy3ZXBBF3XcxC5rPOYyPaOJ8+Oft1jLAwBHiXJJpX/h8L2KotfjUCkYLCoHVzvYNRfEgIC82N68PgovOi0iMMu+gfIVxVAJW05SFzPZHPXAxr5pRDg253M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635087; c=relaxed/simple;
	bh=kjFXNlbmAL0BO92rYrTkCSuMABiMP5ofoNy2abW+ap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8ObZTzjLvnBA1lYEeMVlbWreF/fUD0PNMeKTMoNgmsuoircR9jWm+FBtDX7PrRCOltEljvTcb+4y2reCTKCyELXtUl08RTylGFeonE1onY8KeeGi3b3LVEmUtJCCbTuEcUE49sOcZmaB2f5+rMZ9GDhLkWPrxvbLyJaobQHLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VcAbRWxC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VcAbRWxC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee07570deso2229915e9.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635085; x=1770239885; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZU7FEnl0OZQVA7ODIpy0SKJAEacHqZRjK4EaXTvPIzs=;
        b=VcAbRWxCx1sqsR7wsEPCek4TghMY0a1vc9GxEknZR59yeMCqkqjg1CaJoLrqOfymzc
         LYIMCKsdWDcGTXFFAeHuG1vHMeb1H+qG5dYzKoFl7O7O7tffhq8wkVwb943kpXJavfS0
         JXZsmZ0mietseQsxHDXU+1WCIwSUXbjThkfHww+t/wfYahNCHJc0k2smjB2CrMlHRT1J
         oIQsBhMzeHlO8saKSiNKhXA9/h9DM4jnwQKUtbAdkzeoYpUc8uBTKgDNTO8n/XeLXBVg
         zwGU85oRqLdKHO38LyxQs5lZtHxrEalkUPEs9Yf3ZRzRT6Goe8iMzyZqQbtbc0i++cMy
         lmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635085; x=1770239885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU7FEnl0OZQVA7ODIpy0SKJAEacHqZRjK4EaXTvPIzs=;
        b=UHAXe68Jdc97fJrwRLihsWR/dRBfW/ziuNT0RGbAzbDSm9Cql//1Ag5CfQwlqVfyHx
         ktX6x+hZh0VbSk4bebaLV/NEhX2EyRJJ1yi4F0DY79w5HxF6kcwgTYZN7bER+cZeeKEa
         8JxCsxRgFYKCG34VmoeVBnQy7I0+1H6C7xuhGMY5oOivOTJSjvGyOOXekhT4iXL/re8e
         Xir9fajxKSwOLMszsLaIB5PEK+GwmXpdvCyHiXtDOLhGIA/qLPxUxIi1FesKSUM1r0Eq
         eUUi5pLR9fIkqmg5qGhWK0U11jtb9zeY2AtoKY4q6Pfpd1bSQ7KLC1kdBjsc1CH3J7mD
         L7WA==
X-Forwarded-Encrypted: i=1; AJvYcCV54Rxl1A9V+y/kbWrzhTHpP2lae+IOP0rcWOxYTNaWd7+xqA6X1s6KzfRVBpheeEnWb8sA7rixLwyIAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaWcgmWF5xn7A3L1UC/CJUrwx1BD7YmMnylx7NJmOZ3VypLEQ
	tSqjCjfZ698+ZLKJfbWpGazg9PtdTDVUBriQTy4MCScbNWWMyqy6FjRFUwk41oY79Ro=
X-Gm-Gg: AZuq6aK7thm1tUHq4pjmb0MH8Y/nPfY7/3nKO5vT947owMn5l64h/bED4ntV2DC8v0Y
	Od5o1KlBYLsu2ezg1zBQthgOXlC7sZ2Ex1Bc/LZVV4DDhnAhiT+JPrZEDDeSs7i6A6NyOBw1gx4
	Ct0K4bfqyV54wMr10CPjfadTOS0Itt1mku1/pH3mzPIUnY42unuH+uQO2HCQ7wae2h3/aQtUrfO
	fSVi5mGJKhtHN9NwIiUBznubclCXDWXU7U700fxYs5hMrz3CRC+P60+z/KqweuLFq1QIqmzy1Ta
	i/pdwAF5bzD0AC67yvl3G241fF3qQqt2o52q5DqoHaMCILoQQk3HKcBNXNc3EoXEdpiHTCNbdME
	lnRPDfvIHZESkn2Be4Ab7hoAy4Emiq1RAHqpfJaUd4rvot5ItWnVf+esj2yZVgxFd3oYrSspTTy
	Q3ww1MERG2iq21TYYs3kPQ9DIz
X-Received: by 2002:a05:600c:154c:b0:47e:e9bf:dd8a with SMTP id 5b1f17b1804b1-48069cb2fddmr85513805e9.37.1769635084662;
        Wed, 28 Jan 2026 13:18:04 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c515sm85708295e9.11.2026.01.28.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:04 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:03 +0100
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
Message-ID: <aXp9CzgCTBEhlDqM@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
 <aXnMj1phN3TJZkNz@tiehlicka>
 <aXnymtIZSc-fw1b8@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXnymtIZSc-fw1b8@localhost.localdomain>

On Wed 28-01-26 12:27:22, Frederic Weisbecker wrote:
> Le Wed, Jan 28, 2026 at 09:45:03AM +0100, Michal Hocko a écrit :
> > On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> > > Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > > > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > > > runtime. In order to synchronize against memcg workqueue to make sure
> > > > > that no asynchronous draining is pending or executing on a newly made
> > > > > isolated CPU, target and queue a drain work under the same RCU critical
> > > > > section.
> > > > > 
> > > > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > > > workqueue flush will also be issued in a further change to make sure
> > > > > that no work remains pending after a CPU has been made isolated.
> > > > > 
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > ---
> > > > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index be810c1fbfc3..2289a0299331 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > > > >  	return flush;
> > > > >  }
> > > > >  
> > > > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > > > +	 * in the same RCU critical section so that later cpuset isolated
> > > > > +	 * partition update only need to wait for an RCU GP and flush the
> > > > > +	 * pending work on newly isolated CPUs.
> > > > > +	 */
> > > > > +	guard(rcu)();
> > > > > +	if (!cpu_is_isolated(cpu))
> > > > > +		schedule_work_on(cpu, work);
> > > > 
> > > > Shouldn't this in the guarded rcu section?
> > > 
> > > This is what guard(rcu)() does, right?
> > > Or am I missing something?
> > 
> > I am probably misreading the patch. But I've had the following in mind
> > 
> > 	scoped_guard(rcu) {
> > 		if (!cpu_is_isolated(cpu))
> > 			schedule_work_on(cpu, work);
> > 	}
> 
> guard(...)() protects everything that follows within the same block
> (here the whole function) whereas scoped_guard only applies to the
> following scope (here what is inside the {} in your example).
> 
> So both work.

I see. Thanks for the clarification. I would probably prefer a more
explicit call convention but no strong opinion on that.
-- 
Michal Hocko
SUSE Labs
