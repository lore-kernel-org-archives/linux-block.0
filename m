Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E081854
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPgFuNOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD1AC433C7;
	Wed, 13 Dec 2023 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702508154;
	bh=G1FxqJz+mw1ktBenK3BMXGSnbr7JEIq8NnrwF8Iw7Ss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dPgFuNOFl8/orAdHe2B9eHNgRQdja5Zr2B/EollHAdSaW9ghoJjsKfE1cUw28FO15
	 IB2RL65kS9/GLgMoIm+h2jZ18Cx4uFsYWsL5vQHKJ3y64aPEIQRgaupfqu5BN+U/X5
	 sHXpPl/HjabSwaBSCuv6NhLg0WfEbObY8u2fYCyHCAyiXWYUzC0W/bGoUNCNc+JHqR
	 e03p7/HWcsdS1zXN/BXMOXavZelkjMawwi7lWNeVkmhNJw8yb6qHkKPX7uSjggVkF9
	 3HOzhQgmtWq35aOiHwSV0T2B6O1zkmP6GLvZFz1mAyj63cdCG51tWyOpXJekv3Amzb
	 CjRUC8GzM2y4g==
Message-ID: <5fc2fbe2-7ad5-439b-ab81-8abe92a37e35@kernel.org>
Date: Thu, 14 Dec 2023 07:55:52 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org> <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <8f807991-f478-4f71-9ce5-f39ba4a08c64@kernel.org>
 <ZXngh1tkV3NBpq9E@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZXngh1tkV3NBpq9E@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 01:49, Jaegeuk Kim wrote:
> On 12/13, Damien Le Moal wrote:
>> On 12/13/23 04:03, Jaegeuk Kim wrote:
>>> On 12/12, Christoph Hellwig wrote:
>>>> On Tue, Dec 12, 2023 at 10:19:31AM -0800, Bart Van Assche wrote:
>>>>> "Fundamentally broken model" is your personal opinion. I don't know anyone
>>>>> else than you who considers zoned writes as a broken model.
>>>>
>>>> No Bart, it is not.  Talk to Damien, talk to Martin, to Jens.  Or just
>>>> look at all the patches you're sending to the list that play a never
>>>> ending hac-a-mole trying to bandaid over reordering that should be
>>>> perfectly fine.  You're playing a long term losing game by trying to
>>>> prevent reordering that you can't win.
>>>
>>> As one of users of zoned devices, I disagree this is a broken model, but even
>>> better than the zone append model. When considering the filesystem performance,
>>> it is essential to place the data per file to get better bandwidth. And for
>>> NAND-based storage, filesystem is the right place to deal with the more efficient
>>> garbage collecion based on the known data locations. That's why all the flash
>>> storage vendors adopted it in the JEDEC. Agreed that zone append is nice, but
>>> IMO, it's not practical for production.
>>
>> The work on btrfs is a counter argument to this statement. The initial zone
>> support based on regular writes was going nowhere as trying to maintain ordering
>> was too complex and/or too invasive. Using zone append for the data path solved
>> and simplified many things.
> 
> We're in supporting zoned writes, and we don't see huge problem of reordering
> issues like you mention. I do agree there're pros and cons between the two, but
> I believe using which one depends on user behaviors. If there's a user, why it
> should be blocked? IOWs, why not just trying to support both?

We do support both... But:
1) regular writes to zones is a user (= application) facing API. An application
using a block device directly without an FS can directly drive the issuing of
sequential writes to a zone. If there is an FS between the application and the
device, the FS decides what to do (regular writes or zone append, and to which zone)
2) Zone append cannot be directly issued by applications to block devices. I am
working on restoring zone append writes in zonefs as an alternative to this
limitation.

Now, in the context of IO priorities, issuing sequential writes to the same zone
with different priorities really is a silly thing to do. Even if done in the
proper order, that would essentially mean that whoever does that (FS or
application) is creating priority inversion issues for himself and thus negating
any benefit one can achieve with IO priorities (that is, most of the time,
lowering tail latency for a class of IOs).

As I mentioned before, for applications that use the zoned block device
directly, I think we should just leave things as is, that is, let the writes
fail if they are reordered due to a nonsensical IO priority setup. That is a
nice way to warn the user that he/she is doing something silly.

For the FS case, it is a little more difficult given that the user may have a
sensible IO priority setup, e.g. assigning different IO priorities (cgroups,
ioprio_set or ionice) to different processes accessing different files. For that
case, if the FS decides to issue writes to these files to the same zone, then
the problem occur. But back to the previous point: this is a silly thing to do
when writes have to be sequential. That is priority inversion right there.

The difficulty for an FS is, I think, that the FS cannot easily know the IO
priority until the BIO for the write is issued... So that is the problem that
needs fixing.

Bart's proposed fix will, I think, address your issue. However, it will also
hide IO priority setup problems to users accessing the block device directly.
That I do not like. As I stated above, I think it is better to let writes fail
in that case to signal the priority inversion. There are *a lot* of IO priority
SMR HDD users out there. Literally millions of drives running with that, and not
just for read operations. So please understand my concerns.

A better solution may be to introduce a BIO flags that says "ignore IO
priorities". f2fs can use that to avoid reordering writes to the same zone due
to different IO priorities (again, *that* is the issue to fix in the first place
I think, because that is simply silly to do, even with a regular HDD or SSD
since that will break sequential write streams and thus impact performace,
increase device-level GC/WAF etc).

-- 
Damien Le Moal
Western Digital Research

