Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D20448CF4
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912205; cv=none; b=a/RgPGV5cvQq2l/UxnMOJ4wtc0C0Pg7Cb8N6CWJ2JbRzxVwN/AXFo1ktnW7jZjr1uHXjuVW9uOWIWvRQ0Bjujxu6wOI+26UEHIqhvm/faEtkOdedmgmRzcH4+1dpe147gcVoQeE+lEr2Y2bvKfvsWGSEyKvbBU0XI/57loVQIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912205; c=relaxed/simple;
	bh=zE3gxvGgwugD20Ct90IVmuDEhCYhymVsoQa+BUY7wJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LL5awITrkzFF5VqA5Nwjqh727CJ/zw67HYq0dM4rTfvp7kptir3Sq1IBikFRt2DU7ffZpeN0JqFGqWy3hgHcVMtDdiUt6/FKT5WyBTBvKkQyJ9dcQ7iMEjyoXj/GWiwQLH2+intyEF1nuCyXCdjDecjbVCSCkaDa31nRsnHcZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Epciqs5y; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Epciqs5y"
Message-ID: <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784912197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUrnWy2WKVTXvQRFpa4Dg33IG19qhdXuCbSecbj9/ww=;
	b=Epciqs5yfiRz6u6HGHqSg2CDRdAPPD2qTeNhYpUfxlt4tyVplFWCPZJTERcKUlRTR9DICd
	O+xLXrvBLWYvPwmSi4c1SuSXIp39vebQL541e4rtC+fWoHyYr+cP1RVNJmfoolbNRuxvxk
	9T7jv2kla5l9ZTEy9iV6lJWczJEAPt4=
Date: Fri, 24 Jul 2026 17:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <amOGxr3rxvDflHLv@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/26 16:37, Keith Busch wrote:
> On Fri, Jul 24, 2026 at 04:29:08PM +0100, John Garry wrote:
>> On 7/24/26 13:45, Keith Busch wrote:
>>> Can we just thread through partitions for the bio's block_device instead
>>> of assuming part0? I know the hidden path devices skip partition
>>> scanning, but maybe if we let it happen, then those will have the same
>>> partition setup as the head gendisk. Then we can go right to the
>>> disk->part_tbl for what we provide to bio_set_dev() for both submission
>>> and failover, and everything should work out from there.
>>
>> I guess that we would just scan through the per-path gendisk->part_tbl and
>> match somehow to lookup the partition. Maybe vs start address of
>> bio->bi_bdev. Or is there a simpler (and quicker) way?
>>
> 
> This is the idea, assuming we can get the partition tables of the head
> and path disks to be aligned:
> 
> ---
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -543,7 +543,10 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>          srcu_idx = srcu_read_lock(&head->srcu);
>          ns = nvme_find_path(head);
>          if (likely(ns)) {
> -               bio_set_dev(bio, ns->disk->part0);
> +               struct block_device *bdev;
> +
> +               bdev = xa_load(&ns->disk->part_tbl, bdev_partno(bio->bi_bdev));
> +               bio_set_dev(bio, bdev);
>                  /*
>                   * Use BIO_REMAPPED to skip bio_check_eod() when this bio
>                   * enters submit_bio_noacct() for the per-path device. The EOD
> --

ok, got it.

And I think that we would need to do the reverse lookup in 
nvme_mpath_start_request() and nvme_mpath_end_request() to get the head 
disk partition, like:
bdev = xa_load(&ns->head->disk->part_tbl, bdev_partno(bio->bi_bdev));

I suppose that the tricky part now would be have the per-path disk scan 
run but keep those per-path disks hidden.

I experimented by stop setting GENHD_FL_HIDDEN for the per-path disk, 
and the diskstats look ok, FWIW.
