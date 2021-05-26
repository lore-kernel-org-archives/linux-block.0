Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B6C2B9F7
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E21C613CD
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEZISq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 04:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhEZISl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 04:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPzbOUdLDB1kxTXxDyLQuPw6KP2rbbpd7VzwwvU6XsA=;
        b=RxGfT8z6vXzzlF1JAAWmcd440Lp7CzVZBXTPBAip8ZxsEnN2ZUDtcexx0Iq+H+aYLpugVs
        kXBHYQ8VQWE7M2E1oNxQnt28MDITgWJr+LCs3J21hGw6rBB9xd2jA92yTGlGHziNw+NGQ4
        9zASs4hSWOL44NaQMxDMUxJC5+owCEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-va0V2lwMN6OiCBFS1C2ZIg-1; Wed, 26 May 2021 04:17:06 -0400
X-MC-Unique: va0V2lwMN6OiCBFS1C2ZIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352A91009446;
        Wed, 26 May 2021 08:17:05 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 550641001281;
        Wed, 26 May 2021 08:16:56 +0000 (UTC)
Date:   Wed, 26 May 2021 16:16:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 1/4] block: support polling through blk_execute_rq
Message-ID: <YK4D9HZjBtg5AK/2@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-2-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:42PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Moved blk_execute_rq's poll handling into a small helper function

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

