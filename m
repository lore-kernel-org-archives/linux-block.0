Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83795C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiFPBhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbiFPBhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD62D2AC3
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATLG0BtZ4viqAkZBvygniBh0d9e1d2NEOdOgAY8ZW0s=;
        b=Pbc3h7TGLsRzvWd7nY+eZsKLMHbCqTJFQ+3V3s6o8iSVaD0Mr1ke/D35MSlQulWaVnnurk
        xR7ejh7hQ+pjlU9U3pBMuFhlVsmfz6D3oUeo6UPvzXmy3lDZAVmVD4obfMV3wkaC+bEm/r
        I+iqJVqtQYjDriBFW5d1j6g7jZ3DxcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-HdLX6bLMPNO88M2-i2Ud9A-1; Wed, 15 Jun 2022 21:37:44 -0400
X-MC-Unique: HdLX6bLMPNO88M2-i2Ud9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4376F8339AE;
        Thu, 16 Jun 2022 01:37:44 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D1EC40334D;
        Thu, 16 Jun 2022 01:37:40 +0000 (UTC)
Date:   Thu, 16 Jun 2022 09:37:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/3] block: Make blk_mq_get_sq_hctx() select the
 proper hardware queue type
Message-ID: <YqqJXxWGINzHfvm6@T590>
References: <20220615225549.1054905-1-bvanassche@acm.org>
 <20220615225549.1054905-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615225549.1054905-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 03:55:49PM -0700, Bart Van Assche wrote:
> Since the introduction of blk_mq_get_hctx_type() the operation type in
> the second argument of blk_mq_get_hctx_type() matters. The introduction
> of blk_mq_get_hctx_type() caused blk_mq_get_sq_hctx() to select a
> hardware queue of type HCTX_TYPE_READ instead of HCTX_TYPE_DEFAULT.
> Switch to hardware queue type HCTX_TYPE_DEFAULT since HCTX_TYPE_READ
> should only be used for read requests.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

