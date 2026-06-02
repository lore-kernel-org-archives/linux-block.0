Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A333A03F
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365753; cv=none; b=hp+ZVlFueax3B2gqxOl/rXvbYEvVlbGG8y+l7nQabb+sKjjZgDmiCOgqg5NEFhLr20o7EEIUuqU0m1+8karD79wLMuAYHR8lGdEtS7l2MXHcxXivaVI+/DxknUnZ8JR69VmfA4Lf/Tb4bFJLqQ/9NB6WUweE29wGwmM+xhxTVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365753; c=relaxed/simple;
	bh=4c3HxiNf/o9YDjCtEqMTF0xdGqjnroVz8yDppoabx6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psPkG2aqbLUse5huuJxPaBxWvBWDU8zwOwZ2JDPtkOLOCB98Mw8J7CvRLOJENOTTEIy53Z2QHhEmgTNXTCSDfh7vBtzurYRSQcfnlo67vmQLLreXN/uLMy70TNw4XXH6s1l/A+gBt7VHY7LY+OxvMUMCreT+gm/atLKIGhbp1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=quTRLVAP; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="quTRLVAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1780365751;
	bh=1bH9sJe186VqJCIcr0CHi8vVxsQpzOuCBdS8Qj+ILmo=;
	h=From:Subject:Date:Message-ID;
	b=quTRLVAPpjtwuSZM+1+xYbRKVVc7/UrMoZzJthlskHCotgarlzt4vqmWrCYwvlzsm
	 s4rTs2m3G6XrEr1VM+HfjVt++qODQnvpgL+t7of0PvKuOFQq1j5CYHMvvA91DRrsSP
	 n0p3mw4rYQr5FfUYQaJxrnEXtbosXORdhPd3kUYM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A1E39A600003D56; Tue, 2 Jun 2026 10:02:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4078536816537
X-SMAIL-UIID: E78B314D45EE49BEBFAC1BE9F84BB44F-20260602-100217-1
From: Hillf Danton <hdanton@sina.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Date: Tue,  2 Jun 2026 10:02:03 +0800
Message-ID: <20260602020204.1420-1-hdanton@sina.com>
In-Reply-To: <ah4Xc7OmGle_C5M3@fedora>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on Mon, 1 Jun 2026 18:36:19 -0500 Ming Lei wrote:
> On Tue, Jun 02, 2026 at 07:17:30AM +0800, Hillf Danton wrote:
> > On Mon, 1 Jun 2026 17:14:59 -0500 Ming Lei wrote:
> > > On Tue, Jun 02, 2026 at 05:51:26AM +0800, Hillf Danton wrote:
> > > > On OnMon, 1 Jun 2026 10:29:25 -0500 Ming Lei wrote:
> > > > > syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.
> > > > >
> > > > > https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
> > > > >
> > > > > Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
> > > > > this bio submission context if this req isn't issued via wq.
> > > > >
> > > > I suspect this makes $.02 sense given the check of Lo_bound upon queuing rq.
> > > 
> > > Can't lo->lo_state be updated after the check? It is totally lockless...
> > >
> > Sounds good hm... do you mean it is UNWISE to not flush the loop workqueue
> > when closing disk?
> 
> Quite the opposite, it is wise to not flush wq in __loop_clr_fd(), please
> see my previous comment.
>
When queuing rq, if lo_state is updated after checking Lo_bond, I see nothing
that prevents syzbot from reporting null-ptr-deref exists. Can you tippoint
why flush is NOT needed if you are right?
