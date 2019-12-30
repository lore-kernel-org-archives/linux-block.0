Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A88C2D0C0
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 01:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E99D2075D
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 01:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQah/FoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfL3BZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:25:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbfL3BZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Dec 2019 20:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577669155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJdLYdZWjE9V14oKSEekxJS38xuffO103PXHGFAx8cs=;
        b=MQah/FoKJtcKLN7b8oKH6xnoYpSz9LZ5zzJu62Pi8L+R7mwaTmKk9SdJW6dWFm+gfg9D3v
        5KflWqnDHI8O9K1+RMPIaUbqTwu/ZrTYJVwanW0OtTjF+BVk6eajFeeJnE/3g92COb0cMP
        QLVdy4ARrAFX6/3RnGasxIc3lOu93mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-AKttb3BqNUWypnIAKHokEQ-1; Sun, 29 Dec 2019 20:25:49 -0500
X-MC-Unique: AKttb3BqNUWypnIAKHokEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F8E800EBF;
        Mon, 30 Dec 2019 01:25:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3061081318;
        Mon, 30 Dec 2019 01:25:42 +0000 (UTC)
Date:   Mon, 30 Dec 2019 09:25:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20191230012537.GC21985@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <f49d02ee-9b36-be80-9a84-d74cfb35f796@kernel.dk>
 <b1969f9b-5b40-ed58-b020-ae0a4a328384@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1969f9b-5b40-ed58-b020-ae0a4a328384@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 29, 2019 at 05:15:49PM -0800, Bart Van Assche wrote:
> On 2019-12-29 08:14, Jens Axboe wrote:
> > On 12/28/19 7:32 PM, Ming Lei wrote:
> >> There are two issues in get_max_segment_size():
> >>
> >> 1) the default segment boudary mask is bypassed, and some devices still
> >> require segment to not cross the default 4G boundary
> >>
> >> 2) the segment start address isn't taken into account when checking
> >> segment boundary limit
> >>
> >> Fixes the two issues.
> > 
> > Given the potential severity of the bug, I think it deserves a somewhat
> > richer explanation than just that. It should also go into stable. This
> > is what I queued up:
> > 
> > https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=add1fc07334260253dfa880d9c964edc8381deac
> 
> Although this patch looks fine to me, seeing Jens' patch description
> makes me wonder whether the DMA segment boundary for the mpt3sas adapter
> should be made explicit, e.g. by setting the SCSI host .dma_boundary
> parameter in the mpt3sas driver? From the SCSI core:
> 
> 	blk_queue_segment_boundary(q, shost->dma_boundary);

See scsi_host_alloc():
		...
        /*
         * assume a 4GB boundary, if not set
         */
        if (sht->dma_boundary)
                shost->dma_boundary = sht->dma_boundary;
        else
                shost->dma_boundary = 0xffffffff;


Thanks, 
Ming

