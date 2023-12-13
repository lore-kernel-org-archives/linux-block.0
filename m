Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC62C2CC
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNcNCk8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E6C433C7;
	Wed, 13 Dec 2023 05:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702445388;
	bh=NlspXZxqnj6YNoLkeOXEj5v8PPGGI1CaVRVF59yiOoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fNcNCk8FoXf0wtS0jh8imJgZAr/5pmTjJcGjN0hAvL2h2SGMOUUx6wqglZferjirv
	 63v1ASLejwcc5Pi6QMnicQCAI6r3kvFiEy0gLv7ztJysAyPhCDjPYKkqCdT1+ekWP/
	 V5KKZB41F19wHw3W2CzhcSCruiwDzzF7CxAnRWul97Ego0AcAus8ju1jK5+qoI4hO/
	 xxU9Z3VNyO8kWCEk+wYtqIO0+RNl4q1Flz0UsGzbGlXwavG56PHO870GNoba6yKo2g
	 IFThESKAQorZdlBZG1UDB0v5MUFCAz6++pIkowu91v3CK762ehudECTvnqxjfFfonu
	 e3rONdNSVZqUQ==
Message-ID: <b689319f-d168-4e6e-9ddc-a50a02459dc1@kernel.org>
Date: Wed, 13 Dec 2023 14:29:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
 <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
 <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
 <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
 <deee82e3-ccc4-42d7-bb54-9f4d1cd886b0@kernel.org>
 <8998e3cd-6bf1-4199-9e21-60fdfba37571@acm.org>
 <95ecba8c-9a1a-49c9-92c8-f45580bc9f95@kernel.org>
 <3248683c-d2af-4f0c-b665-1aeff41e9d21@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3248683c-d2af-4f0c-b665-1aeff41e9d21@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 10:02, Bart Van Assche wrote:
> On 12/12/23 13:52, Damien Le Moal wrote:
>> Trying to solve this issue in mq-deadline would require keeping track of the io
>> priority used for a write request that is issued to a zone and use that same
>> priority for all following write requests for the same zone until there are no
>> writes pending for that zone. Otherwise, you will get the priority inversion
>> causing the reordering.
>>
>> But I think that doing all this without also causing priority inversion for the
>> user, i.e. a high priority write request ends up waiting for a low priority one,
>> will be challenging, to say the least.
> 
> Hi Damien,
> 
> How about the following algorithm?
> - If a zoned write refers to the start of a zone or no other writes for
>    the same zone occur in the RB-tree, use the I/O priority of the zoned
>    write.
> - If another write for the same zone occurs in the RB-tree, use the I/O
>    priority from that other write.
> 
> While this algorithm does not guarantee that all zoned writes for a 
> single zone have the same I/O priority, it guarantees that the 
> mq-deadline I/O scheduler won't submit zoned writes in the wrong order 
> because of their I/O priority.

I guess this should work.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

