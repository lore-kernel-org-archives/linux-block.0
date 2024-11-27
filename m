Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D4208A5
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695445; cv=none; b=oDnlEqXWSle8U+0KPtLX0sLYRxigaVHYI4HTCsS7q4osOCDSIqWz3N5lOIQWXFbIa6pvXA/zbkoI77F6ZHJ2B4jtPNirVBvTpr5iNQZJ34LlKrWHK+muYQpZzhuuTSFcE7cfddrdkitisyJVyWyX7AitmPEbb5DkjIyC1XRGT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695445; c=relaxed/simple;
	bh=AG5GAdKBQVjs2Gtu8Rq6atMScNjsntLpIxZRcPrS5lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy670Qo0sSi9oFTH2lbkuyDINTqfJFaYzivLHWXtVQyPYcDvj7BySwKnjKVHvFYKv2Tq7ChldWfMOEtuw0PK858K7X4Y1aOy4SP0PnHs9nJdfrA130BafwOUAnyJ0fX3nql85X+p38mvQgDkgjwvTS50jdn/kpOOOiO2NbpMtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB2PIIdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB2PIIdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBD8C4CECC;
	Wed, 27 Nov 2024 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732695444;
	bh=AG5GAdKBQVjs2Gtu8Rq6atMScNjsntLpIxZRcPrS5lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sB2PIIdpNrnS81QUHj5LllTezAvD7V1nbKWFNUddrHtxzlKFnhNqzNnmERDjIsSeF
	 W7l3ArKtHc7j/QkFPsOKTZytBSPpzQkGfMcRMiip6YleQigZsCs3q7AkGhru/PopOJ
	 /NRdUQlAvedEdgdr+23cn1FOlglt3LHgVcv2PnZXlwSTUhgZDHugKe5G4WfLTH4q8Y
	 /b/2hSfBi1hcArULjF3b2SwphdHTLN0uu7eflp8bBpMbxxIWHZRkMb8+kLwJiGBAgw
	 qLaaC16Hvv4gBWhjUm/tl4BmsXsnnFQilQLMaXPy26vLeoEEdBSBIPjo4jTl7AMBlU
	 VIv2nM1lKiPWA==
Message-ID: <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
Date: Wed, 27 Nov 2024 17:17:08 +0900
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
References: <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0bIDopTmAaE_nxQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 4:19 PM, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 04:02:42PM +0900, Damien Le Moal wrote:
>> Got something simple and working.
>> Will run it through our test suite to make sure it does not regress anything.
>>
>> The change is:
> 
> This looks reasonable.  Do we also need to do something about
> zone reset/finish command with the NOWAIT flag set?  Right now no
> caller set NOWAIT, but maybe we should warn about that and clear
> the flag?

Good point. I will add that as well.

After all these fixes, the last remaining problem is the zone write plug error
recovery issuing a report zone which can block if a queue freeze was initiated.
That can prevent forward progress and hang the freeze caller. I do not see any
way to avoid that report zones. I think this could be fixed with a magic
BLK_MQ_REQ_INTERNAL flag passed to blk_mq_alloc_request() and propagated to
blk_queue_enter() to forcefully take a queue usage counter reference even if a
queue freeze was started. That would ensure forward progress (i.e.
scsi_execute_cmd() or the NVMe equivalent would not block forever). Need to
think more about that.


-- 
Damien Le Moal
Western Digital Research
