Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD8C4709A
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF5B613AC
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 08:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFDI7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhFDI6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jun 2021 04:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622797017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2habXtFi+UHh+znxB11Jx0FmHzxf3yEzU08Y6G1HBPA=;
        b=if4+r2K1W1NQc0jKIZshhPBUmeOfZnNRxiwiUdvgPp7gphv0+YkRyeuGKZ9QRK9hps8SzA
        XHH84XeEm9wi9c6/0mHgQrYk9Q1HMb8tnD1qg5Bk5dOb3XHKYdTt7HXUcVjAEdVc1nDadO
        W34uNYybO8rQ329BjvZiA4lU7oDCPtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-aCMrdi39MHGLE_d9TvrSag-1; Fri, 04 Jun 2021 04:56:56 -0400
X-MC-Unique: aCMrdi39MHGLE_d9TvrSag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB731854E26;
        Fri,  4 Jun 2021 08:56:54 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF6ED1964B;
        Fri,  4 Jun 2021 08:56:48 +0000 (UTC)
Date:   Fri, 4 Jun 2021 16:56:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] block: loop: fix deadlock between open and remove
Message-ID: <YLnqzJkwipxZ1hY8@T590>
References: <20210604000424.189928-1-ming.lei@redhat.com>
 <20210604065733.GA11135@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604065733.GA11135@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 08:57:33AM +0200, Christoph Hellwig wrote:
> This looks good, but I think we can do simple by just adding add new
> Lo_deleting state.  Completely untested as I'm at the tail end of a vacation
> with a broken laptop:

Indeed, adding one deleting state is simpler to kill the lock of loop_ctl_mutex
in lo_open():

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

