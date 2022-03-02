Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9005EC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiCBJXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiCBJXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 04:23:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D3F826576
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 01:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646212953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5cv9ckMyAQvycmj3ygMnBxgnwglX3QuVv5vqKkm/T3I=;
        b=VPOfbluEX8qG9m+x4zX57SDrtOwL7hTCMbgA7NBZPTqbTfGlDU5C+CH2ShCsoOHHwR8QGG
        /bATxaKGCWjtqvJbetHvvNVNuxDueAiSFxUqt4nyyaKNrnJXvw6sqSZa9bK0qRv8lAwr4m
        Ky969vTL5aK0xRVwjIJMDnexfGJfdbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-t28vn2JUNvGx2M6WCQwLPQ-1; Wed, 02 Mar 2022 04:22:30 -0500
X-MC-Unique: t28vn2JUNvGx2M6WCQwLPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74FC21091DA0;
        Wed,  2 Mar 2022 09:22:29 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED0583172;
        Wed,  2 Mar 2022 09:22:14 +0000 (UTC)
Date:   Wed, 2 Mar 2022 17:22:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
Message-ID: <Yh83Qma/MYWBNwiN@T590>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
 <45adf246-176a-b4a5-d973-4c885c37d821@huawei.com>
 <Yh7MqBLsE2FJvT2Z@T590>
 <7d112d9f-6ab1-4f8e-6005-b940074f1071@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d112d9f-6ab1-4f8e-6005-b940074f1071@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 09:02:53AM +0000, John Garry wrote:
> On 02/03/2022 01:47, Ming Lei wrote:
> > > >    static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
> > > >    					       unsigned int hctx_idx,
> > > >    					       unsigned int nr_tags,
> > > >    					       unsigned int reserved_tags)
> > > >    {
> > > >    	struct blk_mq_tags *tags;
> > > > -	int node;
> > > > +	int node = blk_mq_get_hctx_node(set, hctx_idx);
> > > nit: the code originally had reverse firtree ordering, which I suppose is
> > > not by mistake
> > What is reverse firtree ordering here? I don't know what is wrong
> > with the above one line change from patch style viewpoint, and
> > checkpatch complains nothing here.
> 
> checkpath would not complain about this. I'm talking about:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst#n587
> 
> The original code had:
> 
> 	struct blk_mq_tags *tags;
> 	int node;
> 
> as opposed to:
> 
> 	int node;
> 	struct blk_mq_tags *tags;
> 
> That's all. The block code seems to mostly follow this style when possible.
> It's just a style issue.

But my patch doesn't change the order, :-)


Thanks,
Ming

