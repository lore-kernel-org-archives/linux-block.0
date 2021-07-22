Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC3C63793
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80B861279
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhGVPAQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 11:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbhGVPAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626968450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LqkqyX7S/95pr5/lOuPctwyfim32Ia6rqADhZKhbKU=;
        b=WzmazJWOx79+GuucUmRMmDgwOG1yHGTiaeju65gHliJ7HZqKMpkUvF2PZrzNCJq/HCXjWL
        s/2SxhEon5CGvR04yl2qBtaLcE7zVoLzj/vMry/My6F55FyOkzRUUjmajIXrJsmnVEDbUG
        qT3ghl101PwW2VBbiqt6BVKO7wFeWWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-ItzTw8ZnPYGC3H6QLXaMpw-1; Thu, 22 Jul 2021 11:40:45 -0400
X-MC-Unique: ItzTw8ZnPYGC3H6QLXaMpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60B21940956;
        Thu, 22 Jul 2021 15:40:29 +0000 (UTC)
Received: from T590 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A3560936;
        Thu, 22 Jul 2021 15:40:23 +0000 (UTC)
Date:   Thu, 22 Jul 2021 23:40:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <YPmRY1DvFyIpQ8uM@T590>
References: <20210722095246.1240526-1-ming.lei@redhat.com>
 <20210722095246.1240526-3-ming.lei@redhat.com>
 <20210722130609.GB26872@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722130609.GB26872@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 03:06:09PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 05:52:45PM +0800, Ming Lei wrote:
> 	 and nvme rdma driver can allocate
> > +	 * and submit requests on specified hctx via
> > +	 * blk_mq_alloc_request_hctx
> 
> Why does that matter for this setting?

blk_mq_alloc_request_hctx() has been broken for long time, which
can only work if the hctx isn't driven by non-managed irq.


Thanks,
Ming

