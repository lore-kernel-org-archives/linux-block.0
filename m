Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A693C433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A78206DC
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Euj2GW9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgJTJoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403839AbgJTJoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603187078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXYs6egZBi1dDPtBtWTXxsg0s20RzV1tfBLOiwQO35Y=;
        b=Euj2GW9ZsiOF8yqxfdoi21xpgXHtGgV1MPVo8hLLy0CtTvniH7fYTCIkFf8SrVcs8vrjzY
        8hxkmdIpHWXJ8BlWEUcFucVsYlZjdmR7A4HMMEEgxsWUHefl7ShX1JgsExzdiukaFAiDaz
        p1IwqKvZ8z77PAVldmyboDldjPEGLJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17--q8sY-yOPza9jAQy6bEoYg-1; Tue, 20 Oct 2020 05:44:36 -0400
X-MC-Unique: -q8sY-yOPza9jAQy6bEoYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72549640AC;
        Tue, 20 Oct 2020 09:44:34 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8856198C;
        Tue, 20 Oct 2020 09:44:24 +0000 (UTC)
Date:   Tue, 20 Oct 2020 17:44:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH 3/4] nvme: tcp: fix race between timeout and normal
 completion
Message-ID: <20201020094420.GD1429635@T590>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-4-ming.lei@redhat.com>
 <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 20, 2020 at 01:11:11AM -0700, Sagi Grimberg wrote:
> 
> > NVMe TCP timeout handler allows to abort request directly when the
> > controller isn't in LIVE state. nvme_tcp_error_recovery() updates
> > controller state as RESETTING, and schedule reset work function. If
> > new timeout comes before the work function is called, the new timedout
> > request will be aborted directly, however at that time, the controller
> > isn't shut down yet, then timeout abort vs. normal completion race
> > will be triggered.
> 
> This assertion is incorrect, the before completing the request from
> the timeout handler, we call nvme_tcp_stop_queue, which guarantees upon
> return that no more completions will be seen from this queue.

OK, then looks the issue can be fixed by patch 1 & 2 only.

Yi, can you test again and see if the issue can be fixed by patch 1 & 2?


Thanks,
Ming

