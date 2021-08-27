Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D705C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A6160EE7
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbhH0N3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231964AbhH0N3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 09:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630070903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aserqfxgK4j648DubNeStR0HBDeNL2sC/ZgY9Ze9vt4=;
        b=DpKiJ10l5q/RPXA23/hiXqkBOx3EI1BmGlbvj6S1qEP3cnPUwXEqwdLLCplXK8W2bFzVxg
        /dwvh/0c/7rY0oql2x+XK+p/w0WyrYLcZoCEPHCbCU7YenGnI8jOy9zV23I2fYlMBHiIIW
        7vNXzzlyR1XC+YFk1ala3phEna7+zfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-2qT1BMhXPcaSOYLyD0plAg-1; Fri, 27 Aug 2021 09:28:22 -0400
X-MC-Unique: 2qT1BMhXPcaSOYLyD0plAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10224190A7A1;
        Fri, 27 Aug 2021 13:28:21 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84DC15DA60;
        Fri, 27 Aug 2021 13:28:11 +0000 (UTC)
Date:   Fri, 27 Aug 2021 21:28:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Message-ID: <YSjoZ/cul4w2l8tG@T590>
References: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
 <20210827124100.98112-2-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827124100.98112-2-Niklas.Cassel@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 12:41:31PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Currently, __blk_mq_alloc_request() calls ops.prepare_request and sets
> RQF_ELVPRIV.
> 
> Therefore, (if the request is not a flush) the RQF_ELVPRIV flag will be
> set for the request in blk_mq_submit_bio(), regardless if the request
> was submitted to a scheduler, or bypassed the scheduler.
> 
> Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
> if it is, the ops.finish_request callback will be called.
> 
> The problem with this is that the finish_request scheduler callback
> will be called for requests that bypassed the scheduler.
> 
> Fix this by calling the scheduler ops.prepare_request callback, and
> set the RQF_ELVPRIV flag only immediately before calling the insert
> callback.

One request could be inserted more than one times, such as requeue,
however __blk_mq_alloc_request() is just run once, so is it fine to
call ->prepare_request more than one time for same request?

Or I am wondering why not call ->prepare_request when the following
check is true?

	if (e && e->type->ops.prepare_request && !op_is_flush(data->cmd_flags) &&
		!blk_op_is_passthrough(data->cmd_flags))
		e->type->ops.prepare_request()




Thanks, 
Ming

