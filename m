Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B316C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2076620825
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598456204;
	bh=Tjfk74rL/WYzH4L2aX4m/1aYntg6RTB+ENg6qGV7dVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PS7YHlzFl7M75j6TjmPeWpq5qIMKXLhuA1to4c0sYC1E4zV/ggF+KHNR0RlcWHCe
	 I1Awz+zxYxFEUnx4iu7sQKshYyWi9mZUDAR7E4eClaaGgOFZQdR72Kc43PlEprUKvp
	 BUIs2HWTDTQPD8MvklKmFeNwRoW0ttldgI2aL3Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZPgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgHZPgl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 11:36:41 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259232078D;
        Wed, 26 Aug 2020 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598456195;
        bh=Tjfk74rL/WYzH4L2aX4m/1aYntg6RTB+ENg6qGV7dVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAHTcP/qcAfODAr7afNB5163dkV8bEfUK6uHfMuVe5XVDLvcA6a9gS61mXBx1EKmy
         YRHIdJlJ3MFGb5pvPBJU17YwQOkd9JSixtJ4Wz6QCf7PFvFAsrGF81kfQjwJf+jr0J
         +Cb7MO2edE4gdrbLovgkyCCYT3bZ2/IQGIScqbjU=
Date:   Wed, 26 Aug 2020 08:36:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Message-ID: <20200826153633.GA2151118@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200825141734.115879-2-ming.lei@redhat.com>
 <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
 <20200826085422.GB116347@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826085422.GB116347@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 26, 2020 at 04:54:22PM +0800, Ming Lei wrote:
> On Wed, Aug 26, 2020 at 03:51:25PM +0800, Chao Leng wrote:
> > It doesn't matter. Because the reentry of quiesce&unquiesce queue is not
> > safe, must be avoided by other mechanism. otherwise, exceptions may
> > occur. Introduce mq_quiesce_lock looks saving possible synchronization
> > waits, but it should not happen. If really happen, we need fix it.
> 
> Sagi mentioned there may be nested queue quiesce, so I add .mq_quiesce_lock 
> to make this usage easy to support, meantime avoid percpu_ref warning
> in such usage.
> 
> Anyway, not see any problem with adding .mq_quiesce_lock, so I'd suggest to
> move on with this way.

I'm not sure there really are any nested queue quiesce paths, but if
there are, wouldn't we need to track the "depth" like how a queue freeze
works?
