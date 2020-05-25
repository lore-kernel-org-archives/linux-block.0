Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3976C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9484F2073B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAnok7ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbgEYNsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 09:48:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403812AbgEYNsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 09:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590414515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ilU+TRFDpPM2WJQUaq7upvxo6ldmL/P6OQbk+icD0KQ=;
        b=aAnok7chbYI6larFse9LrcCByOW+KDl35PkzTQrLbX/9D8PUuA5Nm5YckZwfjtYXa4R6lZ
        WbElWEDIMF7SLJkPn15Mu3qFpBYobIq32eCsKNr3KX70ksmEmUGA+Ct5niSoufiAYzIMpC
        o3LpaCm8mSEBe/GcQ4o7kQfjxIULGCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-8L2af7cfObez3EZNBC8XoQ-1; Mon, 25 May 2020 09:48:33 -0400
X-MC-Unique: 8L2af7cfObez3EZNBC8XoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B34C8474;
        Mon, 25 May 2020 13:48:31 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BBDC5C1BB;
        Mon, 25 May 2020 13:48:25 +0000 (UTC)
Date:   Mon, 25 May 2020 21:48:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Message-ID: <20200525134820.GA847759@T590>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-6-ming.lei@redhat.com>
 <SN4PR0401MB359822F483E45C998996D49B9BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359822F483E45C998996D49B9BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 25, 2020 at 11:01:29AM +0000, Johannes Thumshirn wrote:
> On 25/05/2020 11:39, Ming Lei wrote:
> >  bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
> > -			     bool got_budget)
> > +			     unsigned int nr_budgets)
> 
> I would probably just call it budget instead of nr_budgets.
> 

It was named as 'budget' or 'budgets', but Christoph suggested to rename
it as 'nr_budgets'.

Thanks, 
Ming

