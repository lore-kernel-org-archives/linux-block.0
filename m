Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F8BC10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8672076F
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daOqYi3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRLHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:07:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31289 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgCRLHh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 07:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584529656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kPEH+tInwqphKZ57t+2OCT6TWMP2t0j1ltyfG+wEr8=;
        b=daOqYi3o36tX/Rq6R66n5xvnQODZq+PRpKJkDDmZjGTT+FYwzbk3Jwd/Ro2zJ+G3BljCuf
        mrnl2a0ONdsaFa3JPyu+he2rdcHoQ/FlV1c0QiNMVVaR3QfVjg4gZU86qLYriKH+V1ovxb
        TIJtctEYnF3zN2pqEvCWZQdfJZCrAIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-IwzhO1SOPyCfK4c45xTKMw-1; Wed, 18 Mar 2020 07:07:33 -0400
X-MC-Unique: IwzhO1SOPyCfK4c45xTKMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3A8108BC2E;
        Wed, 18 Mar 2020 11:07:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3FEA196AE;
        Wed, 18 Mar 2020 11:07:20 +0000 (UTC)
Date:   Wed, 18 Mar 2020 19:07:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] block: Prevent hung_check firing during long sync IO
Message-ID: <20200318110711.GA1920@ming.t460p>
References: <20200318034336.6212-1-ming.lei@redhat.com>
 <3f8eb43f-4ad7-11f1-380c-c11969fe19ad@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8eb43f-4ad7-11f1-380c-c11969fe19ad@cloud.ionos.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 18, 2020 at 11:55:09AM +0100, Guoqing Jiang wrote:
> Hi Ming,
> 
> On 3/18/20 4:43 AM, Ming Lei wrote:
> > submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
> > may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
> > takes up to 100 second on some devices. Also any block I/O operation
> > that occurs after the BLKSECDISCARD is submitted will also potentially
> > be affected by the hung task timeouts.
> > 
> > Another report is that task hang can be observed when running mkfs
> > over raid10 which takes a small max discard sectors limit because
> > of chunk size.
> 
> Could you point the link about the raid10 task hang? And we have observed
> task hang with raid5, not sure it is related or not.
> 
> Our set up is md/raid5 -> 100+ LVs (fs is created on top of one LV), run heavy
> IOs on LVs and dbench on the LV with fs, then dbench hangs with 'D' state.

Red Hat Bugzilla 1813383.


Thanks,
Ming

