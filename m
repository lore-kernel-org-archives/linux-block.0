Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51703C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 23:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiFAX5u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 19:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiFAX5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 19:57:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBDA280F28
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 16:57:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gd1so3446181pjb.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2XYIiNyPAxUCbPTW69gSeTjEEL/1p7bXfOfkRP2R+fc=;
        b=AnVtflFbxLoXdOq9BIgNzWOJWX5MjLy5hTpl10niEjW/MiLfkhVpK/bYI4PNqt+hXL
         CndBf+09kS+cPl/8TKkLg1gCenAXWq7DZXfTDhyfmBw1f2r9AZ7TnlxY2owMbEg7vIuX
         eZBe+mDq7MnY2egmLsIh/foumg7cvgUEOX36FX01x9dUIsgpY1sD/10/K45uSuLxS5Xl
         oFqSvLV9R6p24dJ5kBOhFU4Z/DlNGgijY4aPr7Z72wgUFxfe2/LwZY4SEjeg6X3h3Fw+
         AB34r+vkLrWYYnCTT7Iv0Bg49Aa3hxHQZGDpnrBG1tMSUscRxjT0FG6abSwGLZsK5CtJ
         NSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2XYIiNyPAxUCbPTW69gSeTjEEL/1p7bXfOfkRP2R+fc=;
        b=lfLruacAhCSaLMTHVLBZs9HLnJ3c5R1gvKRe/7gnm2CBlbaZRxwStAkH3+E0xLKnw2
         YW4E/zlHeEJI/pF83FbwcUf2IDjuleEtUa3ByuVxU+cQh1X7umPtUZx5SL1KHc2r+hL7
         QkjYm0ebpAn1YI2RG3w1IcwWjXB385jVsKEHRWSZFTFWbdlbNsFS1e3qE8qcKl0E/r+J
         k3cggY+jNNk3U4LoAobicLlBO/fJOVHkLqL2qM7bXrWIS/FLuXmFXSC64FPz5sJVTt2Y
         RSup0T29RHbjMKNkQmbWWFIpxR6GCwPjz6PhEBClSFu+jA7dvodxMYUeHy3lG2FlMqwN
         TdSw==
X-Gm-Message-State: AOAM530yXANvnx9+cwkCxg4HDV+nC63LKXJGlV11YMbFAn+spd2dOsgD
        uSophULldQOtyX6l2GuN0mPj2g==
X-Google-Smtp-Source: ABdhPJyZ89NVGJO9n6rvyH2+UnhVOjm73j5+UWD3ThnWFMT8FpPVXYSUW9vfwDtLfITlXb6Ggo/ykQ==
X-Received: by 2002:a17:90a:6441:b0:1e0:b413:c290 with SMTP id y1-20020a17090a644100b001e0b413c290mr36860926pjm.179.1654127864974;
        Wed, 01 Jun 2022 16:57:44 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e67:690:38d5:dec6:94e6:8d4b? ([2409:8a28:e67:690:38d5:dec6:94e6:8d4b])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b0051874318772sm2018554pfh.201.2022.06.01.16.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 16:57:44 -0700 (PDT)
Message-ID: <cd11d854-31c4-57a4-4732-ecb7999d672c@bytedance.com>
Date:   Thu, 2 Jun 2022 07:57:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] blk-iocost: only flush wait and indebt stat deltas
 when needed
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601122007.1057-1-zhouchengming@bytedance.com>
 <20220601122007.1057-2-zhouchengming@bytedance.com>
 <YpeSct3LJcBjnZ2x@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YpeSct3LJcBjnZ2x@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/6/2 00:23, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 08:20:07PM +0800, Chengming Zhou wrote:
>> We only need to flush wait and indebt stat deltas when the iocg
>> is in these status.
> 
> Hey, so, I'm not seeing any actual benefits of the suggested patches and
> none of them has actual justifications. For the time being, I'm gonna be
> ignoring these patches.

Hi, the current code will flush wait and indebt stat deltas even for idle
iocgs, which seems strange. This patch only do that for iocgs that are in
wait or indebt status, so it's a performance and code improvements, although
it's minor.

Thanks.

> 
> Thanks.
> 
