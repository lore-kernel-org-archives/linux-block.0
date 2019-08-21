Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE56C3A589
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 02:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97A22CE3
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 02:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHUCpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfHUCpV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 22:45:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07EAE3082E03;
        Wed, 21 Aug 2019 02:45:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2FA60BF3;
        Wed, 21 Aug 2019 02:45:09 +0000 (UTC)
Date:   Wed, 21 Aug 2019 10:45:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
Message-ID: <20190821024503.GC24167@ming.t460p>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <429c8ae2-894a-1eb2-83d3-95703d1573cf@acm.org>
 <20190819081536.GA9852@ming.t460p>
 <b79a9f96-f085-1888-bd10-d6dc72aba30b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79a9f96-f085-1888-bd10-d6dc72aba30b@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 21 Aug 2019 02:45:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:43PM -0700, Bart Van Assche wrote:
> On 8/19/19 1:15 AM, Ming Lei wrote:
> > hctx->tags is tagset wide or host-wide, which is protected by set->tag_list_lock.
> 
> Isn't the purpose of set->tag_list_lock to protect set->tag_list?

In theory, .tags is shared among all queues in tagset, so it should be
protected by tagset wide lock, what is why set->tag_list_lock is held
in blk_mq_update_nr_hw_queues().

However, both sysfs and debugfs read/write doesn't hold this lock because
the .tags won't be shrunk in blk_mq_update_nr_requests(), and
blk_mq_update_nr_hw_queues un-registers debugfs/sysfs before changing .tags.


thanks,
Ming
