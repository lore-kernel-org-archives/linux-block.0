Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F3C4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 00:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5E2310C
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 00:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394095AbgLKAXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391159AbgLKAX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 19:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607646120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpTMTphjO/oim15KCL6ORgEfW4SV00cbVBa5mHFRiDU=;
        b=D4u+dhC4hHdolop548Uk/YW+k18QI5vRAA9xQSbnt4mugtHx9kralbYbuKmOKVD1pKzmzh
        k5WowXnEe0/DpTbLctZHDSS0+DaNLzHtWCh2H/QL69jiuZd98Ktr4LFc07gN7qoPKyCsMp
        bnZFHZ2QH0V5LAlaWo1FS1+6krlpDJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-uDwf87uhMc2z3YFWa96RGA-1; Thu, 10 Dec 2020 19:21:58 -0500
X-MC-Unique: uDwf87uhMc2z3YFWa96RGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A313E801817;
        Fri, 11 Dec 2020 00:21:56 +0000 (UTC)
Received: from T590 (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6636F984;
        Fri, 11 Dec 2020 00:21:48 +0000 (UTC)
Date:   Fri, 11 Dec 2020 08:21:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, hare@suse.de,
        ppvk@codeaurora.org, bvanassche@acm.org, kashyap.desai@broadcom.com
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
Message-ID: <20201211002143.GA1495739@T590>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
 <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
 <20201209010102.GA1217988@T590>
 <13327a68-6f86-96da-0c5f-5fa0be326d6f@huawei.com>
 <20201210020745.GA1363446@T590>
 <d8500ca2-1f26-7d28-6baa-237284df0a5c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8500ca2-1f26-7d28-6baa-237284df0a5c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 10, 2020 at 10:44:54AM +0000, John Garry wrote:
> Hi Ming,
> 
> On 10/12/2020 02:07, Ming Lei wrote:
> > > Apart from this, my concern is that we come with for a solution, but it's a
> > > complicated solution and may not be accepted as this issue is not seen as a
> > > problem in practice.
> > If that is the case, I'd suggest to consider the solution in the
> > following link:
> > 
> > https://lore.kernel.org/linux-block/20200820180335.3109216-1-ming.lei@redhat.com/
> > 
> > At least, the idea is simple, which can be extended to support allocate driver tags
> > request pool dynamically.
> 
> As I see with your approach, we may still iterate a stale request, but it
> just has not been freed, so just no use-after-free BUG, right? Rather it is
> cached until all references dropped. It may be best solution.

The approach just need to read the stale request pointer, and won't
access any field of that request, so no UAF. Yeah, the stale request
won't be freed until when the reference from request pool is dropped.



Thanks,
Ming

