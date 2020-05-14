Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC127C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3E0205ED
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvdZjSvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbgENAd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 20:33:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732844AbgENAd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589416438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEfeJQVnh83lgWxO0Khzps4UYnwxzvvtaf6sh4pyaX4=;
        b=gvdZjSvQbpWI5kz90RdxN7cPw/Z02TtgX1fyfOekh5sShbtBZvqb862fzP73Wqb9s4wfii
        YXhTAKGE3reAnihzVpQKcBGvdPojzrem2/lz6+qzWXmxf8Brqh/Hl7J/eL1jgf94H06dNp
        hdGnJQpCWF6+36OGYOZYX5F+E9elVJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-qdrIUAt6MvCMzn1p745weQ-1; Wed, 13 May 2020 20:33:56 -0400
X-MC-Unique: qdrIUAt6MvCMzn1p745weQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C2BEC1B0;
        Thu, 14 May 2020 00:33:54 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C9E360C05;
        Thu, 14 May 2020 00:33:46 +0000 (UTC)
Date:   Thu, 14 May 2020 08:33:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 06/12] blk-mq: prepare for draining IO when hctx's
 all CPUs are offline
Message-ID: <20200514003340.GA2073570@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-7-ming.lei@redhat.com>
 <20200513115832.GB6297@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513115832.GB6297@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 01:58:32PM +0200, Christoph Hellwig wrote:
> I think the flag should be inverted, indicated managed irqs if set.
> And we should fine a a way to automatically set it from the managed
> IRQ blk_mq_*_map_queues helpers instead of leaving the decisions to

blk_mq_*_map_queues doesn't tell us if managed IRQ is used, only the
driver knows that.

> the driver author that is most likely going to get it wrong, especially
> for SCSI, where the actual driver can't even get at the current flag.
> 

BLK_MQ_F_NO_MANAGED_IRQ is just for avoiding deadlock in draining IO
during cpu hotplug. So far, only stacking blk-mq drivers need this flag.

That is why the flag is named as NO_MANAGED_IRQ, or we may add flag of
BLK_MQ_F_STACKING for this purpose too.

thanks,
Ming

