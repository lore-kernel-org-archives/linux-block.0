Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76686C38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjAaPuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjAaPuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 10:50:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C618168
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:50:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g68so10333599pgc.11
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ie1Tu6T5P7OyMvhaX+1We9mgq07ImgIcLLeG4SwMOjQ=;
        b=FBtrIrhsOIusHWuD924kR02et5pmQOo5ll3SDYlQz1OpzF3wU7RhZoQ8QkA7psTAkw
         O/0S6cJ9x7tC8fxl9qbqLsZgluGJH637m0WSyW+8t46HfWl5CMTucaUizbWwuzmptkzp
         swVL+p9joaxNus898fhg+0Rfr9UMOZHLlbfnwSwPnxk5E/UVMuAbxEiAWYtfubwOqPce
         JFX18ON3fu8Tqmn47ViDigQg9nZxIODr3wSQ1BCLIb02cKzR1/pthU2HZ0la+If4INIT
         GUq6WLZyPjb6JYNwGkTRheCsETaGvK2QX5FMYCZDFqJbRY0i434VPfnc6AEIU0DgPHil
         dAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie1Tu6T5P7OyMvhaX+1We9mgq07ImgIcLLeG4SwMOjQ=;
        b=6AwW7uE32FBjFELinDA63IHsx9Bw5tMatkU88Dsm1cH9g6CFS/ZdLwzTWJpb58pilf
         iNbtARQFjy4vv3HGr0URXIvRT3xaWuRsLaoB/xp+yNTTJyhkxAEGVWfEk8W7mFGYxvEk
         PwpZroGUTTEaIRdyiPKGHILcrGtpFcTGBuh+A+QmsCUI84PrpuKRyyMbbtAWMya+h+lC
         WZRO6NmtHrbWhQ+qRsxNezGtVuM01kFwURamoPGdBdmKVsTXGxpu5LD/3O2u+V0h00fa
         /If4W46iMDWSoDtlBYjr6Ui11e6c4/TcODoyvB+OSvxplxipPVRB2RukwIN+YFIPb36x
         +RNA==
X-Gm-Message-State: AO0yUKXvOJjH4YgpZm+N/WrVQ7ArDvE9TeSvN4B6gTK6rfH0vQ3U1qbt
        eU3UgCDucRdV9+XvRTWcN31NcA==
X-Google-Smtp-Source: AK7set/Qs0lcf5OqHcsAR85kec39013TaL9a+mcutiC/DbFPsIp01hRf242WzD+iCei392fcSTBUWw==
X-Received: by 2002:a05:6a00:1804:b0:587:bdcc:bf0d with SMTP id y4-20020a056a00180400b00587bdccbf0dmr149966pfa.0.1675180207578;
        Tue, 31 Jan 2023 07:50:07 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bw6-20020a056a00408600b005810a54fdefsm9637183pfb.114.2023.01.31.07.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:50:07 -0800 (PST)
Message-ID: <f9930b12-bf71-0301-3168-d5a1981a9fa4@kernel.dk>
Date:   Tue, 31 Jan 2023 08:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: move FOLL_PIN debug accounting under CONFIG_DEBUG_VM
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
 <057142a9-b190-905a-5539-02d9d8a5d26e@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <057142a9-b190-905a-5539-02d9d8a5d26e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 8:48?AM, David Hildenbrand wrote:
> On 31.01.23 16:36, Jens Axboe wrote:
>> Using FOLL_PIN for mapping user pages caused a performance regression of
>> about 2.7%. Looking at profiles, we see:
>>
>> +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
>>
>> which wasn't there before. The node page state counters are percpu, but
>> with a very low threshold. On my setup, every 108th update ends up
>> needing to punt to two atomic_lond_add()'s, which is causing this above
>> regression.
>>
>> As these counters are purely for debug purposes, move them under
>> CONFIG_DEBUG_VM rather than do them unconditionally.
>>
>> Fixes: fd20d0c1852e ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
>> Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
>> Link: https://lore.kernel.org/linux-block/f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk/
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> I added fixes tags, even though it's not a strict fix for this commits.
>> But it does fix a performance regression introduced by those commits.
>> It's a useful hint for backporting.
> 
> I'd just mention them in the commit log instead, but I don't
> particularly care here as long as the commit ID's are stable.

Sure, I can move that bit into the commit message.

> If still possible, I'd include this as a preparational change for
> these commits instead. Anyhow

That would be preferable in general, but I don't think it's worth
rebasing the series just for that.

> Acked-by: David Hildenbrand <david@redhat.com>

Thanks! Will add in conjunction with updating the commit message.

-- 
Jens Axboe

