Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE19F9DD
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689141; cv=none; b=VXZNIq5AGiihr6bBaZ90GdbLNUZIfQ+0mjFPk6x+92mOgXcR8pwHpmRin6iy46OqdA0109q7ftWyjto+wbWue9PI9rRJNbV9r0DDWWH4+lGHAFeKJDmUcOO4+DXRhU4zBGVGRkrIxJngXhUnIeR1ynDNiGJoUyptZJzgio6UqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689141; c=relaxed/simple;
	bh=oCHQT0dHY6NRBI1jqPKAm5SLeD3ijf3+cLQdDcRoLNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdVywUNI6xPLz7mO1aNhnYMnaKyC+0dkPco0tdWkL5S08DZsw9kGZ7xSjbyms3tUt892/ak3bZNSvhbvf1UaIxdxrCkLinCtHb9RW16+zBoE7/D/SUOJxTCVUEzgFFOLOreyplNZsw+WSRecBep9SP/nnXhcWCnb9YCQsdPktE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0VdqtMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0VdqtMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93040C4CED2;
	Wed, 27 Nov 2024 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732689141;
	bh=oCHQT0dHY6NRBI1jqPKAm5SLeD3ijf3+cLQdDcRoLNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F0VdqtMGPXBSEKlUBuFvFMkhGk5ry1mD+bO5s+elmZB53H8+/1y+1kw0I8jrIKqGF
	 mg+GB1YnAwL9XkblkOra0yuzxGqxs9UFG3/8AagBOyugrln9lcZUQ8dCrO+S2zXo7b
	 d5tjS/zfWWRV6ScOLEYQ59zPHqe4KkuketJzyWR0oGk384AJEogwRYVB4Oh1ms5cha
	 c4FFZmozIoYiTYKkMUxaElyrVQAIv6w6/ubWXH8gRBM/JMfIA7g+6km7Le1j3yzdTS
	 gGZMm8X15iUYiFw4Pv22zEXBBPv5+k0BD9WOCi1EubdgohhMeJIR7Gx7MCnJiubnNE
	 lLVb1G30JAM8w==
Message-ID: <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
Date: Wed, 27 Nov 2024 15:32:04 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0a6ehUQ0tqPPsfn@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 3:21 PM, Christoph Hellwig wrote:
> On Tue, Nov 26, 2024 at 10:16:18PM -0800, Christoph Hellwig wrote:
>> Did you trace where the bio_wouldblock_error is coming from?  Probably
>> a failing request allocation?  Can we call the guts of blk_zone_plug_bio
>> after allocating the request to avoid this?
> 
> The easier option might be to simply to "unprepare" the bio
> (i.e. undo the append op rewrite and sector adjustment), decrement
> wp_offset and retun.  Given that no one else could issue I/O
> while we were trying to allocate the bio this should work just fine.

Might be good enough. But will also need to clear the REQ_NOWAIT flag for the
BIO if it is issued from the zone write plug BIO work. Because that one should
not have to deal with all this.

Let me try.


-- 
Damien Le Moal
Western Digital Research
