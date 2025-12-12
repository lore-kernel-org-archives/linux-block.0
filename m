Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44761E573;
	Fri, 12 Dec 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765520220; cv=none; b=M6ESKzzIWWpi+ve/ORpG6DXGwDU97vgmMiPiL3rD7NFU/DpvLQJnLdBMAtDQmqOOyQsSPwsOyi3ohvE+dE6bk1UMbgiedorwlPLhws5tlScuF2AXYEqO9FhMOePD0HF+mNPd7aSG1Veje9Xm0LG9pTnNdPNByn0f03PW9A//urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765520220; c=relaxed/simple;
	bh=QfZrgqzAncxvas4yHsMrdlbPA17A+b5GiGiFwZZrrxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVlQTfg6E8Tthb9hSGowdS8MzboFAPvyQww0ajRc5hSgvR1PZoTq0nfICs9niKT7xRhJiulcq2xiw/yOEGYrw049glUJcOk8luMHljO5+nZrZaQPZuTmiDThcWVkmCJtnrDMX1OWivl8/0ctBtxyAJR+ebmR9Y2GwG3qoktMWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a712HwGC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a712HwGC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RVbeqaKmV/CkrAr279AosT6P4hCvQh6BDML9FuG+hcg=; b=a712HwGCg+7vfcI6uAxN3jUHhy
	J87pEZbRJvZKrym/3Zzff8oTTgF9Hz30wzK6tFoeSJabGfJxF3VjegHqX+3IbkZGZIp1m7usUs4l+
	iBe41JtaNtD86fSoMmCnfcbV7JU4tNgb5oQHTqM1Gx0xattw98RYzFh1UEQQh8AYtNWkOtY1HJL4w
	f1f8OuYvUQuhTAnWU/aL07Cc9iIuzlem91Tm80COUOfIakB3brWw6Fpa06HPVrZO0mvIzu8yR2wk4
	EAjNLCy3zj0Rim8uuwEU9n+43kdaExIPuDJ18tE44D0Tw4xCYh1fatg28eiIfqru3GRVtx+dLY3/K
	qGWU1ANg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTwST-000000009ZU-486n;
	Fri, 12 Dec 2025 06:16:54 +0000
Date: Thu, 11 Dec 2025 22:16:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: axboe@kernel.dk, stefanha@redhat.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: add allocation size check in blkdev_pr_read_keys()
Message-ID: <aTuzVdo8cuxXhUxB@infradead.org>
References: <20251212013510.3576091-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212013510.3576091-1-kartikey406@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 12, 2025 at 07:05:10AM +0530, Deepanshu Kartikey wrote:
>  	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
> -	if (keys_info_len == SIZE_MAX)
> +	if (keys_info_len == SIZE_MAX || keys_info_len > KMALLOC_MAX_SIZE)

Well, bother checks for sure are redundant.  But maybe this is also
a good chance to pick a sane arbitrary limited instead of
KMALLOC_MAX_SIZE.  And if that is above KMALLOC_MAX_SIZE, switch to
using kvzalloc.

