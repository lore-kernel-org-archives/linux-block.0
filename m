Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B8C35642
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146AD2071E
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxDai5Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgBUIsJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:48:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728280AbgBUHr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 02:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582271248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OGuPwMfMiavp4ic2KSY0kzgjuZEfAnQxEHrP11AHCuA=;
        b=SxDai5XfcNwPCQcQipBeeX0poGQPoJSSB4lAGhsuuU0kszAzAKgOtRH0FM1uMTam43CF7g
        5x+XLPhoqHhaKwFBdrsf2OvKzttLCm1BCZPJ9enUeWMTNK7f+CiDBOMHW42GaRg48EhcxA
        bnHHoJLHIpEuH2w3VYDY5O5q/ZOBIoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-UymqvszUNhCyeoq8v4e9IA-1; Fri, 21 Feb 2020 02:47:20 -0500
X-MC-Unique: UymqvszUNhCyeoq8v4e9IA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7249A0CBF;
        Fri, 21 Feb 2020 07:47:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E9C5C553;
        Fri, 21 Feb 2020 07:47:12 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:47:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 1/4] block: fix use-after-free on cached last_lookup
 partition
Message-ID: <20200221074707.GA2156@ming.t460p>
References: <20200109062109.2313-1-ming.lei@redhat.com>
 <20200109062109.2313-2-ming.lei@redhat.com>
 <5eb26a32-d2b2-e2c3-52e2-591cf626a1ff@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb26a32-d2b2-e2c3-52e2-591cf626a1ff@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 20, 2020 at 08:03:52PM -0800, Bart Van Assche wrote:
> On 2020-01-08 22:21, Ming Lei wrote:
> > delete_partition() clears the cached last_lookup partition. However
> > the .last_lookup cache may be overwritten by one IO path after
> > it is cleared from delete_partition(). Then another IO path may
> > use the cached deleting partition after __delete_partition() is
> > called, then use-after-free is triggered on the cached partition.
> > 
> > Fixes the issue by the following approach:
> > 
> > 1) always get the partition's refcount via hd_struct_try_get() before
> > setting .last_lookup
> > 
> > 2) move clearing .last_lookup from delete_partition() to
> > __delete_partition() which is release handle of the partition's
> > percpu-refcount, so that no IO path can overwrite .last_lookup after it
> > is cleared in __delete_partition().
> > 
> > It is one candidate approach of Yufen's patch[1] which adds overhead
> > in fast path by indirect lookup which may introduce one extra cacheline
> > in IO path. Also this patch relies on percpu-refcount's protection, and
> > it is easier to understand and verify.
> > 
> > [1] https://lore.kernel.org/linux-block/20200109013551.GB9655@ming.t460p/T/#t
> 
> Hi Ming,
> 
> disk_map_sector_rcu() is called from the I/O path only and hence with
> q->q_usage_counter > 0. Has it been considered to freeze disk->queue
> from delete_partition() before deleting a partition and unfreezing
> disk->queue after partition deletion has finished? Would that approach
> allow to eliminate partition reference counting and thereby improve the
> performance of the hot path?

Hi Bart,

I did consider that approach, but this way may cause performance
regression, given deleting any partition drops IO performance a lot
on other un-related partitions.



Thanks,
Ming

