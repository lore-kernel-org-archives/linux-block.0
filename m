Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14938C433EF
	for <linux-block@archiver.kernel.org>; Sun, 13 Feb 2022 08:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiBMIf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Feb 2022 03:35:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Feb 2022 03:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E095EDD4
        for <linux-block@vger.kernel.org>; Sun, 13 Feb 2022 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644741321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6ZlI3Dqwo4UKY7jAxIGcE0pPnnVzQTfMXYUPVsBqRU=;
        b=Un7MzgG8qfTOa+5ffJY9/ByYMpqKMOVB8lILvCqbp4c8PaYi0BJ5dgf22xp33MOTfWCDDR
        zwD+yvVf46HsAuptoyS9qfJDP8YPCYGX3LEHmDDBgVt5ZILXLFdl0hShG0gQNQPzR7kCiW
        Xh5kFIoZ6qhRv6p6tl5gVCzvUrwvtos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-uO_OP2kPOOSHrMTRfbPEAQ-1; Sun, 13 Feb 2022 03:35:18 -0500
X-MC-Unique: uO_OP2kPOOSHrMTRfbPEAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B8D814245;
        Sun, 13 Feb 2022 08:35:16 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D83D87AB63;
        Sun, 13 Feb 2022 08:34:58 +0000 (UTC)
Date:   Sun, 13 Feb 2022 16:34:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 0/7] block: improve iops limit throttle
Message-ID: <YgjCrXxdpfxKAYAD@T590>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 05:14:22PM +0800, Ming Lei wrote:
> Hello Guys,
> 
> Lining reported that iops limit throttle doesn't work on dm-thin, also
> iops limit throttle works bad on plain disk in case of excessive split.
> 
> Commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
> was for addressing this issue, but the taken approach is just to run
> post-accounting, then current split bios won't be throttled actually,
> so actual iops throttle result isn't good in case of excessive bio
> splitting.
> 
> The 1st three patches are cleanup.
> 
> The 4th patches add one new local helper of submit_bio_noacct_nocheck() for
> blk_throtl_dispatch_work_fn(), so that bios won't be throttled any more
> when blk-throttle code dispatches throttled bios.
> 
> The 5th and 6th patch makes the real difference for throttling split bio wrt.
> iops limit.
> 
> The last patch is to revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS
> throttle for large IO scenarios").
> 
> Lining has verified that iops throttle is improved much on the posted
> RFC V1 version.
> 
> V2:
> 	- remove RFC
> 	- don't add/export __submit_bio_noacct(), instead add one new local
> 	helper of submit_bio_noacct_nocheck() per Christoph's suggestion
> 
> Ming Lei (7):
>   block: move submit_bio_checks() into submit_bio_noacct
>   block: move blk_crypto_bio_prep() out of blk-mq.c
>   block: don't declare submit_bio_checks in local header
>   block: don't check bio in blk_throtl_dispatch_work_fn
>   block: throttle split bio in case of iops limit
>   block: don't try to throttle split bio if iops limit isn't set
>   block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for
>     large IO scenarios")

Hello Tejun, Chunguang and guys,

Can you give an review on this patchset? Especially the last 4 changes
on blk-throtl?


Thanks,
Ming

