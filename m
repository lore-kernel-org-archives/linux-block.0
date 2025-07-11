Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251851F239B;
	Fri, 11 Jul 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224351; cv=none; b=fR+QPMQ179ZGNvyUViKPnCap1YId0hiGFFtT5Oab70uL9UVv00RXlPcLZcEFHc0q84KglhHO6RFux2LRGEAmEXKo8xeemOSR+v0RocexAgSHIDnF61sPddAEgr++KwXzvMMaE3T0sdpYhvZ2YSyiqj6iYWFcSSEZ7LzfA7dlReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224351; c=relaxed/simple;
	bh=kEXza4Ha2xIKkCBtUM8X6B50TAnGx1/rcfDQeDo3DYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfoFQN2Gi2j1f1Ui+hOTcalg0F+2dHWI39hg28BDJufKD8OGK5jQ1Nkecb60K44gP4pzDd++sd/FhPLtHez6mxU5J9IebCNH/Bcg3Q8yw7jVcVEQgQX6kLX4iACyYzEd82Pwdx8eGo9TUXcV45fW8xWjhgzCbul/tHWXhKKT2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vjfcKQ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7jOi4t25; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vjfcKQ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7jOi4t25"
Date: Fri, 11 Jul 2025 10:59:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752224348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0llLkde7WG4AF/KGQ4nlp3OLeowJCKa+95llvSgan4=;
	b=4vjfcKQ/oST+LbyZmq5cq7uUByrWjRJnYh8IFh7b2DzsbcMDYSG9z6aKbvckdBIxedVIT9
	0qIQn73OIUPtWSIPYmUjDoFjS13gMcby/04jw4eSOiCMif+Z0pnvRocHIEDvhCd7vYHcC0
	ZCHZKRQgtwKjOAyw7G5wZX1dSlv0E0Gnn5ROY479OAss08QkuslBwu2Lo45kOBGwcAdHQf
	z3JnJMK7LL+MZC6DanTtDL6mPbIrU1rd9H637HJrruSpB3GTsM+LUtJH5wR1vne9PtVH9o
	QgFLkuKSYDZ+2I2fKXqX/IyqHZtYYvsUBnCZMBsxlvliFntzwlz5kSc64rGYrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752224348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0llLkde7WG4AF/KGQ4nlp3OLeowJCKa+95llvSgan4=;
	b=7jOi4t25c8zbcIY9iTonlu/egoHxD2uMJW0N9zB9gBarWYMfLuRFIaX4H+YGwSB580H6yF
	5cfujcExqiQ2QyAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	RT <linux-rt-users@vger.kernel.org>
Subject: Re: block: lockdep splat with RT config v6.15+
Message-ID: <20250711085906._cTpNNFu@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <da51a963b04f0a1b628e80a2c5df72a1609960d1.camel@gmx.de>
 <aG_hNb-c_m0yfVE4@intel.com>
 <641d3228244517fd1cfb4a103339e86a222cae2b.camel@gmx.de>
 <cb6f0eb4abcbae7b0d447b679823b5d537b25b70.camel@gmx.de>
 <990089f6aaf73d7e3a49d1db1fe677bb575043ac.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <990089f6aaf73d7e3a49d1db1fe677bb575043ac.camel@gmx.de>

On 2025-07-11 10:05:18 [+0200], Mike Galbraith wrote:
> (was PREEMPT_RT vs i915)
> 
> Ok, the splat below is not new to the 6.16 cycle, seems it landed in
> the 6.15 cycle, as that also gripes but 6.14 boots clean.

I don't remember how you triggered this. Do you happen to know if this
is RT only or also triggers without the RT bits?

Sebastian
