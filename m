Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75639C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjEWJEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjEWJEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB8FF
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684832615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1BBioVo29NATKIYtrkCfpyqpTQFfozpEKHQWKglz20=;
        b=Lo07KydxMNg7mgKxHafpPGlCamtP0sczjr/tZ7ODfQqkTi/QRWDFjF6kkVoXbqEzZI0huj
        5sNlRSRcxBZbJvoEfpfKk45/xaV5tfAPgA0/UTxDKXdj/0sclsPwddYYAHLdaguObzF+/g
        H6Pe6SP/O2/kVkOgzHkwVWVonsGrbLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-_xotZw9bOUut5Esaup4YoA-1; Tue, 23 May 2023 05:03:32 -0400
X-MC-Unique: _xotZw9bOUut5Esaup4YoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D96802E58;
        Tue, 23 May 2023 09:03:32 +0000 (UTC)
Received: from ovpn-8-32.pek2.redhat.com (hp-dl380g10-01.lab.eng.pek2.redhat.com [10.73.196.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7122E20296C6;
        Tue, 23 May 2023 09:03:26 +0000 (UTC)
Date:   Tue, 23 May 2023 17:03:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, ming.lei@redhat.com
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Message-ID: <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522183845.354920-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 11:38:37AM -0700, Bart Van Assche wrote:
> Send requeued requests to the I/O scheduler such that the I/O scheduler
> can control the order in which requests are dispatched.

I guess you are addressing UFS zoned for REQ_OP_WRITE:

https://lore.kernel.org/linux-block/8e88b22e-fdf2-5182-02fe-9876e8148947@acm.org/

I am wondering how this way can maintain order for zoned write request.

requeued WRITE may happen in any order, for example, req A and req B is
in order, now req B is requeued first, then follows req A.

So req B is requeued to scheduler first, and issued to LLD, then
request A is requeued and issued to LLD later, then still re-order?

Or sd_zbc can provide requeue order guarantee? 

Thanks,
Ming

