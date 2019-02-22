Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E1206BA
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfBVVKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVVKL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 16:10:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10207C01BC86;
        Fri, 22 Feb 2019 21:10:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBEF51001E9E;
        Fri, 22 Feb 2019 21:10:07 +0000 (UTC)
Date:   Fri, 22 Feb 2019 16:10:06 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block: be more careful about status in __bio_chain_endio
Message-ID: <20190222211006.GA10987@redhat.com>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eflmpqkb.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 22 Feb 2019 21:10:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 15 2018 at  4:09am -0500,
NeilBrown <neilb@suse.com> wrote:

> 
> If two bios are chained under the one parent (with bio_chain())
> it is possible that one will succeed and the other will fail.
> __bio_chain_endio must ensure that the failure error status
> is reported for the whole, rather than the success.
> 
> It currently tries to be careful, but this test is racy.
> If both children finish at the same time, they might both see that
> parent->bi_status as zero, and so will assign their own status.
> If the assignment to parent->bi_status by the successful bio happens
> last, the error status will be lost which can lead to silent data
> corruption.
> 
> Instead, __bio_chain_endio should only assign a non-zero status
> to parent->bi_status.  There is then no need to test the current
> value of parent->bi_status - a test that would be racy anyway.
> 
> Note that this bug hasn't been seen in practice.  It was only discovered
> by examination after a similar bug was found in dm.c
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e1708db48258..ad77140edc6f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -312,7 +312,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>  	struct bio *parent = bio->bi_private;
>  
> -	if (!parent->bi_status)
> +	if (bio->bi_status)
>  		parent->bi_status = bio->bi_status;
>  	bio_put(bio);
>  	return parent;
> -- 
> 2.14.0.rc0.dirty
> 

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Jens, this one slipped through the crack just over a year ago.
It is available in patchwork here:
https://patchwork.kernel.org/patch/10220727/
