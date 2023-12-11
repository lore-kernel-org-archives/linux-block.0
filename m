Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F61F616
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx7hq/zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380CC433C8;
	Mon, 11 Dec 2023 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702280456;
	bh=p9sCy8CYyxRCV5qPL2EKIe6Bbg4xRQH2/n7ZX6C8dgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hx7hq/zfaCXUgL4Glw5aEXn7trxSwaSgZfbU5niF7u2myHDeBLn82MHHEvNuFcQ4J
	 JtM23BX7ZqCdbDuwxjvcdp8+Qln4O6yg7itiGo9VxNLd+yO9EDGEBRThEdCS6cmHKX
	 2YqXc6D49e03X/tW237ShVIELxD1cx6JANzU6hma6+cnoG3MfHvHbwkEPBh73O7bj4
	 Cwr3qczg73l2Iau9E7TCkwYg6nIVVUrKwsWPY9Kwj8Ur7LChXoS+i6B6zaezFBjDod
	 42N0YG7YMuHvMLAXvhFchaN0mJ3ZSMySxZIhttcPurq1xWu7o+6hfazeZzhHB/r40k
	 yAFMPPcU29QsQ==
Message-ID: <deee82e3-ccc4-42d7-bb54-9f4d1cd886b0@kernel.org>
Date: Mon, 11 Dec 2023 16:40:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
 <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
 <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
 <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/23 03:40, Bart Van Assche wrote:
> On 12/7/23 17:37, Damien Le Moal wrote:
>> On 12/8/23 09:03, Bart Van Assche wrote:
>>> +static bool dd_use_io_priority(struct deadline_data *dd, enum req_op op)
>>> +{
>>> +	return dd->prio_aging_expire != 0 && !op_needs_zoned_write_locking(op);
>>> +}
>>
>> Hard NACK on this. The reason is that this will disable IO priority also for
>> sensible use cases that use libaio/io_uring with direct IOs, with an application
>> that does the right thing for writes, namely assigning the same priority for all
>> writes to a zone. There are some use cases like this in production.
>>
>> I do understand that there is a problem when IO priorities come from cgroups and
>> the user go through a file system. But that should be handled by the file
>> system. That is, for f2fs, all writes going to the same zone should have the
>> same priority. Otherwise, priority inversion issues will lead to non sequential
>> write patterns.
>>
>> Ideally, we should indeed have a generic solution for the cgroup case. But it
>> seems that for now, the simplest thing to do is to not allow priorities through
>> cgroups for writes to zoned devices, unless cgroups is made more intellignet
>> about it and manage bio priorities per zone to avoid priority inversion within a
>> zone.
> 
> Hi Damien,
> 
> My understanding is that blkcg_set_ioprio() is called from inside submit_bio()
> and hence that the reported issue cannot be solved by modifying F2FS. How about
> modifying the blk-ioprio policy such that it ignores zoned writes?

I do not see a better solution than that at the moment. So yes, let's do that.
But please add a big comment in the code explaining why we ignore zoned writes.


-- 
Damien Le Moal
Western Digital Research

