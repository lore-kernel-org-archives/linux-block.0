Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA16EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiDRWRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiDRWRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:17:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31F27CEF
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:14:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q3so13472774plg.3
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XCuzB01LGSL9/HOavB4RFvC0I6XpJnR3zV29Fxj7OZY=;
        b=Z1X6jwlwqScEDGRROgM14mPNFaA5wZLurOTjXxwn8IlqP9MQhn1kSo60M4lYGMc4Tb
         e6GkUd683u0ZKx4zTlxafbvWT8q6C5N+Q5GdD8cVEBNs94IEnCZMzOt/88/RekgBwrsm
         +UQIscT5oZAWDgYJi7SFy7Tkeu6oILE7fi53g69V776cR47I7tlx2qgHbX3Z/CsO9DAi
         v1iwAX9jYAJcKABnbIZ/cbqU1jxTUCWUJIup1Z/0xPE7iSuEiJ4yqc7D2O2sfosgymM2
         goPyG07dZlrlLOb1/2YQTDTApbLkiyO4uzvb3rhyJHmo/WXJzXdTYohDdnj6wJwgmfGA
         bqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XCuzB01LGSL9/HOavB4RFvC0I6XpJnR3zV29Fxj7OZY=;
        b=FarmQmG4QJhXFgq53GsG5cakhTO/p5Y1OSKejDhjImgjr1TctQ7vSOhD0R/eyHhglx
         PkMS6I1z5lnpITVM6Gqsnl0vt1QZ6yWMZyEk07PxoR8x9ru6l/hzVxnd/ynYgeF5Rk4T
         QT0sjqYduR7vxubmVweHhiAwgCgnUi3hhWl9AwKnF89e982m6EZB/f5Y2Q6BTePo3B5j
         RKPieYCNoTYq3ez/KnQAzNG5DZkGUdPKFOHrl70jVFjV3kCLaWxYQ3W08vvAmL72C5Hp
         PKBIgRL5xL9keaFfdOjU6D9yklrcHaRbQv0m2RrOnkO6ZctkOZKCalxgnSu5JAb0d3sq
         Xpyw==
X-Gm-Message-State: AOAM530sFMoJ7pqz++VdLIehQnzMI9dyntxl/9AEmSsWbrO70j+49Zfx
        x9B0+jcpGA+b3voyxuiANUKRZw==
X-Google-Smtp-Source: ABdhPJyTUPgzSxbguPgShOT6EKs9TAC3CxWdA1E7PSw3zQ2yVrOz6ITulXVFzU7Gd+fxIskhCOE9EQ==
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id w3-20020a170902904300b0014faa088497mr12798170plz.109.1650320068196;
        Mon, 18 Apr 2022 15:14:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b001cd498dc153sm880631pjm.3.2022.04.18.15.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:14:27 -0700 (PDT)
Message-ID: <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
Date:   Mon, 18 Apr 2022 16:14:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Nullblk configfs oddities
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 3:54 PM, Chaitanya Kulkarni wrote:
> On 4/18/22 14:38, Josef Bacik wrote:
>> Hello,
>>
>> I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
>> trying to use the configfs thing, and it's doing some odd things.  My basic
>> reproducer is
>>
>> modprobe null_blk
>> mkdir /sys/kernel/config/nullb/nullb0
>> echo some shit into the config
>> echo 1 > /sys/kernel/config/nullb/nullb0/power
>>
>> Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
>> modprobe.  But this doesn't show up in the configfs directory.  There's no way
>> to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
>> above steps gets my device created at /dev/nullb1, but there's no actual way to
>> figure out that's what happened.  If I do something like
>> /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
>> my fancy name.
>>
> 
> when you load module with default module parameter it will create a 
> default device with no memory backed mode, that will not be visible in 
> the configfs.

Right, the problem is really that pre-configured devices (via nr_devices
being bigger than 0, which is the default) don't show up in configfs.
That, to me, is the real issue here, because it means you need to know
which ones are already setup before doing mkdir for a new one.

On top of that, it's also odd that they don't show up there to begin
with.

-- 
Jens Axboe

