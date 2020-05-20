Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBFC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 03:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D02F2070A
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI8xrvd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgETDEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 23:04:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgETDEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 23:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589943882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R73O4aUb2p7w01cdPQS1ezbGo2TrRH6uTOtAEoGytJg=;
        b=OI8xrvd+rtFND7NoO6/+gGZtTr09IlPCATW572Ei3lxtXSZdJTaZ3aimZ5ovZdBjS8JN3c
        gfKknmZt8/SLZrDMOUFRAktmvoxSbza9dqbhAe9zV2gNDtHPdnH1CiGnHnG9y1KU/tJg2a
        6yPrJMFvj13Iam0czFPccRmT+JWC19s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-zX1buEnGN9Ke__JvbqtseA-1; Tue, 19 May 2020 23:04:37 -0400
X-MC-Unique: zX1buEnGN9Ke__JvbqtseA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9539C8018A2;
        Wed, 20 May 2020 03:04:36 +0000 (UTC)
Received: from T590 (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6085261A1;
        Wed, 20 May 2020 03:04:29 +0000 (UTC)
Date:   Wed, 20 May 2020 11:04:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200520030424.GI416136@T590>
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de>
 <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de>
 <20200518141107.GA50374@T590>
 <20200518165619.GA17465@lst.de>
 <20200519015420.GA70957@T590>
 <20200519153000.GB22286@lst.de>
 <20200520011823.GA415158@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520011823.GA415158@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 09:18:23AM +0800, Ming Lei wrote:
> On Tue, May 19, 2020 at 05:30:00PM +0200, Christoph Hellwig wrote:
> > On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
> > > As Thomas clarified, workqueue hasn't such issue any more, and only other
> > > per CPU kthreads can run until the CPU clears the online bit.
> > > 
> > > So the question is if IO can be submitted from such kernel context?
> > 
> > What other per-CPU kthreads even exist?
> 
> I don't know, so expose to wider audiences.

One user is io uring with IORING_SETUP_SQPOLL & IORING_SETUP_SQ_AFF, see
io_sq_offload_start(), and it is a IO submission kthread.

Thanks,
Ming

