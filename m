Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F5C352A2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4F214AF
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 13:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bytdz/ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGNF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:05:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgBGNF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Feb 2020 08:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581080727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G209Wv5MQavy/7/DC938A8QVxwiqMrb8NkT5S9IRXUs=;
        b=Bytdz/tiTz79Ro4jX9qyLB+xuNaFU6b/PKzQGotQ+8SvVkY4gomgqL8PO11g7WOvUTOPcF
        cCUDROBzbOEi4RfU2jzVa86n1zlQ4SAwADfH8gbxZcWzzcb0KGX+42KzYsszoyC3jtU0na
        0I8jKUrhkQd8CwcvYEqClGj8aUwQlGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-FZT0AXHfO42pDE-QipJceg-1; Fri, 07 Feb 2020 08:05:24 -0500
X-MC-Unique: FZT0AXHfO42pDE-QipJceg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B961C801A06;
        Fri,  7 Feb 2020 13:05:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A4577931;
        Fri,  7 Feb 2020 13:04:50 +0000 (UTC)
Date:   Fri, 7 Feb 2020 21:04:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        ajay.joshi@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, luoshijie1@huawei.com
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
Message-ID: <20200207130446.GA14465@ming.t460p>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <20200207093012.GA5905@ming.t460p>
 <1f2fb027-1d62-2a52-9956-7847fa1baf96@huawei.com>
 <63873791-e303-aece-94c5-efb2a6976363@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63873791-e303-aece-94c5-efb2a6976363@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 07, 2020 at 08:24:59PM +0800, yukuai (C) wrote:
> On 2020/2/7 18:26, yukuai (C) wrote:
> > The reason of the problem is because the final release of request_queue
> > may be called after loop_remove() returns.
> 
> The description is not accurate. The reason of the problem is that
> __blk_trace_setup() called before the final release of request_queue
> returns.(step 4 before step 5)

But blk_mq_debugfs_register() in your step 3 for adding loop still may
fail, that is why I suggest to consider to move
blk_mq_debugfs_register() into blk_unregister_queue().


Thanks,
Ming

