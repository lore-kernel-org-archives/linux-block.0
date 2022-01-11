Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbiAKBQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 20:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243319AbiAKBQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 20:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641863796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n37laBNeHlFVkepdln4JNu3sYP+g8lj1mC7WFxrVNA4=;
        b=hubZLhjWxzdt7XXH+IhQ8Tg5SCkT9AKWxULGjdGF5jOWd99l/ENu2Drslg8buJu3xK1OfB
        kV4BR4IOWAEMVsAw4HIEpUvb5zAHnaH5X2XGSWPzlhGaFt08YqZLH3AAfDxOsLYxe7eY0a
        9qTGye7M0O9fT7eCVAviFpR2Jmh/p4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-BBbI8lV2Oy-LGiuefZ2Phg-1; Mon, 10 Jan 2022 20:16:33 -0500
X-MC-Unique: BBbI8lV2Oy-LGiuefZ2Phg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FB25F9CA;
        Tue, 11 Jan 2022 01:16:32 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A6860854;
        Tue, 11 Jan 2022 01:16:19 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:16:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: don't protect submit_bio_checks by q_usage_counter
Message-ID: <YdzaXp4DVyCP6lKS@T590>
References: <20220104134223.590803-1-ming.lei@redhat.com>
 <20220110164909.GA7372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110164909.GA7372@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 05:49:09PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 09:42:23PM +0800, Ming Lei wrote:
> > Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
> > uses q_usage_counter to protect submit_bio_checks for avoiding IO after
> > disk is deleted by del_gendisk().
> > 
> > Turns out the protection isn't necessary, because once
> > blk_mq_freeze_queue_wait() in del_gendisk() returns:
> > 
> > 1) all in-flight IO has been done
> 
> Only for blk-mq drivers.

Yes, but the q_usage_counter protection for bio based queue is just for
calling ->submit_bio(), which is added in:

3ef28e83ab15 block: generic request_queue reference counting

Also we never support to drain in-flight IO for bio based queue, and
this patch doesn't make a difference on this area.

> 
> So I don't think this is actually safe.

Draining bio based queue is always driver's responsibility, block
layer never supports that.


Thanks,
Ming

