Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1321C76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C316F2173B
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 08:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="zhAH42hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfGRIVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:21:16 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54]:49418 "EHLO
        pv50p00im-tydg10021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfGRIVP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 04:21:15 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 04:21:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1563437746; bh=rygbksnDqOaSKR3XLkW4e13nzvuYk7oKU0GX4JXNTak=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=zhAH42hbz4XLf76nlyZ8NQLNle36tqzflOlDKDaesle5jD6G5c8o8WaYeAOe6mCTe
         hJVEqJ8tlB58zEmDMcTX3Nq16TBNrxqI6USRO5QpK1QgBn6aBkgdmE3VAICyRVSMTV
         8aosauw1040CDhtSUwF2BahpBlVu51CtHemJVaUo2/YXAxwj/mcPvZcJsAb7DtnUOT
         R0dBcGKOlzbzLKFw/4SG431ABvMt9kni7RXHeZuyTWDxrTpVc/vJuFik0Si5C7JXPY
         7wNlpiwz27vWvI6a1UGTobMxeBiGOtqcXsm8mAvu/DUsV5rCwuW9dF7qF5fmse56U0
         MoLnUCSn/8zNQ==
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net [220.133.187.190])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 235F3840296;
        Thu, 18 Jul 2019 08:15:44 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
From:   Kai-Heng Feng <kaihengfeng@me.com>
In-Reply-To: <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
Date:   Thu, 18 Jul 2019 16:15:42 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        John Lenton <john.lenton@canonical.com>,
        jean-baptiste.lallement@canonical.com
Content-Transfer-Encoding: 7bit
Message-Id: <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1907180095
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

at 21:34, Jens Axboe <axboe@kernel.dk> wrote:

> On 5/27/19 6:29 AM, Jan Kara wrote:
>> On Thu 16-05-19 14:44:07, Jens Axboe wrote:
>>> On 5/16/19 8:01 AM, Jan Kara wrote:
>>>> Loop module allows calling LOOP_SET_FD while there are other openers of
>>>> the loop device. Even exclusive ones. This can lead to weird
>>>> consequences such as kernel deadlocks like:
>>>>
>>>> mount_bdev()				lo_ioctl()
>>>>    udf_fill_super()
>>>>      udf_load_vrs()
>>>>        sb_set_blocksize() - sets desired block size B
>>>>        udf_tread()
>>>>          sb_bread()
>>>>            __bread_gfp(bdev, block, B)
>>>> 					  loop_set_fd()
>>>> 					    set_blocksize()
>>>>              - now __getblk_slow() indefinitely loops because B != bdev
>>>>                block size
>>>>
>>>> Fix the problem by disallowing LOOP_SET_FD ioctl when there are
>>>> exclusive openers of a loop device.
>>>>
>>>> [Deliberately chosen not to CC stable as a user with priviledges to
>>>> trigger this race has other means of taking the system down and this
>>>> has a potential of breaking some weird userspace setup]
>>>>
>>>> Reported-and-tested-by:  
>>>> syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>> ---
>>>>   drivers/block/loop.c | 18 +++++++++++++++++-
>>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> Hi Jens!
>>>>
>>>> What do you think about this patch? It fixes the problem but it also
>>>> changes user visible behavior so there are chances it breaks some
>>>> existing setup (although I have hard time coming up with a realistic
>>>> scenario where it would matter).
>>>
>>> I also have a hard time thinking about valid cases where this would be a
>>> problem. I think, in the end, that fixing the issue is more important
>>> than a potentially hypothetical use case.
>>>
>>>> Alternatively we could change getblk() code handle changing block
>>>> size. That would fix the particular issue syzkaller found as well but
>>>> I'm not sure what else is broken when block device changes while fs
>>>> driver is working with it.
>>>
>>> I think your solution here is saner.
>>
>> Will you pick up the patch please? I cannot find it in your tree...  
>> Thanks!
>
> Done!

This patch introduced a regression [1].
A reproducer can be found at [2].

[1] https://bugs.launchpad.net/bugs/1836914
[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836914/comments/4

Kai-Heng

>
> -- 
> Jens Axboe


