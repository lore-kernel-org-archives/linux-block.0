Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC2C432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDFF60F12
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 09:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhHaJgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240519AbhHaJfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 05:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630402453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7DL5Qz9ZV5QSQecAa3/NSnBuDFbjLfavrK2voEwfYQ=;
        b=Kg3wja8TmrtwfAXPGIZJbDao3YMiQ7yktfJRCwvHTNgC6ePOTt8f3QY01HxkHC9IuJCeCm
        wIBDhU+xX90XL8pTyoHMjVdVqX6LL36z02kp5TrKeFZFdea3PTJIEnO+7K/18carS2W9Hu
        G/PifSJQ2A5XfUMTyvrRnLPEM1YaEYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-n-wgwNhXNDO0Mq-zpkSkiQ-1; Tue, 31 Aug 2021 05:34:11 -0400
X-MC-Unique: n-wgwNhXNDO0Mq-zpkSkiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7017871805;
        Tue, 31 Aug 2021 09:34:10 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0425427089;
        Tue, 31 Aug 2021 09:34:00 +0000 (UTC)
Date:   Tue, 31 Aug 2021 17:33:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martin Svec <martin.svec@zoner.cz>
Cc:     linux-block@vger.kernel.org
Subject: Re: NULL pointer dereference in blk_mq_put_rq_ref (LTS kernel
 5.10.56)
Message-ID: <YS33g6bLXCeB7Pue@T590>
References: <1706c570-6c07-4eb7-219f-de3366e54077@zoner.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706c570-6c07-4eb7-219f-de3366e54077@zoner.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 04:52:54PM +0200, Martin Svec wrote:
> Hi all,
> 
> after upgrade from 5.4.x to 5.10.56 one of our LIO iSCSI Target servers hung
> with kernel NULL pointer dereference bug, see below. According to the call trace
> I guess that the bug is related to the generic blk-mq subsystem. I don't see any
> fixes related to blk-mq between 5.10.56 and 5.10.60, so this bug probably occurs
> in latest 5.10 stable releases too. I this a known issue or do you have any ideas
> what's wrong?

The issue should have been fixed by the following two patches:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9ed27a764156929efe714033edb3e9023c5f321
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2da19ed50554ce52ecbad3655c98371fe58599f


Thanks,
Ming

