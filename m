Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C6C432BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 01:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DA161027
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 01:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhIABgy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 21:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241192AbhIABgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 21:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630460157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ig4axNJNT0Dq5sJr3sZt7gc+PdhIceOOKtmcIYoEfDI=;
        b=f08bM1BxGRDY0hYU1vql+ik1ZkWmFsM2v58gR5bekMtIQjDIFXSVtZdTl/ZQaQxR4Vaeqq
        tGg8/7jV61eHuTTUiDpoqZ93BfTvwFZkO6tZ9Q5eEy4bo78Ovkdt3ugelFlPzD2u4FscK8
        GsNtci13yChmZMzDpkbkPG54mJoND0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-xK9uHLSNOXmXZ24bQc0QJg-1; Tue, 31 Aug 2021 21:35:56 -0400
X-MC-Unique: xK9uHLSNOXmXZ24bQc0QJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172801853028;
        Wed,  1 Sep 2021 01:35:55 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B3C27CA8;
        Wed,  1 Sep 2021 01:35:49 +0000 (UTC)
Date:   Wed, 1 Sep 2021 09:35:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martin Svec <martin.svec@zoner.cz>
Cc:     linux-block@vger.kernel.org
Subject: Re: NULL pointer dereference in blk_mq_put_rq_ref (LTS kernel
 5.10.56)
Message-ID: <YS7Y8Ej3BKLR175+@T590>
References: <1706c570-6c07-4eb7-219f-de3366e54077@zoner.cz>
 <YS33g6bLXCeB7Pue@T590>
 <996b8008-f7ec-4752-e207-669fe88021df@zoner.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996b8008-f7ec-4752-e207-669fe88021df@zoner.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 31, 2021 at 12:30:57PM +0200, Martin Svec wrote:
> Hello Ming,
> 
> thanks a lot. I don't see the patches in 5.10 stable queue yet, is it safe to apply them on top of
> 5.10.60 LTS kernel?

Yeah, both are fix on 2e315dc07df0 ("blk-mq: grab rq->refcount before calling
->fn in blk_mq_tagset_busy_iter") which is in 5.10.60 stable tree, so
safe to apply them.



Thanks,
Ming

