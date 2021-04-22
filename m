Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3CEC433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 07:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5716145A
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 07:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhDVHON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhDVHOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 03:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619075618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcJZWIrFQ1hZTwdAYmDotiiXZIerfAM8EJ1tZgT/mYs=;
        b=ZNM3t/0ruI8487ymdYVJ+922lmTG1sl0JTSLpAn616FFeep/sD1GKz3w2am0OIdzaM4Hz/
        4YtXq+VXMP1lY+mZ9rvNFOY+V7ZLDBXdq6baoH3ah3+OelBw3cX6TVmjc0Ls66yFEoMgeM
        nJAjp8FhbU57SbofO335UKl4QnCvjIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-rUDZhD-dMkyKr_ZBmtOMaw-1; Thu, 22 Apr 2021 03:13:34 -0400
X-MC-Unique: rUDZhD-dMkyKr_ZBmtOMaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BCF3817476;
        Thu, 22 Apr 2021 07:13:32 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2D710016FD;
        Thu, 22 Apr 2021 07:13:21 +0000 (UTC)
Date:   Thu, 22 Apr 2021 15:13:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
Message-ID: <YIEiElb9wxReV/oL@T590>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org>
 <YIDqa6YkNoD5OiKN@T590>
 <b717ffc0-a434-738f-9c63-32901bd164b2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b717ffc0-a434-738f-9c63-32901bd164b2@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 21, 2021 at 08:54:30PM -0700, Bart Van Assche wrote:
> On 4/21/21 8:15 PM, Ming Lei wrote:
> > On Tue, Apr 20, 2021 at 05:02:33PM -0700, Bart Van Assche wrote:
> >> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >> +{
> >> +	struct bt_tags_iter_data *iter_data = data;
> >> +	struct blk_mq_tags *tags = iter_data->tags;
> >> +	bool res;
> >> +
> >> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
> >> +		down_read(&tags->iter_rwsem);
> >> +		res = __bt_tags_iter(bitmap, bitnr, data);
> >> +		up_read(&tags->iter_rwsem);
> >> +	} else {
> >> +		rcu_read_lock();
> >> +		res = __bt_tags_iter(bitmap, bitnr, data);
> >> +		rcu_read_unlock();
> >> +	}
> >> +
> >> +	return res;
> >> +}
> > 
> > Holding one rwsem or rcu read lock won't avoid the issue completely
> > because request may be completed remotely in iter_data->fn(), such as
> > nbd_clear_req(), nvme_cancel_request(), complete_all_cmds_iter(),
> > mtip_no_dev_cleanup(), because blk_mq_complete_request() may complete
> > request in softirq, remote IPI, even wq, and the request is still
> > referenced in these contexts after bt_tags_iter() returns.
> 
> The rwsem and RCU read lock are used to serialize iterating over
> requests against blk_mq_sched_free_requests() calls. I don't think it
> matters for this patch from which context requests are freed.

Requests still can be referred in other context after blk_mq_wait_for_tag_iter()
returns, then follows freeing request pool. And use-after-free exists too, doesn't it?

Thanks,
Ming

