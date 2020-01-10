Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86A9C3F68F
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58502075D
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 02:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKNolHmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgAJC6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:58:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730952AbgAJC6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 21:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578625093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQq8OjZQe+jrASIwtflhAXk/e88ivOD4URwk9vFRX54=;
        b=YKNolHmi3xqX3f/R3Tp/qdln/0w4KvXwke3RUAqNCSO9OuWE5dF2kAsSVtVaHLMbPEpWEd
        jRsK7m8kYm5hxmMiZIFjAjU8hTtugj4sja5HywtEng58Yrn0ll7nFc/gDMem8aJfH1nIgf
        nLwrGNufxlpj/rQ+QbnZO5TT9/4pmgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-jEimyCIWOWC6_uyc-Amy7w-1; Thu, 09 Jan 2020 21:58:12 -0500
X-MC-Unique: jEimyCIWOWC6_uyc-Amy7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16890DB6C;
        Fri, 10 Jan 2020 02:58:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D92E05C28C;
        Fri, 10 Jan 2020 02:58:05 +0000 (UTC)
Date:   Fri, 10 Jan 2020 10:58:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200110025801.GC4501@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org>
 <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
 <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 09, 2020 at 08:18:04AM -0700, Jens Axboe wrote:
> On 1/9/20 12:16 AM, Christoph Hellwig wrote:
> > On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
> >> It has been addressed in:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
> > 
> > That is probably correct, but still highly suboptimal for most 32-bit
> > architectures where physical addresses are 32 bits wide.  To fix that
> > the proper phys_addr_t type should be used.
> 
> I'll swap it for phys_addr_t - we used to use dma_address_t or something
> like that, but I missed this type.

Guenter mentioned that 'page_to_phys(start_page) as well as offset are
sometimes 0'[1].

If that(zero page physical address) can happen when phys_addr_t is 32bit,
I guess phys_addr_t may not work too.

Guener, could you test the patch in link[2] again?


[1] https://lore.kernel.org/linux-block/20200108023822.GB28075@ming.t460p/T/#m5862216b960454fc41a85204defbb887983bfd75
[2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=b6a89c4a9590663f80486662fe9a9c1f4cee31f4


Thanks,
Ming

