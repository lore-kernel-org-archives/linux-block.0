Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF6C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899F22146D
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nr/JtIQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899F22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLER7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:59:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55484 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeLER7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:59:24 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so22740339itg.5
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpPcrsADw7QFK6peSxeWUe3+0iVDEwjDYzLdZGe2oTs=;
        b=Nr/JtIQK4DWy8Wq62DX7iABUHcJ4xXBef1gIB1FbRj8RyDm46jQ+oihLcg3hbvxafi
         QPxvu+4rTPv0MZiuy34jfQYat0WhPt6NSMoHLiCXt/7jamNJE5O3u7lmls7ud7Iu5UZf
         THMA6wE5JFFqC58s08V/6/r3+PKH/GfPPwANywDPx9CfA+rgAoyPKomhMo+mRpHwA/XO
         ffebowJGEvt9aI3miHxSpe0QVSU2aJX+w1UUs1RMOquMX5p7KCkx9ZK6CWlrpF/FVFM/
         aYHykRbqtE8ui94SjxbOks91LVotDyOmpSBU33HUfXgbKAbb6GTCC63Nv+qUuMGhIyL4
         NgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpPcrsADw7QFK6peSxeWUe3+0iVDEwjDYzLdZGe2oTs=;
        b=QeEk0qiLBzIOiQsf7zZ5N0cC5J6529G8pe15Qki/b3rm74D/7s7HY3TDK1KhuYbyV1
         uiEDmUuZLmwEMSIBP31RyjNlhLE6TYclMYFyF0Tn6rzmwgvcS+onyuHbq+Z4FyYK5jPW
         mgshaAwjc9ZTWsUGJhpPWtvnR10+MuQMa7wVYpdX8bvschQ1r5nukG3VD1sURzil+/5i
         Eg6rRoUf7yalxBGQmMVmR7A4q3Uz9D+/MkVl4fRo8Q7C4m2N9IKQJhRw95rDCP3/vqgl
         FVow5kR0w/YYDmYwXuHAO2wqqKFzpbmm3wPbeNGDgXEbxydEdnmNdX2SFaD7DDuEtd8l
         bpfg==
X-Gm-Message-State: AA+aEWZU+Dm46r8yMG0HaSv3UDt0xS9DmhcqRT4vztczhNmln+2KKD1g
        iyl1eKiqnqqe+x0qWfnmKb6pXg==
X-Google-Smtp-Source: AFSGD/VSL3c0IUz0vxha7nONLRhSNry9b0fXiwDrxQvmcIM/wMSHgEs8K8eUSAvouLnQi0jUF2Bq3w==
X-Received: by 2002:a24:be06:: with SMTP id i6mr14327148itf.168.1544032763603;
        Wed, 05 Dec 2018 09:59:23 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 18sm1848889itk.28.2018.12.05.09.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:59:22 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013821.GA19605@roeck-us.net>
 <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
 <20181205175554.GA1810@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82d71778-c89d-7b95-7ebd-addfd0b5fe8c@kernel.dk>
Date:   Wed, 5 Dec 2018 10:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205175554.GA1810@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 10:55 AM, Guenter Roeck wrote:
> On Tue, Dec 04, 2018 at 07:25:05PM -0700, Jens Axboe wrote:
>> On 12/4/18 6:38 PM, Guenter Roeck wrote:
>>> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
>>>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
>>>> we queue the request up normally. However, the SCSI layer may have
>>>> already setup SG tables etc for this particular command. If we later
>>>> merge with this request, then the old tables are no longer valid. Once
>>>> we issue the IO, we only read/write the original part of the request,
>>>> not the new state of it.
>>>>
>>>> This causes data corruption, and is most often noticed with the file
>>>> system complaining about the just read data being invalid:
>>>>
>>>> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
>>>>
>>>> because most of it is garbage...
>>>>
>>>> This doesn't happen from the normal issue path, as we will simply defer
>>>> the request to the hardware queue dispatch list if we fail. Once it's on
>>>> the dispatch list, we never merge with it.
>>>>
>>>> Fix this from the direct issue path by flagging the request as
>>>> REQ_NOMERGE so we don't change the size of it before issue.
>>>>
>>>> See also:
>>>>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
>>>>
>>>> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> ... on two systems affected by the problem.
>>
>> Thanks for testing! And for being persistent in reproducing and
>> providing clues for getting this nailed.
>>
> 
> My pleasure.
> 
> I see that there is some discussion about this patch.
> 
> Unfortunately, everyone running a 4.19 or later kernel is at serious
> risk of data corruption. Given that, if this patch doesn't make it
> upstream for one reason or another, would it be possible to at least
> revert the two patches introducing the problem until this is sorted
> out for good ? If this is not acceptable either, maybe mark blk-mq
> as broken ? After all, it _is_ broken. This is even more true if it
> turns out that a problem may exist since 4.1, as suggested in the
> discussion.

It is queued up, it'll go upstream later today.

> Also, it seems to me that even with this problem fixed, blk-mq may not
> be ready for primetime after all. With that in mind, maybe commit
> d5038a13eca72 ("scsi: core: switch to scsi-mq by default") was a
> bit premature. Should that be reverted ?

I have to strongly disagree with that, the timing is just unfortunate.
There are literally millions of machines running blk-mq/scsi-mq, and
this is the only hickup we've had. So I want to put this one to rest
once and for all, there's absolutely no reason not to continue with
what we've planned.

-- 
Jens Axboe

