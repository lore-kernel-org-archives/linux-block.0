Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF72EBE
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM0XvZQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E38C433C7;
	Mon, 11 Dec 2023 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702334405;
	bh=mUQS84jmgcSnSlqsDNICBQvOVxeORuWBskPxpUFd+Yg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GM0XvZQeeH/pBAxk1Q9+bUCZsHr+MCIUFYqN25xYCP7wNN3r7vAzGJLfso9D7mzrK
	 Vz8kynl0FxeWKES52fCvPHCxmQOEB4SO+ZMEPZtjPPaDKSTT12gTwhkRoCU/zyCVR6
	 BKlSpSOhwb1CVmtXVDXEaI8K5QX11CkdGY7m0dmfQDwqGT3SItARSOVADJiEKEgLEp
	 AHWRN0QRVRZ92PCR3SeemBvKF5YAMcxqD0pvR39o+QQ5a5j4TymyZYl0MKldmPl0tv
	 lDXcHGZ/qrlDWFIMRafiAINhgPTx95QGWyAtpbTtFMLTdT23mhUpl6NJLA7FR1Ecvs
	 pMy7YHPzikeAQ==
Message-ID: <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
Date: Tue, 12 Dec 2023 07:40:02 +0900
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
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231211165720.GC26039@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 01:57, Christoph Hellwig wrote:
> On Mon, Dec 04, 2023 at 09:32:13PM -0800, Bart Van Assche wrote:
>> Fix the following two issues:
>> - Even with prio_aging_expire set to zero, I/O priorities still affect the
>>   request order.
>> - Assigning I/O priorities with the ioprio cgroup policy breaks zoned
>>   storage support in the mq-deadline scheduler.
> 
> Not it doesn't, how would it?  Or do you mean your f2fs hacks where you
> assume there is some order kept?  You really need to get rid of them
> and make sure f2fs doesn't care about reordering by writing the
> metadata that records the data location only at I/O completion time.
> Not only does that make zoned I/O trivially right, it also fixes the
> stale data exposures you are almost guaranteed to have even on
> conventional devices without that.

Priority CGroups can mess things up I think. If you have 2 processes belonging
to different CGs with different priorities and:
1) The processes do raw block device accesses and write to the same zone,
synchronized to get the WP correctly
2) The processes are writing different files and the FS decides to place the
block for the files in the same zone

Case (1) is clearly "the user is doing very stupid things" and for that case,
the user definitely deserve seeing his writes failing. But case (2) is perfectly
legit I think. That is the one that needs to be addressed. The choices I see
are: every file system supporting zone writes need to be priority CG aware when
writing files, or we ignore priority CG when writing.

The latter is I think better than the former as CGs can change without the FS
being aware (as far as I know), and such support would need to be implemented
for all FSes that support zone writing using regular writes (f2fs and zonefs).

-- 
Damien Le Moal
Western Digital Research

