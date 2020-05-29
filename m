Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F833C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E592075A
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2M1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 08:27:48 -0400
Received: from verein.lst.de ([213.95.11.211]:32783 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgE2M1s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 08:27:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92FFF68B02; Fri, 29 May 2020 14:27:46 +0200 (CEST)
Date:   Fri, 29 May 2020 14:27:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200529122746.GB28107@lst.de>
References: <20200528153441.3501777-1-kbusch@kernel.org> <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 09:36:23AM -0600, Jens Axboe wrote:
> On 5/28/20 9:34 AM, Keith Busch wrote:
> > For when drivers have a need to bypass error injection.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk
> 
> Assuming this goes in through the NVMe tree.

Given that other drivers will need this as well, and the nvme queue for
5.8 is empty at the moment I think you should pick up the next version
once it has better naming and documentation.
