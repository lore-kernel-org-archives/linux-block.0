Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8871C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1820834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C1820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLAEXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:23:35 -0500
Received: from verein.lst.de ([213.95.11.211]:51599 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeLAEXf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:23:35 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7491D67357; Fri, 30 Nov 2018 18:13:36 +0100 (CET)
Date:   Fri, 30 Nov 2018 18:13:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 02/27] aio: clear IOCB_HIPRI
Message-ID: <20181130171336.GA17030@lst.de>
References: <20181130165646.27341-1-axboe@kernel.dk> <20181130165646.27341-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130165646.27341-3-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think we'll need to queue this up for 4.21 ASAP independent of the
rest, given that with separate poll queues userspace could otherwise
submit I/O that will never get polled for anywhere.
