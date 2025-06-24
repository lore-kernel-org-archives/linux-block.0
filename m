Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7F35961
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761970; cv=none; b=ocm0jSokaXcEC3jH4FBDkXhSpsqAi0ETfRSrCZrDdHMm3spDZ6pmrNNffGGTO/6S/BDEnvV2vHuZu2yPe55ceGpXoWh5ZXDFyEaQSJta+vuYq8wciN9xEdKYodpnujQhyI63MgKW3V2Fo7ws7TeyMPb+UPhQu3KgNk+ECRSCts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761970; c=relaxed/simple;
	bh=3uMxTFi8ki/2Td4/4rO+nztBLmmD5YFvOkEU13uDsUA=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=YNWx4jnOqmlyuzCa2OGwzEQQfutt5pvHozDwIuPiJyoza4t9DPgrR4oA4LELNOeTzxmdSvJAD7hRsGSPtzIykm5BogbtQwCoq3dXZQOVVbnwe/XpxW83QaU0+tov4chDBATKDLMEs/gL05uNfxlJTkRIfCVbifZ3I29RVqTLxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hxBf/cwI; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hxBf/cwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750761969; x=1782297969;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=NKjSkzFzBlLzs8kCs/Xp0XEbSYmzzfjPSpjWy1g834Y=;
  b=hxBf/cwIOJxMSsay0pxcSAIpECciSutcHVTE1QJlL9PsmPWKcFEyHGk7
   ilG/z3G+KAHvyrTZkC9JRqkGozPjnNqeN5YnLGP7jW0vUnMjKpDWZ666O
   rqHTEjiOS1PuFCCkfQc+cOewdgiNIKVL0dHGSYlDNWD4O6Gxn6q3IqmOY
   bqB2S4YuvCR+L6jkxRU22WMgQtP52wLBFP8s5/XPVdcUKs8KAEoAo3F9e
   018ZTrXrKDz7CSx7AdB7Y0mzwyCgUGtNdlKhoVEpf6c7n7WxtQieDIlkU
   VN2myQsm+Hr0khSS2Gj8M8WILpEtvSMQ4L3dHJTWubZ6TdpfrdG31yRG+
   g==;
X-IronPort-AV: E=Sophos;i="6.16,261,1744070400"; 
   d="scan'208";a="838102643"
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge attempt
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 10:46:03 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:39000]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.233:2525] with esmtp (Farcaster)
 id d473aeec-8ee9-43a8-b357-b7f97d8caa48; Tue, 24 Jun 2025 10:46:02 +0000 (UTC)
X-Farcaster-Flow-ID: d473aeec-8ee9-43a8-b357-b7f97d8caa48
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 24 Jun 2025 10:46:01 +0000
Received: from [192.168.29.246] (10.106.83.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 24 Jun 2025 10:46:01 +0000
Message-ID: <d9d623e5-4247-4dce-9aaa-d78e1d648f10@amazon.com>
Date: Tue, 24 Jun 2025 11:45:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D006EUA003.ant.amazon.com (10.252.50.176) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 11/06/2025 18:53, Jens Axboe wrote:
> Yes we can't revert it, and honestly I would not want to even if that
> was an option. If the multi-queue case is particularly important, you
> could just do something ala the below - keep scanning until you a merge
> _could_ have happened but didn't. Ideally we'd want to iterate the plug
> list backwards and then we could keep the same single shot logic, where
> you only attempt one request that has a matching queue. And obviously we
> could just doubly link the requests, there's space in the request
> linkage code to do that. But that'd add overhead in general, I think
> it's better to shove a bit of that overhead to the multi-queue case.
> 
> I suspect the below would do the trick, however.
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..4313301f131c 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -1008,6 +1008,8 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>          rq_list_for_each(&plug->mq_list, rq) {
>                  if (rq->q != q)
>                          continue;
> +               if (blk_try_merge(rq, bio) == ELEVATOR_NO_MERGE)
> +                       continue;
>                  if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>                      BIO_MERGE_OK)
>                          return true;
> 
> --
> Jens Axboe

Sorry for my delayed reply here as I was on business trip for the last 
couple of weeks. I have done some testing on 6 SSDs aggregated as raid0 
to simulate the multi-queue case but I haven't seen measurable impact 
from that change at least on the random write test case. Looks like the 
patch has been queued to 6.15 & 6.12 stable without this change so I 
assume we are dropping it?

Kernel         |  fio (B.W MiB/sec)  | I/O size (iostat)
-------------- +---------------------+--------------------
6.15.2         |   639               |  4KiB
6.15.2+patchv1 |   648               |  4KiB
6.15.2+patchv2 |   665               |  4KiB
--------------+----------------------+--------------------

Hazem
