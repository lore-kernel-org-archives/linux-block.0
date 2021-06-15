Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94E8C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 03:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66936140D
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 03:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFODj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230179AbhFODj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 23:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623728273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDHNc5Tyf/BE3LnU7xQVP8PWodTzMsA3/eBC7eGEh90=;
        b=drOpg6wSZXJ9P9XiXtgS5mvPv5N+N7U7yAFSqy2aXixS+5si5VbPSzK/SM6aDr0lnbH98Z
        rORMTJTdRzyxPm8L+MZ5kZyWdkUI06rqJ+t3K4ZpypO4NJVfQhXRfiBY9vCrEQVAZ+/S+C
        7KsiscWUbQgQuMO3JYFRHw99p0PPPi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-5sCKDPAAPk6I8Nedw6j_Og-1; Mon, 14 Jun 2021 23:37:51 -0400
X-MC-Unique: 5sCKDPAAPk6I8Nedw6j_Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CB34801B21;
        Tue, 15 Jun 2021 03:37:50 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D6CA18F0A;
        Tue, 15 Jun 2021 03:37:43 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:37:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Do not lookup ctx with invalid index
Message-ID: <YMggg+0mVwA0Gl4j@T590>
References: <20210608183339.70609-1-dwagner@suse.de>
 <20210614113706.astexefgfo4tuejr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614113706.astexefgfo4tuejr@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 14, 2021 at 01:37:06PM +0200, Daniel Wagner wrote:
> On Tue, Jun 08, 2021 at 08:33:39PM +0200, Daniel Wagner wrote:
> > cpumask_first_and() returns >= nr_cpu_ids if the two provided masks do
> > not share a common bit. Verify we get a valid value back from
> > cpumask_first_and().
> 
> So I got feedback on this issue (but not on the patch itself yet). The
> system starts with 16 virtual CPU cores and during the test 4 cores are
> removed[1] and as soon there is an error on the storage side, the reset
> code on the host ends up in this path and crashes. I still don't
> understand why the CPU removal is not updating the CPU mask correctly
> before we hit the reset path. I'll continue to investigate.

We don't update hctx->cpumask when CPU is added/removed, and that is
assigned against cpu_possible_mask from beginning.

It is one long-term issue, which can be triggered when all cpus in
hctx->cpumask become offline. The thing is that only nvmf_connect_io_queue()
allocates request via specified hctx.

thanks,
Ming

