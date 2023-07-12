Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8EEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 10:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGLKNJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLKNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 06:13:08 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9114F1995
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 03:13:04 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qJWq5-0006CQ-PL; Wed, 12 Jul 2023 12:12:53 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qJWq5-0004RS-C8; Wed, 12 Jul 2023 12:12:53 +0200
Message-ID: <ea29d76f-99c0-fcf2-09a3-4cc2e18f87da@uls.co.za>
Date:   Wed, 12 Jul 2023 12:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
 <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
 <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2023/07/11 16:45, Bart Van Assche wrote:

> On 7/11/23 06:22, Jaco Kroon wrote:
>> So *suspected* mq-deadline bug?
>
> That seems unlikely to me. I have not yet seen mq-deadline causing an
> I/O lockup. I'm not claiming that it would be impossible that there is a
> bug in mq-deadline but it seems unlikely to me. However, I have seen it
> many times that an I/O lockup was caused by a buggy HBA driver and/or
> HBA firmware so I recommend to start with checking these thoroughly.
Care to share how or at least point me in a direction please?
>
>> Supermicro has responded with appropriate upgrade options which
>> we've not executed yet, but I'll make time for that over the coming 
>> weekend, or perhaps I should wait a bit longer to give more time for 
>> a similar lockup with the none scheduler?
>
> If this is possible, verifying whether the lockup can be reproduced 
> without I/O scheduler sounds like a good idea to me.

If I had a reliable way to trigger this it would help a great deal.  
Currently we're at 14 days uptime with scheduler set to none rather than 
mq-deadline, previously we had to hard reboot approximately every 7 days 
... again, how long is a piece of string?  A lockup proves the presence 
of an issue, but how long must it not lock up to prove the absence of?

Ideas/Suggestions?

Kind regards,
Jaco


