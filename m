Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4587C64E8A
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D86C20B80
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLCBtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:49:13 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34710 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgLCBtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:49:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHMcpTK_1606960110;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHMcpTK_1606960110)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 09:48:31 +0800
Subject: Re: [dm-devel] dm: use gcd() to fix chunk_sectors limit stacking
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com>
 <7326607a-b687-3989-dee7-cf469ab37ac4@linux.alibaba.com>
 <20201202151112.GD20535@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <353a132b-1430-60b0-3f17-979af1b8dd22@linux.alibaba.com>
Date:   Thu, 3 Dec 2020 09:48:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202151112.GD20535@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 11:11 PM, Mike Snitzer wrote:
> On Wed, Dec 02 2020 at  2:10am -0500,
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>>
>>
>> On 12/2/20 1:03 PM, Mike Snitzer wrote:
>>> What you've done here is fairly chaotic/disruptive:
>>> 1) you emailed a patch out that isn't needed or ideal, I dealt already
>>>    staged a DM fix in linux-next for 5.10-rcX, see:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b
>>
>> Then ti->type->io_hints() is still bypassed when type->iterate_devices()
>> not defined?
> 
> Yes, the stacking of limits really is tightly coupled to device-based
> influence.  Hypothetically some DM target that doesn't remap to any data
> devices may want to override limits... in practice there isn't a need
> for this.  If that changes we can take action to accommodate it.. but I'm
> definitely not interested in modifying DM core in this area when there
> isn't a demonstrated need.

Thanks.

-- 
Thanks,
Jeffle
