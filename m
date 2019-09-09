Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4070C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 22:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4834D21924
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 22:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="auH9GBQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbfIIWMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:12:31 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:42098 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388574AbfIIWMb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 18:12:31 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id C165E5E2CE;
        Tue, 10 Sep 2019 00:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1568067143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJY6UtPgPy1DP9gN4c817C4pfsRGmr4+oxLeVFeXGIg=;
        b=auH9GBQ5Ig0psgOQx4/Fvz/y6xv75xtD7xXx69OlkvSqZHGVa88anreUaGs12B3bdeAtbb
        gGWz/NRtOyC1CliD2e3fO+OiraYP+XH6CcRMwrDmyJ8So4/pObJWmqlnjwZY9N0XV9xq3+
        gsotEVYluBEoImCZRq0ZqNIXU/zBL3o9SWvuIKrN2yLjqNA/l/FQQAwzaIbQBVrs1xPkvX
        xEEwMWrlG3KtxBhJO87OIZiUcsJrtAW4YWrC7e5CsflXQQ0ermcRbA8VNgcnP3OA1rSnEx
        crC9eM1vKqXK+OUN/0CgFggH/uH1xfCEEAZcUHbAoBRvjUgAY7b5rMj757B6yQ==
From:   Manuel Bentele <development@manuel-bentele.de>
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     Manuel Bentele <development@manuel-bentele.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
 <4cc02259-24c0-0858-5439-5b1b0649d4f2@web.de>
 <48618bb6-45c5-34c7-2a9a-1a6ddf828e8c@acm.org>
 <ac915b98-9c4e-1f5e-70d8-258e2f6ef7ba@manuel-bentele.de>
Cc:     linux-block@vger.kernel.org
Message-ID: <256b093e-04ab-909a-734f-b5e8c8cfb7ea@manuel-bentele.de>
Date:   Tue, 10 Sep 2019 00:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <ac915b98-9c4e-1f5e-70d8-258e2f6ef7ba@manuel-bentele.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1568067144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJY6UtPgPy1DP9gN4c817C4pfsRGmr4+oxLeVFeXGIg=;
        b=Pjwc/sdDmJ6Nz4Tp3aSABG05vvse/7JdcM5rTFohx4oKdtEGCItSL1o+KFrRMmdFPoXzWv
        bq6799aDaltefpW7oFajPu2Ngdqq9xQFijs8TMGNAosGbFKyZps5627daBHm0oR49PqBVa
        fDTHhbj3TfIKW88tofUjH2+6dk9fNPR6hSQgyR3YxIT9ZW6uQiAYaAAwKdLE7ah4xgkn3t
        YrOEbqPryr7h3bybuxUrky7oINm1I8Xr3oGoKpq/sB2bCny5EgrRVl0oZFVkQXH3B2kg4M
        cuC2/c+X2KdWEYniZm4Zdi4stD3yTW2466/XPDUx9g6TEk2Tq/cIj1betH6dQg==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1568067144; a=rsa-sha256;
        cv=none;
        b=j7lsJaqn49LaAMicm/05FM/Ee5vP6aoKev5TkJblQQwEjTQsQy1SmddJz4EZqD707X6fBg
        8Xdd9LvpyuCJ8m/Gg0826XpIcZgCKLRk+TJ8x+KLI/qmGRWXHoity9H8ItJD8eJU/TycrT
        ZHQGjUfM6Bx9sTB0ZAbFXfGNGFBU39jKh8ktv5TMSNhnWwDZE4otAITEF15Hsb1KYjRdr1
        cQDpU9h0RVVLtCvUChQh8tU+4vyDIXDggcl0nSJn0E2WahU3AfwUEpMt3lAmVUziQIMYsJ
        M7e/g8ywKfXgrbJb43HKMAoZ1XwM3tITMIZ3RIyrNurZ/V336u8yMcllGphYAQ==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/19 2:15 PM, Manuel Bentele wrote:
