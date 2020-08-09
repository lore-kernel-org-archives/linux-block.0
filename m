Return-Path: <SRS0=6aiD=BT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80622C433E0
	for <linux-block@archiver.kernel.org>; Sun,  9 Aug 2020 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57754206E2
	for <linux-block@archiver.kernel.org>; Sun,  9 Aug 2020 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYWNwklH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHICkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:40:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbgHICkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Aug 2020 22:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596940822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZWmNdmE9mXz97K5KedK2xTYBcMa+8BCG/iCLTDYqd8=;
        b=SYWNwklHfN01WgxbnRqfxLU1SreQ/icXE2ndxkMjo9JSm3AoIwigHK1HOvx7OMYB7BJviW
        7omVEgbSVu/SvWfZ5dW69RcLybILH4/iCF6fi4EATnH15qLW9Q6xiW7xyJMQIEy9uVL4fq
        Q80B2OM+KXwgKnHZnK/HqToyLWggyUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ZN91v3kLN4eIyNUc3Cyx1A-1; Sat, 08 Aug 2020 22:40:18 -0400
X-MC-Unique: ZN91v3kLN4eIyNUc3Cyx1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B9459;
        Sun,  9 Aug 2020 02:40:17 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F67E2C26B;
        Sun,  9 Aug 2020 02:40:10 +0000 (UTC)
Date:   Sun, 9 Aug 2020 10:40:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Very slow qemu device access
Message-ID: <20200809024005.GC2134904@T590>
References: <20200807174416.GF17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807174416.GF17456@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Matthew,

On Fri, Aug 07, 2020 at 06:44:16PM +0100, Matthew Wilcox wrote:
> 
> Everything starts going very slowly after this commit:
> 
> commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Tue Jun 30 22:03:57 2020 +0800
> 
>     blk-mq: centralise related handling into blk_mq_get_driver_tag

Yeah, the above is one known bad commit, which is reverted in
4e2f62e566b5 ("Revert "blk-mq: put driver tag when this request is completed")

Finally the fixed patch of 'blk-mq: centralise related handling into blk_mq_get_driver_tag'
is merged as 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag").

So please test either 4e2f62e566b5 or 568f27006577 and see if there is
such issue.


Thanks,
Ming

