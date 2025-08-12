Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F99199223;
	Tue, 12 Aug 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972911; cv=none; b=M4CjHkuc7XDoHSehF5tvnPjxqqCPSR/QSxMijC2j1pCaA+4GN/WYlrkVwS9UAChYKv1jaieldu5285BmFoNf7+EyqSHZW2a9Gl0gaMnFj7gMr48gtUoCuTtxgWVxeBmV0LwBdkD2KeORA1P/q5KGrrAE9ti5rcivwrhm1yZv360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972911; c=relaxed/simple;
	bh=EVg1QPlryJI5RlQoLq7IKMrluLBr88OBOidARW0cTH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9JoZu6w+MU4ICKZvEqFjohqcKzcFl8/EMi+Hqd/gnCv/TkCHIm/sw3UqReBAiQCC6873CVHJrnF70yeJEZyi2XwVAuahXoLBmmv37SdRHqr2RCx5PLGsef/OVYiUX78rf0BZlWe/r3EgsacN6/ucZgRhg3X/ztlS3hwsewrHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c+eLJlyb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c+eLJlyb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JSElFSsA6IBpZJbElLm1tzo0NDz8BKGsF+KpN39TN64=; b=c+eLJlyb508Z/tnQVJUcXyoRkU
	YxHTR9gNKj3yTrbbFtcgeYvZzvdBxoy+9SnWv1Kq9z4MXZx6AtHL8pR/FlYipiP2lfY/AFpkuiIfH
	ysXQekjWDAetPP3pn/zJcfg01jVmDI0jtK1g5pg5uPeO8rtClqnx6D9h/nVVQK9rxdAyNqdWoex2j
	EU+1cI4F8TQbt63hT/KDHh1WqWt7u8mQDLZTa4lhn+zoN7RqSi2WxUHLV/FsMNKUbeZTJ0ggzLlk3
	8qPoXdef9xCdfTc+igSy/Mq5DT+aB4ppNgwXOYBTNXShRUV8f/+qel88Z10YqsWY5KfIjWleq+E6P
	weLLC9Jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulgcc-0000000A1Rx-1QSy;
	Tue, 12 Aug 2025 04:28:26 +0000
Date: Tue, 12 Aug 2025 05:28:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk,
	yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Message-ID: <20250812042826.GU222315@ZenIV>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
 <34624336-331d-4047-822f-8091098eeebc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34624336-331d-4047-822f-8091098eeebc@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:42:44PM +0900, Damien Le Moal wrote:

> Since loff_t is "long long", so a signed type, I would keep this interface and
> add a negative error check in the 2 call sites for get_size(). That is simpler.

Umm...  First of all, what's the point of separate get_size() and loop_get_size()?
Another thing to watch out for - replacing file needs to be careful, lest you
replace the old file that has come to fail vfs_getattr() with new one that
does the same thing ;-)
