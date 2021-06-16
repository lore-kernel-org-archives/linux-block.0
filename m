Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4AC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A9461107
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 14:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhFPOOh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233868AbhFPOOb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 10:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623852714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNQxvpVw4oQJcTtl1E2dEswnYQenc04TCbcdv2AY5Yk=;
        b=Ja+BmASWsK7wdin6X7nA1dgp5Db62q3d3IEYZG3zSzgWN7Z/Jozqc78p+9evSA0vt4yfG4
        afLrYZZ7Xpp5T3Y1oiUprhWZdcL3jUmB/w5X8AdBVMW9qX2IVMP53kQxF+EUQmoLfMVJH/
        8fPe8LQYqzuD5cP5qBn5G6dAs5Q4yCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-_G-aMhvqPCiMQ-hEESRVcQ-1; Wed, 16 Jun 2021 10:11:50 -0400
X-MC-Unique: _G-aMhvqPCiMQ-hEESRVcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A20619611A7;
        Wed, 16 Jun 2021 14:11:49 +0000 (UTC)
Received: from T590 (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 581A810AFE96;
        Wed, 16 Jun 2021 14:11:39 +0000 (UTC)
Date:   Wed, 16 Jun 2021 22:11:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 0/2] block: fix race between adding wbt and normal IO
Message-ID: <YMoGlzLE2kUyaHlC@T590>
References: <20210609015822.103433-1-ming.lei@redhat.com>
 <YMfQSAT4hMDmdumY@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMfQSAT4hMDmdumY@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 05:55:20AM +0800, Ming Lei wrote:
> On Wed, Jun 09, 2021 at 09:58:20AM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Yi reported several kernel panics on:
> > 
> > [16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > ...
> > [16687.163549] pc : __rq_qos_track+0x38/0x60
> > 
> > or
> > 
> > [  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> > ...
> > [  997.850347] pc : __rq_qos_done+0x2c/0x50
> > 
> > Turns out it is caused by race between adding wbt and normal IO.
> > 
> > Fix the issue by freezing request queue when adding/deleting rq qos.
> > 
> > V3:
> > 	- use ->queue_lock for protecting concurrent adding/deleting rqos on
> > 	  same queue
> > 
> > V2:
> > 	- switch to the approach of freezing queue, which is more generic
> > 	  than V1.
> > 
> > 
> > 
> > Ming Lei (2):
> >   block: fix race between adding/removing rq qos and normal IO
> >   block: mark queue init done at the end of blk_register_queue
> > 
> >  block/blk-rq-qos.h | 24 ++++++++++++++++++++++++
> >  block/blk-sysfs.c  | 29 +++++++++++++++--------------
> >  2 files changed, 39 insertions(+), 14 deletions(-)
> > 
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> 
> Hello Jens,
> 
> Any chance to merge the fixes if you are fine?

Hi Jens,

Yi finds that the issue can be triggered in his more tests, and
has escalate it in RH BZ, can we fix the issue?


Thanks,
Ming

