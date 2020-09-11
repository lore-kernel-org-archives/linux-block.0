Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFBC43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E37622206
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV8jvFqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKLB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgIKLBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 07:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599822077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7DWGAMGUlghK8Ts0hwYNJ0yHHg/yrlXBfF1FNO88LE=;
        b=EV8jvFqRWSaej0u3o3PUBfHlwZFj+VjxGQNj4GL14AVIQRatuGK6mR4ph8zp8edMFh9AjL
        16VRRAIGw702vzvnUaQLBz/0vrr2IwMz8i3pqfCC8AsEGeccV0D2OUFzlm8aOtaslR5PQZ
        ctMXSNGcGtBB3d7A1iJTCQLVL0D4Wo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-q9-T0QvmP0O1BFUvNBSUDA-1; Fri, 11 Sep 2020 07:01:15 -0400
X-MC-Unique: q9-T0QvmP0O1BFUvNBSUDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006571074640;
        Fri, 11 Sep 2020 11:01:14 +0000 (UTC)
Received: from T590 (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C846D5D9E8;
        Fri, 11 Sep 2020 11:01:05 +0000 (UTC)
Date:   Fri, 11 Sep 2020 19:01:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [RFC] block: enqueue splitted bios into same cpu
Message-ID: <20200911110101.GA143560@T590>
References: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 11:29:58AM +0800, Jeffle Xu wrote:
> Splitted bios of one source bio can be enqueued into different CPU since
> the submit_bio() routine can be preempted or fall asleep. However this
> behaviour can't work well with iopolling.

Do you have user visible problem wrt. io polling? If yes, can you
provide more details?

> 
> Currently block iopolling only polls the hardwar queue of the input bio.
> If one bio is splitted to several bios, one (bio 1) of which is enqueued
> into CPU A, while the others enqueued into CPU B, then the polling of bio 1
> will cotinuously poll the hardware queue of CPU A, though the other
> splitted bios may be in other hardware queues.

If it is guaranteed that the returned cookie is from bio 1, poll is
supposed to work as expected, since bio 1 is the chained head of these
bios, and the whole fs bio can be thought as done when bio1 .end_bio
is called.

> 
> The iopolling logic has no idea if the input bio is splitted bio, or if
> it has other splitted siblings. Thus ensure that all splitted bios are
> enqueued into one CPU at the beginning.

Yeah, that is why io poll can't work on DM.

> 
> This is only one RFC patch and it is not complete since dm/mq-scheduler
> have not been considered yet. Please let me know if it is on the correct
> direction or not.
> 
> Besides I have one question on the split routine. Why the split routine
> is implemented in a recursive style? Why we can't split the bio one time
> and then submit the *already splitted* bios one by one?

Forward progress has to be provided on new splitted bio allocation which
is from same bio_set.


Thanks, 
Ming

