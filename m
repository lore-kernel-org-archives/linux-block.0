Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02907C47096
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C6A6140B
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFDAFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhFDAFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 20:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622765016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ5CPDtRXl0LM3qR/9YQLe9GMP9U72Ad+zphDU05STw=;
        b=g0701YbAJ15MeICxPUMCOfwwI3fMr4DF2zWBz687kEmldV53RvCd8s5AC9m822ve/3l10t
        7A/z/MW7oA6yClPxR7U4kk5Iw8tT+p6JpU3I7XsuMQB7bbr+IUR0JvnaI/hymvNiJ4sF9t
        6/sOKsyGdozOH/qFLqwWcpx9eu1RLt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-1Yo7fJaoN7eUut1axOuA6Q-1; Thu, 03 Jun 2021 20:03:34 -0400
X-MC-Unique: 1Yo7fJaoN7eUut1axOuA6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16AD81840B;
        Fri,  4 Jun 2021 00:03:33 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 611515D6AB;
        Fri,  4 Jun 2021 00:03:25 +0000 (UTC)
Date:   Fri, 4 Jun 2021 08:03:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH 0/4] block: fix race between adding wbt and normal IO
Message-ID: <YLltyRYCpidJBas1@T590>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525080442.1896417-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 04:04:38PM +0800, Ming Lei wrote:
> Hello,
> 
> Yi reported several kernel panics on:
> 
> [16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> ...
> [16687.163549] pc : __rq_qos_track+0x38/0x60
> 
> or
> 
> [  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> ...
> [  997.850347] pc : __rq_qos_done+0x2c/0x50
> 
> Turns out it is caused by race between adding wbt and normal IO.
> 
> Fix the issue by moving wbt allocation/addition into blk_alloc_queue().

Hello Guys,

Ping...


Thanks,
Ming

