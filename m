Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FFC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268B720774
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIuSlXAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGHN1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:27:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728148AbgGHN1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594214838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOWf3p3xI1sepLL9g4G4R9mj9kA3+N6jtmLxi0HMHLk=;
        b=YIuSlXALq268R6D9XEPbU5Z01TJT7TaZAwPp5EtQYQFcC27T9QfvTQzvY20xgkf/nCOXv8
        bF6/Z6kstKgJ/YBPZTBPPUtzLkuhYnD4ZC4tzW6zHMFv1jj0TRGSYzX6BoQnAxRw8xviJO
        RBQH2cx9q8ZpjhJ35alqGvv5T5KOLJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-TBCS1W0rPTaI3Dzd6AdJZw-1; Wed, 08 Jul 2020 09:27:16 -0400
X-MC-Unique: TBCS1W0rPTaI3Dzd6AdJZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB121082;
        Wed,  8 Jul 2020 13:27:14 +0000 (UTC)
Received: from T590 (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6717FE8B;
        Wed,  8 Jul 2020 13:27:08 +0000 (UTC)
Date:   Wed, 8 Jul 2020 21:27:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH RFC 1/5] block: return ns precision from
 disk_start_io_acct
Message-ID: <20200708132704.GB3340386@T590>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 09:58:15AM +0200, Guoqing Jiang wrote:
> Currently the duration accounting of bio based driver is converted from
> jiffies to ns, means it could be less accurate as request based driver.
> 
> So let disk_start_io_acct return from ns precision, instead of convert
> jiffies to ns in disk_end_io_acct.
> 
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: drbd-dev@lists.linbit.com
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/blk-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..0e806a8c62fb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1466,6 +1466,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>  	struct hd_struct *part = &disk->part0;
>  	const int sgrp = op_stat_group(op);
>  	unsigned long now = READ_ONCE(jiffies);
> +	unsigned long start_ns = ktime_get_ns();
>  
>  	part_stat_lock();
>  	update_io_ticks(part, now, false);
> @@ -1474,7 +1475,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>  	part_stat_local_inc(part, in_flight[op_is_write(op)]);
>  	part_stat_unlock();
>  
> -	return now;
> +	return start_ns;
>  }
>  EXPORT_SYMBOL(disk_start_io_acct);
>  
> @@ -1484,11 +1485,11 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>  	struct hd_struct *part = &disk->part0;
>  	const int sgrp = op_stat_group(op);
>  	unsigned long now = READ_ONCE(jiffies);
> -	unsigned long duration = now - start_time;
> +	unsigned long duration = ktime_get_ns() - start_time;
>  
>  	part_stat_lock();
>  	update_io_ticks(part, now, true);
> -	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
> +	part_stat_add(part, nsecs[sgrp], duration);
>  	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>  	part_stat_unlock();

Hi Guoqing,

Cost of ktime_get_ns() can be observed as not cheap in high IOPS device,
so not sure the conversion is good. Also could you share what benefit we can
get with this change?

Thanks,
Ming

