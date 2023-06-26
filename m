Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15773EB64D7
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 08:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFZIRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFZIRk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 04:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342341732
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687767395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIcKvrhyfvRyhcUbtV7vj92mRmoPHG9FohugtG7uhy0=;
        b=WH7LqDlx1J+tFRlbhbnZd6R++OdADt8QtxtcVGkyE6xyORbWXTQHsA+XaS6jnCQIyCnxs2
        2hi/uKERRLpFJEyjMsZkKHrLIbht2hdiyyCu82IhsXMuKJ1UjOAVu9jP7qjnG912PgSduD
        yhIIrXDJIaRoalMTciZyYleG2kE+LjA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-Q25Y_-KcPl2aULgEbpT0kw-1; Mon, 26 Jun 2023 04:16:31 -0400
X-MC-Unique: Q25Y_-KcPl2aULgEbpT0kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86DA21C03D97;
        Mon, 26 Jun 2023 08:16:30 +0000 (UTC)
Received: from ovpn-8-20.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87F3615230A0;
        Mon, 26 Jun 2023 08:16:26 +0000 (UTC)
Date:   Mon, 26 Jun 2023 16:16:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 5/7] block: Preserve the order of requeued requests
Message-ID: <ZJlJVRQtt9M2sAxS@ovpn-8-20.pek2.redhat.com>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-6-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:32PM -0700, Bart Van Assche wrote:
> If a queue is run before all requeued requests have been sent to the I/O
> scheduler, the I/O scheduler may dispatch the wrong request. Fix this by

Can you explain in more details about the issue? What is the wrong
request? How?

If you mean write order for requeued write request, there isn't such issue,
given new write request from same zone can be issued before the old
requeued one is completed.

Thanks, 
Ming

