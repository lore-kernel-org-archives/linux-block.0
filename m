Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65FC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGUHzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiGUHzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0492025EB5
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658390134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T84preX3RmbDwcmeB2eVEjfwXPCYgds93T82Ag7KOsM=;
        b=O42uR9QAEoyFKCtXT4bpTdmojgmrHRuraUZCKDxVb8Kpxj/V2ATtqvpVJl7JDYxWKcYl+h
        srZbz6gwWHoGaPlUj26d3Vixx2I8/gm+F49pF0Jrp7g/eDLNi8QAsjpTwWsSRBHlUyyoHh
        yZX3YDgDWAqqj0PDgEcEYCjN6uKX8cI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-sEHDLOsSO_GyfviCZrrJkQ-1; Thu, 21 Jul 2022 03:55:28 -0400
X-MC-Unique: sEHDLOsSO_GyfviCZrrJkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 028AB3C025AF;
        Thu, 21 Jul 2022 07:55:28 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D17F40D282F;
        Thu, 21 Jul 2022 07:55:24 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:55:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 8/8] ublk: defer disk allocation
Message-ID: <YtkGaEpNXdlek3Lz@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:32AM +0200, Christoph Hellwig wrote:
> Defer allocating the gendisk and request_queue until UBLK_CMD_START_DEV
> is called.  This avoids funky life times where a disk is allocated
> and then can be added and removed multiple times, which has never been
> supported by the block layer.

As commented in last patch, tagset can be allocated once for retrieving
affinity reliably from tagset's map instead of building it via
blk_mq_map_queues() before allocating tagset, meantime the code gets
simplified.

Then you can still allocate queue/disk together.

Thanks,
Ming

