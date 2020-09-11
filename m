Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC52C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9967122207
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 22:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xKBpO0c7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgIKWnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIKWnW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 18:43:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C7C061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so8390542pff.6
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4dnIXk3uASFKmAsRylpgs6PaxAQ2I8kA/uiE395NMo=;
        b=xKBpO0c7GRfYDlEvLIcuNo7cRQKOSRBWiJnlgrExH6GawCClKntMGl+YgUGmo44diD
         hVelwgwdl8uGB6WpaSdNINPmC+FAW+U5a8iu9cXUDZ64bb7PgTxsVdn0EVVo5jzk8sTL
         p0ethGOksPgsdk/nQTW+OAR+zST8OuXiaWDh856pqqP+RQsPxz/U2veX7DhRRRUDpikB
         2fmlhmtzOOSamIyWoTaqagyl76oQZuf5XRaDm/gsI3gppuiS5MvVp4YHjMRpBEOlTw4k
         +DEkeaQNS2WeLJ6OLV9t1UFRRxPRfSv6ZFwnnulpSP8Yy3TOCl+kyeJLFvQUXrKrFfae
         d78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4dnIXk3uASFKmAsRylpgs6PaxAQ2I8kA/uiE395NMo=;
        b=HWHYLJGe8rZzrg11AO/H/LwOkpO9mKg7Y7+FTE2d0iGOzD8g+c9rFdbELca2GvWj1C
         8/32pVIo/EfFCvsL6UQ9DxIu4SDy8IyaP/f1Q/mIrnLtMgLimQWcf6Y5Nos+9scyQhld
         nMJVtQLwLP9c1WpWg4fD9G1mfI6gaiu4dFuY35R0UWxxVwQ22a56OIbon3NScyIA2smX
         BC4Xp5nm9avTl1aI0r9T0ZOgG/0piQdRTHF4mk98OyAg756jMb48gMNj/TpVCdFN6a0B
         YetT7wnIkKIvxsZl0D7ppXkIl0CjqoBA9QBG/ject4UdRxZ3LSUTL6cBY9U4zLUTPmSx
         AOuA==
X-Gm-Message-State: AOAM53148aRGUp0tM5ufXVO5P5hOjsfJFgDCZT8ePKmQ8LOgURg/jsyM
        SUUGJ6cvLSLxBe9P0yKT3BAIEQ==
X-Google-Smtp-Source: ABdhPJyFM5VCvQ9wgag86nKFAph92fcH4OJjuMFJOFcQihZDKQd0xTwdWGH6BphZfULMmmBWq14Cbg==
X-Received: by 2002:a63:2250:: with SMTP id t16mr3185165pgm.303.1599864202018;
        Fri, 11 Sep 2020 15:43:22 -0700 (PDT)
Received: from ?IPv6:2600:380:4955:1abc:b8c:928e:5fe6:fb78? ([2600:380:4955:1abc:b8c:928e:5fe6:fb78])
        by smtp.gmail.com with ESMTPSA id l7sm2500221pjz.56.2020.09.11.15.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:43:21 -0700 (PDT)
Subject: Re: [PATCH v2 block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20200911170746.GG4295@mtj.thefacebook.com>
 <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
 <20200911224049.GA865564@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59987f54-47fc-766f-0667-5a90daca0b1a@kernel.dk>
Date:   Fri, 11 Sep 2020 16:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911224049.GA865564@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 4:40 PM, Tejun Heo wrote:
> Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
> all hweight calculations round up and thus it may end up >= WEIGHT_ONE
> triggering divide-by-zero and other issues. Bound the value to avoid
> surprises.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: e08d02aa5fc9 ("blk-iocost: implement Andy's method for donation weight updates")
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Jens, I was flipping between doing max_t(, 1) over the whole divider and
> doing min_t(, WEIGHT_ONE - 1) for hweight_donating. I thought that I as
> testing after the last change but it obviously wasn't and the previous patch
> doesn't compile due to missing type argument. Can you please apply this
> patch instead? I can send an incremental patch if that'd be better. My
> apologies.

Sure, I replaced it. BTW, you had two signed-off-by's in there.

-- 
Jens Axboe