> On 8/24/19 6:04 PM, Bart Van Assche wrote:
>> On 8/24/19 2:14 AM, Manuel Bentele wrote:
>>> On 8/24/19 5:37 AM, Bart Van Assche wrote:
>>>> On 8/23/19 3:56 PM, development@manuel-bentele.de wrote:
>>>>> During the discussion, it turned out that the implementation as device
>>>>> mapper target is not applicable. The device mapper stacks different
>>>>> functionality such as compression or encryption on multiple block
>>>>> device
>>>>> layers whereas an implementation for the QCOW2 container format
>>>>> provides
>>>>> these functionalities on one block device layer.
>>>> Is there a more detailed discussion available of this subject?
>>> No, the only discussion is the referenced one [1]. But there was a
>>> similar discussion in the master's thesis of Francesc Zacarias Ribot
>>> [2]. Unfortunately, I found no attempt on the mailing list that proposes
>>> his solution.
>>>
>>>> Are you familiar with the dm-crypt driver?
>>> I don't know the specific implementation details, but I use this driver
>>> personally and I like it. Do you want to propose that only the storage
>>> aspect of the QCOW2 container format should be used and all other
>>> functionality inside the container should be provided by available
>>> device mapper targets?
>> (+Mike Snitzer)
>>
>> Hmm, I haven't found any reference to the device mapper in the
>> document written by Francesc. Maybe that means that I overlooked
>> something?
> Oh sorry, you're right. I meant this in general for the topic 'QCOW2 in
> the kernel space'.
>
>> I referred to the dm-crypt driver because I think that's an example
>> that shows that QCOW2 file format support could be implemented using
>> the device mapper framework.
> Okay, now I get it :)
>
>> Mike, do you perhaps want to comment on what the most appropriate way
>> is to implement such functionality?
> To implement the QCOW2 format or other sparse container formats
> correctly, the implementation must be able to ...
>   - extend the capacity of the mapped block device
>   - shrink the capacity of the mapped block device
>   - rescan the paritions of the mapped block device
>
> Are all three functionalities feasible using the device mapper framework?
Because there was no answer, I have analyzed the device mapper in more
detail. I found out, that one can get access to the virtual and
"underlying" devices. The virtual device (mapped_device) is created and
managed by the device mapper. The mapped_device can be obtained in the
constructor of a device mapper target by calling dm_table_get_md(). The
function call needs the table of the dm_target as parameter and returns
a pointer to the mapped_device structure. The structure contains
pointers to the gendisk and the block_device of the mapped_device. The
"underlying" devices of the table can be obtained or added by calling
dm_get_device() in the constructor, too. The call returns a pointer to a
dm_dev structure. Then, the dm_dev structure contains a pointer to its
referenced block_device. Now there is direct access to the block_device
or gendisk structures. This means that one can implement the three
functionalities to support sparse container formats and implement my
file format subsystem and file format drivers as device mapper targets.
But one should take care of the direct access to the block_device and
gendisk structures in a device mapper target because sometimes there is
the risk of bypassing the device mapper framework. Please be careful and
read the comments and descriptions of the exported functions in the
device mapper framework.

Compared to the proposed loop device module integration, this approach
seems harder to achieve for me. Furthermore, the device mapper target
needs an additional user space utility to simplify the control of the
file format subsystem and drivers and help people who are afraid of the
dmsetup utility ;)

Would you accept the proposed file format subsystem and drivers
implemented as device mapper targets?

>> The entire patch series is available at
>> https://lore.kernel.org/linux-block/86279379-32ac-15e9-2f91-68ce9c94cfbf@manuel-bentele.de/T/#t.
> Note that PATCH [1/5] is missing in this series, although I've submitted
> it twice. I asked already in [1] for the reason but haven't received any
> answer, yet. Therefore, I temporarily insert a link to my repository
> showing the missing PATCH [1/5]:
> https://github.com/bahnwaerter/linux/commit/7a78da744b4c84809ad6aa20673a2b686bafb201
>
> Regards,
> Manuel
>
> [1] https://www.spinics.net/lists/linux-block/msg44255.html

Regards,
Manuel

