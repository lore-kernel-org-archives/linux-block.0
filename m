Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE284C3F2D7
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982B521739
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgCDLHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:07:20 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43609 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgCDLHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 06:07:20 -0500
Received: from webmail.gandi.net (webmail14.sd4.0x35.net [10.200.201.14])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id BBC721C0018;
        Wed,  4 Mar 2020 11:07:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Mar 2020 14:07:17 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: fix dereference after null check
In-Reply-To: <20200303091436.2e7ab191@gandalf.local.home>
References: <20200303073358.57799-1-cengiz@kernel.wtf>
 <20200303091436.2e7ab191@gandalf.local.home>
Message-ID: <950cfb6c63a0ab33ff2b4bb33cfa3567@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-03 17:14, Steven Rostedt wrote:
> 
> Note, you should probably add a note in your change log that this issue 
> was
> found by Coverity. Sometimes static analyzers have a tag of some kind 
> that
> they would like patches that fix the issues they discover to be in the
> change log. This way they can track the fixes that are found by the 
> tool.
> 

I have added the Coverity issue ID and relevant notes to mark it. 
Thanks.

> 
> As I said in the other email, the above assignment still needs RCU
> annotation:
> 
> 		bt = rcu_dereference_protected(q->blk_trace,
> 				lockdep_is_held(&q->blk_trace_mutex));

I missed that. Thanks for reminding. TIL.

Please check PATCH-v2.

-- 
Cengiz Can
@cengiz_io
