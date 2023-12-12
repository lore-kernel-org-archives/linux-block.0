Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B14064CDB
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/mIeSE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C673C433C8;
	Tue, 12 Dec 2023 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702425171;
	bh=6Ivr7HMMblD3OuCf4443ntmLWy8jQLg/wF7X3+7fNWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/mIeSE0xRJGM3dUM/hTmZ6Ylo18i4BRCBiqwRIo94mwRJs+kMllHJ77MG2FoiRh9
	 mk/yEN5wQmXRfVoH5ix+xAnz2uohJa1RjioXKOe0+C0mx84y0s1sHeNn+cTsLgh+V7
	 NbRDF0xrfuXShwAJ578EYgVzoOq6IRc0RsUZgeqKaExSrlpFNihI4WhcHSVvlrvYlH
	 3IrbAkQ5kiFnYpXeEB1EAFC9LdQPXAgkdzoWfznf5XTEFLjC5pns9irYvZvXMT++dU
	 ay5jk0+oZ54G3ThWI9uq50zgZtPpIbc0QB/wbUoz2Dzv8bKzIZ2tNHZYZ0WItyYg6s
	 euNtbtpovuMQA==
Message-ID: <95ecba8c-9a1a-49c9-92c8-f45580bc9f95@kernel.org>
Date: Wed, 13 Dec 2023 08:52:49 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8998e3cd-6bf1-4199-9e21-60fdfba37571@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 07:44, Bart Van Assche wrote:
> On 12/10/23 23:40, Damien Le Moal wrote:
>> On 12/9/23 03:40, Bart Van Assche wrote:
>>> My understanding is that blkcg_set_ioprio() is called from inside submit_bio()
>>> and hence that the reported issue cannot be solved by modifying F2FS. How about
>>> modifying the blk-ioprio policy such that it ignores zoned writes?
>>
>> I do not see a better solution than that at the moment. So yes, let's do that.
>> But please add a big comment in the code explaining why we ignore zoned writes.
> 
> Hi Damien,
> 
> We tested a patch for the blk-ioprio cgroup policy that makes it skip zoned writes.
> We noticed that such a patch is not sufficient to prevent unaligned write errors
> because some tasks have been assigned an I/O priority via the ionice command
> (ioprio_set() system call). I think it would be wrong to skip the assignment of an
> I/O priority for zoned writes in all code that can set an I/O priority. Since the
> root cause of this issue is the inability of the mq-deadline I/O scheduler to
> preserve the order for zoned writes with different I/O priorities, I think this
> issue should be fixed in the mq-deadline I/O scheduler.

Not necessarily. When the priority for an IO is set when a BIO is prepared, we
know where that priority come from:
1) The user kiocb through aio_reqprio
2) The process ionice context
3) priority cgroups

We can disable (2) and (3) and leave (1) as is.

Trying to solve this issue in mq-deadline would require keeping track of the io
priority used for a write request that is issued to a zone and use that same
priority for all following write requests for the same zone until there are no
writes pending for that zone. Otherwise, you will get the priority inversion
causing the reordering.

But I think that doing all this without also causing priority inversion for the
user, i.e. a high priority write request ends up waiting for a low priority one,
will be challenging, to say the least.


-- 
Damien Le Moal
Western Digital Research

