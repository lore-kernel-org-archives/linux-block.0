Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0885C47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C90222C0
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Q7RcWQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfJDSwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:09 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41521 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDSwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 14:52:08 -0400
Received: by mail-pl1-f173.google.com with SMTP id t10so3532482plr.8
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OrTnY+mm3WX+7dBQM/JfufoJxg4sjmrddJaAwoFljnY=;
        b=1Q7RcWQ7bqSz3AhSuGeUNDz9lo522L87uvc53JuPVZCkKwUq8hivNFP0Av/oqbM2zv
         kcz9NSs4+376/fCE8GMSLlSSfPr34uy+tspOM+TKS/yYqNfXwemcAvdgxctUvDEbneXp
         WB/gtZ6A5OGL7zuQUsGUCYdHJ812KonBuNT0EYkAdUTW3DgU0AL8RAXLqWE43m8sb1GZ
         ahUQu0nCvTor4p0KWe6L2JzlIAA6MGR2ytPLqD2GNAfdqUlXUK5tko7tUhOVDWjrgAl6
         QxZxNOxIrsJiOQsrwyWqL2ACAYyssjsW70ToMslme72igmzTeodNdTcn7yEoaVqNUEmY
         m/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrTnY+mm3WX+7dBQM/JfufoJxg4sjmrddJaAwoFljnY=;
        b=WjBs/aL8gDf2uwIemJMaa0VNsjmPTelqj6mgUCYNJKjFQNbb9ZASK+cwgb4BET6h81
         dBXnhvRYD2v4mByU0MSrQlyEi3apjErzXQ20iQYmE7vvYOK0HgyHry9LD99kCKa6ubWO
         mmde9HeSrkmqK/M9S2JhrrW/Gb9nW/49/BxydiYNaA2fxcvFPH9isZxIMw7Rfo0IYmMa
         yfL7+H98eqfj16dm9A7h6EmnJBR+UjgUcO4U9kUusHZzS7mvh4v4EuJ0BCdgAgu/x8qT
         SPnqYhNcxQmepgl0EV/8C5VVI5BrODzVb11o31Ur0Jz86vHBpKtuy7XKxQc+wd/y6KnP
         BUdg==
X-Gm-Message-State: APjAAAVHSboH05/eR6tMsvMpeFqyXt4D+ySztH0llo1IdUos/R9Oh3Hs
        GxjC9RbjNI7NelsC/21p2AtU1QJ4AScC4w==
X-Google-Smtp-Source: APXvYqy2ohSniTYxQ2bFCEcGQao6wZQJ86a0+ICypP9ASol0VT3IEySR3Bcuu/JN/nqlEFuyg2ULOQ==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr15458406plp.103.1570215127360;
        Fri, 04 Oct 2019 11:52:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j126sm7820898pfb.186.2019.10.04.11.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 11:52:05 -0700 (PDT)
Subject: Re: [PATCHSET v2] io_uring: support fileset add/remove/modify
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191004162222.10390-1-axboe@kernel.dk>
 <x49pnjcl6jk.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0fc6aee0-f9bd-fa5b-3ea9-eb5463a8373a@kernel.dk>
Date:   Fri, 4 Oct 2019 12:52:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <x49pnjcl6jk.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/19 12:17 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Currently we only support registrering a fixed file set. If changes need
>> to be made to that set, the application must unregister the existing set
>> first, then register a new one.
>>
>> This patchset adds support for sparse file sets (patch 1), which means
>> the application can register a fileset with room for expansion. This is
>> done through having unregistered slots use fd == -1.
>>
>> On top of that, we can add IORING_REGISTER_FILES_UPDATE. This allows
>> modifying the existing file set through:
>>
>> - Replacing empty slots with valid file descriptors
>> - Replacing valid descriptors with an empty slot
>> - Modifying an existing slot, replacing a file descriptor with a new one
> 
> I don't pretend to understand the socket code you wrote.  The io_uring
> bits look good to me.  I also added a testcase to your file-register.c
> program--diff below.  The test passes, of course.  :)

Great, thanks Jeff, I'll add this to the test case.

-- 
Jens Axboe

