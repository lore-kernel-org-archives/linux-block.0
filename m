Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3093C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CB82089D
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgHjDZXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgFRCte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:49:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728779AbgFRCtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 22:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592448570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nnbk1M+xPuRM6Vq4295m9irTxwaPM4/Pj1yhlQHwijA=;
        b=EgHjDZXk6C0TurrHOGVPoBebMY6vytz5y9Zqx0+Y5SNTD0rvlCE0G3ZybzDY3cSl/wXTYE
        itc1fkr1B0NVd4Rtyqf4B21GlotVwrFSi18rUqOy/W0VYFuer1acsPVr08RShFz/1a61y2
        WrjWoBAIg8+4nkob8h5FEfPjios12uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-W4hLRoaXPzq9EntaBpnQGw-1; Wed, 17 Jun 2020 22:49:27 -0400
X-MC-Unique: W4hLRoaXPzq9EntaBpnQGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A701005512;
        Thu, 18 Jun 2020 02:49:26 +0000 (UTC)
Received: from T590 (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B34979301;
        Thu, 18 Jun 2020 02:49:20 +0000 (UTC)
Date:   Thu, 18 Jun 2020 10:49:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     axboe@kernel.dk, bvanassche@acm.org, tom.leiming@gmail.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: update hctx map when use multiple maps
Message-ID: <20200618024916.GB142660@T590>
References: <20200617061830.GA15100@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617061830.GA15100@192.168.3.9>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 17, 2020 at 02:18:37PM +0800, Weiping Zhang wrote:
> There is an issue when tune the number for read and write queues,
> if the total queue count was not changed. The hctx->type cannot
> be updated, since __blk_mq_update_nr_hw_queues will return directly
> if the total queue count has not been changed.
> 
> Reproduce:
> 
> dmesg | grep "default/read/poll"
> [    2.607459] nvme nvme0: 48/0/0 default/read/poll queues
> cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
>      48 default
> 
> tune the write queues to 24:
> echo 24 > /sys/module/nvme/parameters/write_queues
> echo 1 > /sys/block/nvme0n1/device/reset_controller
> 
> dmesg | grep "default/read/poll"
> [  433.547235] nvme nvme0: 24/24/0 default/read/poll queues
> 
> cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
>      48 default
> 
> The driver's hardware queue mapping is not same as block layer.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4f57d27bfa73..a9aa6d1e44cf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3479,7 +3479,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  
>  	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
>  		nr_hw_queues = nr_cpu_ids;
> -	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
> +	if (nr_hw_queues < 1)
> +		return;
> +	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>  		return;
>  
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -- 
> 2.18.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

