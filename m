Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E4C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D422070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfAHUy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:54:57 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51960 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfAHUy5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 15:54:57 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ggyOl-0004k9-Aq; Tue, 08 Jan 2019 13:54:56 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
Message-ID: <a704ca28-17fd-abe7-9b91-29424a6dc9d7@deltatee.com>
Date:   Tue, 8 Jan 2019 13:54:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Regression in v5.0-rc1: Panic at boot
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-01-07 12:41 p.m., Logan Gunthorpe wrote:
> I found a regression in v5.0-rc1 this morning. My system panics on boot.
> I've attached a log of the panic.

I just sent a patch which, I believe, resolves the regression:

http://lkml.kernel.org/r/20190108205043.3122-1-logang@deltatee.com

The problem turned out to be an allocate-to-small bug in the isci driver.

Logan
