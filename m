Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F9C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4BC208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHkBdRbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4BC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeKOBW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:22:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOBW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PxQ3y8Fi+lTMVMPmyHgv4V+35r7gI90bPqY17fCU8ac=; b=OHkBdRbo1gRBBXsT//ovB3fXj
        TdWThR3l+/u6gVHxzGvOdLlYHncbOrgwipqZDBfwEsKb7U1rT7lIUkEWzAaFFfgyZe9li8IJMyk7D
        t99kqTDhBgYsD6mM9MSoQOtq19wNtYoetpwRQr1nn7VU12/p4GV8pl3tCFBEfExWlMiN57Pv7iI5K
        iTd/BXSQnkp4Xz4HA5MTiTrhd9JX3vxc/Fw4NWye9DiIkxceqK4PC9x6RQ/JSO3r9aqM808ySz9A6
        AMt5m+qASNWGkYMAuKG82cELqAGdB24DZVSfTsG82r4RJoY2xFz5I97d4K59syNcPVykD4cRNA54i
        UT7wBtIzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMwwK-0005lH-7U; Wed, 14 Nov 2018 15:18:48 +0000
Date:   Wed, 14 Nov 2018 07:18:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Alasdair G. Kergon" <agk@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [patch 5/5] block: use a driver-specific handler for the
 "inflight" value
Message-ID: <20181114151848.GA22138@infradead.org>
References: <20181106213858.391264280@debian-a64.vm>
 <20181108145240.GA20087@infradead.org>
 <20181108170701.GA29107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108170701.GA29107@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 08, 2018 at 12:07:01PM -0500, Mike Snitzer wrote:
> Discussed doing that with Jens and reported as much here:
> 
> https://www.redhat.com/archives/dm-devel/2018-November/msg00068.html
> 
> And Jens gave additional context for why yet another attempt to switch
> block core's in_flight to percpu counters is doomed (having already been
> proposed and rejected twice):
> 
> https://www.redhat.com/archives/dm-devel/2018-November/msg00071.html
> 
> And yes, definitely should've cc'd linux-block (now added).

So how is dm different from the the other 3 handful of drivers using
the make_request interface that the per-cpu counters work for dm and
not the others?
