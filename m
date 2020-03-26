Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6AEC43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 00:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B92020719
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 00:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCZATO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:19:14 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:40620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbgCZATN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 20:19:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DD985100E8423;
        Thu, 26 Mar 2020 00:19:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: basin81_8a8cb0808492b
X-Filterd-Recvd-Size: 2061
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:19:11 +0000 (UTC)
Message-ID: <fcb60b1d27fb0120a5934d30481e15fa3f171310.camel@perches.com>
Subject: Re: [PATCH 2/9] block: mark part_in_flight and part_in_flight_rw
 static
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 Mar 2020 17:17:21 -0700
In-Reply-To: <20200325154843.1349040-3-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
         <20200325154843.1349040-3-hch@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-03-25 at 16:48 +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Some people still ask for some commit description,
not just a sign-off line.

I do think that's unnecessary though when, as here,
the patch subject is descriptive and complete.

> diff --git a/block/genhd.c b/block/genhd.c
[]
> @@ -139,7 +139,8 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>  		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
>  }
>  
> -unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
> +static unsigned int part_in_flight(struct request_queue *q,
> +		struct hd_struct *part)

genhd.c aligns multi-line arguments to open parenthesis,
it'd be nicer to maintain that style.

>  {
>  	int cpu;
>  	unsigned int inflight;
> @@ -159,8 +160,8 @@ unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
>  	return inflight;
>  }
>  
> -void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> -		       unsigned int inflight[2])
> +static void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> +		unsigned int inflight[2])

etc.


