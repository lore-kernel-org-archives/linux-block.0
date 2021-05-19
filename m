Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39230C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190056024A
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 15:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbhESPxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhESPxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 11:53:23 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 May 2021 08:52:03 PDT
Received: from resdmta-ch2-02v.sys.comcast.net (resdmta-ch2-02v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5344C06175F
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 08:52:03 -0700 (PDT)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40])
        by resdmta-ch2-02v.sys.comcast.net with ESMTP
        id jOJ5l8NnOLnUajOUNlUwz3; Wed, 19 May 2021 15:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1621439523;
        bh=AtpN7XokfCmtNz4fE2d1fHQyikNAN1wi6PNzEpHOoLo=;
        h=Received:Received:Received:Reply-To:Subject:To:From:Message-ID:
         Date:MIME-Version:Content-Type;
        b=VbowhQnXX677nZ02lwiXfXt/H2kpNHtgVSVU38I+ahp0WsF04EFnXxf1k3EA5IhWz
         Er/F2DxHqJ8fEr4if90VcitM76AqtUekEMw87ukhY7+kJibHrY6KYLRBuzD4rFYzqS
         AufWOj2ZvyWEBJ1p9d/DOkB32l6sN+4FGZ+gUTcKO12CBWD4behosSSW3V1IkcsOAo
         bSRGWknmhRp9DFHssQbpilB+INLgB4gLlZYIc8O7tZ1F83G5YPxaPdxXXMsbpF/e9A
         ukgOfb9LmZ7YJ8lB05KYTSolfstEMX5+ogpv/bBDZreqe2ZDrbFW3YxrpyTAn2oyOS
         C1DaODsjj+tbw==
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-08v.sys.comcast.net with ESMTP
        id jNOjlsSk05RiAjOTOlwJhe; Wed, 19 May 2021 15:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1621439462;
        bh=AtpN7XokfCmtNz4fE2d1fHQyikNAN1wi6PNzEpHOoLo=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=ePXnJieLwW3STTuWGUpT5Gp2ulHM74DiY7Rsm0EA0dI9SDPFkgWGRJah1+U/u1kdl
         eFDGh8Ay+zbwavK420u7qH57UELG9tj6ckRtXSLtvRdNg07p4nOeKHRjh9yt9HEAPZ
         RxV1Uza1x7iNrvLGYuWo3BVLp2hMvDe8dDbkz3p9Iv5gU2sqZa0My76JLWA/7xELAo
         u6Alt8l6AsmS/UgupaTN7C9QeydEKDLgnrQMsq6DOJBxdvXmlXxBppOmg5J4l1jY4g
         CR/leRwm3wRrM9OexT2pPib0D3Fy7CY8ug2Hl5pUBYXwdPZGjQ74N65vxEZPYLEyM9
         knhmkpVDP1J5Q==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d]
 ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-ch2-07v.sys.comcast.net with ESMTPSA
        id jOTMlmJqKUPp4jOTMllpl9; Wed, 19 May 2021 15:51:01 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Reply-To: james@nurealm.net
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s! -
 RIP smp_call_function_single
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-smp@vger.kernel.org, linux-block@vger.kernel.org
References: <3516e776-6c69-2a83-6da4-19de77621b18@nurealm.net>
 <20210517122709.GC15150@lst.de>
From:   James Feeney <james@nurealm.net>
Message-ID: <6b22e76e-1e37-fda0-0dd5-3021e2f0b9e2@nurealm.net>
Date:   Wed, 19 May 2021 09:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517122709.GC15150@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/21 6:27 AM, Christoph Hellwig wrote:
> Any information of the system?  What block driver(s) do you use, how
> many CPUs, kernel config?
> 

Hey Chris

I see that Markus followed-up with:

====
Well, turns out I should've googled (or at least looked at the bcache wiki entry) at first, which points to a known bug involving bcache and 5.12: https://www.spinics.net/lists/linux-bcache/msg10077.html

I still find it interesting that I get the same symptoms that James describes, but other than that the issues don't seem to be related.
====

For my part, I also had to re-run my bisect, with more thorough testing.  The result changed, and we are currently investigating the final commit, at 4f432e8bb15b x86/mce: Get rid of mcheck_intel_therm_init().

So now, I expect that my issue has nothing to do with your patch set.  Sorry about the noise.  If you still have an interest in my issue, there are posts going to linux-smp and lkml.

James

> On Fri, May 14, 2021 at 12:39:59PM -0600, James Feeney wrote:
>> With the patch to kernel/smp.c in linux 5.12.4, "smp: Fix smp_call_function_single_async prototype", by Arnd Bergmann, I thought maybe there was a fix.  But no.  The error is the same, except the top of the Call Trace is different:
>>
>> ...
>> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! ...
>> ...
>> RIP: 0010:smp_call_function_single+0xeb/0x130
>> ...
>> Call Trace:
>> ? text_poke_loc_init+0x160/0x160
>> ? text_poke_loc_init+0x160/0x160
>> on_each_cpu+0x39/0x90
>> ...
>>
>> and repeats indefinitely.
>>
>> Again, smp_call_function_single is defined in kernel/smp.c
>>
>> It seems that my git bisect is probably off, since apparently the system may sometimes boot to a temporarily working state, and some "exercise" is needed to identify the failure.  However, see another git bisect for possibly the same issue at
>>
>>  https://bugs.archlinux.org/task/70663#comment199765
>>
>> with "bisect-result.txt"
>>
>>  https://bugs.archlinux.org/task/70663?getfile=20255
>>
>> Markus says, in part:
>>
>> ====
>> Trying to bisect, I arrived at a different set of commits though.
>> 7a800a20ae6329e803c5c646b20811a6ae9ca136 showed the issue described, where a seemingly working kernel will lock up rather quickly.
>> f007a3d66c5480c8dae3fa20a89a06861ef1f5db worked flawlessly, without any hiccups doing random internet browsing while I was compiling the next bisect step.
>> However, there are six commits between those, that did not boot and left me stuck with a black screen right after the bootloader (so no systemd startup message or similar). The system did not react to any inputs (Alt+SysRq) or to a short press of the PC's power button, and thus a hard shutdown was necessary.
>> ====
>>
>> These 8 commits - total - are from Christopher Hellwig, 2021 Feb 02.  Perhaps something closer to the real issue is in there.  As with Markus, I've also noticed that a "warm" reboot can result in a frozen system immediately after the boot loader has run.  A full power-off reboot is needed to get past the early screen initialization.
>>
>> I'll have to re-do my git bisect, with more extensive system "exercise", to see if something more useful results.
>>
>> James
> ---end quoted text---
> 
