Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF54C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD09561D0B
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 10:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhF3KQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhF3KQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 06:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625048043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sE33PaxiQVlndCHStL5H+OZPSUiiG6L+MMVETSDNJso=;
        b=Iz33Xs709oObCmJZobWi9xZXc25/udmbL9pmOAxuWVA5qTvIy0SU/J7Adw5NQWzwvH55UL
        nUlTpJYXiCwqxfyzHLflDJHskCuvhPMdytOVRM0MWkkqMy/iVAgK2U40uvvuwA6dxINDJf
        uxsEwGizfwnHCt0dTrvrG1X6bBgyRqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-1bQ7HDSyOgSQq9wKMoxHlg-1; Wed, 30 Jun 2021 06:14:02 -0400
X-MC-Unique: 1bQ7HDSyOgSQq9wKMoxHlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BFB7804144;
        Wed, 30 Jun 2021 10:14:01 +0000 (UTC)
Received: from T590 (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D786460C17;
        Wed, 30 Jun 2021 10:13:53 +0000 (UTC)
Date:   Wed, 30 Jun 2021 18:13:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH] blk-mq: don't allocate requests when all cpus in a hctx
 are offline
Message-ID: <YNxD3ekRJrZK8FKm@T590>
References: <20210630100342.1100-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630100342.1100-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 12:03:42PM +0200, Hannes Reinecke wrote:
> When all CPUs in a hctx are offline in blk_mq_alloc_request_hctx() we should
> not try to allocate the request, as we'll fail later on in blk_mq_get_tag() anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---

Please see my yesterday's reply why this way isn't good:

https://lore.kernel.org/lkml/YNrwnWfsxf8cJcoe@T590/
https://lore.kernel.org/lkml/YNrhXFgv%2FgEWbhbl@T590/


Thanks,
Ming

