Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9D1C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjDTPrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjDTPrk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 11:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142DA1A7
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682005614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0qPfXIAn4cdGYAGROpk5ybZVXPszceXcUMH91E0FcY=;
        b=d8gMgQd1A7JRb8UuEKiDc5OvNs62E5XAyTBAwENJD/qkkabCJQUYLHusbIUT0/9+rAvvKA
        AiIRJ2JQOLn2JgZ8gDQdijVCsFitu9GxK2BtHkxWIauhB3l4kVom+iG6XxClmUuL0Fk+Hm
        k12Ux6owucjptb+EInh7b62zZSX/am4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-4zC34LWSOnmTk65TNLMzMQ-1; Thu, 20 Apr 2023 11:46:50 -0400
X-MC-Unique: 4zC34LWSOnmTk65TNLMzMQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95200101A555;
        Thu, 20 Apr 2023 15:46:50 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A4C492C3E;
        Thu, 20 Apr 2023 15:46:47 +0000 (UTC)
Date:   Thu, 20 Apr 2023 23:46:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 0/7] ublk: cleanup and support user copy
Message-ID: <ZEFeYsQ/ntUjUv2Y@ovpn-8-16.pek2.redhat.com>
References: <20230420154032.1272836-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420154032.1272836-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 11:40:25PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st 3 patch are cleanup.
> 
> The other patches supports to move data copy between io request pages and
> userspace buffer into ublk server(userspace). This way avoids one round trip
> of uring command(UBLK_F_NEED_GET_DATA), and solve buffer release issue for
> READ. Meantime both sides becomes cleaner. Also it can be thought as
> prep patch for supporting zero copy.
> 
> 
> Ming Lei (7):
>   ublk: kill queuing request by task_work_add
>   ublk: cleanup io cmd code path by adding ublk_fill_io()
>   ublk: cleanup ublk_copy_user_pages
>   ublk: grab request reference when the request is handled by userspace
>   ublk: support to copy any part of request pages
>   ublk: add read()/write() support for ublk char device
>   ublk: support user copy
> 
>  drivers/block/ublk_drv.c      | 457 +++++++++++++++++++++++++---------
>  include/uapi/linux/ublk_cmd.h |  25 +-
>  2 files changed, 361 insertions(+), 121 deletions(-)

ublksrv code for supporting user copy(only loop implements it, and
easy for others to support it):

https://github.com/ming1/ubdsrv/commits/usercopy


Thanks,
Ming

