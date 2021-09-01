Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E5C4320A
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F106108E
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 05:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbhIAFsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:48:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50708 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbhIAFss (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 01:48:48 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1815lZUm007349;
        Wed, 1 Sep 2021 14:47:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Wed, 01 Sep 2021 14:47:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1815lYQb007340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Sep 2021 14:47:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] loop: reduce the loop_ctl_mutex scope
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
 <20210828071832.GA31755@lst.de>
 <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
 <33a0a1e5-a79f-1887-6417-c5a81f58e47d@i-love.sakura.ne.jp>
 <cc5c215f-4b3b-94e9-560b-a02d0e23c97c@i-love.sakura.ne.jp>
 <20210830071350.GB2498@lst.de> <20210901053653.GA14913@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2af1f0b7-c6c7-4ad1-dc0c-8103bd3aca8f@i-love.sakura.ne.jp>
Date:   Wed, 1 Sep 2021 14:47:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901053653.GA14913@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/01 14:36, Christoph Hellwig wrote:
> On Mon, Aug 30, 2021 at 09:13:50AM +0200, Christoph Hellwig wrote:
>> Hi Tetsuo,
>>
>> this generally looks fine to me.  The only issue is that I remember is
>> that cmpxchg did historically not work on bool on all architectures.
>> I'm not sure if this has been fixed since.
> 
> Looks like that still is an issue based on the buildbot reports on
> linux-kernel.  I'd suggest to resend with idr_visible as an int.
> 

I sent "[PATCH v3] loop: reduce the loop_ctl_mutex scope" as not using cmpxchg().
The buildbot is reporting errors on the v2 patch.
