Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F098CC7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 19:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFLThJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjFLThI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 15:37:08 -0400
Received: from bagheera.iewc.co.za (unknown [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E77B1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 12:37:03 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1q8nL9-00087l-CZ; Mon, 12 Jun 2023 21:36:35 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1q8nL8-0007SU-J9; Mon, 12 Jun 2023 21:36:34 +0200
Message-ID: <f60c64e0-cfac-53bd-b164-92387c6910cf@uls.co.za>
Date:   Mon, 12 Jun 2023 21:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On 2023/06/12 20:40, Bart Van Assche wrote:
> On 6/9/23 00:29, Jaco Kroon wrote:
>> I'm attaching dmesg -T and ps axf.  dmesg in particular may provide
>> clues as it provides a number of stack traces indicating stalling at
>> IO time.
>>
>> Once this has triggered, even commands such as "lvs" goes into
>> uninterruptable wait, I unfortunately didn't test "dmsetup ls" now
>> and triggered a reboot already (system needs to be up).
>
> To me the call traces suggest that an I/O request got stuck. 
> Unfortunately call traces are not sufficient to identify the root 
> cause in case I/O gets stuck. Has debugfs been mounted? If so, how 
> about dumping the contents of /sys/kernel/debug/block/ into a tar file 
> after the lockup has been reproduced and sharing that information?

Looks to be mounted, at least I've got a /sys/kernel/debug/block/ folder 
on the relevant server.

>
> tar -czf- -C /sys/kernel/debug/block . >block.tgz

Definitely can do, I'm not sure how to interpret the data in this - is 
there anything specific you're looking for?  Would love to not just pass 
the information on but also learn from this.

Generally the lockup rate seem to be about once a week currently so I 
expect (on average) to see this pop again some time over the weekend.

Kind regards,
Jaco

