Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D8C4360F
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4021872
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 22:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBPW3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:29:44 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:32904 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfBPW3o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 17:29:44 -0500
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
Date:   Sun, 17 Feb 2019 00:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190216174536.GC23000@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> The result of the bisection is
>> [88dbcbb3a4847f5e6dfeae952d3105497700c128] blkdev: avoid migration stalls for blkdev pages
>>
>> Is that result relevant for the problem or should I continue bisecting between 4.20.0 and the so far first bad commit?
> 
> Can you try reverting the commit and see if it makes the problem go away?

Tried reverting it on top of 5.0.0-rc6-00153-g5ded5871030e and it seems to make the kernel work - emerge --sync succeeded.

Unfinished further bisection has also not yielded any other bad revisions so far.

-- 
Meelis Roos
