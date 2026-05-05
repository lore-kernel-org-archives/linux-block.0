Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE92356C6;
	Tue,  5 May 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993425; cv=none; b=WlMT+Anz1Ne5/IEafF4BQ+7N52Fh+SAhFAIwVRxMY2c7zBemt83ZUQyt2FtdVKP/N+NGDVaQ2arKIY4UI4h09st7nx45VKUuW9PkS0Hq9Y4hF4dSyiov6c1/dgMB/9ZbdfXaR2Nmq56Sv7nrZJsAVYGGJU/qxZeofG09tlyAVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993425; c=relaxed/simple;
	bh=EQ9EXE/Ffr+wV6+CRqHxSfRAY/71wYjgxoE+F7UDlrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIO+l1J/X2hU36S3eZDUk/YxC27j1NGFqRlYw47vGexeuCgK7U2Z4IsGk8Q5Ycyl6zkzQBy79jVJefbaMBV4+ZxAaajq3sX8yfVV7kLy/Cx4XNagoi//JjfUAmUKNcbSesYem9PIaOPzE779X7CyYm5ueX6NciROlX9g0aHdqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uE32fe3z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3kiH1zys; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uE32fe3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kiH1zys"
Date: Tue, 5 May 2026 17:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777993423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jeObJ50rpgkfNuNh4GvqKDfd9XAxKCOQpO9eF+O9Zc=;
	b=uE32fe3zS9u8zUQ+VD6DHLGJnQqN25MaOZf6EeWN5O+hfwFht28WkZJjotpt+VN0tR+fx+
	Aw9AX3IG8iWPtkV9UHiR60ZeAuzq9i0pw148HONcDOPbxQJL6fsNUovq3UDQk+Z1lCFdO8
	aVFCCWhpCq7iLsq4LjAl9oH7USjvEEA9np057ewJoAdB57YIufBI+2YoyfhhyjiuB6UPrR
	nYABPBc+kQhKhExXpuyd2icMzDjDTpowaQN7XHFR+p0sfx8ppK8kbb6dbFu1AmMT/e5Pkf
	MQZFpRxde56OfzdTDF74c7vGLXMUtG8c/WsmiLEzBw2lgjHDqgy9Jt9Nt7U7AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777993423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jeObJ50rpgkfNuNh4GvqKDfd9XAxKCOQpO9eF+O9Zc=;
	b=3kiH1zysGnF3cWBWGrygXcD5AFxrZDRJznIst3RYw/o8Q7s6unc6jNgXDt4P0xN4tHXXpT
	DvzFZ3FLjIdJMhCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org, clrkwllms@kernel.org, rostedt@goodmis.org,
	ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, chris.friesen@windriver.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v5 0/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
Message-ID: <20260505150341.me97WNAn@linutronix.de>
References: <20260303073744.20585-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303073744.20585-1-ionut.nechita@windriver.com>

On 2026-03-03 09:37:43 [+0200], Ionut Nechita (Wind River) wrote:
> Hi Jens,

Hi Jens,

> This is v5 of the fix for the RT kernel performance regression caused by
> commit 6bda857bcbb86 ("block: fix ordering between checking
> QUEUE_FLAG_QUIESCED request adding").
> 
> Changes since v4 (Feb 13):
> - Rebased on top of linux-next (20260302)
> - No code changes

Anything wrong with this?

Sebastian
