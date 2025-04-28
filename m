Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93495F9D9;
	Mon, 28 Apr 2025 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844389; cv=none; b=GyjkJVQyAvGM9PodreaNBNpUERz3OCfi3EM2FZCFO7IQA7QvEK3Qqk0TjVrrO52BP2WCYjv+xw7sN4lWtrgXDdwHQIXZVZS71VvFxt03LM4T7aN5gdZjIxcNLK2hcdnS6pcDGqWxGMLgt77hklWGfVHkmjy6bRah/44cBkHKc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844389; c=relaxed/simple;
	bh=sv/L3z3u3EBHEaFNroQisP2ZtP74+MUt9FPpkmJIjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRD9obTGC8uJpOy3EHrHKmdxbVyhQktiSppe8pZvca9dNyKY+BOQiQkeOg3x3DFKDPeLbDCE3DWTsXcxfhQUyYxhRPTxmGIoyEU0nk4oGXFZ5TtLQuAGk1nT+OF8rtt9B6uzt0KZ5wFzZVYany2G1LcgHu/7NxlC7TdWNKy9SEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eSfgni9t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eSfgni9t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MKAWOtxMQI0IcXjqxIXBqeQ6Px1uVN3b0phkr8TpUo4=; b=eSfgni9tGySocVDaQ5Db91rL95
	NYdRaDxUJnruVhYZm85yf9g5Ei9ZTYHdgoUTR7szzA/AJs8/wn0KveBwMQB90cCF/dVSALZuXSiBL
	9BOJIRyaLMTYBvj7P4Hi04ezqfmlk9gCGIU2/d4GDqeVYu8Bs1k1lH26kQYGatVQovXp6egC6222o
	mDFwPTN1QDL1vmRo36EEGiTfmqn7t3bBxcrBOXQ4lfYg5gnqB9dX54QiH///YRJ2x3/b1T3leK3F7
	8CORcHoOUgWRjves21i3ZYMfLVnYyXBq9bC8BBYqf0TbeLaNUumtJJqV5tBmyrhLpnTE8Q/fTnImG
	wsktkAPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9NsP-00000006Fmy-3xEO;
	Mon, 28 Apr 2025 12:46:25 +0000
Date: Mon, 28 Apr 2025 05:46:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] loop: Add sanity check for read/write_iter
Message-ID: <aA94oQekLdgnjt67@infradead.org>
References: <aAuOC8djgRrq-Gdj@infradead.org>
 <20250426015028.277421-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426015028.277421-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 26, 2025 at 09:50:28AM +0800, Lizhi Xu wrote:
> > and maybe add a blurb that vfs_iter_read/write had this check.
> It makes no sence. The current issue context does not involve vfs layer
> iter_read/write related routines.

Yes.  But explaining how a change caused a regression is good
information for a commit log.

