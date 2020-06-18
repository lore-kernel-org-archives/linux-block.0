Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A2C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B262075E
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFRPCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:02:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgFRPCO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:02:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB904AD63;
        Thu, 18 Jun 2020 15:02:12 +0000 (UTC)
Date:   Thu, 18 Jun 2020 17:02:12 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 03/12] blk-mq: remove raise_blk_irq
Message-ID: <20200618150212.ukga2mfuks5d2ng3@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-4-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:43AM +0200, Christoph Hellwig wrote:
> By open coding raise_blk_irq in the only caller, and replacing the
> ifdef CONFIG_SMP with an IS_ENABLED check the flow in the caller
> can be significantly simplified.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
