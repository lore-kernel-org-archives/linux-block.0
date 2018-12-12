Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A8C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08D2086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 14:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A08D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeLLOFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:05:20 -0500
Received: from verein.lst.de ([213.95.11.211]:34169 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeLLOFU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 09:05:20 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9791E68D8D; Wed, 12 Dec 2018 15:05:18 +0100 (CET)
Date:   Wed, 12 Dec 2018 15:05:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
Message-ID: <20181212140518.GA4527@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me> <20181212070756.GC28461@lst.de> <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me> <20181212080945.GA29679@lst.de> <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 12:53:47AM -0800, Sagi Grimberg wrote:
>> Well, it should just be a little blk_poll loop, right?
>
> Not so much about the poll loop, but the fact that we will need
> to check if we need to poll for this special case every time in
> .queue_rq and its somewhat annoying...

I don't think we need to add any special check in queue_rq.  Any
polled command should be marked as HIPRI from the submitting code,
and that includes the queue creation.

> Anyway, if people think its really a bad idea we'll go ahead and
> poll the nvmf connect...

I'm really just worried about the completion context switching.  If the
RDMA folks are happy with that API and you strongly favour this version
I'll let you decide.
