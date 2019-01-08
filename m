Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ABCC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83485218A1
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfAHRbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:31:50 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50400 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfAHRbu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 12:31:50 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ggvEC-0002Gf-VU; Tue, 08 Jan 2019 10:31:49 -0700
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
 <x49y37v8dkc.fsf@segfault.boston.devel.redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <40eaef42-6aaf-cfcd-871b-be0aac9720e4@deltatee.com>
Date:   Tue, 8 Jan 2019 10:31:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <x49y37v8dkc.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, jmoyer@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Regression in v5.0-rc1: Panic at boot
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-01-08 6:49 a.m., Jeff Moyer wrote:
>> The traceback seems to indicate the problem is on the bip_get_seed()
>> line in t10_pi_complete(). Which suggests that bio_integrity() is
>> returning NULL.
> 
> Does your hardware actually support protection information?

As far as I know, I do not. If I add a printk to t10_pi_complete(), it
doesn't print on a successful boot and does print on a broken boot. So
something is causing it to be called erroneously.

Logan
