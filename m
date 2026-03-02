Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653D239E7E;
	Mon,  2 Mar 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467701; cv=none; b=AqJhl4LXztE8L4nqR15bN7krfnSqV7HTD3cU4hOId8ITK0tIdSKdO8pwqXFuDptU41SKQhr7d89HFr62HRn1MPvweqIsqXI9IAbdhLfggjONTIMN2vu6zENoNZQST/CpsfAdS08fksh17s6fhk/1IV346fsuQieveY5VgTwbMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467701; c=relaxed/simple;
	bh=Ye2tMBtAP6u0kT6P5FTs3hK8ijBsZ1rni9FjYdn2J50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMK/rzCyQWcOPlspNY7Kxy3wwy/7MLmwu5y7KSyiu7PUQqry+dfgMzcosTlCiehkWzZdkn2n197NGI5vZ9ZKlMw0RGnvMMUEIYq0Az15IMtFKSwQmJ/yWBEw/w/9LiZw/cTqslpxI0ALu1j8hKkbEDv+umGTr+LtHGeYZ9C3zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 90170B6A78;
	Mon,  2 Mar 2026 16:08:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A495731;
	Mon,  2 Mar 2026 16:08:09 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:08:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, "shinichiro.kawasaki@wdc.com"
 <shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible
 context
Message-ID: <20260302110839.1729434c@gandalf.local.home>
In-Reply-To: <84f1e52c-7e70-4b98-8302-ca1f1e3db9fc@nvidia.com>
References: <20260302002207.12165-1-kch@nvidia.com>
	<CAKb3OG_1yUUhLK8uHUxrYtnpph8jNr_j1kjivEWQ9VtkP-fRpQ@mail.gmail.com>
	<84f1e52c-7e70-4b98-8302-ca1f1e3db9fc@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fmetjgqr5yj1t1xuuhqyoqttas74uqxu
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A495731
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/GJgxTyPNc692nYlsRUWFbdKN7qfLYk5U=
X-HE-Tag: 1772467689-441793
X-HE-Meta: U2FsdGVkX197T2w77yCMYaMw1CznxzCq79lnr41pIaYSX2eZCfVX69uEDuUcDK2z3t02FrCfVoBoLZ7K9e5QyTLzfVYEpi79l5DimA8zjsDAnJUCLHFW6WS8XYd1ybzbfzCFKWxdINywOhz7b/KTxgw7N+nCmGw3IjauBLRd+QJOPFHJPzpDPPhad2FB6emcTBw803sdcuAunqnZQvsFLhiERfprYWNcWcqiBYyTbzan5+XtJtpB6UIi/sBMCQT1ehDMWiZx1LsOV7fXmdWx4KW12qLOl1T8np/LTB+g8tS9aE4EQn5d597/l9ZATAtifkY34tK8LvExFW3W51Ne/yNrTmKE6R8J

On Mon, 2 Mar 2026 08:41:58 +0000
Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:

> I totally failed to understand why this bug is appearing right now
> than before.

I wonder if it is because it was never tested under PREEMPT_FULL, which
would be the only config that would trigger the warning, as
PREEMPT_VOLUNTARY has rcu_read_lock() not allow preemption.

Today, the default is now the new PREEMPT_LAZY and not PREEMPT_VOLUNTARY,
where it can preempt within rcu_read_lock(). It could be that this bug
existed since 2012 but was never triggered as most users use
PREEMPT_VOLUNTARY where it would not trigger. But if they used PREEMPT_FULL
back then, it may have.

Today we now use PREEMPT_LAZY where this does trigger.

-- Steve
