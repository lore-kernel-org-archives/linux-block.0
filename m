Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B3CA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 00:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91302084B
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 00:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392821AbfJXAXJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 20:23:09 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:45098 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392153AbfJXAXJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 20:23:09 -0400
X-QQ-mid: bizesmtp11t1571876579tlvkv2f1
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 24 Oct 2019 08:22:57 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZU90B00A0000000
X-QQ-FEAT: XDCR4pEWrpmfMgXPpcHQCpW0d63+G0DRr6mR+IYGwajyQrHNdLd3pQp7whop3
        YEtTEfxb/PGNAPFJ/dOfmBMOvmbygm4tVX/ek2f6sKnHwPykVdZHdu45uc+6GnBfnLSxpLK
        X0hGlrH8VCqw1mLHal6LgV4wYggSAIHK8g15DmlMefu5Wm90yilFOmDLu0l9xzecmGxAa5N
        jj4fH7cCRGjTnWf8vLrMn0PMteq8ySPS1kEoU5WrCkwl8/NqnjEHx7FqbTYZkv2/rcjPbw/
        IuJ6a13hdNCW/yLjFcrGoxFnb4i/KAuH4+DDp3YK5gK9lhzh4EVr6cqhjZl5Quo8Pc0jcz3
        M4oGNHOgi/wOgb3pDE=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] io_uring: ensure cq_entries is at least equal to or
 greater than sq_entries
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <e167ef28-8763-7629-fb5b-e0ef28ed8a49@kernel.dk>
Date:   Thu, 24 Oct 2019 08:22:56 +0800
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BB26710D-8704-4D15-9B33-080B28B7941B@kylinos.cn>
References: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn>
 <x49d0ennw1y.fsf@segfault.boston.devel.redhat.com>
 <e167ef28-8763-7629-fb5b-e0ef28ed8a49@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3594.4.19)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2019年10月24日 03:41，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 10/23/19 12:42 PM, Jeff Moyer wrote:
>> Jackie Liu <liuyun01@kylinos.cn> writes:
>> 
>>> If cq_entries is smaller than sq_entries, it will cause a lot of overflow
>>> to appear. when customizing cq_entries, at least let him be no smaller than
>>> sq_entries.
>>> 
>>> Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size")
>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>> ---
>>>  fs/io_uring.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index b64cd2c..dfa9731 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -3784,7 +3784,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
>>>  		 * to a power-of-two, if it isn't already. We do NOT impose
>>>  		 * any cq vs sq ring sizing.
>>>  		 */
>>> -		if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
>>> +		if (p->cq_entries < p->sq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
>> 
>> What if they're both zero?  I think you want to keep that check.
> 
> sq_entries being zero is already checked and failed at this point.
> So I think the patch looks fine from that perspective.
> 
> Is there really a strong reason to disallow this? Yes, it could
> cause overflows, but it's just doing what was asked for. The
> normal case is of course cq_entries being much larger than
> sq_entries.
> 

There are actually no other stronger reasons. I think it would be better to do a
print job in liburing, but the kernel should still make a limit. Too many overflows
will cause less efficiency.

--
Jackie Liu



