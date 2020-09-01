Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D02C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C0A206FA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pGRMGCSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgIAOen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgIAOeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:34:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE5C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:34:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so718910pjr.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8crO/qCE2Vg3wDVX8UnZ4mszl4wwUVBfaRRSh4XlV3g=;
        b=pGRMGCSDPqovSipZaI/dr2u38ZbCslbnTnCcpaY7TInbZ4vO8wLl8Ppzch1bQY5ESG
         a+S3pCtYM66fwsBLM8bfLxPlYp4GM2MzuEPY+lX6ng83uiJXzC3+cDmqfudUaWrFKXn2
         caWGcQNEF3EZwuyV3ZzebnHnm3g35cDueWDrEIqsSOJnXwL2IQTl0S70qaJG/Vvbg+R/
         QUAA0v8hnXjah/+eExBgjgg7zTloxU9uo81Oip3BTwYkg4Vr4dYq8o0psndyYU00/zwT
         2ChcPWN7UhxYHAsIcZ8FYwAShRWGDiEUdD3LWubhzvcDFFFte9e1u5IKjg0o3oCoCr1U
         RkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8crO/qCE2Vg3wDVX8UnZ4mszl4wwUVBfaRRSh4XlV3g=;
        b=P4bCx5A3FmId8gAyBLsQqKgcGJcED9epkI1dlhwX6vvW9YaFrOC1wp3PHIm1AUQCHa
         b6oSIGOLsJM1A649mszbqZMjhKIDrLX22CuCUbpYgjFaqWwI+/UqRRzklry8bJEMmclA
         7SjBeNWpXJWcIggG7dDuMz7hZwXvUHS2mtJNwLHfrmH/zet4PobJmQ1hYr9ik/Jv1qmq
         3gYqJJh41oqoNHMIynaulK+PZlEN43XGnL1eNO6kboU9k38kvNDYJby2N6KDqmYNg5VI
         2JQeCLW62SFdxFQ+RbeSMm/POcYSv0DpkuD/B1wtHUoGT5HZrCYLRocEPOyy/Onnq7tk
         yxmg==
X-Gm-Message-State: AOAM530+eqk8xpn46QwJhhmFBS/xCojV1wA1l8zppDIdvjhXDGlMnhVz
        pchuopIF8RQLfad1R1IQJowLm0S1FzUN5Y/z
X-Google-Smtp-Source: ABdhPJyUzQnxqWKUuP0CAaMM4Rdzh0qFC6IpUQjeO5jga5Ut7sXfvS9wXP27xAFCM+d/Q4n+i4SwcQ==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr1701737plb.294.1598970869912;
        Tue, 01 Sep 2020 07:34:29 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b20sm2390515pfb.198.2020.09.01.07.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:34:29 -0700 (PDT)
Subject: Re: [PATCH V2] block: release disk reference in hd_struct_free_work
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200901100738.317061-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23652c78-5d7e-2d5b-ca3a-f0064ffb1a78@kernel.dk>
Date:   Tue, 1 Sep 2020 08:34:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901100738.317061-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 4:07 AM, Ming Lei wrote:
> Commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal")
> stops to release request queue from wq context because that commit
> supposed all blk_put_queue() is called in context which is allowed
> to sleep. However, this assumption isn't true because we release disk's
> reference in partition's percpu_ref's ->release() which doesn't allow
> to sleep, because the ->release() is run via call_rcu().
> 
> Fixes this issue by moving put disk reference into hd_struct_free_work()

Applied, thanks Ming.

-- 
Jens Axboe

