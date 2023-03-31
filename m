Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D402C7619A
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 03:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjCaDBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 23:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCaDBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 23:01:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8C1204D
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 20:00:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o11so20016468ple.1
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680231639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMrP2Zp/EKlqbziL+FgCOqPjH/auJOar/Bw7xvN0IJw=;
        b=gFLNd4ejWBxSDzU4aEgXUTu5XK7W5N8DYIf8y981jAiIl1PPhf0gQNwn/L7fY8o8Md
         GzCyVbfJEEy/JWxGYXiht+V4N/+fmTClBVFIuAb6szfd5tNfLkYBw1YNTx2czLm2sI/4
         LcWKYMZvb5xYSRjGmgeCQ85FAdWUc+Df9EGS63HjvDKh3crs1/lOjOR7uTf5jUjUrq5k
         cPnJx6PMlORh0s/D/pBuw61Y2/NN+GOsJ2tQ5p/TrXz7Y/mQIXZHi8xi5J/D+mhr1SvN
         iFKRECz2VC/NXpimQsG6Sf6YMmLfu9tL7zZkXzQAYPPhdz5i+P15KxHZ50QexXZjWeLk
         DgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680231639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMrP2Zp/EKlqbziL+FgCOqPjH/auJOar/Bw7xvN0IJw=;
        b=ZzhmClS2jFbxl2PKHi5Zzh/zBo3WeMBf/lhXz3kcTN2Gij8SCaaQub0qm4rVNfXA4u
         3Jmr1Ul+Voqy/uoUPfBLS43My9CEFEZbO+0Fg5HrFx7H1qaYlhCdxUdo/M7KOn2pw9tA
         BzvPoybYtONDVqihIjhTt61aIVCiEWevo440cfh0bKBVmMJxdBNwbp2YoD37SW+QHHLf
         zBZ/Q3TUJobE6kjmgUm3x4L9wMyIAsu19LzY0Zty4tKSqhKm4qDdtzXl98BmEfWaACGl
         PRJfEDqGpZ0+XwkmV0w2+7yQDHKx3G4yHB7FsrRcl9yzAyNZ02TN+OH3+UPBxHHvig4o
         Qk5A==
X-Gm-Message-State: AAQBX9eqH4U1x+U2NMgZJ+ukOyyzMIRyz0DiTpgUrtST0fwSX7nFnk/i
        xyDLatGw4xirGOd5ApdGPyFe/QZUqWVrEDVyJu5vFA==
X-Google-Smtp-Source: AKy350ag43OiG3r7Vy717gSy+pX9ZevstneHo3UQq2lOby5UUvTIdpZTPDh8OAsdarK8D5U7e+8sBA==
X-Received: by 2002:a17:902:d512:b0:1a0:67fb:445c with SMTP id b18-20020a170902d51200b001a067fb445cmr8985431plg.28.1680231639373;
        Thu, 30 Mar 2023 20:00:39 -0700 (PDT)
Received: from [10.3.157.34] ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001a1ea1d6d6esm372585plb.290.2023.03.30.20.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 20:00:38 -0700 (PDT)
Message-ID: <6128380c-b148-cb7e-44d5-0bd7d05a2942@bytedance.com>
Date:   Fri, 31 Mar 2023 11:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH] blk-throttle: Fix io statistics for cgroup
 v1
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
 <ZCSJaBO8i5jQFC10@slm.duckdns.org>
 <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
 <ZCY7EoAUqfB0ac8S@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZCY7EoAUqfB0ac8S@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2023/3/31 上午9:44, Tejun Heo 写道:
> Hello,
> 
> On Thu, Mar 30, 2023 at 11:44:04AM +0800, hanjinke wrote:
>> 在 2023/3/30 上午2:54, Tejun Heo 写道:
>>> On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
>>>> From: Jinke Han <hanjinke.666@bytedance.com>
>>>>
>>>> Now the io statistics of cgroup v1 are no longer accurate. Although
>>>> in the long run it's best that rstat is a good implementation of
>>>> cgroup v1 io statistics. But before that, we'd better fix this issue.
>>>
>>> Can you please expand on how the stats are wrong on v1 and how the patch
>>> fixes it?
>>>
>>> Thanks.
>>>
>> Now blkio.throttle.io_serviced and blkio.throttle.io_serviced become the
> 
> "now" might be a bit too vague. Can you point to the commit which made the
> change?
> 
>> only stable io stats interface of cgroup v1, and these statistics are done
>> in the blk-throttle code. But the current code only counts the bios that are
> 
> Ah, okay, so the stats are now updated by blk-throtl itself but
> 
>> actually throttled. When the user does not add the throttle limit, the io
>> stats for cgroup v1 has nothing. I fix it according to the statistical
>> method of v2, and made it count all ios accurately.
> 
> updated only when limits are configured which can be confusing. Makes sense
> to me. Can you please update the patch description accordingly?
> 
> Also, the following change:
> 
> @@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
>          struct blkg_iostat_set *bis;
>          unsigned long flags;
> 
> +       if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> +               return;
> +
>          /* Root-level stats are sourced from system-wide IO stats */
>          if (!cgroup_parent(blkcg->css.cgroup))
>                  return;
> 
> seems incomplete as there's an additional
> cgroup_subsys_on_dfl(io_cgrp_subsys) test in the function. We probably wanna
> remove that?
> 
> Thanks.
> 

okay, according to your suggestion, I will send a v2.

Thanks
