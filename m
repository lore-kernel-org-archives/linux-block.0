Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF96C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3D20828
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a4p6XGps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYQXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:23:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53906 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYQXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:23:36 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so599084itf.3
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5RYC5QkNPmWnV7M+cp152sH2vhCRnoMiK4CZtvvJh04=;
        b=a4p6XGpsh4XKbVLZAa544N9Eyip02ETThXf36Kzdq2N67nSugtAGMj8ZW02ZXjqcBo
         dGqv7gA4t4WGd4x9Zbe1UF99alCbkWJM56ao7ntWpb5lvOLioWPPDXd4q8TAN10gAsi7
         AakLjcW6gu94dkOkHpnZ4QUGGZPcF7ihTOTOtMQo1nP7Mw6r9DScn8NuMglhLQZtsV/v
         Ck5jE1PkfUR8r0LOZyyd3I6PzzP+TuAEpr6tCQ3BzlK6CvBCTWJVQcImhu6Rz0S64t9O
         XxRvJs+xo95Fz0UI0U6bgSmCt0ckkICGnrEtwE16vSxtoMypxGAKYQyA6nH5l5+sw2x8
         E/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RYC5QkNPmWnV7M+cp152sH2vhCRnoMiK4CZtvvJh04=;
        b=R4FVcniQm7NGtsU3CBIq4sF0GhdfSDya6dKBw7NklRwZ76uEN2sW811W1vfQGcU1dN
         eItn3tuq8cIAvtfvWCcRVrz3MTetlu+z/BJLOblxX6bQ1UIRNOZGMTw5hwcC8qzY8Q4s
         k95RwkOgRDtG/GITSaAVeMfbdZpTQC36UEprsV9/NSLRYLqPS9geEjLNHUOIFYLgt1mZ
         a604TSEWn2ubXXhvSbFZOiscvI74+8+fCpybNPL8Nrxg5VvIAZFeEvCZWM0xu/J1SGZI
         oTWpx4Bh/3pRwidXomDhJQc6l3Za6B9zx/5R1L5AFw4rvaNoJ1mDCF4iUwPegeRakMSP
         C8Fw==
X-Gm-Message-State: APjAAAUrKiCASCjQM56pMQiPP2eM/DWfwOzOgcsry8WB/ZUvDPgRM8tJ
        YatY3gzi15sS4Nxgcm79bjZKa34e+5qzEg==
X-Google-Smtp-Source: APXvYqzTFUytd6hF1JTNnC7hNWzLdzWp0tAu433Pimy4C35zggJYDouZ4iACNnRfPcoKlOa0F90WEg==
X-Received: by 2002:a24:6794:: with SMTP id u142mr9064550itc.84.1553531015661;
        Mon, 25 Mar 2019 09:23:35 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o11sm5992146itb.33.2019.03.25.09.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:23:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190325143521.34928-1-arnd@arndb.de>
 <1553530766.2955.51.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c77d293-8eb9-01aa-27f8-7f320082e182@kernel.dk>
Date:   Mon, 25 Mar 2019 10:23:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553530766.2955.51.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 10:19 AM, James Bottomley wrote:
> On Mon, 2019-03-25 at 15:34 +0100, Arnd Bergmann wrote:
>> On big-endian architectures, the signal masks are differnet
>> between 32-bit and 64-bit tasks, so we have to use a different
>> function for reading them from user space.
>>
>> io_cqring_wait() initially got this wrong, and always interprets
>> this as a native structure. This is ok on x86 and most arm64,
>> but not on s390, ppc64be, mips64be, sparc64 and parisc.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  fs/io_uring.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 6aaa30580a2b..8f48d29abf76 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -1968,7 +1968,15 @@ static int io_cqring_wait(struct io_ring_ctx
>> *ctx, int min_events,
>>  		return 0;
>>  
>>  	if (sig) {
>> -		ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
>> sigsz);
>> +#ifdef CONFIG_COMPAT
>> +		if (in_compat_syscall())
>> +			ret = set_compat_user_sigmask((const
>> compat_sigset_t __user *)sig,
>> +						      &ksigmask,
>> &sigsaved, sigsz);
>> +		else
>> +#endif
> 
> This looks a bit suboptimal: shouldn't in_compat_syscall() be hard
> coded to return 0 if CONFIG_COMPAT isn't defined?  That way the
> compiler can do the correct optimization and we don't have to litter
> #ifdefs and worry about undefined variables and other things.

That requires the types to be valid for !CONFIG_COMPAT, as well as the
sigmask helper.

-- 
Jens Axboe

