Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD01347A2;
	Tue, 22 Apr 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285984; cv=none; b=n8/1hizZImBxeEtnE6rAxPRP5e/DTUqp3Dn7Frj/sU03jtnQYEPOmvjSHwudxdHcecoZ+Gus1zP3JPKzJBgMMpX13X6I3X4u3sQPkxO776vlNDtLgMQBPoF58yISuerSUHVTu3tW0SCpoSfct5iLY/+e2LkNNzej9IhVZ7AWlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285984; c=relaxed/simple;
	bh=bUVYFZk5eXdq3kmAnDknew2BqucnTxa/Txk7ucaJFlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp3b7n2usFMz/pxklmvQFdUCFmlL1ZmnMYGI8t9Ka7sYgyLbC04nCFhlCqpKjLnKHdwW4iq/VV0sFaz83hwS/KG4TQclR4Vd/z//yiyEPZPvkkBTFueDjxcqnYo8UxEAj0wAkLNwdo0Y6xxcq344jhodh2Yj7UrSSq16eZXaxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQNy0572; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQNy0572"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1CCC4CEE4;
	Tue, 22 Apr 2025 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745285982;
	bh=bUVYFZk5eXdq3kmAnDknew2BqucnTxa/Txk7ucaJFlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQNy05721QLqLtjs9A6TGQ6oYo0HMinPYGPhdLckNDbOAw5T2EVy/rp6xFAt3xsTR
	 qv3WxHX7VuniEgHh+vfqirrIwvfOGMbExV0SA2kJ4QBfUGgSsCKR9/I34O/+UUIvfm
	 aeaKg7iTwy/v74ucYJYp2Oko4sclGlnZxNSvqhJp1qdNv8LTPwu2Uq++aNbeV0wLrA
	 YvdN+qUDYUWA0ibqq/NG+Ni5M+xhwNX3JJfqd4z1NAA9oGlC2TU56MEKfWIQCnwBb6
	 fM5Z7Hs9gBhCMdglFK08JohoNDxy6f9b9d3ia3kCba93tJGtyDkmQBoPZLnmfPxFtb
	 SB+ZTHIg/PMhA==
Date: Mon, 21 Apr 2025 19:39:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Matt Fleming <mfleming@cloudflare.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: 10x I/O await times in 6.12
Message-ID: <aAbzW1POQP9z5BWS@kbusch-mbp.dhcp.thefacebook.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
 <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>

On Tue, Apr 22, 2025 at 09:28:02AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/04/21 23:22, Keith Busch 写道:
> > On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
> > > Hey there,
> > > 
> > > We're moving to 6.12 at Cloudflare and noticed that write await times
> > > in iostat are 10x what they were in 6.6. After a bit of bpftracing
> > > (script to find all plug times above 10ms below), it seems like this
> > > is an accounting error caused by the plug->cur_ktime optimisation
> > > rather than anything more material.
> > > 
> > > It appears as though a task can enter __submit_bio() with ->plug set
> > > and a very stale cur_ktime value on the order of milliseconds. Is this
> > > expected behaviour? It looks like it leads to inaccurate I/O times.
> > 
> > There are places with a block plug that call cond_resched(), which
> > doesn't invalidate the plug's cached ktime. You could end up with a
> > stale ktime if your process is scheduled out.
> 
> This is wrong, scheduled out will clear cached ktime. You can check
> it easily since there are not much caller to clear ktime.

Huh? cond_resched() calls __schedule() directly via
preempt_schedule_common(), which most certainly does not clear the
plug's time.

The timestamp is only invalidated from schedule() or
rt_mutex_post_schedule(). You can check it ... "easily".
