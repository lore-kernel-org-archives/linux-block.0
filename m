Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB1C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 03:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E021D80
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 03:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+czMcrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgINDGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Sep 2020 23:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgINDGB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Sep 2020 23:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600052760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eBi5sSIatPEaDlkdTNdVnDuFPoGMg+QGwpj5+4NF2E=;
        b=K+czMcrvRRtJuQ5mRe+Q/ZrwvuyGzoNrP1U+OzAGE25UhawjB+P/0TrcO47QgfLNB15LwG
        kYEM8XbQyJlBJdShVB/cqCxSBQFOuFv2yQ5ufrM01WG970Z/KqyH628Y3guq+8tpssPXK9
        esNv3ndIIsyxQkPCMrvbgc1XzqutI0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Wi8n9ebnPRqf_yLJaxTNbg-1; Sun, 13 Sep 2020 23:05:56 -0400
X-MC-Unique: Wi8n9ebnPRqf_yLJaxTNbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74F251882FB3;
        Mon, 14 Sep 2020 03:05:54 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B6D19C4F;
        Mon, 14 Sep 2020 03:05:46 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:05:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200914030542.GA342981@T590>
References: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
 <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 01:14:29PM -0600, Jens Axboe wrote:
> On Sep 11, 2020, at 1:12 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> > 
> > ﻿
> >>> Hi Jens,
> >>> 
> >>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> >>> and prepares for replacing srcu with percpu_ref.
> >>> 
> >>> The 2nd patch replaces srcu with percpu_ref.
> >>> 
> >>> The 3rd patch adds tagset quiesce interface.
> >>> 
> >>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> >> What is this series against?
> > 
> > It didn't apply cleanly to me too until I realized it is
> > on top of v4 of: "percpu_ref & block: reduce memory footprint of percpu_ref in fast path"
> 
> Right, and that’s what has the leak issue you found. I’ll hold off on this one until that’s sorted. 

Actually this patchset doesn't depend on patch of 'percpu_ref & block: reduce memory
footprint of percpu_ref in fast path', and I hold them in one branch, so
causes the conflict.

V6 has been sent out, and just rebase against for-5.10/block directly.

Thanks,
Ming

