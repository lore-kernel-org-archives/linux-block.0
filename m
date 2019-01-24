Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB028C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC109218CD
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="geqZzyvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfAXQeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:34:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41848 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAXQeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 11:34:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3237427pfi.8
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 08:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wG+d0BThxRTBKbjQWuxmgTtp6rC8//crIJYX8a5+Y4U=;
        b=geqZzyvL9rKMaMSEQ4Gvhic7CVlO1U2Gi5bl2eODPJslCQ4YT9nIUdsvxXv390r1kM
         GH+khBcTIksNGY6xLrZribvAdF/3iuSZbCAh2Y0hjvkk1PlTzEbquohfzLZORth5NujU
         eM/0lQsl7biJF/VKXrmI9CiZjxsJ+4PLbWmbbGZPsGsgZklM8nEqjoGWRh+DNwhsljXQ
         0+HZgXtcrWO6WJFf7gOSeQQO2qhEsqUV7KTmyb6lcflC2G0BmqqILqsOPSuTA6Vl4CXV
         qMsSX+JoqBdfq0MsN9de6qEprGp95s9OHTG03hS1/QbgOp3U155x8EptGqzo9sx5xh8z
         ZwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wG+d0BThxRTBKbjQWuxmgTtp6rC8//crIJYX8a5+Y4U=;
        b=n4DDP5Jhz0v0M4FDUT5iFB3A8xxzp5kIk7a2fhj+wj3p+ZG03eY8GrUP5SKTydkI+u
         Kbgus/2ZvoFDKvTZBI+pd5SQGhghKwM62wY7mG37BtQL7YJW81m8ePdaT0NV9p8NhLtg
         wkhrXi6/WVo7HreanMwx4EJVhzFu5VgfOi1uElX0t2jTTrsrKOcXkOf9c4gW7SMfmAb7
         VRpfz8gV11P6XIqZpVedcAaKn8FTcJIExZM4bcpyc6LY1vTwjZ2Q3KKWizuVJyNcbWCr
         aymVdmneWj//JpgvuLzxQZpxgRx4xMXWWHfGLgOpgHk7P9YsGXGK2fyc1U0eoqwIRBX4
         Vlbw==
X-Gm-Message-State: AJcUukevsbBtfUGmvwxonrQ3LSxrWpDctdsblCj9fHxKlQrDWNim9FTy
        2K4HH0LOU1EfXYwboWhxCXRhnvHbERE=
X-Google-Smtp-Source: ALg8bN7FaCU5eZ9xF6HOrAw5lJnPcdUOQ3BuFVa35Qcq1v5jZndeed/Xn9ABSAGQYBQAjLU1uO9e6Q==
X-Received: by 2002:a63:5153:: with SMTP id r19mr6498668pgl.281.1548347660031;
        Thu, 24 Jan 2019 08:34:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w3sm31193494pge.8.2019.01.24.08.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:34:19 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix the cmd_flag_name array
To:     Bart Van Assche <bvanassche@acm.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
 <x49h8dygkih.fsf@segfault.boston.devel.redhat.com>
 <c3bde1b4-73ea-9120-0e6c-f9f57c0bbb24@kernel.dk>
 <1548347312.9266.98.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e2a2e33-7eae-30d8-cf58-2a3cd17b91b5@kernel.dk>
Date:   Thu, 24 Jan 2019 09:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548347312.9266.98.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 9:28 AM, Bart Van Assche wrote:
> On Thu, 2019-01-24 at 09:22 -0700, Jens Axboe wrote:
>> On 1/24/19 8:09 AM, Jeff Moyer wrote:
>>> Jianchao Wang <jianchao.w.wang@oracle.com> writes:
>>>
>>>> Swap REQ_NOWAIT and REQ_NOUNMAP and add REQ_HIPRI.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> ---
>>>>  block/blk-mq-debugfs.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>> index 90d6876..f812083 100644
>>>> --- a/block/blk-mq-debugfs.c
>>>> +++ b/block/blk-mq-debugfs.c
>>>> @@ -308,8 +308,9 @@ static const char *const cmd_flag_name[] = {
>>>>  	CMD_FLAG_NAME(PREFLUSH),
>>>>  	CMD_FLAG_NAME(RAHEAD),
>>>>  	CMD_FLAG_NAME(BACKGROUND),
>>>> -	CMD_FLAG_NAME(NOUNMAP),
>>>>  	CMD_FLAG_NAME(NOWAIT),
>>>> +	CMD_FLAG_NAME(NOUNMAP),
>>>> +	CMD_FLAG_NAME(HIPRI),
>>>>  };
>>>>  #undef CMD_FLAG_NAME
>>>
>>> Acked-by: Jeff Moyer <jmoyer@redhat.com>
>>>
>>> You might consider also adding a comment above the req_flag_bits enum
>>> noting that modifications also need to be propagated to cmd_flag_name.
>>
>> Agree... These things are notoriously difficult to keep in sync, this
>> isn't the first time we've had a fixup. Not sure if that situation
>> is improvable, but at least a comment might help.
> 
> How about making the build system derive the CMD_FLAG_NAME() declarations
> from the include/linux/blk* header files? It's not that hard to do that e.g.
> with the help of sed. The output of sed could be written into a .h file and
> that file could be #included from blk-mq-debugfs.c.

I'd be fine with that, if we already require sed for building other parts.
If it can't be handled with pre processor macros or similar.

-- 
Jens Axboe

