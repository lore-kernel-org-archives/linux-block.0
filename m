Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FEEB64DA
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGJTFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJTFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 15:05:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF811A
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 12:05:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1265784b3a.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689015902; x=1691607902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWV26TGTy3//l4E8aINjjrrFmjWk+bhHVAYRbt8sCmU=;
        b=ha8s51UziKSy71k2xdq/HxMISTidO5E4MSfVEkbd/2Dmsmt/hzlzlaqyZ3QKafuskq
         tMvsVykze5yopOTsBYAaCFhBh4/cKOeUEtCcVqj51biTkQ6aQ9Mz5my/LfteY+ggblqQ
         mqLgXStpUN75A7TGSaXsrZyZ3WnYeB4liYqIGjUZxCbObfD1deu9enytYR+BnATTO0z3
         e3TMEtcFPsi/V1CSz0c/RG/mtyS1hYHXJTYdfIXQjlRuzXTkUvgCuVDBtE4pjyjBD4bX
         cIw2LH6DhcZjD31/xHzP9TFyjGnNcazZTQUj9M+4vfnYBLL1aD0iQzQb1kE+ZUBWZ4s5
         ouow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689015902; x=1691607902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWV26TGTy3//l4E8aINjjrrFmjWk+bhHVAYRbt8sCmU=;
        b=ffucJs2IV1Cd5SU+puWlrwb24WuzoRcvhCqUJsrCnXwNCRa7kXi501D7mt9a/AANmf
         VErsaHy9c3ugX8qPTGhtQIxnc9pvRKFc/VGXVIdiinf2vsIAUw4WfMv9eSAKxlnAo1GY
         ARe+XCY1N0xA81vu7g6I1K0/Ixitnq36NKnnlqAEWs3IokyB0hIRekrU47sVCE4ocIHj
         V1EV8GxpoBt9StIPuGCpCZK+nB23eStL8EDEWbD6ueh/lSMoDO4IXLywq3BoW4Mtms5Q
         YOZGM980SmXo83V0jE9qt1Qh2OC9mqWZ0uTG34weNbE2Slt0Tx5p73p+vdR4Rz3uFN+d
         GALg==
X-Gm-Message-State: ABy/qLYsOlqG6qr/sRfx32CTuN6T2GfSxRtcb7Hz0HkXG4H3+9HOV3ZM
        JbQRo0sNkUjrHv8r8B8QmlpVM6b81VSW7CudamE=
X-Google-Smtp-Source: APBJJlEiIWLxcSKnACk8shroBBJlI/U6S4QvWokhBzawLykUkcAHFBh46fnGScu9KFgpew7U4EXhlQ==
X-Received: by 2002:a17:902:ea0a:b0:1b3:ec39:f42c with SMTP id s10-20020a170902ea0a00b001b3ec39f42cmr17068822plg.5.1689015902396;
        Mon, 10 Jul 2023 12:05:02 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b001b1c3542f57sm241949pll.103.2023.07.10.12.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 12:05:01 -0700 (PDT)
Message-ID: <2ade2716-d875-5e4c-82ce-c4c7f00f1bbc@kernel.dk>
Date:   Mon, 10 Jul 2023 13:05:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] brd: enable discard
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Li Nan <linan666@huaweicloud.com>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com>
 <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com>
 <4b6788d2-c6e1-948-22d-dbb7cbba657d@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b6788d2-c6e1-948-22d-dbb7cbba657d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/23 9:24?AM, Mikulas Patocka wrote:
> 
> 
> On Mon, 10 Jul 2023, Li Nan wrote:
> 
>> Hi, Mikulas
>>
>> The lack of discard in ramdisk can cause some issues related to dm. see:
>> https://lore.kernel.org/all/20220228141354.1091687-1-luomeng12@huawei.com/
>>
>> I noticed that your patch series has already supported discard for brd. But
>> this patch series has not been applied to mainline at present, may I ask if
>> you still plan to continue working on it?
>>
>> -- 
>> Thanks,
>> Nan
> 
> Hi
> 
> I got no response from ramdisk maintainer Jens Axboe. We should ask him, 
> whether he doesn't want discard on ramdisk at all or whether he wants it.

When a series is posted and reviewers comment on required changes, I
always wait for a respin of that series with those addressed. That
didn't happen, so this didn't get applied.

-- 
Jens Axboe

