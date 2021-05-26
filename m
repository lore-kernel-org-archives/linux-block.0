Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E04C2B9F7
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691FA61005
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhEZI1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 04:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233105AbhEZI0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 04:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RMhOAcQOW55vgjgxWWqrSlVhG/1Gigk5KVeEqYJeD0=;
        b=EzkefCNLCsbBpuQLHbXPXHZ8KkHWyIhXM7ovptiLWy2nc/EkLSbH8sjR8st848BnDVyuQn
        nfSA7sF96367sADwgHiUDA6U2HIIej3cC0MaeFwRu4Pm4+/jiv1opWX+xELBSR8EL/lE1m
        Y30Ft382UEXnAsUgiQMzk8scNXKgo/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-m5ztJeveO0CkkF2uuxx8dw-1; Wed, 26 May 2021 04:25:09 -0400
X-MC-Unique: m5ztJeveO0CkkF2uuxx8dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 207F5804B89;
        Wed, 26 May 2021 08:25:08 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7BCD6A046;
        Wed, 26 May 2021 08:25:02 +0000 (UTC)
Date:   Wed, 26 May 2021 16:24:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <YK4F2ll2qLWqzlKT@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-3-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:43PM -0700, Keith Busch wrote:
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> No changes since v2

Looks fine, one thing need to pay attention is that this nvme polled
request won't be marked as REQ_HIPRI.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

