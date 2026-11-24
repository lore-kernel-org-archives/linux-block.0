Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539411;
	b=zRA1wm3rkG2Qr5r5ZVjM+jnArtdE0He6XhJR7ZJSYzUP0hR9hJHb6rFHzJ9yH43v/p0A
	 7xhOIcU9+4zjZVeeHr/TNFgEqPCgyrevs2DRqzT+lO8yVGuPtJeJIi6XeyGkH0RNjb9N4
	 Gp2wSTHUY0Nqm4bO0SVNAZsVYGkUOyVDWtaOa/PcCwI0KvycviGSD2wrR0e4S0CTHMbtG
	 /5v6r/Q2sJuSrN1XibBTYRcDmUAitEWIZhlfkwH1tFzECy9e5tBoOo/PbHEzRQcClzXa7
	 unLc7OBS+p5g2i49mDtSTS2FIP5zjnus16+Ebxn0iQD/D3YjGjatL/f7fY3pcgUzgpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LzEyIRkIpKpUCITFC4vhksTMabFd5PcRoeKfvhGw5D4=;
	b=4DCjgVp2tfyErX5dqOaa/LRv8FHnzrOKOC4LTLX1gaJypE7AwVk5VUcu3EMnE/nw7MVt
	 B3gMyNLwyV3pY+ySMMRJmuC02mgU48lc/HDhsXlKGn15ZekNyoC0r0fZdwJEHCwhk+3+x
	 n9ZLeiDvXj9+S8NpT/ncJTQuLiNMJ6TEiSE1vAITDnrjSh0hKQLa9YSOxDfOrwN26yx0b
	 kUwiFdrNwBQN5SDcCI+kBr1jENqsUmbEoSTpgeNu9YdXimaETCbStHzmsREm22NKw0XvE
	 OJqbeYilZiAJmX3QFdrT8oZ6f4cld1f/31hJRKkg1JeO9MOdj5rmppXugi+68aetkXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=R9PGPGgQ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784E606A32C;
	Tue, 24 Nov 2026 16:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1784E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=R9PGPGgQ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jYpr237cgz1XM5kD;
	Tue, 24 Nov 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795539406; x=1798131407; bh=LzEyIRkIpKpUCITFC4vhksTM
	abFd5PcRoeKfvhGw5D4=; b=R9PGPGgQ7ZWGf3Z3mArn8x94eocq/0bVk/29vXvK
	EdSSY+zrnK0GNbY7oeUzE8uvqrLIqP+oXvoQJkJIJbcNrh/UNDTHck/SHBxBr0fE
	WFVZD2YbpXwOrFj84OA28MrD7bCi3HdlhAmX4nsPIex6BExi5B8rrIfi4Uto9zq2
	K0k+G3aWztudGxxpLLJ/24X5qgyVcmVGMZPEJ0w3NkU6m9TMN/hUXa8eyo4K4Xw1
	xtwvqKU1A6BUcrAllXo3mGCpUFcSIvnRndKUnI8RbQhIAzTsSu4ajZVBFYdz5ihy
	GMiAh6SNAlnXWQ0CMW6xTIy+S5AFuddTbdZYJeFZnEIndw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HnAIoYKlkglc; Tue, 24 Nov 2026 16:56:46 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:b87d:aea9:8f72:a6cd] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jYpqy14dCz1XM4Tn;
	Tue, 24 Nov 2026 16:56:46 +0000 (UTC)
Message-ID: <f8d3056d-2950-428c-b5f3-c41b5fa10eb2@acm.org>
Date: Tue, 24 Nov 2026 08:56:45 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20261124031238.555291-1-cui.tao@linux.dev>
 <b48806fb-22a5-40da-a682-22e010c8316d@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b48806fb-22a5-40da-a682-22e010c8316d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/26 12:10 AM, Tao Cui wrote:
 > For v8, my plan is to stop deciding whether to quiet a request at
 > queue_rq() time and instead quiet repeated failures at the point of
 > failure. The verdicts remain recorded for the lifetime of the backing
 > file and are cleared only on rebind or unbind. loop_clear_limits()
 > reports whether a verdict is new, and repeated failures mark only
 > their own request quiet. That guarantees the first failure for each
 > mode is reported, regardless of how dispatch and queue freezing
 > interleave.
 >
 > [ ... ]
 >
 > Does this approach look reasonable to you? If so, I'll send the
 > already tested patch as v8.

That approach sounds reasonable to me. If the verdicts are kept for the
lifetime of the backing file, I think the following simplifications are
possible:
- The clear_limits_pending member variable is no longer needed. The
   work function can read the mask with the unsupported modes without
   resetting it.
- lo_fallocate() can return -EOPNOTSUPP without calling
   file->f_op->fallocate() if the mode is already known to be
   unsupported.

Tracking the verdicts per mode also fixes the following issue in v7:
clear_limits_pending is not per mode, so a failed discard suppresses
the error message for the first write-zeroes failure.

A few more comments about v7 that also apply to v8:
- loop_clear_limits() calls schedule_work() after clear_limits_lock has
   been unlocked. Can a request that passed the lo->lo_backing_file
   check queue the work item after cancel_work_sync() has been called
   by __loop_clr_fd() or loop_remove()? Since lo_free_disk() no longer
   cancels the work item, I think that would result in a use-after-free.
   How about calling schedule_work() while holding clear_limits_lock and
   resetting the state before calling cancel_work_sync() in
   __loop_clr_fd()?
- The code that resets clear_limits_mode occurs three times. Please
   introduce a helper function. Is the reset in
   loop_assign_backing_file() needed since __loop_clr_fd() already
   resets the state and since loop_clear_limits() ignores failures for
   a backing file that is no longer current?
- The work function freezes the queue and commits the queue limits even
   if no mode has been recorded. Please return early in that case.
- The changelog for v7 is missing. Please include a "Changes since v7"
   and a "Changes since v6" section in v8.

Thanks,

Bart.
