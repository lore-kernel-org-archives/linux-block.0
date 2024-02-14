Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318B1419A2
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953664; cv=none; b=U5qBkpSasi4gSVsB6/ocNnnJBN/tPnEuGefQgN5h/r6cWfFuUeRnDJqv2nWeI/B5UZ61BRJSOTTUVUyxE+QeTH3JbxL7zb8T3+RYlhe1a/06TTRY4qO74cZ77IOXrw3xMGy5YkF9TRFgHoP15JQ8eLVjkobwdAWDYsd56jnMMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953664; c=relaxed/simple;
	bh=6WlYbn1JOD2gdhAfQFtFraEP74/usBDF/FoLj79EgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYW2B1P7kNSgP+UdmI22C7uso6KmaXzMKc1BaiNHNuj+r56MdmV5rLzDERfB3E102YwrcgHVdlhYxLWK756B5NSgD0oGjrYTqYK3MACP55lGHgCM07kyzAon8ikhvWKSsib0Zq2YmH5fKlfFxVVIx4xjkDxHMnm/QL2Qu8mfWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnxbsKqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnxbsKqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099DDC433C7;
	Wed, 14 Feb 2024 23:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707953664;
	bh=6WlYbn1JOD2gdhAfQFtFraEP74/usBDF/FoLj79EgJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnxbsKqgR3UWJmQ+J83h8YHr4LMVGG3HFNAa6bjzHSgKtwjT7GpZ/oHCqn7Q2JoI6
	 uQid/8uiLnuyInKQvY/1V52iTHq20T6r6+gguMBu369R09ilrVeGvz9pVP8BykfLQ8
	 NC+gFBQaiAjo9DekH01gVc7+iS0KhBy7RW0ZWJpJuJt0QQy3z4zEJrrDPwfBVCC1GE
	 TRgacDscVJYJ9hmJdfRmgdVpjEa3zc74eSmLWgrw3PssQYU8HzhqpykTDz7pjd06w5
	 +1UMyOKRtb+/5QU/r18Lklte6hx1WEopFNsxR57cOvmqImnpfXnZYFJoYWNVxqOEFJ
	 d2/bRRdD1mnCw==
Date: Wed, 14 Feb 2024 16:34:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Message-ID: <Zc1N_fjAozmbD7-_@kbusch-mbp>
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-2-hch@lst.de>
 <Zcz3pd3A09dJScHH@kbusch-mbp>
 <0a5497e2-87f1-481a-9948-bd9e68b3bb79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5497e2-87f1-481a-9948-bd9e68b3bb79@kernel.org>

On Thu, Feb 15, 2024 at 08:16:19AM +0900, Damien Le Moal wrote:
> On 2/15/24 02:25, Keith Busch wrote:
> > On Wed, Feb 14, 2024 at 10:54:57AM +0100, Christoph Hellwig wrote:
> >> @@ -2036,11 +1813,15 @@ static int null_validate_conf(struct nullb_device *dev)
> >>  		pr_err("legacy IO path is no longer available\n");
> >>  		return -EINVAL;
> >>  	}
> >> +	if (dev->queue_mode == NULL_Q_BIO) {
> >> +		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
> >> +		dev->queue_mode = NULL_Q_MQ;
> >> +	}
> > 
> > Seems pointless to keep dev->queue_mode around if only one value is
> > valid.
> > 
> > Instead of checking the param here once per device, could we do it just
> > once for the module in null_set_queue_mode()?
> 
> We need the check for the configfs path as well...

Yeah, my snippet suggestion wasn't a fully flushed out idea. The
configfs part would just be this:

---
@@ -401,12 +401,20 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
        return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
 }

+static int nullb_apply_queue_mode(struct nullb_device *dev,
+                                 unsigned int queue_mode)
+{
+	if (queue_mode != NULL_Q_MQ)
+		return -EINVAL;
+	return 0;
+}
+
 NULLB_DEVICE_ATTR(size, ulong, NULL);
 NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
 NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
-NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
+NULLB_DEVICE_ATTR(queue_mode, uint, nullb_apply_queue_mode);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
--
