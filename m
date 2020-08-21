Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C0920738
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgHUGZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:25:42 -0400
Received: from verein.lst.de ([213.95.11.211]:45754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUGZl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 02:25:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3FFF68AFE; Fri, 21 Aug 2020 08:25:38 +0200 (CEST)
Date:   Fri, 21 Aug 2020 08:25:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Message-ID: <20200821062538.GD28559@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com> <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me> <20200820082918.GA12926@lst.de> <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 20, 2020 at 08:44:13AM -0700, Sagi Grimberg wrote:
>> So the one thing I'm not even sure about is if just ignoring the
>> errors was a good idea to start with.  They obviously are if we just
>> did a rescan and did run into an error while rescanning a namespace
>> that didn't change.  But what if it actually did change?
>
> Right, we don't know, so if we failed without DNR, we assume that
> we will retry again and ignore the error. The assumption is that
> we will retry when we will reconnect as we don't have a retry mechanism
> for these requests.

Yes.  And I think for anything related to namespace (re-)scanning
we can actually trivially build a sane retry mechanism.  That is give
up on the current scan_work, and just rescan one after a short wait.

>> So I think a logic like in this patch kinda makes sense, but I think
>> we also need to retry and scan again on these kinds of errors.
>
> So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
> cancelled requests and have the scan flow assume that these are
> cancelled requests?

How does nvme_submit_sync_cmd return -ENODEV?  As far as I can tell
-ENODEV is our special escape for expected-ish errors in namespace
scanning.

> At the very least we need a good comment to say what is going on there.

Absolutely.

>
>   Btw,
>> did you ever actually see -ENOMEM in practice?  With the small
>> allocations that we do it really should not happen normally, so
>> special casing for it always felt a little strange.
>
> Never seen it, it's there just because we have allocations in the path.
>
>> FYI, I've started rebasing various bits of work I've done to start
>> untangling the mess.  Here is my current WIP, which in this form
>> is completely untested:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
>
> This does not yet contain sorting out what is discussed here correct?

No, but all the infrastructure needed to implement my above idead.  Most
importanty the crazy revalidate callchains are pretty much gone and we're
down to just a few functions with reasonable call chains.
