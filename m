Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99BC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351A620849
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351A620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLMI1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:27:33 -0500
Received: from verein.lst.de ([213.95.11.211]:39321 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbeLMI1d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 03:27:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3AEFC68D8D; Thu, 13 Dec 2018 09:27:32 +0100 (CET)
Date:   Thu, 13 Dec 2018 09:27:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/6] nvme-core: allow __nvme_submit_sync_cmd to poll
Message-ID: <20181213082732.GB869@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me> <20181213063819.13614-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213063819.13614-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:14PM -0800, Sagi Grimberg wrote:
> Pass poll bool to indicate that we need it to poll. This prepares us for
> polling support in nvmf since connect is an I/O that will be queued
> and has to be polled in order to complete.

I hate these bool parameters.  Maybe we just need a blk_execute_rq_flags
that instead of the at_head paramter takes a flags paramter.  I guess
for now this is ok, but I don't really like it:

Reviewed-by: Christoph Hellwig <hch@lst.de>
