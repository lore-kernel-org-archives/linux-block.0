Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227EAC64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 07:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF97122202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 07:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLBHK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:10:56 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53804 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgLBHK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 02:10:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHIauve_1606893013;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHIauve_1606893013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 15:10:13 +0800
From:   JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com>
Message-ID: <7326607a-b687-3989-dee7-cf469ab37ac4@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 15:10:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202050343.GA20535@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 1:03 PM, Mike Snitzer wrote:
> What you've done here is fairly chaotic/disruptive:
> 1) you emailed a patch out that isn't needed or ideal, I dealt already
>    staged a DM fix in linux-next for 5.10-rcX, see:
>    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b

Then ti->type->io_hints() is still bypassed when type->iterate_devices()
not defined?

-- 
Thanks,
Jeffle
