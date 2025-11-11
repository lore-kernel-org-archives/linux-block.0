Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA82EBBA9
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894272; cv=none; b=rxQNKRZcPgt5Tq82j4/KUnLAYoU3aoFZG45mUSqc+ZYhvvNuBhhyBzM36Qld4wX8A7AzBPWDhSjB68ZNlMiHYL8z7TkVh8Wa38SBlBJEDfif0LkpUItKwHQvc5FdxUxnfPcHWtd2CtD51EnAHIB8mr/5Ku885aQ6pVjCLRIGUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894272; c=relaxed/simple;
	bh=n3MrNFMd3oSeSZ2HKZM9hlUAdTC6gdp6VROlFZ9Cd2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZDY3KYelJyw/uabGyPxRFvU3Qew8lKjI80F1rRWhsRspu7Gp4zdxb2CWMA39ka89lSS+b8Ju+Q1M9CJVs9cuxsU3ezDrHEHy8ZBZ3dkFWm6Zvjtuv2bmKDP1V1G9fCW/47RgOAFxd1PQcIQAU4me9pJ1HE/JM6y8KLhIb3doZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fPWRNi7H; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fPWRNi7H"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5dws5FTxzlstQh;
	Tue, 11 Nov 2025 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762894268; x=1765486269; bh=vCy4I4xPJQz0U4sd0OCLO+2N
	iRhngf/vqr6x7JaLDHA=; b=fPWRNi7HS3WEAU1HxMKGwdGYnhNkXJsxE4vUNWZb
	1JUTKJaAPv0XXcbb5q8YxkfwJjE0uHM3bTUE6OoPcflhfPIMYZSg7LH20O64TbH3
	Xrrds/+EVwmjeHJ6xx0KX/FZS1x68myEMSn6ZoISdOZK9sGV+JGVyx7zy+vM0NDq
	XPK56lHJgpIGhSxVFXcnYafPN/I2kBoy6/bUsOyqwo+pcUYxulhrjNrmXs7Dnrhv
	4loGOHq5/Cw5NtkleOxpMSE6pg4+96i7MjQ/8eBeTJEiLxbL868caqSOq7cKSKPh
	Kzpk9XLJMnk6PSxKifpkniF0w3tca+0xryqzNrjG/oVFjQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id l7gkIpe8Uj7o; Tue, 11 Nov 2025 20:51:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5dwp1ZJmzlnfd6;
	Tue, 11 Nov 2025 20:51:05 +0000 (UTC)
Message-ID: <ffc307ad-89b3-47a7-a268-e71e97d31ab5@acm.org>
Date: Tue, 11 Nov 2025 12:51:04 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-zoned: Move code from disk_zone_wplug_add_bio()
 into its caller
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-5-bvanassche@acm.org> <20251111075318.GD6596@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251111075318.GD6596@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 11:53 PM, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 02:30:02PM -0800, Bart Van Assche wrote:
>>   plug:
>> +	schedule_bio_work = !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
>> +	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
>> +
>>   	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
>> +	if (schedule_bio_work)
>> +		disk_zone_wplug_schedule_bio_work(disk, zwplug);
> 
> Given that the new disk_zone_wplug_add_bio does not touch
> BLK_ZONE_WPLUG_PLUGGED, this reads odd.  Why not:
> 
>   	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
> 	if (!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)) {
> 		zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
> 		disk_zone_wplug_schedule_bio_work(disk, zwplug);
> 	}
> 
> and do away with the extra variable?

That looks like an interesting suggestion to me. I will integrate the
above change in this patch series if it passes my tests.

Thanks,

Bart.
