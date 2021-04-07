Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E7AC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA69C6139B
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbhDGAsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbhDGAsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 20:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617756506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdPTRk091gcTZwqq9o0J9KQfKfYiBKRj+ZIXa/lpmYE=;
        b=NyWEIzwbfVaoPu/NSFno8PlDarkpUZ8rFDUH6m+5h8ZLz1sTJ9WqWG1zg5wsim/p9MQ6w7
        /78esEU35VrJL3S3CoBPzx6KPHjuLcwL70Tz69OV6IKihM7aleRGuue4CQRbPeKsZgXgon
        GGGq4mOLDkNBPhprcURTinXbgggmgZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-qUCCXJc8N-ewV-cm8HrGvw-1; Tue, 06 Apr 2021 20:48:25 -0400
X-MC-Unique: qUCCXJc8N-ewV-cm8HrGvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D6883DD20;
        Wed,  7 Apr 2021 00:48:24 +0000 (UTC)
Received: from T590 (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD3CF19D9D;
        Wed,  7 Apr 2021 00:48:17 +0000 (UTC)
Date:   Wed, 7 Apr 2021 08:48:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yanhui Ma <yama@redhat.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
Message-ID: <YG0BTVsCNKZHD3/T@T590>
References: <20210406031933.767228-1-ming.lei@redhat.com>
 <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 11:25:08PM +0100, John Garry wrote:
> On 06/04/2021 04:19, Ming Lei wrote:
> 
> Hi Ming,
> 
> > Yanhui found that write performance is degraded a lot after applying
> > hctx shared tagset on one test machine with megaraid_sas. And turns out
> > it is caused by none scheduler which becomes default elevator caused by
> > hctx shared tagset patchset.
> > 
> > Given more scsi HBAs will apply hctx shared tagset, and the similar
> > performance exists for them too.
> > 
> > So keep previous behavior by still using default mq-deadline for queues
> > which apply hctx shared tagset, just like before.
> 
> I think that there a some SCSI HBAs which have nr_hw_queues > 1 and don't
> use shared sbitmap - do you think that they want want this as well (without
> knowing it)?

I don't know but none has been used for them since the beginning, so not
an regression of shared tagset, but this one is really.



Thanks, 
Ming

