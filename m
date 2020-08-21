Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C603C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D720735
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgHUUXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:23:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36707 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUUXb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:23:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so1390373plt.3
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2gfWQvCm4JA4u/Phnm0jHU35F/XAL1Zg/HIvrShCJXg=;
        b=D6KBIrJDYccJMBeTk7P0IVgqRbQHlAHlWcmwKKhzltI5W4M4TvAIt4KTAoBpCHut3s
         ltZIn0hPvZu9Tn7z0TqqhI2YRNK7e3I6kvJVzeYTVvDCPU5KeSGxPb2Kdp/wHAjFnavc
         PAhVVYAx79oThCvQEUWnRfX5WTKR6bbD+rDpgBJp8mqKiwNuCdEWnQmDhIS4OV3tonuC
         WrfgCeiFQurcToDmqt15vFFIrFvsdmi8k6PuZppZZNzfDMWft14MFKNUZYt9PBGcns2h
         9wKaNuRBF+o89yiqtYWZUzUG9TbWHjXCkEoG0QgFtA1dqUsKxoXkbaMjngGDJKcDO7kd
         2yEA==
X-Gm-Message-State: AOAM530wx/pvWlI7c1sIQJWG37YxkDZD4+tTb0XJ5aqq30dw5mrf3ZRT
        3R3pNzAsdDT1kRF+TYW1KQI=
X-Google-Smtp-Source: ABdhPJyINuNiQe0BP36p529nR8soirHltcatsfn2ZNpAGrkwXR7VyCszxt64JLsmkDSTDtnIPLOIvQ==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr3701224plo.217.1598041410258;
        Fri, 21 Aug 2020 13:23:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712? ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
        by smtp.gmail.com with ESMTPSA id b22sm3418646pfb.52.2020.08.21.13.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:23:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
        kbusch@kernel.org
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
 <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
 <20200821062538.GD28559@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75b49877-7740-3bd7-2ae9-385c310d7498@grimberg.me>
Date:   Fri, 21 Aug 2020 13:23:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821062538.GD28559@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> So the one thing I'm not even sure about is if just ignoring the
>>> errors was a good idea to start with.  They obviously are if we just
>>> did a rescan and did run into an error while rescanning a namespace
>>> that didn't change.  But what if it actually did change?
>>
>> Right, we don't know, so if we failed without DNR, we assume that
>> we will retry again and ignore the error. The assumption is that
>> we will retry when we will reconnect as we don't have a retry mechanism
>> for these requests.
> 
> Yes.  And I think for anything related to namespace (re-)scanning
> we can actually trivially build a sane retry mechanism.  That is give
> up on the current scan_work, and just rescan one after a short wait.

There is no point in doing that if we are disconnected and will in
the future reconnect, which will trigger a scan that can actually
work.

>>> So I think a logic like in this patch kinda makes sense, but I think
>>> we also need to retry and scan again on these kinds of errors.
>>
>> So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
>> cancelled requests and have the scan flow assume that these are
>> cancelled requests?
> 
> How does nvme_submit_sync_cmd return -ENODEV?  As far as I can tell
> -ENODEV is our special escape for expected-ish errors in namespace
> scanning.

One of these escapes I guess :)

>> At the very least we need a good comment to say what is going on there.
> 
> Absolutely.
> 
>>
>>    Btw,
>>> did you ever actually see -ENOMEM in practice?  With the small
>>> allocations that we do it really should not happen normally, so
>>> special casing for it always felt a little strange.
>>
>> Never seen it, it's there just because we have allocations in the path.
>>
>>> FYI, I've started rebasing various bits of work I've done to start
>>> untangling the mess.  Here is my current WIP, which in this form
>>> is completely untested:
>>>
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
>>
>> This does not yet contain sorting out what is discussed here correct?
> 
> No, but all the infrastructure needed to implement my above idead.  Most
> importanty the crazy revalidate callchains are pretty much gone and we're
> down to just a few functions with reasonable call chains.

OK, that makes sense. I'm still not convinced the retry makes sense
though...
