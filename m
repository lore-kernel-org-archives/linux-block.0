Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052563B4EB7
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450415; cv=none; b=G6VY6J+7cbDbwYct7NQgJxQgxDSZ9TpLUbY2tEPzjN+PJqkfe0AyurTGlGLsw3c8GlBykOKhIISK/UGfOwzSTsra1sg0Qzoic/vm6V4PaqIwfrjd9dEITBvIoNTL/a0HK2swkmsDaNZZYEfYSNu0UhB6XW3yVzi3xETTy6KyAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450415; c=relaxed/simple;
	bh=RRSfbx/JD+2HqEJh08QoFxCfd2vyRm+x2pQKuaOuyjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwg8X5bXaxgx/EfmjdNQvu+BdyX7AfzAhQ/LUds5uYRpEcFQTRWWnTu9PDRJ9PvECzzCp2SJKJuhrGfc/wUhEPnO+RwSf9U5/WHQsE4J15n5gJb09ScaVcmQPfK4nxJKbOkBZ8hM/ROnNzIrohz/YB+AW5CWpt0EFfaSQ9ISIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQgEchfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQgEchfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D7D1F00A3A;
	Tue, 11 Aug 2026 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450413;
	bh=uLTM7OXymOE11x56RHFeZ0RN9nkHPCnk9xrz1nfaNEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hQgEchfi+VQg9lm1uRG8ZJv9/0Ajoy7cO5DSKfyMlHRnwBBpkKTGYJIx4/XTXabxC
	 HnBFPv55+L6aK9VIbXwjKPoyFOsj7VEDJDKaucfmy/jKdkIgCqYesGVibZkFaYtZVe
	 OJ9jcahLpolI5+uNw/i4UZkQyi8xdRJ4TKHNzkfaX8le4sffT/7afu9ohlFoiG8iOP
	 r/OqLw+6dRjbx1CjqBTjSckIzfHRa6Mf/CUu219nEhDPFEj0/SVGg5Gea/psHlgzfe
	 gsksRn04CSCYuE2BhQfziVTsfG+0zjuBYQM5nQGPODJ7yzBJJhV4V/0e7ddxxoc03M
	 yjaIjeOgJu2pg==
Message-ID: <427819c1-a827-478d-a260-a1ecbde09015@kernel.org>
Date: Tue, 11 Aug 2026 05:13:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] block: fail zone management operations to
 read-only and offline zones
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-11-dlemoal@kernel.org>
 <e7b9dd5d-4385-4ae4-90c7-08d20a223ad6@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e7b9dd5d-4385-4ae4-90c7-08d20a223ad6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/11 4:41, Hannes Reinecke wrote:
> On 8/11/26 12:58 PM, Damien Le Moal wrote:
>> Any zone management operation targeting a zone that is in the read-only
>> or offline condition will fail. So there is no point in issuing such
>> BIO. Modify the check in submit_bio_noacct() to use the new helper
>> function bdev_check_zone_mgmt() to check that a zone is sequential (as was
>> checked before) and also that the zone is not offline nor read-only.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/blk-core.c  |  7 +++++--
>>   block/blk-zoned.c | 24 ++++++++++++++++++++++++
>>   block/blk.h       |  6 ++++++
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>
> Hmm. But that checks the in-kernel zone state only,
> so I would expect that we still can see failures if
> the zone state has not been updated (yet) while
> the command has been issued.
> What harm would it do to just run the command and
> deal with the results?

NCQ errors are painful with SATA due to the queue drain they cause. So I am all
for avoiding them as much as possible. This is not the hot path and this check
is not a heavy one, so I added it.

This is a minor case anyway since these errors can only come from a bad
application behavior given that a head depop that offline zones is always user
triggered. So a well-behaving application must do a report zones right after the
depop to note the zones that went offline and let them be.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
