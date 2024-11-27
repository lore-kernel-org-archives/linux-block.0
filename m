Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F08200132
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749083; cv=none; b=XPlTxATkpP5DLlUUr/OEjAIJ+IXjo9ZmTCa6ffBpeTgM91yDlRal3qSTvmx5X/THLOnQc/i9KS2fnrJJ6uTMVt2Dh6eqc8h93RsappykhVG8cx0QCY4mrjO5LR4dvZgRHQlTMTG/KRgGTf4dQ20ZE8awWUP6jRv4xWiEXDIW76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749083; c=relaxed/simple;
	bh=dsNFbQMEu/Cd5v69PDppiHBjHNlNcapK0NBdzPLbWTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvAqYuisNFcIfTrC8or5CvyM8Qe6SpgJ0V/ZveeikiYqBwB4kdBXvGgsdRcX6jqXMifcJoN9nKSPybpopZealLCpVhNL2E9LWh1C+JML746ftkhDydUpgfK5YwLFMjQMxIEPnROZ1WLUfrAfbh+wQHecL9h/3qfPgPAIgYV6OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRBVQ5BR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRBVQ5BR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED7C4CECC;
	Wed, 27 Nov 2024 23:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732749082;
	bh=dsNFbQMEu/Cd5v69PDppiHBjHNlNcapK0NBdzPLbWTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRBVQ5BRDtCEVeGl804bWWWiIOOqG8fa7Bt6nn5xH0sNCaYJCJz9eBcq6KlFtSIP4
	 gk5f9AIcA1DFf+/Cun6/O/QWGBuJlr/oiOQmBdRQgEsSD9Qnkxwkj+9xLuzANIFcog
	 M+HmohZabxpG7RLfVcX58IWih9GHKiO25Tsq/lCoEHyuvR/4I5QEiGxxf8AXxmL2t7
	 jcBMkODmplQVuebwnLnhQBVtIoxFnjdUq+Zs9xsqUcTVMRzNVPY/cEHznWbGJlmxHA
	 7teVoDixK8mm43ajP8pSr3Yytp3i+ZHivO+B/yyJw1G0e6sV96Eyh5RkGF6raqhMrX
	 IeJXxQagsv8eg==
Message-ID: <17c745d9-bdf6-4bc4-b767-e47a663fbe5b@kernel.org>
Date: Thu, 28 Nov 2024 08:11:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
 <31d02cd4-ba0e-4294-9ff1-a114fa266f15@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <31d02cd4-ba0e-4294-9ff1-a114fa266f15@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 02:10, Bart Van Assche wrote:
> On 11/26/24 10:21 PM, Christoph Hellwig wrote:
>> On Tue, Nov 26, 2024 at 10:16:18PM -0800, Christoph Hellwig wrote:
>>> Did you trace where the bio_wouldblock_error is coming from?  Probably
>>> a failing request allocation?  Can we call the guts of blk_zone_plug_bio
>>> after allocating the request to avoid this?
>>
>> The easier option might be to simply to "unprepare" the bio
>> (i.e. undo the append op rewrite and sector adjustment), decrement
>> wp_offset and retun.  Given that no one else could issue I/O
>> while we were trying to allocate the bio this should work just fine.
> 
> Yet another possibility is to move the code that updates
> zwplug->wp_offset from blk_zone_plug_bio() into 
> blk_zone_write_plug_init_request(). With this change the 
> zwplug->wp_offset update won't have to be undone in any case since it
> happens after the all code in blk_mq_submit_bio() that can potentially
> fail.

We could for mq devices, but given that blk_zone_write_plug_init_request() is
not used for BIO devices (dm), we would still need to update the wp early. And
DM may have different failure patterns for REQ_NOWAIT BIOs, so it seems simpler
and more solid to punt the BIO to the BIO work and ignore the REQ_NOWAIT flag there.


-- 
Damien Le Moal
Western Digital Research
