Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE1C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A0B205C9
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeLKAcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:32:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeLKAcJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:32:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33F66308A953;
        Tue, 11 Dec 2018 00:32:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1159E608F2;
        Tue, 11 Dec 2018 00:32:05 +0000 (UTC)
Date:   Mon, 10 Dec 2018 19:32:05 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: dm: fix inflight IO check
Message-ID: <20181211003204.GA14673@redhat.com>
References: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Dec 2018 00:32:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 10 2018 at  5:45pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> After switching to percpu inflight counters, the inflight check
> is totally buggy. It's perfectly valid for some counters to be
> non-zero while having a total inflight IO count of 0, that's how
> these kinds of counters work (inc on one CPU, dec on another).
> Fix the md_in_flight() check to sum all counters before returning
> a false positive, potentially.
> 
> While at it, remove the inflight read for IO completion. We don't
> need it, just wake anyone that's waiting for the IO count to drop
> to zero. The caller needs to re-check that value anyway when woken,
> which it does.
> 
> Fixes: 6f75723190d8 ("dm: remove the pending IO accounting")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I'm seeing that device-mapper-test-suite's "resize_io" test doesn't
pass.  Glad this resolves the xfstest issue but I think more work is
needed, so I'll build any additional changes on this fix.

Thanks.

Acked-by: Mike Snitzer <snitzer@redhat.com>


> 
> ---
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 70568f8b6c53..79ad4b3d215c 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -650,14 +650,14 @@ static bool md_in_flight(struct mapped_device *md)
>  {
>  	int cpu;
>  	struct hd_struct *part = &dm_disk(md)->part0;
> +	long sum = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
> -		    part_stat_local_read_cpu(part, in_flight[1], cpu))
> -			return true;
> +		sum += part_stat_local_read_cpu(part, in_flight[0], cpu);
> +		sum += part_stat_local_read_cpu(part, in_flight[1], cpu);
>  	}
>  
> -	return false;
> +	return sum != 0;
>  }

Heh, amazing any tests passed.. sorry for this
