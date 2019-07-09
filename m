Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E9C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2BC2082A
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIO3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIO3d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 10:29:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDACF3082E44;
        Tue,  9 Jul 2019 14:29:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF51F5D70D;
        Tue,  9 Jul 2019 14:29:21 +0000 (UTC)
Date:   Tue, 9 Jul 2019 22:29:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Message-ID: <20190709142915.GA30082@ming.t460p>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709090219.8784-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Jul 2019 14:29:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:
> Simultaneously writing to a sequential zone of a zoned block device
> from multiple contexts requires mutual exclusion for BIO issuing to
> ensure that writes happen sequentially. However, even for a well
> behaved user correctly implementing such synchronization, BIO plugging
> may interfere and result in BIOs from the different contextx to be
> reordered if plugging is done outside of the mutual exclusion section,
> e.g. the plug was started by a function higher in the call chain than
> the function issuing BIOs.
> 
>       Context A                           Context B
> 
>    | blk_start_plug()
>    | ...
>    | seq_write_zone()
>      | mutex_lock(zone)
>      | submit_bio(bio-0)
>      | submit_bio(bio-1)
>      | mutex_unlock(zone)
>      | return
>    | ------------------------------> | seq_write_zone()
>   				       | mutex_lock(zone)
> 				       | submit_bio(bio-2)
> 				       | mutex_unlock(zone)
>    | <------------------------------ |
>    | blk_finish_plug()
> 
> In the above example, despite the mutex synchronization resulting in the
> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
> issued after BIO 2 when the plug is released with blk_finish_plug().

I am wondering how you guarantee that context B is always run after
context A.

> 
> To fix this problem, introduce the internal helper function
> blk_mq_plug() to access the current context plug, return the current
> plug only if the target device is not a zoned block device or if the
> BIO to be plugged not a write operation. Otherwise, ignore the plug and
> return NULL, resulting is all writes to zoned block device to never be
> plugged.

Another candidate approach is to run the following code before
releasing 'zone' lock:

	if (current->plug)
		blk_finish_plug(context->plug)

Then we can fix zone specific issue in zone code only, and avoid generic
blk-core change for zone issue.

Thanks,
Ming
