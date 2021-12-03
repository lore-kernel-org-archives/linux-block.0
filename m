Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07BDC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 17:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhLCSBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhLCSBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 13:01:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7ADC061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 09:57:51 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id t8so3497080ilu.8
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9HRvEVtAEr9c7N8ChPmQSZrh5Blx26JLDK/LptgEGWw=;
        b=GTIJoB1WBdloOsiwGKhraLR0rgLkXvI9b2t4lD6YASa4Acytc0dDeXwGSDttK/Hza9
         IVPwSmKj/jTxqDwZHrfdk0q2MuiB9Zkak9plpPWI/m4IWeate5RNT5jQLlQaiy7cifNq
         rmEzG5YUzGAH1HvDflPdcG/DIVLc6t6nUad3Piipa8no86EnZOIcsdgqnCunBAM88LzV
         udgVrYVEO7z9VxoH0vPBlMpOjX1feWrzk83Mf9xaNXTSn+EUHto7Ta8rZbv5Lyutuh1N
         WULATrl/AH/4IVdzWEV4vrY8eTluFIGEr7zT52ZiYMiPmLUYY+lUNWIbdLKP2got9YfX
         NhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HRvEVtAEr9c7N8ChPmQSZrh5Blx26JLDK/LptgEGWw=;
        b=ua2ayBqvsLDc94ybWlT+0xG8unhGgbUIhVggH9V63Y+xjOdqvaUGfGRplSqVyszhXP
         2htjlNp7vEFvxJ2eOTVrSmoRBJlD4RsniQ1Fd1wFOISFMBKJYVrOqejR8BQTVsnWhJTR
         YjyPOkeosJKDGn4zwS+/dMUMbguQYo5g7aXT/Qu8HFkWYYTxZKTwnVmb7f06QmwglwRZ
         H1Jz5At/Vc7U4BpCZ96U/S1cqGi335sLAOsMspXPO4y2m9N4ADKlbT/uR87wiuEFZuw7
         HtauYjgynFnBOB5j1m4QPjVj8BKuoc2wahsQeg/L23Jt6DLCa15oyIwfsUs6yVj8z0My
         YUDQ==
X-Gm-Message-State: AOAM531LyrbMbcrQiTmzKe/++K+LAyV85kcJZpwO29ZPYCBDvTHWpWfC
        /pM+LFs+cFV5AcDbfMWG5CVoVpTBCltzE/um
X-Google-Smtp-Source: ABdhPJygaz1FMeiWGSw+fEZZQg9ntd6gm4rRB/U3Ra2GBEkmWsLMlTZNNLJKo0jAg9vgJrxEAp9pzw==
X-Received: by 2002:a05:6e02:1523:: with SMTP id i3mr20273366ilu.101.1638554270824;
        Fri, 03 Dec 2021 09:57:50 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y6sm1872621iln.74.2021.12.03.09.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:57:50 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
 <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
 <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
 <YapYAt7+r7K0aQ3+@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e386e230-4eef-f4da-f327-9b0f1d33fe47@kernel.dk>
Date:   Fri, 3 Dec 2021 10:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YapYAt7+r7K0aQ3+@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 10:46 AM, Matthew Wilcox wrote:
> On Fri, Dec 03, 2021 at 09:38:25AM -0700, Jens Axboe wrote:
>> On 12/3/21 9:35 AM, Jens Axboe wrote:
>>> On 12/3/21 9:31 AM, Jens Axboe wrote:
>>>> On 12/3/21 9:24 AM, Jens Axboe wrote:
>>>>> On 12/3/21 9:16 AM, Matthew Wilcox wrote:
>>>>>> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
>>>>>>> +++ b/include/linux/fs.h
>>>>>>
>>>>>> fs.h is the wrong place for these functions; they're pagecache
>>>>>> functionality, so they should be in pagemap.h.
> 
> I think you missed this ^^^

I did... That would mean moving some more of the declarations too. Prep patch
or just part of this patch?

>>>> That does introduce a dependency from fs.h -> pagemap.h which isn't trivially
>>>> resolvable...
>>>>
>>>> What if we just rename the above funciton to mapping_has_pages() or something
>>>> instead?
>>>
>>> Or just drop the helper, to be honest. There are more tests for
>>> mapping->nrpages right now than there are callers of this silly little
>>> helper.
>>
>> Like this:
> 
> I'm happy with this, if you just move it to pagemap.h

OK, I'll try it out.

-- 
Jens Axboe

