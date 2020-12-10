Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC4C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25FA233EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgLJCJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgLJCJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 21:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607566085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0UEpSglWXCbwIGmM6W0kiiUcEDufQdmtoBvtOA3A/w=;
        b=DBALpF+1DvGwo4rUrSQA7WcE1mU6BFM+ul1bOkkNeG01fGciEtxBaIGPic8y68XI8F3L9W
        a8m4ur6/95+OVJJAOmAn7lFPrbnq9WQ7miQfRHc3C10t7eINNzbT6In2ZGq0HeUymmwooM
        eolOI8Q1jbW1BH2XGJKvIw+8Qg0NWRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-vmbCeoe2PmOS5OAGABbU3Q-1; Wed, 09 Dec 2020 21:08:02 -0500
X-MC-Unique: vmbCeoe2PmOS5OAGABbU3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F268B100C60A;
        Thu, 10 Dec 2020 02:08:00 +0000 (UTC)
Received: from T590 (ovpn-13-118.pek2.redhat.com [10.72.13.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3692D6F97F;
        Thu, 10 Dec 2020 02:07:49 +0000 (UTC)
Date:   Thu, 10 Dec 2020 10:07:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, hare@suse.de,
        ppvk@codeaurora.org, bvanassche@acm.org, kashyap.desai@broadcom.com
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
Message-ID: <20201210020745.GA1363446@T590>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
 <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
 <20201209010102.GA1217988@T590>
 <13327a68-6f86-96da-0c5f-5fa0be326d6f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13327a68-6f86-96da-0c5f-5fa0be326d6f@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 09, 2020 at 09:55:30AM +0000, John Garry wrote:
> On 09/12/2020 01:01, Ming Lei wrote:
> > blk_mq_queue_tag_busy_iter() can be run on another request queue just
> > between one driver tag is allocated and updating the request map, so one
> > extra request reference still can be grabbed.
> > 
> > So looks only holding one queue's usage_counter doesn't help this issue, since
> > bt_for_each() always iterates on driver tags wide.
> > 
> > > But I didn't see such a guard for blk_mq_tagset_busy_iter().
> > IMO there isn't real difference between the two iteration.
> 
> ok, I see. Let me try to recreate that one, which will prob again require
> artificial delays added.
> 
> Apart from this, my concern is that we come with for a solution, but it's a
> complicated solution and may not be accepted as this issue is not seen as a
> problem in practice.

If that is the case, I'd suggest to consider the solution in the
following link:

https://lore.kernel.org/linux-block/20200820180335.3109216-1-ming.lei@redhat.com/

At least, the idea is simple, which can be extended to support allocate driver tags
request pool dynamically.


Thanks, 
Ming

