Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD061C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F482087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HM4cogxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F482087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeKPTW2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:22:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPTW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5gA1pXUs3oZvZB5dKYFu9og15ePwsbv3AEXQv99pU20=; b=HM4cogxrPi/V52/qAdJOgauhw
        s0XkhVMktJlMvlPmf+zCI0+dFW9JjnyB/qzrNAL7rAWcNo7MrHP/SAm/nsq94gabaD7kOTzUuMMtj
        sj/gTWfMC8++rNr4T36noDN49mL14nQhV8V1miP0Ot3v9OvS1Vkxs+zUqsnHiPenbNOfzqS/ehDk0
        Y/GljQqIDegdBs7ISMZrXeYBa40up5XmDNs0aTeiBv4LotSmFdsIXsfPQzhvwJswZBHpDcTDDwsro
        BT1cov4M53rjiGBhZhQ+KModr8EF42Bqo6kgCeA0hpDv8INNC+Bh/gv0QF7LCwAAhYVoM/bhq7YUS
        29rz2PQKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNa9W-0000Gi-EM; Fri, 16 Nov 2018 09:11:02 +0000
Date:   Fri, 16 Nov 2018 01:11:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        "Alasdair G. Kergon" <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH 3/3] block: use a driver-specific handler for
 the "inflight" value
Message-ID: <20181116091102.GA22961@infradead.org>
References: <20181116000508.980108938@debian.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116000508.980108938@debian.vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 01:04:19AM +0100, Mikulas Patocka wrote:
> Device mapper was converted to percpu inflight counters. In order to
> display the correct values in the "inflight" sysfs file and in
> /proc/diskstats, we need a custom callback that sums the percpu counters.
> 
> The function part_round_stats calculates the number of in-flight I/Os
> every jiffy and uses this to calculate the counters time_in_queue and
> io_ticks. In order to avoid excessive memory traffic on systems with high
> number of CPUs, this functionality is disabled when percpu inflight values
> are used and the values time_in_queue and io_ticks are calculated
> differently - the result is less precise.

And none of that is device mapper specific.  Please submit this code
to the block layer for use by all make_request based drivers.  Depending
on what Jens as the maintainers thinkgs of the tradeoffs we can discuss
if the summing should be on or off by default, or if we maybe even
need the current code as a fallback.


