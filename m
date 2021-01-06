Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFCC433DB
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 01:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F9D22D01
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 01:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFBa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbhAFBa0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 20:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609896540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPjM48LYwo/2lrxz087iNT8OSJza9ZbVDyEFZXhhW78=;
        b=WfKu4m8cI/+7yvwJngR3G2eoOHZ8+RdFoQkQFYnrnD8etcbB5xwDZIvWliQekATrW8Sl6E
        9wYyXoLgPRNghbbtgyxT9tUzxlO1uWE3OMqTkkNgqHZliw9UEILtaQTaYcMXZpSwdN3A6b
        XhLEuCU7FHxp1zM1FMDX8Vik22LTuw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-_hy-AiM8OM2TKx69BohpIA-1; Tue, 05 Jan 2021 20:28:56 -0500
X-MC-Unique: _hy-AiM8OM2TKx69BohpIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F5B41842141;
        Wed,  6 Jan 2021 01:28:55 +0000 (UTC)
Received: from T590 (ovpn-12-253.pek2.redhat.com [10.72.12.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28ED17092E;
        Wed,  6 Jan 2021 01:28:44 +0000 (UTC)
Date:   Wed, 6 Jan 2021 09:28:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared
 in hctx_may_queue
Message-ID: <20210106012839.GA3821988@T590>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
 <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
 <20210105022017.GA3594357@T590>
 <bcbe4b32-a819-8423-1849-e9a7db7fcde8@huawei.com>
 <20210105111850.GB3619109@T590>
 <c4aa932f-6ede-ab58-0d66-a7d4a61010ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4aa932f-6ede-ab58-0d66-a7d4a61010ff@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 05, 2021 at 11:38:48AM +0000, John Garry wrote:
> On 05/01/2021 11:18, Ming Lei wrote:
> > > > > ot set normally..
> > > > It always return true, and might just take a bit more CPU especially the tag queue
> > > > depth of magsas_raid and hisi_sas_v3 is quite high.
> > > Hi Ming,
> > > 
> > > Right, but we actually tested by hacking the host tag queue depth to be
> > > lower such that we should have tag contention, here is an extract from the
> > > original series cover letter for my results:
> > > 
> > > Tag depth 		4000 (default)		260**
> > > 
> > > Baseline (v5.9-rc1):
> > > none sched:		2094K IOPS		513K
> > > mq-deadline sched:	2145K IOPS		1336K
> > > 
> > > Final, host_tagset=0 in LLDD *, ***:
> > > none sched:		2120K IOPS		550K
> > > mq-deadline sched:	2121K IOPS		1309K
> > > 
> > > Final ***:
> > > none sched:		2132K IOPS		1185		
> > > mq-deadline sched:	2145K IOPS		2097	
> > > 
> > > Maybe my test did not expose the issue. Kashyap also tested this and
> > > reported the original issue such that we needed this feature, so I'm
> > > confused.
> 
> Hi Ming,
> 
> > How many LUNs are involved in above test with 260 depth?
> 
> For me, there was 12 SAS SSDs; for convenience here is the cover letter with
> details:
> https://lore.kernel.org/linux-block/1597850436-116171-1-git-send-email-john.garry@huawei.com/
> 
> IIRC, for megaraid sas, Kashyap used many more LUNs for testing (64) and
> high fio depth (128) but did not reduce .can_queue, topic originally raised
> here:
> https://lore.kernel.org/linux-block/29f8062c1fccace73c45252073232917@mail.gmail.com/

OK, in both tests, nr_luns are big enough wrt. 260 depth. Maybe that is
why very low IOPS is observed in 'Final(hosttag=1)' with 260 depth.

I'd suggest to run your previous test again after applying this patch,
and see if difference can be observed.

-- 
Ming

