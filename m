Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FCC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760DE20851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760DE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLHH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:07:58 -0500
Received: from verein.lst.de ([213.95.11.211]:60244 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeLLHH6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:07:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B72D868D8D; Wed, 12 Dec 2018 08:07:56 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:07:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
Message-ID: <20181212070756.GC28461@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 03:36:47PM -0800, Sagi Grimberg wrote:
> Add an additional queue mapping for polling queues that will
> host polling for latency critical I/O.
> 
> One caveat is that we don't want these queues to be pure polling
> as we don't want to bother with polling for the initial nvmf connect
> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
> context from SOFTIRQ to DIRECT.

So do we really care?  Yes, polling for the initial connect is not
exactly efficient, but then again it doesn't happen all that often.

Except for efficiency is there any problem with just starting out
in polling mode?
