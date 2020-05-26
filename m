Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156EC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 02:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945362073B
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 02:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQKKBQ5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgEZCzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 22:55:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgEZCzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 22:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590461744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUEGxyh48BMTSWb1vG9IkePEUKPLcFPe+vap0CM+47I=;
        b=QQKKBQ5R+umtnUjpoqU86u8p7Nmu84tVoq8TkqeL24ebtdOatA5F3Wdt2p0H+R5ztfo1AV
        lIoUlOdpFqqqwDAAgKSAXHB907b1nHTi4O07UwyCQR5eFO+M62lLlk5PZl4+esf1sjWfhJ
        qMFaoXKlPw18Qks+dgtJdTjvkVo/YCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-TlDe8w_VOc-6JWDrf6JFvw-1; Mon, 25 May 2020 22:55:39 -0400
X-MC-Unique: TlDe8w_VOc-6JWDrf6JFvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88089460;
        Tue, 26 May 2020 02:55:38 +0000 (UTC)
Received: from T590 (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 085A910013D2;
        Tue, 26 May 2020 02:55:32 +0000 (UTC)
Date:   Tue, 26 May 2020 10:55:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
Message-ID: <20200526025527.GA865019@T590>
References: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 07:56:52PM +0800, Ming Lei wrote:
> Hi,
> 
> For nvme-pci, after controller is recovered, in-flight IOs are waited
> before updating nr hw queues. If new controller error happens during
> this period, nvme-pci driver deletes the controller and fails in-flight
> IO. This way is too violent, and not friendly from user viewpoint.
> 
> Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
> in nvme-pci reset handler with checking if all ns queues are frozen &
> controller disabled. Then a fresh new reset can be scheduled for
> handling new controller error during waiting for in-flight IO completion.
> 
> So deleting controller & failing IOs can be avoided in this situation.
> 
> Without this patches, when fail io timeout injection is run, the
> controller can be removed very quickly. With this patch, no controller
> removing can be observed, and controller can recover to normal state
> after stopping to inject io timeout failure.
> 
> Ming Lei (3):
>   blk-mq: add API of blk_mq_queue_frozen
>   nvme: add nvme_frozen
>   nvme-pci: make nvme reset more reliable
> 
>  block/blk-mq.c           |  6 ++++++
>  drivers/nvme/host/core.c | 14 ++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 37 ++++++++++++++++++++++++++++++-------
>  include/linux/blk-mq.h   |  1 +
>  5 files changed, 52 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.2
> 

Hello Guys,

Ping...

Thanks,
Ming

