Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E284D8BB;
	Mon, 26 Aug 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693539; cv=none; b=LP141YcqvMozxQ3jRdLXNip53/whThx4ymsJyKVtEXymKcSAYnym0zdv3SZBDZ0nD6zTUMlma6xkCy888znHmAxRRVdsPCI9T1ssSaufdTiiu25L5uM1gclQ+pAPG3r5x29km5NS8OfZm/ce3n6WbEOfcnyBFjXv30lfurGq3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693539; c=relaxed/simple;
	bh=oSMsu/JL7mgDWCxRlDA/vsIQF1ic1KWhYBBfR69F1mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki+FRcdd9BVLg6whxNQ2ILoiIHMNRRp5ybKS0rDzTmEwr8T0KwLLCc7Ntuh1I++NWE55Qn6Ptsx44xZlUsh0ILnj7wLrO5BxzRgOdrQ7b5K0GhojO37snt4r0j3HGD7A/4TZUWIYRTi0d1z1+BNA8zG7ad/OX1YyaaRaTwMZig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3536DA7;
	Mon, 26 Aug 2024 10:32:42 -0700 (PDT)
Received: from [10.57.48.129] (unknown [10.57.48.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 212DC3F66E;
	Mon, 26 Aug 2024 10:32:11 -0700 (PDT)
Message-ID: <a93c34a9-7fcf-4bb9-9c67-20202e2f6e59@arm.com>
Date: Mon, 26 Aug 2024 18:32:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Bart Van Assche <bvanassche@acm.org>,
 MANISH PANDEY <quic_mapa@quicinc.com>, Sandeep Dhavale <dhavale@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, axboe@kernel.dk, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, bvanassche@google.com,
 quic_nitirawa@quicinc.com, quic_cang@quicinc.com, quic_rampraka@quicinc.com,
 quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
 <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
 <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
 <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
 <66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com>
 <3d37e8ba-25a8-45c2-93a3-02888dad2c9e@arm.com>
 <22d1bd64-934f-49f1-bb82-1367f4a43f40@quicinc.com>
 <340f156b-0dbb-45d2-a6dd-31e468ead846@acm.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <340f156b-0dbb-45d2-a6dd-31e468ead846@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/23/24 15:12, Bart Van Assche wrote:
> On 8/23/24 6:49 AM, MANISH PANDEY wrote:
>> while making the patch, i figured out that queue_flags is unsigned long type and we already reached up to 32 flags as of now.
> 
> Really? In Linus' master branch I see 13 queue flags. This is less than
> half of 32. From include/linux/blkdev.h:

@Manish:
See recent (6.11) cleanup
https://lore.kernel.org/linux-block/20240719112912.3830443-1-john.g.garry@oracle.com/

> 
> enum {
>     QUEUE_FLAG_DYING,        /* queue being torn down */
>     QUEUE_FLAG_NOMERGES,        /* disable merge attempts */
>     QUEUE_FLAG_SAME_COMP,        /* complete on same CPU-group */
>     QUEUE_FLAG_FAIL_IO,        /* fake timeout */
>     QUEUE_FLAG_NOXMERGES,        /* No extended merges */
>     QUEUE_FLAG_SAME_FORCE,        /* force complete on same CPU */
>     QUEUE_FLAG_INIT_DONE,        /* queue is initialized */
>     QUEUE_FLAG_STATS,        /* track IO start and completion times */
>     QUEUE_FLAG_REGISTERED,        /* queue has been registered to a disk */
>     QUEUE_FLAG_QUIESCED,        /* queue has been quiesced */
>     QUEUE_FLAG_RQ_ALLOC_TIME,    /* record rq->alloc_time_ns */
>     QUEUE_FLAG_HCTX_ACTIVE,        /* at least one blk-mq hctx is active */
>     QUEUE_FLAG_SQ_SCHED,        /* single queue style io dispatch */
>     QUEUE_FLAG_MAX
> };
> 
> Bart.
> 

