Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3050C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911952243E
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911952243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKNTqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:46:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTqY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 14:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A79D689AF9;
        Wed, 14 Nov 2018 09:43:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C47D15D9C7;
        Wed, 14 Nov 2018 09:43:49 +0000 (UTC)
Date:   Wed, 14 Nov 2018 17:43:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/4] blk-mq: refactor the code of issue request
 directly
Message-ID: <20181114094343.GA13193@ming.t460p>
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181114091153.GB20550@ming.t460p>
 <17b51550-d45b-9861-b172-74ee0e256d98@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b51550-d45b-9861-b172-74ee0e256d98@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 14 Nov 2018 09:43:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 05:23:48PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 11/14/18 5:11 PM, Ming Lei wrote:
> >>  
> >> -	if (!blk_mq_get_dispatch_budget(hctx))
> >> -		goto insert;
> >> +	if (unlikely(!blk_mq_get_dispatch_budget(hctx)))
> >> +		goto out_unlock;
> > The unlikely annotation is a bit misleading, since out-of-budget can
> > happen frequently in case of low queue depth, and there are lots of
> > such examples.
> > 
> 
> This could be good for the case for no .get_budget and getting budget success.
> In case of out-of-budget, we insert the request which is slow path.

In case of low queue depth, it is hard to say that 'insert request' is
done in slow path, cause it happens quite frequently.

I suggest to remove these two unlikely() since modern CPU's branch prediction
should work well enough.

Especially the annotation of unlikely() often means that this branch is
missed in most of times for all settings, and it is obviously not true
in this case.


thanks,
Ming
