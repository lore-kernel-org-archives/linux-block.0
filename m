Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC1EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 14:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGKOqE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGKOqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 10:46:04 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180AEBC
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 07:46:01 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-55ae51a45deso2917572a12.3
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 07:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086760; x=1691678760;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBpOAKoBUgHuo6oTWIq6JJlCOSnvLuaiQ0Nx1pqQYvU=;
        b=f6iLuh9BQj0wOTetXPgeoeenIGg7MtaSy1xSWbUNOrgjbowL237G5fUhZ8LpPVsnO0
         bhX77X/95pmw1VhL6urDiqPDbAAviI/TTfmmJcJbcCOEGpPa8/gOswhtiI+euSTd9FHx
         Q90xgic7P13GXfwIGWSPoHMUyjy47EBe8SIpDgHVAcFO+OLHgHDWuxZrCD+J2wGDB/mu
         VruziB/DIUjQZd1yZ2+1wy0bTUUb9YrgYGW/mOEezQ3YYt74qPmqzZBC+VaEBuMbDYxg
         ptR0qML/yGN1/LkeMIsJUD5hj+P1nlCf72BlF9NTjFPNbLBeCxbo3XYi/yoa2FCfB1Vd
         dbrg==
X-Gm-Message-State: ABy/qLZ2yzGLVqKvvAHjIXL3MqstOXEbGsTQMWYin7Yr6gdnW4cIMH45
        gBajr9eJqPCtk7j36dYYqE7WSlBGdkg=
X-Google-Smtp-Source: APBJJlGwpK54yxyyCJ4CXTkqtTyZIw9G2GwRvBkbDctTfoJzhSIXJqCkyPbianUkHekHxY1fpZhmLg==
X-Received: by 2002:a17:90a:ac16:b0:263:6437:29e3 with SMTP id o22-20020a17090aac1600b00263643729e3mr10329240pjq.12.1689086760330;
        Tue, 11 Jul 2023 07:46:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e582:53b1:a691:ab70? ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id w21-20020a17090a461500b002641a9faa01sm8180761pjg.52.2023.07.11.07.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:45:59 -0700 (PDT)
Message-ID: <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
Date:   Tue, 11 Jul 2023 07:45:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: LVM kernel lockup scenario during lvcreate
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
 <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
Content-Language: en-US
In-Reply-To: <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 06:22, Jaco Kroon wrote:
> So *suspected* mq-deadline bug?

That seems unlikely to me. I have not yet seen mq-deadline causing an
I/O lockup. I'm not claiming that it would be impossible that there is a
bug in mq-deadline but it seems unlikely to me. However, I have seen it
many times that an I/O lockup was caused by a buggy HBA driver and/or
HBA firmware so I recommend to start with checking these thoroughly.

> Supermicro has responded with appropriate upgrade options which
> we've not executed yet, but I'll make time for that over the coming 
> weekend, or perhaps I should wait a bit longer to give more time for 
> a similar lockup with the none scheduler?

If this is possible, verifying whether the lockup can be reproduced 
without I/O scheduler sounds like a good idea to me.

Bart.

