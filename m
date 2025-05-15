Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E221B91F;
	Thu, 15 May 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324710; cv=none; b=U1y9T/6v9sBwTeJLa2NcArDkYFE2WCEWwg5Pd1T7I6uIThY6fKSPjM70JJD24QwUTosRvoS/8wMIgPPBcko7e0KPVllnsvE0T/n3ZRhxe0+rHVSh9yNY9ez17umm1rvb4cgN5sMtcSK4VITNVh5UWeoocDAWkogjdLlAFISw4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324710; c=relaxed/simple;
	bh=R1H/UXsGaSYVCvw+5uX0eEYzsRNgloGCKh8AReIPnTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGK2avcgsb2f2zkD7WMzq0maCXourJH63GU34+jEbsuE8AN1ohbneJ1bMffCXUKaLIvNFz6SCRKyn+3lF+rxAQRvLk0TQAnEu+oflzg+xiSj1JySDyD9BNdP8POmPAMRzIaGUlKKx26ECDRPDVv1hX1pm1Kk1YJUrDqTTLC8kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oJGDMdxX; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oJGDMdxX"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZyvyB4qRzzlgrtN;
	Thu, 15 May 2025 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747324704; x=1749916705; bh=PFeKXxYALnMjUsC7mTWZ7ISJ
	RXk4tHkOy0Au+85G4pY=; b=oJGDMdxXRBQzD58vhM6a9NGDtDdCffPR2oLbzTaB
	YRkXquEqkwBu/YwocwCzFYVfLxNA2XelXhMxexC9wjRz9XSpMvs7aVWdC99MMRgS
	xlRYxZNTqWY5ZOIr34qtxXQybFtVLxR2GQbW5LOQ4r9S1nll12dEoDn1REEqwsec
	6PEyeIpMRpE5ytNPQ0K/feW1FWAZSjVQKiKTziz7CyJir41743th2fNShr0R4IuY
	hJhcMrygKIwElFpQAMXl10sGelJuaIdKIXej8yNi2xdEA2eNjrcrPHybDgDXzFrW
	bKo6ny4vB15wYKpT+Mk1Rbt+JyyiatDWyONjAEclaUbc/A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qb34mU40CL_g; Thu, 15 May 2025 15:58:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Zyvxz74l8zlvm7W;
	Thu, 15 May 2025 15:58:14 +0000 (UTC)
Message-ID: <6e448a08-d202-414f-8eb6-423a8ed51fcc@acm.org>
Date: Thu, 15 May 2025 08:58:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Niklas Cassel <cassel@kernel.org>, NeilBrown <neil@brown.name>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <aCWVa68kp9vXTqHb@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aCWVa68kp9vXTqHb@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 12:19 AM, Niklas Cassel wrote:
> Hello Bart,
> 
> On Wed, May 14, 2025 at 01:29:36PM -0700, Bart Van Assche wrote:
>> submit_bio() may be called recursively. To limit the stack depth, recursive
>> calls result in bios being added to a list (current->bio_list).
>> __submit_bio_noacct() sets up that list and maintains two lists with
>> requests:
>> * bio_list_on_stack[0] is the list with bios submitted by recursive
>>    submit_bio() calls from inside the latest __submit_bio() call.
>> * bio_list_on_stack[1] is the list with bios submitted by recursive
>>    submit_bio() calls from inside previous __submit_bio() calls.
>>
>> Make sure that bios are submitted to lower devices in the order these
>> have been submitted by submit_bio() by adding new bios at the end of the
>> list instead of at the front.
>>
>> This patch fixes unaligned write errors that I encountered with F2FS
>> submitting zoned writes to a dm driver stacked on top of a zoned UFS
>> device.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Yu Kuai <yukuai1@huaweicloud.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: stable@vger.kernel.org
> 
> Here you add stable to Cc, but you don't specify either
> 1) a minimum version e.g.
> stable@vger.kernel.org # v6.8+
> or
> 2) a Fixes tag.

Hi Niklas,

Let's add the following to this patch:

Fixes: 79bd99596b73 ("blk: improve order of bio handling in 
generic_make_request()")

Neil, since that commit was authored by you: the commit message is
elaborate but the names of the drivers that needed that commit have
not been mentioned. Which drivers needed that change? Additionally,
can you please help with reviewing this patch:

https://lore.kernel.org/linux-block/20250514202937.2058598-2-bvanassche@acm.org/

Thanks,

Bart.
