Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB6C433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhKZRKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhKZRIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 12:08:51 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970CC08E88C
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:38:54 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e144so12069291iof.3
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vsDYyD+cqa31UWbKWn3gas7TG3YgDSdxqBh84x5L8ZQ=;
        b=4ESDl6lIvAIA7bOq6LGoDfK7Gwkb+PT9CmrOAImhA+cOokgC/h2sx79QIXCzGh3gGV
         yLvyHVLMsBufmmzCdxxhsOe3eh+/0o/hKya/BTEsAT87tDg1ePxhKm4YlmI1MQLJ20Nu
         wOKeL+/5fpRhAKikI5Pwr/4R+f6vjkHbdxvXZ/L3HymKTWt2t10skpHnfXNUvTkumCJE
         9YH3ITIqSmXXmlQvD1F3JDX5PzzvffQ6k7tmqmYjuM1nKAHTSnaDxlcCD6GGU4Y2eZxV
         Js/SoxwpXFtCLkwvnSrZ2350LWT78HEWFdfzF3NIbEll8FQQgKIa0ln/zJZ5Vp0RO4LP
         LQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsDYyD+cqa31UWbKWn3gas7TG3YgDSdxqBh84x5L8ZQ=;
        b=4UCdPUNdcNqKR+u0Hu9r0dztb1Z7fteAlYsilbA+4D5Dv+hUHttw1OQqlAxzqBmEB5
         N3ynqcfLFWZhfh0ujimR92skCP2+piYq7u2FO1Sxx1vYP7JbUeQT+0VFeibDPUAmxRep
         Y096wpUfU7uKulotR8yKGtA7aAR8I1A7d8K8JtjUU7Q/uIAD9PR6vsS6wnzxERC3qyuZ
         Lf6F6VHA9QsaXvV5igHBmKF7HuDk11ol3fEWq3ugZITiKGWG4R3Nw7j1fz6jGd4/Eff/
         Y+l4Avmfz17srmWtVrHKJ/Ytaqii7c4eadU1Tz7CvUmt3zlmGy9aGfJpDcgehPBCB84v
         r0HA==
X-Gm-Message-State: AOAM532OwYvIv0G9mUvbd3akRuE43M8xNqVFVhbJ4RFydsZiM6zL3Ia5
        WZgMoMfJogM2tJP6A+jW9nPjzEZnfIqEzjsC
X-Google-Smtp-Source: ABdhPJy6Fr2SyRiPCTw5yO6VHzXFMZvuF8L8jxBUn5IVGPHs47ZI+wXZFvxdK9nYItMMuXbDqmFINw==
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr41933014jad.21.1637944734024;
        Fri, 26 Nov 2021 08:38:54 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i8sm3817392ilu.84.2021.11.26.08.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 08:38:53 -0800 (PST)
Subject: Re: [bug report] WARNING at block/mq-deadline.c:600
 dd_exit_sched+0x1c6/0x260 triggered with blktests block/031
To:     Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
 <YaBGI7bR/9ot514F@T590> <YaEKWPlAmDJYV6Si@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d909e3a1-942a-efe8-0f8a-f1206676a40f@kernel.dk>
Date:   Fri, 26 Nov 2021 09:38:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YaEKWPlAmDJYV6Si@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 9:24 AM, Ming Lei wrote:
> On Fri, Nov 26, 2021 at 10:27:47AM +0800, Ming Lei wrote:
>> Hi Yi,
>>
>> On Thu, Nov 25, 2021 at 07:02:43PM +0800, Yi Zhang wrote:
>>> Hello
>>>
>>> blktests block/031 triggered below WARNING with latest
>>> linux-block/for-next[1], pls check it.
>>>
>>> [1]
>>> f0afafc21027 (HEAD, origin/for-next) Merge branch 'for-5.17/io_uring'
>>> into for-next
>>
>> After running block/031 for several times in today's linus tree, not
>> reproduce the issue:
> 
> Yi, it should be one for-5.17/block only issue, please test the
> following patch:

Good catch, again - can't believe this keeps biting us, guess we just
have to get used to this pattern. Though not expecting many changes
there in the future, so maybe not a huge issue.

-- 
Jens Axboe

