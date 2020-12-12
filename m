Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8603C433FE
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3DD22571
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 18:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407615AbgLLSPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Dec 2020 13:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406169AbgLLSPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Dec 2020 13:15:14 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36368C061793
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 10:14:34 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lj6so2575472pjb.0
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vPqkNEV8mHk/bP+lF6DmFa2iJcEPH5rRm6JP4KbBMo0=;
        b=uNnf2fVnys7JlLeW0LZFNtKvHbpjwOnfF1lAKwsomWXpUon3wNsJ4a3MFfW21IsGF3
         wdYTHO4V0jE85+uNBbo9caN8aVHcCZHNhcBVIhhSYVdaIlUMv/yUuibNYaaM8qjjOzfH
         07ESzSQ+tZiK2GPGzWyN7dtxk87LenjPiXmbeSkwoHtHwGfAwNekaG5L3PgsbLDhLnvk
         rHl91hu5kXyE+QCytGFWNyJJwBgG2wIDVa+Tr6DCvowP7S8xjBOsTcNFlGCrpsB+xu+r
         i6kqRktMbcC33kg+U9ohfDacpu7+ifKuNHeIrdACm6y3NAP+/89P3AfF+hbkSjZ4ohXX
         be3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPqkNEV8mHk/bP+lF6DmFa2iJcEPH5rRm6JP4KbBMo0=;
        b=N4Nau1rYHgTMYsTo/EVNm717Xih2wF833G12rkGxd7ffBGp5TWOajJ8KKqghULxoTu
         dMnQWrqoVEo0HYZtjvjs3pvqgKlsO7pLwAOcXGa1JsSgpKQ6PIndFcvDt8TVxf+JCkim
         cVXpUqkxrmm3VfndF9Y9HB8YtLU6Z/6ipB0B/BHBLfLi6DlxlOO0Y9z//gelI4h6nGpz
         fnZSF+f8DQJbkdjm2j1Kd9igMU/fMJG7ZuR6nQnv2qHd5FW2qHOth/U9PL6GjqFdSu8e
         GRiHEhCCAhRJahyWEBLc6ahP8Hyw+sCMf62a4lGelybJO7iSiao4k6VEv/NebXkyRItZ
         xkfA==
X-Gm-Message-State: AOAM5309T0jpq4LeKgAvFQl7+sH2d7nva9jQ6imI7EHwEbpB/eDrJt9T
        jUdlzGmLxuzsVJyEmrVfneYnpg==
X-Google-Smtp-Source: ABdhPJyzLfzuB0KUyKGFSNr6IYFEPAE0OXxmdsTO8gURDuRU0fhyabebg0ctlKQwB8lLEJ+t16aEuA==
X-Received: by 2002:a17:90a:df12:: with SMTP id gp18mr18051977pjb.43.1607796873727;
        Sat, 12 Dec 2020 10:14:33 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u24sm574816pjx.56.2020.12.12.10.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 10:14:33 -0800 (PST)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
 <06b4a10d-5ea5-27e1-af0d-83d5c714996f@kernel.dk>
 <b4f3ee74-58fd-52c8-ae60-f352758fb42a@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bc5ff77-4977-a9bd-3fb8-ce35e1179b94@kernel.dk>
Date:   Sat, 12 Dec 2020 11:14:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b4f3ee74-58fd-52c8-ae60-f352758fb42a@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 11:03 AM, Hannes Reinecke wrote:
> On 12/11/20 6:04 PM, Jens Axboe wrote:
>> On 12/11/20 9:56 AM, Hannes Reinecke wrote:
>>> On 12/11/20 5:33 PM, Jens Axboe wrote:
>>>> On 12/11/20 9:30 AM, Mike Snitzer wrote:
>>>>> While I still think there needs to be a proper _upstream_ consumer of
>>>>> blk_interposer as a condition of it going in.. I'll let others make the
>>>>> call.
>>>>
>>>> That's an unequivocal rule.
>>>>
>>>>> As such, I'll defer to Jens, Christoph and others on whether your
>>>>> minimalist blk_interposer hook is acceptable in the near-term.
>>>>
>>>> I don't think so, we don't do short term bandaids just to plan on
>>>> ripping that out when the real functionality is there. IMHO, the dm
>>>> approach is the way to go - it provides exactly the functionality that
>>>> is needed in an appropriate way, instead of hacking some "interposer"
>>>> into the core block layer.
>>>>
>>> Which is my plan, too.
>>>
>>> I'll be working with the Veeam folks to present a joint patchset
>>> (including the DM bits) for the next round.
>>
>> Just to be clear, core block additions for something that dm will
>> consume is obviously fine. Adding this as block layer functionality than
>> then exposes an application API for setting it up, tearing down, etc -
>> that is definitely NOT
>>
> That was never my intention.
> Any consumers of this thing would need to be in-kernel.
> If that was your concern.

Yep, that is/was indeed my concern!

-- 
Jens Axboe

