Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DEC433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiCYIfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiCYIfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 04:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766733AA51
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648197241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saAk925KE4YTcVBlOMWQBhUVk1WAYvAJga7iRSwNkWA=;
        b=HNXwiBS/2E7nYEWwYHxWiZi/Jw62McuqEjXuQtZQJLJ1WWeJXzgORx5oJMibIn+4gk+Sin
        4CH20me2HRfIQCVtx9MBW7IX3KuvIHvOgMkOz2Ps+VyDPhDLGecatg6D97J9Oy/JSN+mLF
        MCnzygiFlrRmdHSJ0qMhe0b14PzSaww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-1eM15YjuPQ2lJIQK-Suu6w-1; Fri, 25 Mar 2022 04:34:00 -0400
X-MC-Unique: 1eM15YjuPQ2lJIQK-Suu6w-1
Received: by mail-wr1-f70.google.com with SMTP id z1-20020adfec81000000b001f1f7e7ec99so2480356wrn.17
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=saAk925KE4YTcVBlOMWQBhUVk1WAYvAJga7iRSwNkWA=;
        b=z90Ikiwmz31QrEc3MZOh1bVgDJCTzj5989gTUQtPLWf+dm8j/8gIsAA97sci5x9da0
         Ik4LNBVZHgTxNmsTEHb9VM5zI30clfKT1zNhW39GBo+SqBCchvdYq05z6CTaU+t06QDu
         ebNGrLlDlNbJgacihLTlSk4QOzW57jpqKUw1j8WiFaZRP4FvRI7a0RPSSUGvUU2fB32j
         uMZq0n9HmdzwkLkTe9N+wnTjIkjv+TA1cb/tO69Cb+zT5z14YOUnXeJDtqA3gYLlKJ84
         RNotRPmHxt9Xk86989GBtanbRRVNLPMZtwO8fyQsEnDrTvJcvBtWyEbF7rLYoDmvlBsn
         v6EA==
X-Gm-Message-State: AOAM532bJflubevuFW+4I174B96xJOxIJ2Cym65hNwVrPEdRFBrGeWzh
        lCexrsWG2UyD/FQoG1TkHkHrb5pPBr5393GDfHIa0dvMH5zxxHwr53paH2iAOwgDqcXScCsJp5n
        PRcYfjSha+KAkmio+CT7yi9Y=
X-Received: by 2002:adf:ebc1:0:b0:1e6:1109:5a1c with SMTP id v1-20020adfebc1000000b001e611095a1cmr7979825wrn.228.1648197239011;
        Fri, 25 Mar 2022 01:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8GsEnvVVsBe7K8bvT5MIDoTV+RToKncLKw5H8I6Ep8Yar8zelHy4/ERbBduTX23N6Bxn9Ig==
X-Received: by 2002:adf:ebc1:0:b0:1e6:1109:5a1c with SMTP id v1-20020adfebc1000000b001e611095a1cmr7979796wrn.228.1648197238720;
        Fri, 25 Mar 2022 01:33:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4200:6374:a71a:a88:a4b? (p200300cbc70542006374a71a0a880a4b.dip0.t-ipconnect.de. [2003:cb:c705:4200:6374:a71a:a88:a4b])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b00203eb3551f0sm6341460wrm.117.2022.03.25.01.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 01:33:58 -0700 (PDT)
Message-ID: <86947c1a-090d-e101-d536-69818e2e8f5d@redhat.com>
Date:   Fri, 25 Mar 2022 09:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: zram corruption due to uninitialized do_swap_page fault
Content-Language: en-US
To:     Ivan Babrou <ivan@cloudflare.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com>
 <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
 <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
 <YjTCF37cUNz9FwGi@google.com> <YjTVVxIAsnKAXjTd@google.com>
 <CABWYdi0tgau=trCiGWULY88Wu1-=13ck8NikV0KxfDQHFCCiMA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CABWYdi0tgau=trCiGWULY88Wu1-=13ck8NikV0KxfDQHFCCiMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.03.22 03:10, Ivan Babrou wrote:
> On Fri, Mar 18, 2022 at 11:54 AM Minchan Kim <minchan@kernel.org> wrote:
>>
>> On Fri, Mar 18, 2022 at 10:32:07AM -0700, Minchan Kim wrote:
>>> On Fri, Mar 18, 2022 at 09:30:09AM -0700, Ivan Babrou wrote:
>>>> On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
>>>>> I'm making an internal build and will push it to some location to see
>>>>> how it behaves, but it might take a few days to get any sort of
>>>>> confidence in the results (unless it breaks immediately).
>>>>>
>>>>> I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
>>>>> locations yesterday to see how it fares.
>>>>
>>>> I have some updates before the weekend. There are two experimental groups:
>>>>
>>>> * My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
>>>> machines in this group across 5 datacenters with cumulative uptime of
>>>> 916 days.
>>>> * Minchan's patch to remove swap_slot_free_notify. There are 376
>>>> machines in this group across 3 datacenters with cumulative uptime of
>>>> 240 days.
>>>>
>>>> Our machines take a couple of hours to start swapping anything after
>>>> boot, and I discounted these two hours from the cumulative uptime.
>>>>
>>>> Neither of these two groups experienced unexpected coredumps or
>>>> rocksdb corruptions.
>>>>
>>>> I think at this point it's reasonable to proceed with Minchan's patch
>>>> (including a backport).
>>>
>>> Let me cook the patch and then will post it.
>>>
>>> Thanks for the testing as well as reporting, Ivan!
>>
>> From 1ede54d46f0b1958bfc624f17fe709637ef8f12a Mon Sep 17 00:00:00 2001
>> From: Minchan Kim <minchan@kernel.org>
>> Date: Tue, 15 Mar 2022 14:14:23 -0700
>> Subject: [PATCH] mm: fix unexpected zeroed page mapping with zram swap
> 
> Is there any action needed from me to make sure that this lands into
> the mm tree and eventually into stable releases?
> 

Sending it as a proper patch with a proper subject, not buried deep down
in a conversation might help ;)

-- 
Thanks,

David / dhildenb

