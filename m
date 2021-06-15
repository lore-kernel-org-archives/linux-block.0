Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A9DC48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 09:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228B56115C
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 09:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFOJZA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231174AbhFOJZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623748975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZomdBvWBdBzyU/KO6r7jol9LTqc+0xLihxqhqLJmkTQ=;
        b=V92+kNwK1cy1FMsAR+BZZYjGXdMOyMSoFF+OXFCz3wiwebLfU0lq+69aIhgBkuHmHievpF
        KWiOaFxctr9cC72eHrWFfn8jatcXiCUYmz7prd/lJp8GUcQCR+4g63nf/U19xLE/jh7qW5
        QLULFS6LolI/dZ1i9Go4rsFYxzQtEiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Y-vBG5rQMk6n_mSUZ2ld4w-1; Tue, 15 Jun 2021 05:22:53 -0400
X-MC-Unique: Y-vBG5rQMk6n_mSUZ2ld4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED2F7803621;
        Tue, 15 Jun 2021 09:22:52 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7115D6D1;
        Tue, 15 Jun 2021 09:22:47 +0000 (UTC)
Date:   Tue, 15 Jun 2021 17:22:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Kilani <omar.kilani@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: Deadlock in wbt / rq-qos
Message-ID: <YMhxY9svDeVApu95@T590>
References: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 13, 2021 at 08:49:47AM -0700, Omar Kilani wrote:
> Hi there,
> 
> I appear to have stumbled upon a deadlock in wbt or rq-qos.
> 
> My journal of a lot of data points is over here:
> 
> https://github.com/openzfs/zfs/issues/12204
> 
> I initially deadlocked on RHEL 8.4's 4.18.0-305.3.1.el8_4.x86_64
> kernel, but the code in blk-wbt.c / blk-rq-qos.c is functionally
> identical to 5.13.0-rc5, so I tried that and I'm able to deadlock that
> as well. I believe the same code exists all the way back to 5.0.1.

Recently Jan Kara fixed one rq-qos deadlock issue, can you check if
the following patch fixes your issue?

https://lore.kernel.org/linux-block/e14aeaa7-45a3-b2f0-7738-3613189ae1d4@kernel.dk/T/#t

 
Thanks, 
Ming

