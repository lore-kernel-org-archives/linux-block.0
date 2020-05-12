Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22373C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E8B20675
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhLkzo/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgELBZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 21:25:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725881AbgELBZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 21:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589246725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGcFcrJDjHyhzOYAmgmxS2YDh5J0l2YE8WFB1MT98CE=;
        b=RhLkzo/7sG7og/5iuh3tPkn33fCOhx9uv0MRNrahZLrrWgAI68hfSOeCon0PZEaVKMNaKb
        bdf/FKifsEtqSTjEXfcmysRQzqeG5VN5irBbxyMPC5DT/DUOrR8Ha8t776FbcMKEAJP0F6
        B/rAFEg8jxVvEAJUBZDKCjAwPni/F98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-COHSH0zpMy21QG3AesPPjg-1; Mon, 11 May 2020 21:25:23 -0400
X-MC-Unique: COHSH0zpMy21QG3AesPPjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09105100A8E9;
        Tue, 12 May 2020 01:25:22 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DBE1000329;
        Tue, 12 May 2020 01:25:14 +0000 (UTC)
Date:   Tue, 12 May 2020 09:25:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200512012510.GA1531898@T590>
References: <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
 <20200509022051.GC1392681@T590>
 <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
 <20200509041042.GG1392681@T590>
 <1918187b-2baa-5703-63ee-097a307cf594@acm.org>
 <20200511014538.GB1418834@T590>
 <8ef5352b-a1bb-a3c1-3ad2-696df6e86f1f@acm.org>
 <20200511034827.GD1418834@T590>
 <832f5935-19f5-8dcf-baee-ad61f0c5d966@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <832f5935-19f5-8dcf-baee-ad61f0c5d966@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 01:56:49PM -0700, Bart Van Assche wrote:
> On 2020-05-10 20:48, Ming Lei wrote:
> > On Sun, May 10, 2020 at 08:20:24PM -0700, Bart Van Assche wrote:
> >> What I meant is to freeze a request queue temporarily.
> > 
> > But what is your motivation to freeze queue temporarily?
> 
> To achieve a solution for CPU hotplugging that is much simpler than this
> patch series, requires less code and hence is easier to test, debug and
> maintain.

Yeah, it can be done by queue freezing in the following way:

1) before one cpu is offline

- if one hctx becomes inactive, then freeze the whole queue and
wait for freezing done

2) after one cpu is offline
- un-freeze the request queue if any hctx is inactive

The whole disk becomes unusable during the period, which can
be quite long, because freezing queue & wait for freezing done takes
at least one RCU grace period even though there isn't any in-flight
IO.

And the above steps need to be run for every request queue in serialized
way, so the whole time of suspending IO can be very long. That isn't
reasonable.

Thanks,
Ming

