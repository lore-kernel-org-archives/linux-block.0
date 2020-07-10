Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA15C433E0
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E87206F4
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Irx4KP3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJJru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:47:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgGJJru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594374469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQvdU3iRt56w7HpkGVuSwd8XeVDq7ZK+VynoX1ee5lc=;
        b=Irx4KP3Ww0ay4Lft3Wgabh3WwkWlF9sl+vQu+qV7QzVfQd2prcuikFNKNb+ynxYRi5CjSs
        RTtHvMTUdAukrx4RVYwqbz5Rcm/eSRBwh76uk93H8VZrNNctbLrLCthJ2P3Xf/vUO0Ct7Q
        f8pEe37pzT0JwOp0+ImIxfvONkX7cfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-aWm8zGwqNZ-WDNJn0Vw6SA-1; Fri, 10 Jul 2020 05:47:47 -0400
X-MC-Unique: aWm8zGwqNZ-WDNJn0Vw6SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C69800FF1;
        Fri, 10 Jul 2020 09:47:46 +0000 (UTC)
Received: from T590 (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F49B6FEF4;
        Fri, 10 Jul 2020 09:47:39 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:47:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove unnecessary validation before calling
 blk_mq_sched_completed_request()
Message-ID: <20200710094735.GB3417252@T590>
References: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
 <20200710082304.GB29262@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710082304.GB29262@VM20190228-100.tbsite.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 10, 2020 at 04:23:04PM +0800, Baolin Wang wrote:
> Hi,
> 
> On Sat, Jul 04, 2020 at 03:28:21PM +0800, Baolin Wang wrote:
> > We've already validated the 'q->elevator' before calling ->ops.completed_request()
> > in blk_mq_sched_completed_request(), thus no need to validate rq->internal_tag again,
> > and remove it.
> 
> A gentle ping?

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

