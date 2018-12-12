Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C53C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139AB2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139AB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLIJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:09:47 -0500
Received: from verein.lst.de ([213.95.11.211]:60575 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeLLIJr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 03:09:47 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C430768DCF; Wed, 12 Dec 2018 09:09:45 +0100 (CET)
Date:   Wed, 12 Dec 2018 09:09:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
Message-ID: <20181212080945.GA29679@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me> <20181212070756.GC28461@lst.de> <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 11:16:31PM -0800, Sagi Grimberg wrote:
>
>>> Add an additional queue mapping for polling queues that will
>>> host polling for latency critical I/O.
>>>
>>> One caveat is that we don't want these queues to be pure polling
>>> as we don't want to bother with polling for the initial nvmf connect
>>> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
>>> context from SOFTIRQ to DIRECT.
>>
>> So do we really care?  Yes, polling for the initial connect is not
>> exactly efficient, but then again it doesn't happen all that often.
>>
>> Except for efficiency is there any problem with just starting out
>> in polling mode?
>
> I found it cumbersome so I didn't really consider it...
> Isn't it a bit awkward? we will need to implement polled connect
> locally in nvme-rdma (because fabrics doesn't know anything about
> queues, hctx or polling).

Well, it should just be a little blk_poll loop, right?

> I'm open to looking at it if you think that this is better. Note that if
> we had the CQ in our hands, we would do exactly what we did here
> effectively: use interrupt for the connect and then simply not
> re-arm it again and poll... Should we poll the connect just because
> we are behind the CQ API?

I'm just worried that the switch between the different context looks
like a way to easy way to shoot yourself in the foot, so if we can
avoid exposing that it would make for a harder to abuse API.
