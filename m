Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C118F5C
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674550; cv=none; b=kw6gEf7gsEYL7kQjfeMexKQjjQ/S1Gj+sBYmPt210gNsnIAbzv8I2ud8dCjKfM4Etujq2lIFZF9z994BI75cCBHy84GEakZaHgQ/woeyiZ31tUooW4J5/sqoHC9kIxVKXkDmLDBi/b0uGPElf/uYgGjC9K3Xbdl62nubfwi6qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674550; c=relaxed/simple;
	bh=Dg+3g6/0f+MbEDW2DQjTlIJC/u+YTxDW4EAPhgwcyZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ib3WCeyHOusji1pIcqtk1OKVgknwwjm6B4CtWvhLx28sE58V1L5tvF1mj08jYM9vzGI2nJGqHRVGVsHei5n9skEsQA3MJl6QfUY9nZEyUJiDWkZ9RSCDjsZPcEMEbiaVtwqFPNjeG0PIzF8f/Wdp0YdiQtFhZU1KwjbqN4X8uCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ8+ua+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ8+ua+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47904C4CECF;
	Wed, 27 Nov 2024 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674550;
	bh=Dg+3g6/0f+MbEDW2DQjTlIJC/u+YTxDW4EAPhgwcyZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iJ8+ua+nZvrDKZfJCRl152redFAWKV1plPKY4ItS0DumkyexSuuuzIyGbOiXldws/
	 +D+UEyLRj5jtHS1cG7SB7BxvssMngehDvJ1CVO1PEk+bjwKmwxk0qvDAkH2egiXHgm
	 aXjSDbdRlwRYziCfkyA0btWRpJf+4q43do/6t5pjM/JMSzvRh/nfHCr+heSkkpoQd9
	 vMOOWcoiYONWxRjN0sJtJKxoPeUrjAAmcVTrOSwxEMEWkf22jtJ5NIDSgDBQyaVvew
	 muA9em47BwVWdan5ay/p9h2w+l40WVv/tc+6bJhOMCN4jWVFOxdrB0uglWnDmzs75x
	 hkHVl7hjJzMXw==
Message-ID: <c50fb9b8-5978-4585-874b-4ccbbb1b60b2@kernel.org>
Date: Wed, 27 Nov 2024 11:28:52 +0900
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
 <1e5a1594-a945-4302-bdf9-1a57cc140b9d@kernel.org>
 <Z0XD54wTNpI-6ahJ@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0XD54wTNpI-6ahJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 9:49 PM, Christoph Hellwig wrote:
> On Tue, Nov 26, 2024 at 08:26:13PM +0900, Damien Le Moal wrote:
>> Note that I tried qd > 1 with libaio and everything works just fine: the test
>> passes. Things are strange only with io_uring.
> 
> It might be worth checking if it has something to do with REQ_NOWAIT
> writes and error handling for their EAGAIN case.

Yes, the issue is related to this. If I clear REQ_NOWAIT from all BIOs that go
through write plug, the problem disappears. Now trying to figure out the best
way to address this as I do not think that always clearing REQ_NOWAIT is the
best solution (plugging a BIO in a zone write plug does not block the caller...).


-- 
Damien Le Moal
Western Digital Research
