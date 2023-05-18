Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75609C77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjERNYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjERNY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 09:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74EEDA
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684416221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAzxyQS9/nbdlkkYn4hDeXF4AMB4pc3WOtt86xOXrNk=;
        b=ZU6wLuh16BnVQpjPt5uAb3h8KlMmqJlO96aYvRXDHyuAOMMwJ1CM6fv6DPViScUYmOxoj0
        gmPnYYpJDJexkRfUmPV6hk4xugIgctcCmTjsBro9EKkGER98Waeh+mrCTs3JhrNvB/OibV
        fRzsUoweVzVhO5EQXq5G8RPErhAJ1VA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-a-VuL3lPNdWhYKEFkuuZlw-1; Thu, 18 May 2023 09:23:37 -0400
X-MC-Unique: a-VuL3lPNdWhYKEFkuuZlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 449AF185A79C;
        Thu, 18 May 2023 13:23:37 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EA572166B31;
        Thu, 18 May 2023 13:23:34 +0000 (UTC)
Date:   Thu, 18 May 2023 21:23:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: make sure elevator callbacks aren't called
 for passthrough request
Message-ID: <ZGYm0KT9UG/OqVIW@ovpn-8-21.pek2.redhat.com>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518053101.760632-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 07:31:01AM +0200, Christoph Hellwig wrote:
> In case of q->elevator, passthrought request can still be marked as
> RQF_ELV, so some elevator callbacks will be called for them.
> 
> Fix this by splitting RQF_SCHED_TAGS, which is set for all requests that
> are issued on a queue that uses an I/O scheduler, and RQF_USE_SCHED for
> non-flush, non-passthrough requests on such a queue.
> 
> Roughly based on two different patches from
> Ming Lei <ming.lei@redhat.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

