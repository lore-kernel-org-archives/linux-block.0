Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA90C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95EC6103A
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 16:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhHMQWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHMQV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 12:21:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0927C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 09:21:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so16776168pjb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMX/SCoPdNc8wpciVQCrAusk4Odh/i/26CttVypzDKw=;
        b=l56mKcaENWVEHQj81uDuoYUB3nZSHyYv62KCEDtFWnHT0qiHYCqGNNf5LsuJ/0zJ9J
         Ik0M/TnvcnY68wixV9LfKWjki83TP59PLbZHo3lGX4ENNTj/XqaIj+absIsdiYN4Cm8y
         b4fxkN3k2w9JVV48ifD4bkD+Wa1KbQYNuQ8T3kLQzp8UvJ+s7zHwzPghJZ9PB/jBRHR+
         NJJdiIAcTD1xL/w8imvxxX6cCUY0weOS+MIlMJVClsukMOjerJP+PAU29uSC4rSxSnxI
         a70mbKEdwXDdZibyvq7b51bZFhQS8jZytXFGWWPprim1qbKrOSGaRfSetjDmVODrRl/F
         l7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YMX/SCoPdNc8wpciVQCrAusk4Odh/i/26CttVypzDKw=;
        b=XoWqNaspvtr2A/xZ3iR2BZlr8GBGPMsjjN44nA9S5nEyUAocUmfAFWeELo2hVwt0gT
         5urhHCAwLnnfzqKPlR1NDfkp1yPLBqKPJ0hejDHyNTJvjBssxKT4mbKmKzaNl58M+JcX
         x3njGUHVCtCV0dy5rwDN8/rBXRkwfHsE3EhlrA7jgi5Du7YNAAy0HchKIdshxAqS5ryT
         AVIcrV1a338YLaSJ6B6aOB5ximruw+yhrbCVa4yY6BL+mGqCsYrW3MaDOYut/SeO7fDN
         rq1wiQmRddEB2CsSZaySNP0Q5Dlkr4f9J3X6z687TNRkRWrWANErq5YNs3w3Ds3rZava
         NQHg==
X-Gm-Message-State: AOAM531F9teFbgAKmoD5GXL5ybpiWBrUJdximDK0p8jRBpzOo3yDvyb/
        oWumeFXTIzfxTBGZd9JR+L0=
X-Google-Smtp-Source: ABdhPJw3EHdlGLuPk8PemVsTz5NTavlvtJ4R9F36fJCRcNVrR/JRRenIBjbUG+l1KYo7NYWTcsaTIA==
X-Received: by 2002:aa7:84d5:0:b029:3c7:58e1:83be with SMTP id x21-20020aa784d50000b02903c758e183bemr3159897pfn.24.1628871689097;
        Fri, 13 Aug 2021 09:21:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id q19sm3262488pgj.17.2021.08.13.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:21:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Aug 2021 06:21:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: questions about sane_behavior in cgroup v1
Message-ID: <YRacB4mYCIw+CQTl@mtj.duckdns.org>
References: <7ecceefb-ba98-399f-38b0-5a7717a51649@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecceefb-ba98-399f-38b0-5a7717a51649@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 13, 2021 at 05:25:12PM +0800, yukuai (C) wrote:
> We want to support that configuration in parent cgroup will work on
> child cgroup in cgroup v1. The feature was once supported and was
> reverted in commit 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior
> with cgroup2 fs type").
> 
> Switching to cgroup v2 can support that, however, the cost is too high
> because all of our products are using v1, and there's a big difference
> in usage between v1 and v2.
> 
> My question is that why is the feature reverted in cgroup v1? Is it
> because there are some severe problems? If not, we'll try to backport
> the feature to cgroup v1 again.

Because __DEVEL__sane_behavior, as the name clearly indicates, was a
temporary development vehicle to gradually implement cgroup2 and not
an official user-facing feature.

I have a hard time imagining backporting and maintaining that being
less painful than moving the users to cgroup2 but that's for you guys
to decide.

Thanks.

-- 
tejun
