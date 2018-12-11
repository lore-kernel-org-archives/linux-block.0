Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C2C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E28C20849
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E28C20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeLKN2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:28:45 -0500
Received: from verein.lst.de ([213.95.11.211]:55325 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKN2p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:28:45 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D9D9F68DD2; Tue, 11 Dec 2018 14:28:43 +0100 (CET)
Date:   Tue, 11 Dec 2018 14:28:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] implement nvmf read/write queue maps
Message-ID: <20181211132843.GA20401@lst.de>
References: <20181211104936.25333-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 02:49:30AM -0800, Sagi Grimberg wrote:
> This set implements read/write queue maps to nvmf (implemented in tcp
> and rdma). We basically allow the users to pass in nr_write_queues
> argument that will basically maps a separate set of queues to host
> write I/O (or more correctly non-read I/O) and a set of queues to
> hold read I/O (which is now controlled by the known nr_io_queues).
> 
> A patchset that restores nvme-rdma polling is in the pipe.
> The polling is less trivial because:
> 1. we can find non I/O completions in the cq (i.e. memreg)
> 2. we need to start with non-polling for a sane connect and
>    then switch to polling which is not trivial behind the
>    cq API we use.

I think we should enhance the CQ API to better support polling,
the old poll code was a bit of a layering violation vs the core
code..
