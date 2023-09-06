Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEFBEE14A9
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjIFWGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjIFWGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 18:06:13 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB99199B
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 15:06:08 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qe0es-0007EM-13;
        Thu, 07 Sep 2023 00:05:58 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qe0er-0006Fx-22;
        Thu, 07 Sep 2023 00:05:57 +0200
Message-ID: <5e75a5b3-00fe-cb41-a657-ceaf9119a963@uls.co.za>
Date:   Thu, 7 Sep 2023 00:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Jens Axboe <axboe@kernel.dk>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
 <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
 <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
 <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
 <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
 <29785264-a5f1-493a-df22-8fa291c3d28a@uls.co.za>
 <7794cbbe-c55c-47d2-b836-595083874273@kernel.dk>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <7794cbbe-c55c-47d2-b836-595083874273@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2023/09/06 23:22, Jens Axboe wrote:
> On 9/6/23 3:03 PM, Jaco Kroon wrote:
>> With the only extra patch being the "sbitmap: fix batching wakeup"
>> patch from David Jeffery.
> Should we get that sent to stable, then? It applies cleanly.

It's debatable whether that was what fixed the underlying problem.  
Personally it makes sense to me that it could well have been.

There are three things here that *could* have been the resolution:

1.  firmware bug on the MPT3SAS controller that was fixed by the 
firmware upgrade.
2.  the relevant patch (imho likely).
3.  other changes from 6.4.6 to 6.4.12 (I didn't spot anything that I 
think relates).

I'm also not convinced it was the controller, as such I think it likely 
that the patch in question was what did the trick.

Kind regards,
Jaco

>
