Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF359C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 00:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8988F22318
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574123683;
	bh=M274F5zR/Oyk28DX3L9hfU3Cu9CLN6grskgFrtA5yj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jR1i5wga7uCH5CxgmMxov+UbjgOMvMuMqI/7zAnSqorI2CYll+xfNSdL+fbKkeYt
	 gBrlftpe3fdAmzpqX1NIKtmPLh/LePFiV2Gk36Esd8rNBMhz/hkpeSJUT4Ia3FXEg8
	 eOPz4isiW61FI+DpQylA+wncAqKvCe7RF4+WGqQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSAem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfKSAem (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 19:34:42 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D542230B;
        Tue, 19 Nov 2019 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574123682;
        bh=M274F5zR/Oyk28DX3L9hfU3Cu9CLN6grskgFrtA5yj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcaSktkTP4FvrY1hWFd3C8EOi3IvE1kWakBQiXFiOc8PzkoCTDiOU+Cd43t7fsMzz
         L8s/zRU7DkPKEoPP4sKJ6Z4A+/BazIXRKM+UnYrCYx0QswXFB9JouKUbFrfDUsbNBl
         PrNL5+3g4JJ6s3Mp6lVCQmZ8tgV6jbHSkA1DoDFE=
Date:   Tue, 19 Nov 2019 09:34:37 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 18, 2019 at 04:05:56PM -0800, Sagi Grimberg wrote:
> 
> I'm starting to think we maybe need to get the connect out of the block
> layer execution if its such a big problem... Its a real shame if that is
> the case...

We still need timeout handling for connect commands, so bypassing the
block layer will need to figure out some other way to handle that.

This patch proposal doesn't really handle the timeouts very well either,
though: nvme_rdma_timeout() is going to end up referncing the wrong
queue rather than the one the request was submitted on. It doesn't
appear to really matter in the current code since it just resets the
entire controller, but if it ever wanted to do something queue specific...
