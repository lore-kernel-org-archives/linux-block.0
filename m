Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D12036F3
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660924; cv=none; b=Exej/Z5ceCN+nDArbfW4b+CPpTguiy6JMyLUJTcQN10edYAIKJ1eziPjL5gDMDdxHD+ACqgDHg8j1MZWSaEmI8TTjC/QEK48nPMh3Or4yp4RWtPAlKtrYJNoxn83VjilIozOUqegA3Da50RTkkOPvm1XhvdgRBHBo1mHUT+rFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660924; c=relaxed/simple;
	bh=/BYJGEK5VSnQ2im2j9+Mcc1Yw3VEOKvR3qaGuByio5I=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=cheqxy99QDtRDG0pSKA8ilTAydunqWBLjsVCzbH0+KOwEXDhs/ohJ2TKHyki4yARkvsUrqXohHxnojG1CBMdvVxXWiP/5vb0JD2rxNx5oGCoU+1EDXxl+cZJNLtxjGCSbEASUaJ4nw4kWpDpU+/S+3ZS9IZvqLrI6bdZLPL+Vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=D5/4uSPw; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="D5/4uSPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749660923; x=1781196923;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=+sz7knN8Z0VfmvXOc2eTlLjaY/awNO0fk1KuXeDEg6c=;
  b=D5/4uSPwm+4DeJzpCuAGDWHcxPPesty/u5Ls00/TaRyBQf3PcZ2m9bco
   iqbzojhbsVW5YAiYOvqzxJ+5hKlGKT9MqyTCYHaF6v7euWNphSitFXDDl
   k419YsKBN54lM/k5OQ4EUCp7BO0TwTId5t3ns2jpZXE8EWZIiunpAC0tO
   GMghRxKlhFFm1qjbE88kACIUEDF+a1TjHKOriyTo/U29Ox13IMVAh6k76
   sRn/9BOJ7YHcKiVtm4hGmOsDdWXMMULWk6/2dAA4yBJtFjW5CuIdsc3g1
   wWwrxj5W13hcMv6dg50uns5GLWwcHIdSMz5974cosRtw2zZPNjYQIsRiD
   g==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="732370126"
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge attempt
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 16:55:20 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:54656]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.131:2525] with esmtp (Farcaster)
 id ec59e720-6edf-42e3-a385-e2edb17b81aa; Wed, 11 Jun 2025 16:55:18 +0000 (UTC)
X-Farcaster-Flow-ID: ec59e720-6edf-42e3-a385-e2edb17b81aa
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 16:55:16 +0000
Received: from [192.168.11.154] (10.106.82.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 16:55:16 +0000
Message-ID: <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
Date: Wed, 11 Jun 2025 17:55:14 +0100
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
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D005EUA002.ant.amazon.com (10.252.50.11) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 11/06/2025 15:53, Jens Axboe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> Previously, the block layer stored the requests in the plug list in
> LIFO order. For this reason, blk_attempt_plug_merge() would check
> just the head entry for a back merge attempt, and abort after that
> unless requests for multiple queues existed in the plug list. If more
> than one request is present in the plug list, this makes the one-shot
> back merging less useful than before, as it'll always fail to find a
> quick merge candidate.
> 
> Use the tail entry for the one-shot merge attempt, which is the last
> added request in the list. If that fails, abort immediately unless
> there are multiple queues available. If multiple queues are available,
> then scan the list. Ideally the latter scan would be a backwards scan
> of the list, but as it currently stands, the plug list is singly linked
> and hence this isn't easily feasible.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-block/20250611121626.7252-1-abuehaze@amazon.com/
> Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
> Fixes: e70c301faece ("block: don't reorder requests in blk_add_rq_to_plug")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3af1d284add5..70d704615be5 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -998,20 +998,20 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>          if (!plug || rq_list_empty(&plug->mq_list))
>                  return false;
> 
> -       rq_list_for_each(&plug->mq_list, rq) {
> -               if (rq->q == q) {
> -                       if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> -                           BIO_MERGE_OK)
> -                               return true;
> -                       break;
> -               }
> +       rq = plug->mq_list.tail;
> +       if (rq->q == q)
> +               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> +                       BIO_MERGE_OK;
> +       else if (!plug->multiple_queues)
> +               return false;
> 
> -               /*
> -                * Only keep iterating plug list for merges if we have multiple
> -                * queues
> -                */
> -               if (!plug->multiple_queues)
> -                       break;
> +       rq_list_for_each(&plug->mq_list, rq) {
> +               if (rq->q != q)
> +                       continue;
> +               if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> +                   BIO_MERGE_OK)
> +                       return true;
> +               break;
>          }
>          return false;
>   }
> 
> --
> Jens Axboe
> 

Thanks for posting this fix, I can confirm that this patch mitigated the 
regression reported in [1], my only concern is the impact when we have 
multiple queues available as you explained in the commit message. Given 
that reverting e70c301faece ("block: don't reorder requests in 
blk_add_rq_to_plug") will break zoned storage support and the plug list 
is singly linked, I don't think we have a better solution here.

[1] 
https://lore.kernel.org/lkml/20250611121626.7252-1-abuehaze@amazon.com/T/#u

Hazem
