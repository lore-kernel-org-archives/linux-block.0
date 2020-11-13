Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8AC61DD8
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C812222F
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7QCONz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKMO7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMO7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 09:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605279579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zWvWfm5EC9n6yS1QRwyDfBRn8hdpgcvdl6VrZxASiI=;
        b=M7QCONz27/QpMe8aRDvIIQE+Ay58pbzRR7SBYzd7HBbVTa/jVKYS8IBuw5ddFkHcEZe6JJ
        xh/CmRqOCvzg0ngl3lKX5UTVSrfC0Y9VDZoTxU3rTzd071kiMZO/GDCFnedDCrBNTBvcow
        vQS8woT8HSz7TeeuweZczv4ehwrtaxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-fZaW6_88OhKTBYPgrkW4ow-1; Fri, 13 Nov 2020 09:59:35 -0500
X-MC-Unique: fZaW6_88OhKTBYPgrkW4ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19EDF1018F72;
        Fri, 13 Nov 2020 14:59:33 +0000 (UTC)
Received: from T590 (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71CB05D9E8;
        Fri, 13 Nov 2020 14:59:18 +0000 (UTC)
Date:   Fri, 13 Nov 2020 22:59:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rachit Agarwal <rach4x0r@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
Message-ID: <20201113145912.GA1074955@T590>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112140752.1554-1-rach4x0r@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Nov 12, 2020 at 09:07:52AM -0500, Rachit Agarwal wrote:
> From: Rachit Agarwal <rach4x0r@gmail.com>>
> 
> Hi All,
> 
> I/O batching is beneficial for optimizing IOPS and throughput for various
> applications. For instance, several kernel block drivers would benefit from batching,
> including mmc [1] and tcp-based storage drivers like nvme-tcp [2,3]. While we have
> support for batching dispatch [4], we need an I/O scheduler to efficiently enable
> batching. Such a scheduler is particularly interesting for disaggregated storage,
> where the access latency of remote disaggregated storage may be higher than local
> storage access; thus, batching can significantly help in amortizing the remote access
> latency while increasing the throughput.
> 
> This patch introduces the i10 I/O scheduler, which performs batching per hctx in terms
> of #requests, #bytes, and timeouts (at microseconds granularity). i10 starts
> dispatching only when #requests or #bytes is larger than a default threshold or when
> a timer expires. After that, batching dispatch [3] would happen, allowing batching
> at device drivers along with "bd->last" and ".commit_rqs".

blk-mq actually has built-in batching(or sort of) mechanism, which is enabled
if the hw queue is busy(hctx->dispatch_busy is > 0). We use EWMA to compute
hctx->dispatch_busy, and it is adaptive, even though the implementation is quite
coarse. But there should be much space to improve, IMO.

It is reported that this way improves SQ high-end SCSI SSD very much[1],
and MMC performance gets improved too[2].

[1] https://lore.kernel.org/linux-block/3cc3e03901dc1a63ef32e036182521af@mail.gmail.com/
[2] https://lore.kernel.org/linux-block/CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com/

> 
> The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
> scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number
> of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
> RAM block device. For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
> terms of IOPS per core over "noop" I/O scheduler. These results are available at [5],
> and many additional results are presented in [6].

In case of none scheduler, basically nvme driver won't provide any queue busy
feedback, so the built-in batching dispatch doesn't work simply.

kyber scheduler uses io latency feedback to throttle and build io batch,
can you compare i10 with kyber on nvme/nvme-tcp?

> 
> While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
> in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
> nor a need for a global tracking context, so a new scheduler is needed rather than
> to build this functionality to an existing scheduler.
> 
> We currently use fixed default values as batching thresholds (e.g., 16 for #requests,
> 64KB for #bytes, and 50us for timeout). These default values are based on sensitivity
> tests in [6]. For our future work, we plan to support adaptive batching according to

Frankly speaking, hardcode 16 #rquests or 64KB may not work everywhere,
and product environment could be much complicated than your sensitivity
tests. If possible, please start with adaptive batching.

50us timeout can be contributed to IO latency, and I'd like to see io latency
data with i10, especially i10 vs. vanilla none.


Thanks, 
Ming

