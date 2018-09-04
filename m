Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45770 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeIDOSs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 10:18:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so2396574lff.12
        for <linux-block@vger.kernel.org>; Tue, 04 Sep 2018 02:54:26 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
To: javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans.holmberg@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
 <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
Date: Tue, 4 Sep 2018 11:54:23 +0200
MIME-Version: 1.0
In-Reply-To: <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/03/2018 11:16 AM, Javier Gonzalez wrote:
>> On 31 Aug 2018, at 15.57, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/31/2018 03:34 PM, Javier González wrote:
>>> Matias,
>>> This patchset implements support for retrieving chunk metadata when
>>> submitting a reset/erase command. Patches 0 and 1 are small fixes that
>>> can be directly merged into your patch:
>>>       lightnvm: move bad block and chunk state logic to core
>>> Also, note that these do not apply on top of your for-4.20/core due them
>>> depending on patches that I sent before that you have not picked up yet.
>>> You can see them though in for-4.20/pblk. I'll rebase as patches in the
>>> list appear in your tree.
>>
>> Thanks. It is really confusing when you guys maintains an implicit order and posts the patches separately. I will appreciate that patches that are related are posted together, such that I don't have to manually track what comes before another. That makes it less of a pain for me to keep track of and we can keep the reviews together.
>>
>> This is the patches that I have in the pipeline (from before the e-mails from today):
>>
>>   - This serie - Pending review
>>   - Serie: pblk: support variable OOB size - Waiting on review from Igor
>>   - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't apply due to the fixes to the pad distance patch.
>>
> 
> Yes, I know and I apologize - we should have a better flow. What do you
> say that for windows like this, where we have a number of patches that
> have dependencies that we post them in meaningful patchsets and point to
> a branch where they are ordered, like in a PR? Then we can rebase and
> propagate changes properly?

I am with the patchset posted, that should have the order. I just wanted 
to mention it. One thing that would be good, if you do have patches you 
have upstream, feel free to push them in smaller increments, so we can 
pull them in as we go. Only a nitpick, it is obviously up to you guys 
how you want to do it :)

> 
> For this window, I'll rebase the rest of the patches in for-4.20/pblk on
> top of your for-4.20/core, then we can propagate changes as they come.
> 
> Javier
> 
