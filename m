Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12343C33CB3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3AE207E0
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 09:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3+AZHlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgAPJEI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:04:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58461 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726752AbgAPJEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579165446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uq7CJP6ErsEJycjsCTDTuQWMus4wprdzivApMYpPR8Y=;
        b=J3+AZHlRLV0Ko9FzOBdkWB6XiSFzLsNgTH6Ajweb4a0hHLwjYeq33GZxxYqhFwNHjEYDIY
        jdHfOvy0F0pbuUu6m1/4GzvfKQlVty0yevEI1R4+z+dqQlcK/ITWoixytt8CYwdMC02kXB
        SluiDejQ0o8JJelF33oS6DKrBa9dCQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-kMrcA-dSO96pcFTwt3z2Eg-1; Thu, 16 Jan 2020 04:04:00 -0500
X-MC-Unique: kMrcA-dSO96pcFTwt3z2Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A64118CA270;
        Thu, 16 Jan 2020 09:03:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40CB184668;
        Thu, 16 Jan 2020 09:03:51 +0000 (UTC)
Date:   Thu, 16 Jan 2020 17:03:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        john.garry@huawei.com, "axboe@kernel.dk" <axboe@kernel.dk>,
        hare@suse.de, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [Question] abort shared tags for SCSI drivers
Message-ID: <20200116090347.GA7438@ming.t460p>
References: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 16, 2020 at 12:06:02PM +0800, Yufen Yu wrote:
> Hi, all
> 
> Shared tags is introduced to maintains a notion of fairness between
> active users. This may be good for nvme with multiple namespace to
> avoid starving some users. Right?

Actually nvme namespace is LUN of scsi world.

Shared tags isn't for maintaining fairness, it is just natural sw
implementation of scsi host's tags, since every scsi host shares
tags among all LUNs. If the SCSI host supports real MQ, the tags
is hw-queue wide, otherwise it is host wide.

> 
> However, I don't understand why we introduce the shared tag for SCSI.
> IMO, there are two concerns for scsi shared tag:
> 
> 1) For now, 'shost->can_queue' is used as queue depth in block layer.
> And all target drivers share tags on one host. Then, the max tags for
> each target can get:
> 
> 	depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> But, each target driver may have their own capacity of tags and queue depth.
> Does shared tag limit target device bandwidth?

No, if the 'target driver' means LUN, each LUN hasn't its independent
tags, maybe it has its own queue depth, which is often for maintaining
fairness among all active LUNs, not real queue depth. 

You may see the patches[1] which try to bypass per-LUN queue depth for SSD.

[1] https://lore.kernel.org/linux-block/20191118103117.978-1-ming.lei@redhat.com/

> 
> 2) When add new target or remove device, it may need to freeze other device
> to update hctx->flags of BLK_MQ_F_TAG_SHARED. That may hurt performance.

Add/removing device isn't a frequent event, so it shouldn't be a real
issue, or you have seen effect on real use case?

> 
> Recently we discuss abort hostwide shared tags for SCSI[0] and sharing tags
> across hardware queues[1]. These discussion are abort shared tag. But, I
> confuse whether shared tag across hardware queues can solve my concerns as mentioned.

Both [1] and [0] are for converting some single queue SCSI host into MQ
because these HBAs support multiple reply queue for completing request,
meantime they only have single tags(so they are SQ driver now). So far
not many such kind of hardwares(HPSA, hisi sas, megaraid_sas, ...).


Thanks, 
Ming

