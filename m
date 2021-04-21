Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C89C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37FD6142B
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhDUH0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:26:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhDUH0A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 03:26:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 262E8B0B6;
        Wed, 21 Apr 2021 07:25:27 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:25:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
Message-ID: <20210421072526.vsimzcgz2ncgiug3@beryllium.lan>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
 <20210413075024.xivnj3jy6olaqglc@beryllium.lan>
 <3a7d44c5-cf67-3d74-49e9-93f83e6eba3c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7d44c5-cf67-3d74-49e9-93f83e6eba3c@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20, 2021 at 02:35:53PM -0700, Bart Van Assche wrote:
> On 4/13/21 12:50 AM, Daniel Wagner wrote:
> > Maybe you could also annotate blk_mq_all_tag_iter() with a
> > might_sleep(). This would help to find API abusers more easily.
> 
> Hmm ... my understanding is that blk_mq_all_tag_iter() does not sleep
> since that function does not sleep itself and since the only caller of
> blk_mq_all_tag_iter() callers passes a callback function that does not
> sleep?

Yes, you are right. I read the documentation and assumed a might_sleep()
would be missing.
