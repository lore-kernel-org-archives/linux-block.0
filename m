Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B11C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 04:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiLNEDI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 23:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiLNEDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 23:03:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D722027165
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 20:02:58 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l10so2066853plb.8
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 20:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fCrMB9cQt2MX8YzEWi0sGLkBMAE2dTTyW94AFZn9pA=;
        b=fgjO1qQIwaV1ipZKA8klXdP4Ve8zlCH05WM04DBeAuVhT2gV0/NDQjwzHWxvy6vjoo
         Z8Wpdy4M8ga+fRK0sYnPreKKUxfL63DTSNOd+GnpDA5wFIEeY2UZ6ZizffNy5TSem3fD
         OASi7zyrHG3s4Cefq1ZVxzjAlDEwOJdGHqEyh+ePjyV/tbXz8S0ksLLjPOSMBw+VUGLc
         h6l+EOVvIc7rBKKXCwQ0L0ko7MdR1a95ECuIGMulh2iJaSWH0s7Fjmc9D+aOWAorlGYa
         11LUxOEneebX67UHldEWM+Vgc3beULPdhg7ncK0q2+MFuQACLqTCu2dc15pdEWPK5h2K
         FgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fCrMB9cQt2MX8YzEWi0sGLkBMAE2dTTyW94AFZn9pA=;
        b=qURgR5ROH9X6Dl6uSDTEf7cowYxHqNl66WUGQqyI0MvO+Y5NykbvlDOOJnZf4cSVsP
         qwjn9qoibixeLav6XJyToUPx0tAjf/mFMC+HHJEfLxetuEZYP45v/ULhbcoiNox2hhJo
         UYAdTKdoIk0S8mJWDg5XGipPv+MLtPkqjd2AIqnHW1MJj9BoS+UeLWWd0JlF50Ep1iz4
         ExYvUZvsOVPHV/u4yiUIUT5ZKR7hzH9t7XlnniO/ZcdvTusJvi925tDNnWaN/vYXwvGE
         ITyjafh60rH+hNXIbz3PZgR4qs6Cbum17j0nCHJqCFSA+SVIVx06qTSQcERHgib9+2Lj
         tVsA==
X-Gm-Message-State: ANoB5plh4HLkqvMdHb3ocBvjz106zs9xMzG+Xk+SdT1Rq+X0OGeNFqVA
        lHwdIzOPwFGHDue/ktNM0Gy5ySWI6lOTBePv
X-Google-Smtp-Source: AA0mqf4eQdsVDxhyLdxJPM3HETuo0Ym+0gSGYwMuYtLjp51oYGKdeufiEWmH06tCm5OiFbgvmqG6Sg==
X-Received: by 2002:a17:902:a502:b0:186:7a6b:24d9 with SMTP id s2-20020a170902a50200b001867a6b24d9mr21682666plq.23.1670990578230;
        Tue, 13 Dec 2022 20:02:58 -0800 (PST)
Received: from [10.5.231.247] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902b18f00b00189393ab02csm675922plr.99.2022.12.13.20.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 20:02:57 -0800 (PST)
Message-ID: <1e53592f-b1f1-df85-3edb-eba4c5a5f989@bytedance.com>
Date:   Wed, 14 Dec 2022 12:02:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y5et48VryiKgL/eD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/12/13 上午6:40, Tejun Heo 写道:
> On Wed, Dec 07, 2022 at 12:38:26AM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> Now we don't distinguish sync write ios from normal buffer write ios
>> in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
>> until write completion soon after it submit. So it's reasonable for sync
>> io to complete as soon as possible.
>>
>> In our test, fio writes a 100g file in sequential 4k blocksize in
>> a container with low bps limit configured (wbps=10M). More than 1200
>> ios were throttled in blk-throtl queue and the avarage throtle time
>> of each io is 140s. At the same time, the operation of saving a small
>> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
>> the sync ios of fsync will be blocked by a huge amount of buffer write
>> ios ahead. This is also a priority inversion problem within one cgroup.
>> In the database scene, things got really bad with blk-throtle enabled
>> as fsync is called very often.
>>
>> This patch introduces a independent sync queue for write ios and gives
>> a huge priority to sync write ios. I think it's a nice respond to the
>> semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO gains the same
>> priority as they are important to fs. This may avoid some potential
>> priority inversion problems.
> 
> I think the idea makes sense but wonder whether the implementation would be
> cleaner / simpler if the sq->queued[] are indexed by SYNC, ASYNC and the
> sync writes are queued in the sync queue together with reads.
> 
> Thanks.
> 
Should we keep the main category of io based READ and WRITE, and within 
READ / WRITE the subcategory were SYNC and ASYNC ? This may give less 
intrusion into existing frameworks.

Thanks.
