Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF9C77B75
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 00:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEXAcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXAcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 20:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50D9C2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684888315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ks7rB47/Z5Xm+9sUr74193MomCGEYY/A+4iRfpxJcxM=;
        b=FrL16lVKXWthrWZ6Zu8AdDjGhmXyqaCsQiynPap9VvYdH6DLJnnm02N0Hoq+A3gnpu9W6P
        k2EUR1At4vIGkv4nkMspcZFN2mrBqY8cSZWhY4qCA7dve77LLmwkp0RrqRuTYK6Xmrl7gH
        AKy9hiAYIDtReRD12/NAZx2uIxLtatU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-oswvAzyZO5ulNrwUr6Rnow-1; Tue, 23 May 2023 20:31:50 -0400
X-MC-Unique: oswvAzyZO5ulNrwUr6Rnow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7311C05147;
        Wed, 24 May 2023 00:31:49 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 674CD20296C6;
        Wed, 24 May 2023 00:31:43 +0000 (UTC)
Date:   Wed, 24 May 2023 08:31:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, ming.lei@redhat.com
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Message-ID: <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 10:19:34AM -0700, Bart Van Assche wrote:
> On 5/23/23 02:03, Ming Lei wrote:
> > On Mon, May 22, 2023 at 11:38:37AM -0700, Bart Van Assche wrote:
> > > Send requeued requests to the I/O scheduler such that the I/O scheduler
> > > can control the order in which requests are dispatched.
> > 
> > I guess you are addressing UFS zoned for REQ_OP_WRITE:
> > 
> > https://lore.kernel.org/linux-block/8e88b22e-fdf2-5182-02fe-9876e8148947@acm.org/
> > 
> > I am wondering how this way can maintain order for zoned write request.
> > 
> > requeued WRITE may happen in any order, for example, req A and req B is
> > in order, now req B is requeued first, then follows req A.
> > 
> > So req B is requeued to scheduler first, and issued to LLD, then
> > request A is requeued and issued to LLD later, then still re-order?
> > 
> > Or sd_zbc can provide requeue order guarantee?
> 
> Hi Ming,
> 
> The mq-deadline scheduler restricts the queue depth to one per zone for zoned
> storage so at any time there is at most one write command (REQ_OP_WRITE) in
> flight per zone.

But if the write queue depth is 1 per zone, the requeued request won't
be re-ordered at all given no other write request can be issued from
scheduler in this zone before this requeued request is completed.

So why bother to requeue the BLK_STS_RESOURCE request via scheduler?

Thanks,
Ming

