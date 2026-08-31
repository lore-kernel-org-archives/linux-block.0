Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694A4A4844;
	Mon, 31 Aug 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188340; cv=none; b=RNEs+k9uqjTH/gtNjsDeAtszBQJNyQytooWzmvX9T5BBcJgnydBf8fnTLadsIU+z/GtUY4YnWEz4jYIbELtML3Fgm+/7hHSGNFIyaNNw19O8lajyHexAdVI2lPYOX+9uxQQvp0tymaPbqO4FNBpnC6OO/p7IunmfZFZprwDEUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188340; c=relaxed/simple;
	bh=APbP3/wimRJr2gE1cSIRP3gDJwEHcvRTK6fLaUrVbFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8GQNtzC2CjhIJIPR5RIans1uj3BwQ+JLrzvx6RIzoUR4SXXogVsCu+VlImfGo70c8Q3TVxi5Y0RN93DCygYcnIAwt5keX0G9iQl6E926ob+qi+3jIYhSk29JItiKuAZDrCqC+9fLD23oSRqx5Mw7c+DBEM3/wQIPWiRfVk+Nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwIigDYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwIigDYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE6B1F000E9;
	Mon, 31 Aug 2026 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188339;
	bh=14bNFPNL5UxWNXFU6JP1TsTgUvqSn2B1NpHtXK6Gc8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IwIigDYmUFKcMyWnc48szI2N9Wf1Wh4eaJ2qeAnCArP5eyhm2WCJ1oHo6dgjvWvpF
	 ayof/nBOv9fNGf3nv2yv01Z9SGx9EN2VB0EpgMiwFHPHe6oRCsqpBBeYHEnvOtramz
	 D6+zHiFBVVUhrR7tUcHwrtKLP8C8USlKJCW6eslv2z1Mp+Wg7rBqmKekbpgG723oIr
	 eRfL3UY11/lHkRl3UqYojjcvXTKKJsOk5pmrINmccWd5G17LJf09iDEIvbY4To1J5H
	 l8kIhYmmNOV6nBxWslm/20cnKSzObV3L2Lej3GvhDx0B8a4TR9fnJi2baBUJyU+vCn
	 fhq3hd98Ch23g==
Date: Mon, 31 Aug 2026 08:58:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] [block?] BUG: corrupted list in
 blk_mq_request_bypass_insert
Message-ID: <apWWsVUm5ri7b4oR@kbusch-mbp>
References: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
 <2cf45e85-176a-4209-86ad-8f389a9a4282@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf45e85-176a-4209-86ad-8f389a9a4282@acm.org>

On Sat, Aug 29, 2026 at 05:16:00PM -0700, Bart Van Assche wrote:
> On 8/28/26 10:31 PM, syzbot wrote:
> > kernel BUG at lib/list_debug.c:34!
> > Call trace:
> >   __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32 (P)
> >   __list_add_valid include/linux/list.h:96 [inline]
> >   __list_add include/linux/list.h:158 [inline]
> >   list_add_tail include/linux/list.h:191 [inline]
> >   blk_mq_request_bypass_insert+0x130/0x1cc block/blk-mq.c:2551
> >   blk_mq_requeue_work+0x3a4/0x52c block/blk-mq.c:1560
> >   process_one_work kernel/workqueue.c:3322 [inline]
> >   process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
> >   worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
> >   kthread+0x304/0x3d4 kernel/kthread.c:436
> >   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
> 
> If my AI assistant got it right the root cause of this issue is as
> follows (I haven't tried to verify this):
> * Concurrent calls of nvme_reset_work() and blk_mq_requeue_work().
> * nvme_decide_disposition() does not check NVME_REQ_CANCELLED for
>   non-multipath requests and returns RETRY instead of COMPLETE.

We want to be able to retry eligible commands that were caught in the
crossfire of a controller reset.
