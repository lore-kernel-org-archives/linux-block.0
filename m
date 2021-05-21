Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65636C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F69261244
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEUNN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 09:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhEUNNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621602749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PoQu4/RJUKE4oJ7zZaBjFI6JNdpGnPnDJZVJlZEylVU=;
        b=CbGiMN8oi4KXh+JJmUjJbwVq/us6ApI3oD7WWVqchA4khze8QHU6r+JOB1hRo4JOMZ+lUQ
        rnKmFkLaMVL+PUfEvmsE7FOGEhffiy+G3mPo0crldha+c7e90iBMdbwAYXD/vzeBHqwdxN
        ayTE5CFTwQecjYwMn4ybDE2yPNag73A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-c8M2MgEtNS-kl1yZo1D1Qw-1; Fri, 21 May 2021 09:12:27 -0400
X-MC-Unique: c8M2MgEtNS-kl1yZo1D1Qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000CB107ACC7;
        Fri, 21 May 2021 13:12:25 +0000 (UTC)
Received: from T590 (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30A175D74B;
        Fri, 21 May 2021 13:12:18 +0000 (UTC)
Date:   Fri, 21 May 2021 21:12:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 1/2] block: Do not merge recursively in
 elv_attempt_insert_merge()
Message-ID: <YKexrshH5i7mvF6U@T590>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-2-jack@suse.cz>
 <YKcB6Hxhe3a1St31@T590>
 <20210521115354.GJ18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521115354.GJ18952@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:53:54PM +0200, Jan Kara wrote:
> On Fri 21-05-21 08:42:16, Ming Lei wrote:
> > On Fri, May 21, 2021 at 12:33:52AM +0200, Jan Kara wrote:
> > > Most of the merging happens at bio level. There should not be much
> > > merging happening at request level anymore. Furthermore if we backmerged
> > > a request to the previous one, the chances to be able to merge the
> > > result to even previous request are slim - that could succeed only if
> > > requests were inserted in 2 1 3 order. Merging more requests in
> > 
> > Right, but some workload has this kind of pattern.
> > 
> > For example of qemu IO emulation, it often can be thought as single job,
> > native aio, direct io with high queue depth. IOs is originated from one VM, but
> > may be from multiple jobs in the VM, so bio merge may not hit much because of IO
> > emulation timing(virtio-scsi/blk's MQ, or IO can be interleaved from multiple
> > jobs via the SQ transport), but request merge can really make a difference, see
> > recent patch in the following link:
> > 
> > https://lore.kernel.org/linux-block/3f61e939-d95a-1dd1-6870-e66795cfc1b1@suse.de/T/#t
> 
> Oh, request merging definitely does make a difference. But the elevator
> hash & merge logic I'm modifying here is used only by BFQ and MQ-DEADLINE
> AFAICT. And these IO schedulers will already call blk_mq_sched_try_merge()
> from their \.bio_merge handler which gets called from blk_mq_submit_bio().
> So all the merging that can happen in the code I remove should have already
> happened. Or am I missing something?

There might be at least two reasons:

1) when .bio_merge() is called, some requests are kept in plug list, so
the bio may not be merged to requests in scheduler queue; when flushing plug
list and inserts these requests to scheduler queue, we have to try to
merge them further

2) only blk_mq_sched_try_insert_merge() is capable of doing aggressive
request merge, such as, when req A is merged to req B, the function will
continue to try to merge req B with other in-queue requests, until no
any further merge can't be done; neither blk_mq_sched_try_merge() nor
blk_attempt_plug_merge can do such aggressive request merge.



Thanks,
Ming

