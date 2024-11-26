Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183B1BD9E4;
	Tue, 26 Nov 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616742; cv=none; b=ajB0+zjkMEs2CJ1Z+WVbBOZkJ1gSMR3yHOD/AWqbGUDNV0T2Y1dfussYTTHcRJIFSA1NQe7wax6dEGLG+mmv5OY8P1oztdNcZqMlxxWsxlzz6LQH+mol1rawySgLgaKqSmSmE13miPKNWncyXRcJxnrlKtjVf+1lWjKnvelloQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616742; c=relaxed/simple;
	bh=7j2qzJo8IKOH+TTvvXtqZ+rF8iYpRb1o+yDqOHmJSQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXCUuKxLJBc+//cLIDn7Kb78ikp9bsFOHt/FRm080oOobdI9GwJIPTTV/Ts0Xbt9DB4xwTurxpg8vDlRJtsEgNiJ6+LwMC+XGxo9lxKxzAqDxrNB55VP1H5ZMSDTdqWblZB5FbK0FWJrsWukZYJ0DfmlHMAD1FORzW7unjYO8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 173C468D80; Tue, 26 Nov 2024 11:25:36 +0100 (CET)
Date: Tue, 26 Nov 2024 11:25:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: syzbot <syzbot+f53c29806b4b263165f3@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [syzbot] [block?] WARNING in dd_exit_sched
Message-ID: <20241126102535.GA16063@lst.de>
References: <67442263.050a0220.1cc393.0069.GAE@google.com> <2d5e17d7-53a5-4c4e-b961-96a23abfed9f@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5e17d7-53a5-4c4e-b961-96a23abfed9f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 25, 2024 at 02:58:55PM -0800, Bart Van Assche wrote:
> All ongoing I/O requests should have completed before elevator_exit() is
> called. del_gendisk() calls __blk_freeze_queue_start() indirectly before
> it calls elevator_exit() but it doesn't wait for the queue freeze
> operation to complete. Isn't that a bug in del_gendisk()?

It does.  This should be fixed by:

https://lore.kernel.org/linux-block/20241126102136.619067-1-hch@lst.de/T/#u
