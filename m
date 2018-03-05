Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f51.google.com ([209.85.160.51]:39888 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeCEVqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 16:46:34 -0500
Received: by mail-pl0-f51.google.com with SMTP id s13-v6so10529365plq.6
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 13:46:33 -0800 (PST)
Subject: Re: [PATCH] bcache: don't attach backing with duplicate UUID
To: tang.junhui@zte.com.cn
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
References: <1520212069-29181-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <3dfa2d73-8790-6181-23b5-05baaa95f986@lyle.org>
Date: Mon, 5 Mar 2018 13:46:31 -0800
MIME-Version: 1.0
In-Reply-To: <1520212069-29181-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tang Junhui---

Thanks for your review.  I just sent it upstream (with your change) to Jens.

Mike

On 03/04/2018 05:07 PM, tang.junhui@zte.com.cn wrote:
> Hello Mike
> 
> I send the email from my personal mailbox(110950397@qq.com), it may be fail,
> so I resend this email from my office mailbox again. bellow is the mail
> context I send previous.
> 
> ====================================================
> 
> I am Tang Junhui(tang.junhui@zte.com.cn), This email comes from my
> personal mailbox, since I am not in office today.
> 
>>> From: Tang Junhui <tang.junhui@xxxxxxxxxx>
>>>
>>> Hello, Mike
>>>
>>> This patch looks good, but has some conflicts with this patch:
>>> bcache: fix for data collapse after re-attaching an attached device
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=73ac105be390c1de42a2f21643c9778a5e002930
>>> Could you modify your fix base on the previous patch?
> 
>> That doesn't make sense.  This patch was generated from a current tree
>> where it's applied on top of that: (It's based on next when it should
>> really be based on Linus's tree, but it doesn't matter for patch
>> application because there's no changes in next right now to bcache that
>> aren't in Linus's tree).
> 
> Originally, I did not mean merger conflicts, but the 
> code logical conflicts, since the previous patch add a new input parameter
> set_uuid in bch_cached_dev_attach(), and if set_uuid is not NULL,
> we use set_uuid as cache set uuid, otherwise, we use dc->sb.set_uuid as
> the cache set uuid.
> 
> But now, I read your patch again, and realize that you did not use 
> dc->sb.set_uuid, but use dc->sb.uuid to judge whether the device is a
> duplicate backend device, so it's OK for me.
> 
>> May I add your reviewed-by so I can send this (and your fix) upstream?
> Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Thanks 
> Tang Junhui
> 
> Thanks
> Tang Junhui
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
