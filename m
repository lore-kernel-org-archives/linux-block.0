Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F673C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 00:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiCBAqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCBAqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 19:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7028A5F24A
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 16:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646181962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9GiUqB4Tu/RCAi83nCkYUeMANtbdClO14LgMa0o8fw=;
        b=gLhPHeTcL6v+poFDm5eF/0Tlk7u+sOD0an87O968WrsCsQusks0pJmJKJfclCWqzQqLIJv
        NqKtO/lYMrKgat7VOU+kpjnE1Y1kSb8QKcGLv0MOd+1HsuyIess8jKkHfGUzC0y87xwW3p
        IvM4C3fvi57arwh0vZMCRyV7sH9lDSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-DlvziJF8OfC_0xRYsyzhyg-1; Tue, 01 Mar 2022 19:45:55 -0500
X-MC-Unique: DlvziJF8OfC_0xRYsyzhyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7361006AA6;
        Wed,  2 Mar 2022 00:45:53 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DBC7F7E2;
        Wed,  2 Mar 2022 00:45:22 +0000 (UTC)
Date:   Wed, 2 Mar 2022 08:45:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/3] block/dm: support bio polling
Message-ID: <Yh6+HUBnx62CUCSu@T590>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
 <Yhz4AGXcn0DUeSwq@redhat.com>
 <Yh1vrWXlaTnEcrNd@T590>
 <Yh6N7msbMBcANFxg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh6N7msbMBcANFxg@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 01, 2022 at 04:19:42PM -0500, Mike Snitzer wrote:
> On Mon, Feb 28 2022 at  7:58P -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Mon, Feb 28, 2022 at 11:27:44AM -0500, Mike Snitzer wrote:
> > > 
> > > Hey Ming,
> > > 
> > > I'd like us to follow-through with adding bio-based polling support.
> > > Kind of strange none of us that were sent this V3 ever responded,
> > > sorry about that!
> > > 
> > > Do you have interest in rebasing this patchset (against linux-dm.git's
> > > "dm-5.18" branch since there has been quite some churn)?  Or are you
> > > OK with me doing the rebase?
> > 
> > Hi Mike,
> > 
> > Actually I have one local v5.17 rebase:
> > 
> > https://github.com/ming1/linux/tree/my_v5.17-dm-io-poll
> > 
> > Also one for-5.18/block rebase which is done just now:
> > 
> > https://github.com/ming1/linux/tree/my_v5.18-dm-bio-poll
> > 
> > In my previous test on v5.17 rebase, the IOPS improvement is a bit small,
> > so I didn't post it out. Recently not get time to investigate
> > the performance further, so please feel free to work on it.
> 
> OK, I've rebased it on dm-5.18.
> 
> Can you please share the exact test(s) you were running?  I assume you
> were running directly against a request-based device and then
> comparing polling perf through dm-linear to the same underlying
> request-based device?

I run io_uring over dm-linear and dm-stripe, over two nvme disks with
2 poll_queues.

IOPS improvement can be observed, but not big.

Thanks,
Ming

