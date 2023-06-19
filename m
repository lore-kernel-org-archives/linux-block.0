Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08EEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 06:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFSGHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFSGHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 02:07:11 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6EDA
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 23:07:06 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qB82F-0005tz-Vv; Mon, 19 Jun 2023 08:06:44 +0200
Received: from [192.168.42.204]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qB82F-00076V-Dv; Mon, 19 Jun 2023 08:06:43 +0200
Message-ID: <f59c8494-009c-060b-3ddf-74b525c8b87a@uls.co.za>
Date:   Mon, 19 Jun 2023 08:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2023/06/19 01:56, Bart Van Assche wrote:
> On 6/18/23 12:34, Jaco Kroon wrote:
>> On 2023/06/12 20:40, Bart Van Assche wrote:
>>> tar -czf- -C /sys/kernel/debug/block . >block.tgz
>>>
>> Right on queue ... please find attached.  Not seeing any content in 
>> any of the files from the tar czf so I doubt there is much use here 
>> ... perhaps you might be able to explain why all of these files under 
>> /sys/kernel/debug/block would be empty?
>
> Apparently the tar command is incompatible with debugfs :-( I should 
> have tested the command before I sent it to you.
>
> Does this work better?
>
> (cd /sys/kernel/debug/block/ && grep -r . .) | gzip -9 > block.gz

Yes it will, but now we wait again.  And I really don't like waiting.

Wonder why tar won't work though ... but alas, it is what it is.

Kind Regards,
Jaco
