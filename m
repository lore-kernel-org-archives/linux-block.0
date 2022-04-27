Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA44C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiD0Kl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiD0Kl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 06:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0469136EE13
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651054801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OpIunjeIYPh5Rz1kLsEA2FMELtrbur+qP4oN0kQVy8o=;
        b=Wb6na531/Xto0pwyqFuDm1g9tntaiuksKLJnl224TpJCAASzvX3hjnXx8h6Py3My+CDOS1
        1pyuaszxZ3vy9t9vK83DkUg5tgJoITvL0rvGHGx8drGzb5tB62Vbfw1Cp6heJmf4mwmu32
        44yPKhJF9gJzRMyp6Kl8zTcA5Z94zmw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-vpCXn147NkCXlJjdA95btQ-1; Wed, 27 Apr 2022 05:57:30 -0400
X-MC-Unique: vpCXn147NkCXlJjdA95btQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB63B38035A0;
        Wed, 27 Apr 2022 09:57:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D51FC2812C;
        Wed, 27 Apr 2022 09:57:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23R9vTpg010661;
        Wed, 27 Apr 2022 05:57:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23R9vTw8010657;
        Wed, 27 Apr 2022 05:57:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 27 Apr 2022 05:57:29 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
cc:     "yukuai (C)" <yukuai3@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Hunt, Joshua" <johunt@akamai.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: Precise disk statistics
In-Reply-To: <1651017390610.22782@akamai.com>
Message-ID: <alpine.LRH.2.02.2204270549490.10147@file01.intranet.prod.int.rdu2.redhat.com>
References: <1650661324247.40468@akamai.com> <1650915337169.63486@akamai.com>,<87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com> <1651017390610.22782@akamai.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> [+ Mikulas and Ming]
> 
> I see. Thank you for the response, Kuai, appreciate it.
> 
> The conversation here https://lkml.org/lkml/2020/3/24/1870 hints at 
> potential improvements to io_ticks tracking.
> 
> @Mikulas, Mike, please let us know if you have plans for more accurate 
> accounting or if there is some idea we can work on and submit a patch.

I know that the accounting is not accurate, but more accurate accounting 
needed a shared atomic variable and it caused performance degradation. So, 
we don't plan to improve the accounting.

Mikulas

> 
> Thanks
> -Sri
> 
> 
> 

