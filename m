Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB87C04AA8
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D6D20835
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfD3PHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:07:16 -0400
Received: from verein.lst.de ([213.95.11.211]:47065 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfD3PHQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 11:07:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1F0C267358; Tue, 30 Apr 2019 17:06:59 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:06:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: simplify bio_for_each_segment_all
Message-ID: <20190430150658.GA25407@lst.de>
References: <20190425070300.3388-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425070300.3388-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Thu, Apr 25, 2019 at 09:02:58AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series simplifies bio_for_each_segment_all a bit, as suggested
> by willy.
---end quoted text---
