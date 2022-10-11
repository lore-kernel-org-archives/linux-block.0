Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F85CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJKQyH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJKQyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 12:54:04 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745AA59AF
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 09:54:02 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so6717818pjb.2
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 09:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AC9RnLQ6FtnT0b/u+5GXr5MIOjs95fXXop2vwcrIHok=;
        b=ov28gxQ1N66SK7hbj/StKGT9eOBsod+qCYSPc3fqT4YR85igHsPsXcbsmcpoHjiNhI
         sJQAjzfYhPIMXYwmUgCFsOafMX4FyzHtSDuUMUBKEk8vCjWKF1AVgIpsQYnJ9JelVpqu
         O3lQsm9HgLu88PHEG7nFAgtEFJlBDauYPO7/xbXPJghQ3EU+iMdv+wecz6I1b66RpLuy
         vrzSGKXJm5pITdmEI43cYgxiT+x9sRZILG7bvFDD7drTvLbRwnulFTgwN32GB6hHjhPS
         z6opSH1zLzQXe/zFJ0YeEuDDLYIthxjBDL2yxBTRRuVY3jRxbGQECTdHUBZwthXmkllR
         Pa6g==
X-Gm-Message-State: ACrzQf2Hi4vZEqSHHOJ8pZhzL4eWTdM7vePA9VMfU38a/uPxLevFkfnD
        0txCGbtHUJZVfhlfL0pB6rz1Dj9xW/8=
X-Google-Smtp-Source: AMsMyM4U1nAKEjdsXo1nP9XQ8xhb+/0plqg6wR1gh5Vn0pVRjIg4z99psXJpUoT7DrEOO35R+SMtJg==
X-Received: by 2002:a17:90b:1c8c:b0:203:89fb:ba79 with SMTP id oo12-20020a17090b1c8c00b0020389fbba79mr73931pjb.92.1665507241952;
        Tue, 11 Oct 2022 09:54:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9f77:abf2:346f:9b6e? ([2620:15c:211:201:9f77:abf2:346f:9b6e])
        by smtp.gmail.com with ESMTPSA id h25-20020aa796d9000000b0056126b79072sm9250448pfq.21.2022.10.11.09.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:54:01 -0700 (PDT)
Message-ID: <9114b8a3-5539-b705-ea47-f692f51dc4bf@acm.org>
Date:   Tue, 11 Oct 2022 09:53:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: again? - Write I/O queue hangup at random on recent Linus'
 kernels
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        Igor Raits <igor.raits@gooddata.com>,
        Daniel Secik <daniel.secik@gooddata.com>,
        David Krupicka <david.krupicka@gooddata.com>
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
 <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
 <acac67a6-3331-75dd-840a-40b509ada0c1@acm.org>
 <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/22 08:15, Jaroslav Pulchart wrote:
> čt 6. 10. 2022 v 18:57 odesílatel Bart Van Assche <bvanassche@acm.org> napsal:
>>
>> On 10/6/22 05:36, Jaroslav Pulchart wrote:
>>> I apply the
>>> echo 0 > /sys/block/vdc/queue/wbt_lat_usec
>>> at the production servers. I expect it will disable wbt. Could you
>>> please confirm that my expectation is correct?
>>
>> Hi Jaroslav,
>>
>> I have no experience with WBT. But what I found in the documentation seems
>> to confirm that the above command is sufficient to disable WBT:
>>
>>    What:         /sys/block/<disk>/queue/wbt_lat_usec
>> Date:           November 2016
>> Contact:        linux-block@vger.kernel.org
>> Description:
>>                  [RW] If the device is registered for writeback throttling, then
>>                  this file shows the target minimum read latency. If this latency
>>                  is exceeded in a given window of time (see wb_window_usec), then
>>                  the writeback throttling will start scaling back writes. Writing
>>                  a value of '0' to this file disables the feature. Writing a
>>                  value of '-1' to this file resets the value to the default
>>                  setting.
 >
 > we disabled the wbt, issue is happening much sooner. The logs are attached
 > 1/ "dmesg-20221011.log" form kernel messages
 > 2/ "command.logs" from execution of
 >      (cd /sys/kernel/debug/block/vdc && find . -type f -exec grep -aH . {} \;)
 >
 > Best regards,
 > Jaroslav Pulchart

(+Ted)

Hi Jaroslav,

Please reply at the bottom of an email when posting on a Linux kernel mailing
list (see also https://en.wikipedia.org/wiki/Posting_style#Bottom-posting).

Hi Ted,

In the dmesg fragment provided by Jaroslav I only see references to ext4. Are
you perhaps aware of any recently introduced issues in the layers between ext4
and the block layer? For the attachment provided by Jaroslav, see also
https://lore.kernel.org/linux-block/CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com/T/#m97ece301ca9a47ee8a4976f6c35ffcf55669b248

Thank you,

Bart.
