Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC5AC282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8962921738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 22:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfA1WOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfA1WOs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 17:14:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E77AC791D;
        Mon, 28 Jan 2019 22:14:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 994105D96E;
        Mon, 28 Jan 2019 22:14:43 +0000 (UTC)
Date:   Mon, 28 Jan 2019 17:14:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
Message-ID: <20190128221441.GA24102@redhat.com>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 28 Jan 2019 22:14:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 26 2019 at  6:17am -0500,
John Dorminy <jdorminy@redhat.com> wrote:

> Hi. I have read a bit of DM code and spent an hour reviewing this... I
> didn't get to the point of knowing what the right fix for the problem
> is, and I may have a wrong understanding, but I have two thoughts
> about the patch:
> 
> I don't think this is the right solution for two reasons:
> 
> In the first place, if it's an LVM-only issue, we should fix it only
> for device-mapper devices. If this is the right way to fix it,
> possibly the way to do that would be to change DM calls to
> blk_queue_max_write_same_sectors() to only set the max sectors to more
> than 0 if and only if the logical block sizes match.

There is no way this is specific to lvm (or DM).  It may _seem_ that way
because lvm/dm are in the business of creating stacked devices --
whereby exposing users to blk_stack_limits().

I'll have a closer look at this issue, hopefully tomorrow, but Zhang
Xiaoxu's proposed fix looks bogus to me.  Not disputing there is an
issue, just feels like a different fix is needed.

Mike
