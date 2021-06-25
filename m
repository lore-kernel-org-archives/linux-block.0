Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6BC49EA6
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 00:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1198610C7
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 00:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFYAuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYAuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 20:50:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285FC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 17:47:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g22so10676543iom.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8nSJpWYHGCpkuNBOhQkSMR2oaoPzxAOpHnbMVy+0cK8=;
        b=P3alooKh/efB4RQG5GaJALO3lY9ThVgtLlrwm1wUUa9sxoaJjMGm1q5OR4IK1l/j2I
         rvNQbylzYx/oU9pNqkCTv68GhHmhJKYqwglwzPy55q/b+XmUlhKjN2CSq1OySvbhlSnV
         W/PuxSUrURMJPWwE7JqEaqhE7Vio1h1hI42BfJ7eQmLLUEzo1x31X7oeardi2s2oJF1n
         y6YeuQLY3yFm/bukZo562ue/ALj4MfIFxIaMbh8R42KUokh5LXfdLYC2fL5GZxuzK09n
         lCjKW5EYjWY7NudHpzUSRaxWY5QCynetbGaJ8QfPRRVIk81inNQqc5+z2lo4VAf9gxMj
         3dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nSJpWYHGCpkuNBOhQkSMR2oaoPzxAOpHnbMVy+0cK8=;
        b=NjWV1m1f2rgSAOvxRPNkDRiCeWElxPm+lhoExZapurBr3EyjeoP1CjL6WLGxfbR0Y9
         +CzjdGYedp9Ymy4BE6iesqr57ZibL7MpcJFyUjIcw0KLZqlyAfYQl0P7/IexVow0WjqX
         3P22wn5uyLPadZERuOmNV/YNZKRt4F7mJt896qPiLuoL1xievQMhx8Ll0jKZamUCThmz
         98WeJEoJLAlpHvCUx8u5R+dqTmSbCwoSYslvbzWSGJznNc2SHX0paPmBQOnvx6VCgRqD
         y3FlKJm9VglSfRZRfLcOz2Tzc2eNVoDKInlI1ZIs+o71MnWki1LjPBVf+d+ZTe9YgWZo
         FFfQ==
X-Gm-Message-State: AOAM532itAMgB+x7B++ZJpaJVms+Tjc56D4Q58XKH00EqaN+3/OlLtBs
        gW7ZjfK3+rAPVZjMVuyn8Qq4mQ==
X-Google-Smtp-Source: ABdhPJxpcWjhp/ELSXOF9gQiJ26hj0rLvrj8oktAvPr07ek67h2zv74inkQ2etInABitPqQWi31raA==
X-Received: by 2002:a5d:8a07:: with SMTP id w7mr6338421iod.154.1624582078752;
        Thu, 24 Jun 2021 17:47:58 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id m7sm2661303ild.49.2021.06.24.17.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 17:47:58 -0700 (PDT)
Subject: Re: [PATCHv4 0/4] block and nvme passthrough error handling
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
 <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f6df0d6d-9315-7a16-545e-9f752f65df00@kernel.dk>
Date:   Thu, 24 Jun 2021 18:47:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/21 8:57 AM, Keith Busch wrote:
> Jens,
> 
> Do you have any thoughts on this series? I think it's good to go and
> have received reviews, and just want to check if you are okay to take
> this through block.

Looks fine to me, I have applied it for 5.14. Thanks.

-- 
Jens Axboe

