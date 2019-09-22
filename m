Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C98C3A5A6
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F331206C2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gi53Zs06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfIVQZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:25:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44768 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbfIVQZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 12:25:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so5340746pll.11
        for <linux-block@vger.kernel.org>; Sun, 22 Sep 2019 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hltgf71YapihTcBTRmZa9sf8qZmrsGrRP3YUTaQJH34=;
        b=gi53Zs06TVrBKLqi4ojcw4GlBhizPcf8/+iDWsBPDrfDyqEZsocglW+owMPsuvxmT2
         XOXnMSXPmhZjUWn0yWtyrMF5hqeDSsLbETNlmWf901K0xP+GLO4LFRIRwhZVovD2/o07
         aL6vMIpnE0sk7vn5gLqKv3m2m2dSvQquf4e0k7cUEErIDpADFi/LVa4+7+5llClDPCiP
         HQrMcQxA4i1Vm8HdYlqF/buA2pSkH74daUCqeIE2EKoQ+erRIc2bzLnoGuLb6TrWc/1P
         cYXwJ/X5oZCkzsHEQVxjXC3JwyoO9Eo/+jpLdX7+AteIdnWTUrLZinjErsPBM6rAB9/2
         RKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hltgf71YapihTcBTRmZa9sf8qZmrsGrRP3YUTaQJH34=;
        b=gU8iit0GYq9QDNzWOMo4kQCNn+vM9LYI2l15Y1v+9RZfbyEnfZ4RN5wqX5JthCzpoL
         RgnppBAsQNyWuROH7oOR8h7uTWz4JweqjNfpfdEoNVcybee5TzmReFs2yBjiZ01C9ke7
         5KdxJIL+KmSIsTX7ujFfzAeLMXDiYlUPEHk3xfMYMhEEKu+Vao9YfoVJJN6c3A6Ykm/h
         LNtujF/AGzJFEUXifS3OjWdV3ur5+awWs4WnSmtQ8QjyKz/Dscs21PtzuAVuAuaAetes
         lR8iAnrSov7giZYgVRPTQwbdeEAaqzH89qdvmXwZ4o3MiwhYB7w1w0KvfXwHV7T3ty2m
         nl+Q==
X-Gm-Message-State: APjAAAVWuAmHQB7M19fvPw8sHxQyz+//1Ranf4lcu64sUzVcSOposvSD
        dhBdollwd/PCtL9asOR2SasjNbQ7dNan3A==
X-Google-Smtp-Source: APXvYqyZA7uBo+Vg18dsxIp9TIJAazh6e7vYLlykyZA6RQGeYEs6GbfSydQZCTd9gWmc9Q7ovXXe0A==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr28584870plb.84.1569169517813;
        Sun, 22 Sep 2019 09:25:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f128sm12544147pfg.143.2019.09.22.09.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 09:25:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     Max Gurtovoy <maxg@mellanox.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
 <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> <yq1tv955kfy.fsf@oracle.com>
 <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
 <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddd909c8-1309-5830-0669-371d2ae839fc@kernel.dk>
Date:   Sun, 22 Sep 2019 10:25:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/19 3:38 AM, Max Gurtovoy wrote:
> 
> On 9/22/2019 2:29 AM, Jens Axboe wrote:
>> On 9/21/19 4:54 PM, Martin K. Petersen wrote:
>>> Jens,
>>>
>>>>> block/t10-pi.c: In function 't10_pi_verify':
>>>>> block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
>>>>>                          not handled in switch [-Wswitch]
>>>>>           switch (type) {
>>>>>           ^~~~~~
>>>> This commit message is woefully lacking. It doesn't explain
>>>> anything...?  Why aren't we just flagging this as an error? Seems a
>>>> lot saner than adding a BUG().
>>> The fundamental issue is that T10_PI_TYPE0_PROTECTION means "no attached
>>> protection information". So it's a block layer bug if we ever end up in
>>> this function and the protection type is 0.
>>>
>>> My main beef with all this is that I don't particularly like introducing
>>> a nonsensical switch case to quiesce a compiler warning. We never call
>>> t10_pi_verify() with a type of 0 and there are lots of safeguards
>>> further up the stack preventing that from ever happening. Adding a Type
>>> 0 here gives the reader the false impression that it's valid input to
>>> the function. Which it really isn't.
>>>
>>> Arnd: Any ideas how to handle this?
>> Why not just add the default catch, that logs, and returns the error?
>> Would seem like the cleanest way to handle it to me. Since the
>> compiler knows the type, it'll complain if we have missing cases.
> 
> what about removing the switch/case and do the following change:

It's effectively the same thing, I really don't think we need (or should
have) a BUG/BUG_ON for this condition. Just return an error?

Just include a T10_PI_TYPE0_PROTECTION case in the switch, have it log
and return an error. Add a comment on how it's impossible, if need be.
I don't think it has to be more complicated than that.

-- 
Jens Axboe

