Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C81A0BFA;
	Wed, 21 May 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862313; cv=none; b=S/Zzj9migBdlaW7KPknmB8LSFS2T4XUOnWSssrXw1sUBvJww7mKyRjOAImm5QbGRChKqVSQb7K34QlZaZdL0dVartYj8Hqwfzoz0Ag46n6fAbwqsM2PmLae2HZoYFN7vx/qvDUgK8YHelpf5ftHIgeIV30SLrtPpuuMbSixykUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862313; c=relaxed/simple;
	bh=sFmNg+sRzeQW8b/bXk594r1u42KX8ixPLpGXLgQwUgI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FcQ/Pp0KAi+5s5yn1AqxXr5G+1neAr/MsAeNkyWycT19JBjjCfEbxvqPbHw/l+5eHBAgtlKmx2uKpqMf3pfBUZWO6Pg7QjW6JYbVMT/8VyY2ac2mHyRwpILd2WnTwSN8jBCCUnJ1b2RFbHhH7JvOEG2W62HwmTlLJzkbxwzWhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rEFvA50G; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rEFvA50G"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b2kmd0LcYzm0yTt;
	Wed, 21 May 2025 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747862303; x=1750454304; bh=CortWlPLWxahKjuA3qgMbBQ8
	6+IIjupf+ZqaKjahROQ=; b=rEFvA50G/UEZgOK3fm7awWrdpluP36r4btnpVjq7
	TCnntFQqgSprCcP6LlBqLQO8JVoW11rqAwtvKscfwwSy8ZghjdzHQb5mMgagrc3j
	X1LJ57rTyHliyvS7KYZKtrft9x55UTcVsCjjcFhe55y/b2supfY7M8YMR2/gdnY7
	Dfqi9Fl4Vv/tJyo7e5ZFGIxFqg2LStQvQkfMMvE+cMVzAQq0/eVExqYlCXXu33rh
	nTfMi8iUmx/l33LqHDwKgZiEOuOMUbfStkbS6xSVLQzkgTaXJYV2Vs0VXzhB2q1H
	ow8RN47cLOw3obO2r+W2DEN6Fi2SxS7hw2/6lYxA1KcC+Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tk5WrT8Cq6W4; Wed, 21 May 2025 21:18:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b2kmV1WFnzm0pKD;
	Wed, 21 May 2025 21:18:17 +0000 (UTC)
Message-ID: <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
Date: Wed, 21 May 2025 14:18:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
Content-Language: en-US
In-Reply-To: <20250521055319.GA3109@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 10:53 PM, Christoph Hellwig wrote:
> On Tue, May 20, 2025 at 11:09:15AM -0700, Bart Van Assche wrote:
>> If the sequential write bios are split by the device mapper, sorting
>> bios in the block layer is not necessary. Christoph and Damien, do you
>> agree to replace the bio sorting code in my previous email with the
>> patch below?
> 
> No.  First please create a reproducer for your issue using null_blk
> or scsi_debug, otherwise we have no way to understand what is going
> on here, and will regress in the future.
> 
> Second should very much be able to fix the splitting in dm to place
> the bios in the right order.  As mentioned before I have a theory
> of how to do it, but we really need a proper reproducer to test this
> and then to write it up to blktests first.

Hi Christoph,

The following pull request includes a test that triggers the deadlock
fixed by patch 2/2 reliably:

https://github.com/osandov/blktests/pull/171

I do not yet have a reproducer for the bio reordering but I'm still
working on this.

Bart.


