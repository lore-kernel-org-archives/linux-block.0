Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA4C4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F375461008
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 12:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhHJMKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhHJMKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 08:10:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D6C0613D3;
        Tue, 10 Aug 2021 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CuE8tVzqrDVmqFyhKv4EHczZmJiXfG1mo07uoIkbB/Q=; b=SLnBS0X2kqj7gfFIvKrcxIDuT8
        l1e9LPbXRGRmZfdUXZL5GeYVFo4qiOyU5YxECzStC4XBGXI7MRrZSk/Na4fM3HluxrD/dJjB4uTen
        rH/Hu93sf/N3tJYGh094hrvHbPJPAWGuhTGFYV0sx+NeuCSAO1eTdxR3B1NMk4Cy3ITosaow2DSJK
        8TJHfnHnvpv83jazTEU6c5iWaSlOwYwqrERUz1LeBiqGHFqNh+4GVI4Eayx4Zat4UJlLEa/+s3uu8
        pfTX0COt9hJMOAXk6ySLc5EI2UlY8QeG9dj9spem1sGKUxeFfHRosg8XB8Q+qPUTD+Tv6ZtLRalgV
        dl7BqyOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDQZl-00C59h-PI; Tue, 10 Aug 2021 12:09:51 +0000
Date:   Tue, 10 Aug 2021 13:09:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Page Cache Allowing Hard Interrupts
Message-ID: <YRJsiapS/M3BOH9D@casper.infradead.org>
References: <20210730213630.44891-1-vishal.moola@gmail.com>
 <YRI1oLdiueUbBVwb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRI1oLdiueUbBVwb@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 09:15:28AM +0100, Christoph Hellwig wrote:
> Stupid question, but where do we ever do page cache interaction from
> soft irq context?

test_clear_page_writeback() happens in _some_ interrupt context (ie
the io completion path).  We had been under the impression that it was
always actually softirq context, and so this patch was safe.  However,
it's now clear that some drivers are calling it from hardirq context.
Writeback completions are clearly not latency sensitive and so can
be delayed from hardirq to softirq context without any problem, so I
think fixing this is just going to be a matter of tagging requests as
"complete in softirq context" and ensuring that blk_mq_raise_softirq()
is called for them.

Assuming that DIO write completions _are_ latency-sensitive, of course.
Maybe all write completions could be run in softirqs.
