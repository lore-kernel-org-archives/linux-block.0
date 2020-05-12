Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21216C54E4B
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 07:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EBB20643
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 07:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qndc32W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgELHzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 03:55:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgELHzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 03:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589270121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+HYDe6g+ou+zcVtktMtVat8vILndiBh80hjXAWHjV0=;
        b=Qndc32W3oYrIq9CmjCiRFvt8oD8PR/40GudpgpRe44rCRevTOPLbnB5+ayN3xwAliEc0Y2
        B2TTEXd5scBO9Lo99IqSqwyRbu8gSXsoUssYNm1S3sNWvDQKAaUQmU9Kbs+e4nnkFe11G2
        QRKtedzD2XwJ+7OklaIPF1skDFtXASY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-VS6eSzupOSi69pF4FRK3pA-1; Tue, 12 May 2020 03:55:17 -0400
X-MC-Unique: VS6eSzupOSi69pF4FRK3pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0E5A18FE860;
        Tue, 12 May 2020 07:55:15 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE7C5D9DD;
        Tue, 12 May 2020 07:55:05 +0000 (UTC)
Date:   Tue, 12 May 2020 15:55:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
Message-ID: <20200512075501.GF1531898@T590>
References: <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
 <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
 <20200511012942.GA1418834@T590>
 <8f2ddabc-01d0-dae9-f958-1b26a6bdf58c@grimberg.me>
 <20200511114731.GA1525935@T590>
 <9dc69d5a-b4f3-23a6-e033-377b4e133f97@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc69d5a-b4f3-23a6-e033-377b4e133f97@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 11:26:07PM -0700, Sagi Grimberg wrote:
> 
> > > devices will benefit from the batching so maybe the flag needs to be
> > > inverted? BLK_MQ_F_DONT_BATCHING_SUBMISSION?
> > 
> > Actually I'd rather to not add any flag, and we may use some algorithm
> > (maybe EWMA or other intelligent stuff, or use hctx->dispatch_busy directly)
> > to figure out one dynamic batching number which is used to dequeue requests
> > from scheduler or sw queue.
> > 
> > Then just one single dispatch io code path is enough.
> 
> Sounds good to me, do you plan to submit a patchset?
> 

Yeah, I am working on that.


Thanks,
Ming

