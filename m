Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DF248886;
	Tue, 19 May 2026 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151214; cv=none; b=M8xj7BmRr8AvjXELwk1/EhMTxdIWjX6CU5PS3Ah9JkFEBRitXmBymt2v3qjODv79vqwWSfC3fo9A/zlG/O5xZXkE3J/fnBD1quolbUnh6C7UtP16ewPc1lIMf/mDCKxw1cEPNf8zeCK80cW6pNQA2Jz7GukDsTx3qjsTikKBibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151214; c=relaxed/simple;
	bh=0yj+lp6n9FozO+fuL+YywBzZhwtbHqP53a9tssYzgGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f6RH32Xt0cDtdxWfWeYW7l7GsXk3vDL8G4SgvU658N2FW5xaOa4x+X78q/10mjwGkyE7hNXlBYPKB0idslU4q3y0HecNZMFvqKTB4GVZ39ck5qf6LJwSNPu4OTBfMOK8lL0kAMQlS4sB7JRxkmDELenwhcCkeUSJ/o6AdBakPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X2o8CM0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X2o8CM0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B91C2BCB7;
	Tue, 19 May 2026 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779151214;
	bh=0yj+lp6n9FozO+fuL+YywBzZhwtbHqP53a9tssYzgGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2o8CM0fvkv/XeprBy2hKFJ4HZOPzo3gCuvRXRu14a5OG+gKBHocHkuOrSP6o1Sn4
	 +s9RhLUJwBSqYcPhewjKlhhgQ2X48IPyeCqXBBEtf0v0WGr7uDPR/RUr6dMpvLrE1T
	 7NwsGNy9HAn7lMOuVJWZfWddzDkjpiLR6+8QwB0c=
Date: Mon, 18 May 2026 17:40:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block <linux-block@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
Message-Id: <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
In-Reply-To: <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
	<e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
	<e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
	<c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
	<f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
	<af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
	<9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 10:38:36 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> The loop driver relies on lo_release() to automatically clear the loop
> device via __loop_clr_fd() when the last file descriptor is closed
> (LO_FLAGS_AUTOCLEAR). Although the backing file structure itself remains
> allocated in memory thanks to proper file reference counting (f_count is
> not zero), a severe race condition exists regarding the visibility of
> the lo->lo_backing_file pointer.
> 
> This race window was exposed by commit 65565ca5f99b ("block: unify
> the synchronous bi_end_io callbacks"). By unifying and optimizing
> the synchronous I/O completion path, the timing and scheduling behavior of
> the block layer altered significantly.
> As a result, a highly-concurrent execution pipeline emerged where
> lo_release() can progress to __loop_clr_fd() and nullify
> lo->lo_backing_file while an already-scheduled asynchronous I/O work
> (lo_rw_aio) is just about to be executed by a kworker thread.
> 
> Since the kworker enters lo_rw_aio() after lo->lo_backing_file has been
> cleared, it attempts to dereference the now-NULL pointer when initializing
> the kiocb, leading to the reported NULL pointer dereference bug.
> 
> To close this race safely without introducing heavy fast-path checks,
> we must ensure that any running or scheduled dispatch threads have
> completed before we nullify the pointer. Since loop_queue_rq() operates
> within the block layer's RCU read-side critical section, invoke
> synchronize_rcu() and drain_workqueue() in __loop_clr_fd() prior to
> clearing lo->lo_backing_file.

AI review asked a couple of questions:
	https://sashiko.dev/#/patchset/9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp
