Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9B67A00
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459045; cv=none; b=sN8iXraWSQ93dQuyBnn92fBUzkHh+bAUfKtd/Zs2uebONM/x82uaLkGS5fhPiMs9j43rMmczpaMEYMPw4NLQTer7ntPvdgNQLPfsDC3A7xf143aMPZ6eDIBT7TA1gLoG/Xch1Y1k8H+29Zg4yEaVYJf1ZWOyLuduvDPqVOgf5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459045; c=relaxed/simple;
	bh=F2vJDYkBySdyAK8PyG6qvZcvb4vyN6atoboZazLr00w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGSWSssbM12CeyaQT5peW/tZLymekWDVrh8vPpjE/qJhYtiPKKxsAL16XkBx9Zkxks4FZp0+i0ivcK7TfOirXQgHyUp8kH1aB5Y5owHXU2r1LnL55Qe5uxHy++PYOBvsXdkKrV2PtU3L5+/JWWN/hPkgBqb6pgaFFBQMnpqJVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPM4VmRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPM4VmRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EBFC43394;
	Tue, 26 Mar 2024 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711459044;
	bh=F2vJDYkBySdyAK8PyG6qvZcvb4vyN6atoboZazLr00w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPM4VmRlJBSr4haOdVU0r7fOcYSuYcxGcfguMw6e/Ad4Ex0oJFpcAgno2ixSmcxHb
	 kv1BvUJ4fD6egcl/WfrMlXwWs7zdfFzkgnWCchTBI73jeCMtVyUlGc1o83BwSGrm3W
	 j7JkPDFxEp1Ay28ANNpTrSQQsa/KW1Pa2MyY9tVFLvVicXKrasySSmINy7RNCJCx5R
	 sYn9JfS5Yw0lRWfSEFbJXoH124a8t/YD3rJybzxIBZMntg7Zoow+UKH/PjG35NF/Gw
	 rw6aE6vCFj6EgHIKzHk0eDLRPsZKeZfcPju4VFeevDJdZYBJJla7qViMFWZ4yA+jTG
	 xadULLzSIFzww==
Date: Tue, 26 Mar 2024 14:17:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326-eidesstattlich-abwahl-ddfb1c75c05e@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <20240326125715.i23eo6sh5223tdmc@quack3>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326125715.i23eo6sh5223tdmc@quack3>

On Tue, Mar 26, 2024 at 01:57:15PM +0100, Jan Kara wrote:
> On Sat 23-03-24 17:11:19, Christian Brauner wrote:
> > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > default this option is set. When it is set the long-standing behavior
> > of being able to write to mounted block devices is enabled.
> > 
> > But in order to guard against unintended corruption by writing to the
> > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > off. In that case it isn't possible to write to mounted block devices
> > anymore.
> > 
> > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > the mode was passed around. Since we managed to get rid of the bdev
> > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > on whether the file was opened writable and writes to that block device
> > are blocked. That logic doesn't work because we do allow
> > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> > 
> > So fix the detection logic. Use O_EXCL as an indicator that
> > BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> > for pidfds where O_EXCL means that this is a pidfd that refers to a
> > thread. For userspace open paths O_EXCL will never be retained but for
> > internal opens where we open files that are never installed into a file
> > descriptor table this is fine.
> > 
> > Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> > directly be raised by userspace. It is implicitly raised during
> > mounting.
> > 
> > Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> > unset.
> > 
> > Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> The fix looks correct but admittedly it looks a bit hacky. I'd prefer
> storing the needed information in some other flag, preferably one that does
> not already have a special meaning with block devices. But FMODE_ space is
> exhausted and don't see another easy solution. So I guess:

Admittedly, it's not pretty but we're abusing O_EXCL already for block
devices. We do have FMODE_* available. We could add
FMODE_WRITE_RESTRICTED because we have two bits left.

One other solution apart from FMODE_* I had come up with was even
nastier which would've been using the struct fd approach of using the
two available bits in the pointer. But that doesn't work because we have
stuff like dm that passes in strings which are byte aligned. And it's
arguably uglier.
