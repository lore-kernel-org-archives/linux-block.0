Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608CC433E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 03:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C4F206F6
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 03:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHS4k8KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgG0Duw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:50:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53098 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbgG0Duv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 23:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595821850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pAM0Zmv2QoUOAi07IeWvi0mIrJEh5DbB2DkMIwNm64=;
        b=NHS4k8KEsfIKr5NSJ10sdeS2aWxNwlnl6vYeXYA5N/aMGKf+pLtCBwy7iqVfFUoMOJHS0v
        +MUo/Zo0rGVmB0UWrdeTb6cwRR9xNZ+Gudih7oj8+nK44BzQueUhT6SQpCltLb0b2EyPsj
        GG7Nfk8hUNjzxfgxJYQAcfWYx7RXHy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-AGFhF_-bNwWwSq5HNf1UWw-1; Sun, 26 Jul 2020 23:50:46 -0400
X-MC-Unique: AGFhF_-bNwWwSq5HNf1UWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7976680183C;
        Mon, 27 Jul 2020 03:50:44 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D158FA35;
        Mon, 27 Jul 2020 03:50:37 +0000 (UTC)
Date:   Mon, 27 Jul 2020 11:50:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727035033.GD1129253@T590>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/27 10:08, Ming Lei wrote:
> > > It is at the end and contains exactly what is needed to synchronize. Not
> > The sync is simply single global synchronize_rcu(), and why bother to add
> > extra >=40bytes for each hctx.
> > 
> > > sure what you mean by reuse hctx->srcu?
> > You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> > to each hctx for just simulating one single synchronize_rcu().
> 
> To sync srcu together, the extra bytes must be needed, seperate blocking
> and non blocking queue to two hctx may be a not good choice.
> 
> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
> not need if which do not need batch sync srcu, I still think it's better
> for the SRCU to provide the batch synchronization interface.

The 'struct rcu_synchronize' can be allocated from heap or even stack(
if no too many NSs), which is just one shot sync and the API is supposed
to be called in slow path. No need to allocate it as long lifetime variable.
Especially 'struct srcu_struct' has already been too fat.


Thanks, 
Ming

