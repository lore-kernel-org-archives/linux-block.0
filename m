Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91E1C6FE9;
	Wed, 11 Jun 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654935; cv=none; b=oVib80+z8c1N7CyQfhizrVpkCymegwhSp/dO+9C5MO40lB+bDypo/64esONHPlXOZyOQjfz+sXFu5wKb0FqUg129o4Y/x3+QdIaQggP8sWfomvNk968/8M6sqGd0MhLK6/j1ajlp5lMqtfUHzK7FI39ED1uYVYXPeNKWqDACM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654935; c=relaxed/simple;
	bh=/kJknUTKQ/4WpidAfHPn9U3Yq4PEwjxxr08pxsCbWCU=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nxey/x3BSYzeWqeSD3cND1am8J/2LKrNmw1/sw1q0Urzr+ihZ1Fp3V3EoMApIpICqEu5dbMxK9Mg98Bwb4i28fwWXqjzqccIsMfz/8Fsw2/R9pIPEVW0ELnopdOXM+BkjffsuY6ZoEYSrf0skweLGcqCrZ99EewaFl6saNW6+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NmdnFXSF; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NmdnFXSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749654934; x=1781190934;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=LJdY97oBOFmkrzTZ00vwdAJipUoD7h4TKZBdAWF9EYs=;
  b=NmdnFXSFeutXzfArxiZx08EHto6X5EAt4xTjcEGBnmKlN24uYOg5PjoX
   6Fqrj0SDujuNYrt5h6loIGmZbc4n10RZKsvu+7C4yLn2uN6ZG4MD5Acg3
   3Hi3kgArMPAeR7LjUzu45qaptagiL2nkm+aO7tRfvmFak4aicqbJFiFjT
   lE1b+Qi3cCUvYYkQu7pU3oR+548sdGFSBGNCyvh9d43bDNkqcrs929cfk
   /bDzcv9+rqW//i/YI+BBfsTd4AGsZ6LEMPwWb1wFgpURKJmY74dIroBM+
   GnAjIiwDqqLYUuO4Lk8q21rVm0/BrOJoWzihuyN09TYIYY8BhECPW4oDJ
   g==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="754307810"
Subject: Re: [PATCH] Revert "block: don't reorder requests in blk_add_rq_to_plug"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:15:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:5574]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.246:2525] with esmtp (Farcaster)
 id e1a08913-2abb-4193-ad77-3ba6edd6ef77; Wed, 11 Jun 2025 15:15:29 +0000 (UTC)
X-Farcaster-Flow-ID: e1a08913-2abb-4193-ad77-3ba6edd6ef77
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:15:28 +0000
Received: from [192.168.11.154] (10.106.82.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:15:27 +0000
Message-ID: <f9976d55-f418-45b8-82ac-e0557e713b4c@amazon.com>
Date: Wed, 11 Jun 2025 16:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>
CC: <stable@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>, Hagar
 Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D005EUB002.ant.amazon.com (10.252.51.103) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 11/06/2025 13:56, Jens Axboe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
> 
> Rather than revert this commit, why not just attempt a tail merge?
> Something ala this, totally untested.
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3af1d284add5..708ded67d52a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>          if (!plug || rq_list_empty(&plug->mq_list))
>                  return false;
> 
> +       rq = plug->mq_list.tail;
> +       if (rq->q == q)
> +               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
> +
>          rq_list_for_each(&plug->mq_list, rq) {
>                  if (rq->q == q) {
>                          if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> 
> --
> Jens Axboe

I thought about that solution before submitting the revert and I believe 
it will help with the case we are discussing here  but what about the 
case where we have raid disks for which we need to iterate the plug 
list? In this case we will iterate the plug list from head to tail while 
the most recent requests (where merging will likely happen) will be 
closer to that tail so there will be additional overhead to iterate 
through the whole plug list and I believe the revert will also be better 
for this specific case unless I am missing something here :)

