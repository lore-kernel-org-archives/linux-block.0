Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0357083C
	for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407146; cv=none; b=qZnmh+1j3+YWZOIJCsOBfT31UUv0hubV/X5O2hRQFAFP++yuZugBmddN8OblP0Cea9y3t7027CM18pKAPMsTGqPDh76O4/ZD1j/UhlrRbtVuvZuPRsPD+Mb8zvWA9uatnbv1hyaQx2KpU23qOOOzTf9y6Yg7H0ecswEiuDwNzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407146; c=relaxed/simple;
	bh=0ekbu07f4tS/74cP3eCqM7h5bFfjV8JNVfiZixcdWxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIS9yuiInPW/SWHfJs5ezp4Zg/PG7QwOXZJVtObOAsKe1WZ8VezB3rXt09HDByA5rY/q5nCa+kEyEry3TgkGCQliyvPxLT8AzAxKYrw46HPXju1IG8UcTysSn9E1WaOfy+EDm0rsj3pqj3CehkBVq/T8aMdwPFwMPfke0fI7is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vl23Tf11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIf8YGPq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vl23Tf11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIf8YGPq"
Date: Mon, 31 Mar 2025 09:45:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743407142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ/BW6GXmNSlhD+uZ4t2ZYkR1yvCJQ3S7CnL9jv1y1Y=;
	b=Vl23Tf117IRS0N8GCZpT3mpyI5f/8m/vdIZDlPBiKzoW0ZvlR/RLSm2fdecTpsk84JwZPO
	aqNWOlx+pzRXNWB8wgjq3E68MYDFTi2vqduq8C5yTkhDptkEcmfZiwV5AK5R9isk/8WJlC
	tIpKx4XVHoWt70JOrKScwLPytPUqgTMt+vlCJQK5arjVjXP6o8BxVRSqwZLO7Y/nrFje0V
	gissUjTnI0dZac4Eha2AFcE7g+E1xOkaenLwx/UO81iVt0BC67QHK5tE09UjKQZu0Ijx3p
	SCT2Ds0mdtaq7SND1we5DRnSyzK/cHA9t8Emvi/RLKS4HYGFFfvfIoqTo6JttA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743407142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ/BW6GXmNSlhD+uZ4t2ZYkR1yvCJQ3S7CnL9jv1y1Y=;
	b=aIf8YGPqFS8UpqoKhqvAU7P9fA10ugdQ1RoPIZishJZJx9R1P54CgoFNcGw4uRtGF1SuST
	aXDqXRwiAaj1LDDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Bueso <dave@stgolabs.net>, Tso Ted <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <20250331074541.gK4N_A2Q@linutronix.de>
References: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
 <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
 <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
 <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z-c6BqCSmAnNxb57@bombadil.infradead.org>

On 2025-03-28 17:08:38 [-0700], Luis Chamberlain wrote:
=E2=80=A6
> > Are there some preemption configs under which cond_resched() won't
> > trigger a kernel splat where expected so the only thing I can think of
> > is perhaps some preempt configs don't implicate a sleep? If true,
> > instead of adding might_sleep() to one piece of code (in this case
> > foio_mc_copy()) I wonder if instead just adding it to cond_resched() may
> > be useful.
>=20
> I think the answer to the above is "no".

I would say so. You need CONFIG_DEBUG_ATOMIC_SLEEP for the might-sleep
magic to work. And then the splat from might_sleep() isn't different
than the one from cond_resched().=20

>=20
>   Luis

Sebastian
