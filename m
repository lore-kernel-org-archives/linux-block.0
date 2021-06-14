Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F75BC49361
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E958E61166
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 21:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhFNV5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhFNV5m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 17:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623707739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLVO0uHHSAtgtB8zfOsGh07ySHX0in1v8TZBqoRBniI=;
        b=edl2qqN/JNKjAyZc5aLGW3AHkHKqbPo2tQKrmxqp1oZ2kvAEkbNyAqLyofSb2OH3ppXAuX
        FLzf+KMAgeJYgtvUg6yo/FF2IzA/YE5bIQkxDlnD240THGtX87zarQ4id/03XDmW8zOV9i
        B3uAWwFyhNbVmAucA720lE1jGnJaOzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-6WVpP6FrMaOdg18wXb4_Rw-1; Mon, 14 Jun 2021 17:55:35 -0400
X-MC-Unique: 6WVpP6FrMaOdg18wXb4_Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F6E21084F40;
        Mon, 14 Jun 2021 21:55:34 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 148E060C4A;
        Mon, 14 Jun 2021 21:55:24 +0000 (UTC)
Date:   Tue, 15 Jun 2021 05:55:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 0/2] block: fix race between adding wbt and normal IO
Message-ID: <YMfQSAT4hMDmdumY@T590>
References: <20210609015822.103433-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609015822.103433-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 09:58:20AM +0800, Ming Lei wrote:
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
> Fix the issue by freezing request queue when adding/deleting rq qos.
> 
> V3:
> 	- use ->queue_lock for protecting concurrent adding/deleting rqos on
> 	  same queue
> 
> V2:
> 	- switch to the approach of freezing queue, which is more generic
> 	  than V1.
> 
> 
> 
> Ming Lei (2):
>   block: fix race between adding/removing rq qos and normal IO
>   block: mark queue init done at the end of blk_register_queue
> 
>  block/blk-rq-qos.h | 24 ++++++++++++++++++++++++
>  block/blk-sysfs.c  | 29 +++++++++++++++--------------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Bart Van Assche <bvanassche@acm.org>

Hello Jens,

Any chance to merge the fixes if you are fine?

Thanks,
Ming

