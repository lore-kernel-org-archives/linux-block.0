Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D652C4332F
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhKYQQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbhKYQOz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:14:55 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5EC06175E
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:00:01 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id j7so6236804ilk.13
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W1H1/OqzWONOwkmnXRSgAJv5ASwvwk/7xQAco2zbWHo=;
        b=XwaR+PwrvisMARVt1o6TSNK2p/Khrsc0ZfcfF0nb7xykVxfQ1MMwUDtLSEMqBYq8MM
         Ld3ZTi/Wz0rxYUwnmqwsRGCA2lpZInWU+X4IYL+4uOaHknzqo1OuoiYueVZzlxz3qefq
         IZ16ukK7esv4b1ICSRngpjOXkQf4wbHlm/63Wr3dkFSfngKsv4hQDgLQuXSFH3bun+yB
         NkfbI7sdsiE5MtBXSNDsg39cJ2GgtHu6pRV06mHkpGuRvuK/XtfXwlQp86e7E5TebReB
         YW6ln7vndswlc8vQBTg0gVBGMJgNXckiY6Dv6tQHvu8joBeENaRxyWz6nLocUowBQiY+
         y6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1H1/OqzWONOwkmnXRSgAJv5ASwvwk/7xQAco2zbWHo=;
        b=7klrZIpK/Ew3W6ld+ruZrLlyTJYAcCEu77yBhJKPR0d05Ijm80beumsHvEf69E+fM4
         1ILPekczejZHw81so0HrBRnjqVsbuuBJoYY5fWxqtinCLZaFvsW5vqHDHW7s5DECK5Fn
         VZ2pwbD9vYjFrvz6VfNXnGWvxvBvmHkiNOEYi7YwCmKXAMS8BSzR4KCEayVfcUPO8VLH
         MGsLjrp88AUvoo+g+Ad5tKI59xwze/ZowLCtf5gD0D5w+rOhvTW4SIYo0e5ypa/AmLee
         SO7GMkc/1Lt8Kz4Viy56X9e2Gvf4IK53VVcRfH8wPkA3GevMkwIkWVGw6/82gJ6epTKP
         M2NQ==
X-Gm-Message-State: AOAM5309WRFhcUp23cWKHq8T56x9Ldq5l9Yr+LnyVCrJhynapaI/TdNn
        Z87eDMq7HoHfZwTzv32ZMydUQv6jK5ntllgh
X-Google-Smtp-Source: ABdhPJx/leFzevbJKm39V27GTB1Oc+k6/sVr/7S6H/KUHJwP7sTZSdamwZ1Q62CT8XyRv8TctjIBvg==
X-Received: by 2002:a92:da0f:: with SMTP id z15mr23607377ilm.151.1637856000854;
        Thu, 25 Nov 2021 08:00:00 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm1627267ilj.41.2021.11.25.07.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:00:00 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YZ+X/qGC6/w3bp2c@infradead.org>
 <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
 <YZ+mI9a1Jd2/zNkh@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d933bfa-eeec-2b9a-ab91-aa1140a41f62@kernel.dk>
Date:   Thu, 25 Nov 2021 08:59:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ+mI9a1Jd2/zNkh@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/21 8:05 AM, Christoph Hellwig wrote:
> On Thu, Nov 25, 2021 at 07:55:38AM -0700, Jens Axboe wrote:
>> On 11/25/21 7:04 AM, Christoph Hellwig wrote:
>>>  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
>>>  drivers/nvme/host/fabrics.c       |  3 ++
>>>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
>>>  drivers/nvme/target/io-cmd-file.c |  2 ++
>>>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
>>>  5 files changed, 93 insertions(+), 46 deletions(-)
>>
>> This doesn't match what I get:
>>
>>  drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
>>  drivers/nvme/host/fabrics.c       |  3 +++
>>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
>>  drivers/nvme/target/io-cmd-file.c |  4 ++-
>>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
>>  5 files changed, 94 insertions(+), 47 deletions(-)
>>
>> Hmm?
> 
> Looks like the diffstt doesn't include the the requested reformatting
> in io-cmd-file.c.  But I have no idea why.

Funky... I pulled it and pushed it out, just double check if it looks
consistent with what you expect.

-- 
Jens Axboe

