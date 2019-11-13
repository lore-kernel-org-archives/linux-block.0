Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E326C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ECE214E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKMIEx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:04:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbfKMIEx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 03:04:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9467B40C;
        Wed, 13 Nov 2019 08:04:51 +0000 (UTC)
Subject: Re: [PATCH 00/10] bcache patches for Linux v5.5
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191113053346.63536-1-colyli@suse.de>
 <20191113071923.GB17875@infradead.org>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <64aefb93-0046-76bd-5d5d-0ac1a3ec0e31@suse.de>
Date:   Wed, 13 Nov 2019 16:04:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113071923.GB17875@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/13 3:19 下午, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 01:33:36PM +0800, Coly Li wrote:
>> Hi Jens,
>>
>> This is the patches for Linux v5.5. The patches have been testing for
>> a while during my current development, they are ready to be merged.
>>
>> There are still other patches under testing, I will submit to you in
>> later runs if I feel they are solid enough in my testing.
> 

Hi Christoph,

> This seems to be missing my patches for the makefile cleanup and export
> removal that you acked a while ago.
> 

Of cause we should have these two patches in this wave. Re-submit the
bcache v5.5 series, thanks for the reminding.

-- 

Coly Li
