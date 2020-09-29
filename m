Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB22C4727D
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789E32145D
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CGjlMFVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgI2OKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2OKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 10:10:35 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F4C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:10:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z5so5007135ilq.5
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t3xxJI4fr+uYUsUTf3UQpoEtRxa7/1jEEx8P+WMzaS8=;
        b=CGjlMFVjzxfZY1uNdHYVtpouWV0fqdsa1MT3lo1mLW1NUGXpaq+TLiDOu0+QqbgJpB
         tHhXsWlEAf/c5oEPuw/4gW/Ov2sG/0FFpwkhp6JUQzFnFvgs9yixaRozGlPu6TaqIipk
         wcJCaS9/GH3O1FKwuAGpx6Y36IEEMsvtbYRnuRPOU8TD07fb14I6mSJ/yUlWtKiDXeOb
         Fj0CB/IVWGTr7EYDDcKXHlMrIxNS0BEvyM93dxsbE9ABRCqRaeVeCD0rvs86685LZhpI
         uV+k8OBBrtZdbdTyqAMXZGl4XyeIstQEbHq54HqqmzEpWb0XIcD64gn7NYIy1gbDLn++
         ExHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3xxJI4fr+uYUsUTf3UQpoEtRxa7/1jEEx8P+WMzaS8=;
        b=aQudMGKdfzTqKAE4FkeSd1wV71IN9FTo/3U1EJmJMEPKB0F0DtFYqvWdsF1D605JlE
         2cBPtRkwU/nqD9FuQUtwXAvYvl5LFcKc9mbFtsbiyuc5wXnox6MOyMDznt+YXU7izrLw
         zeC6C9c0H5ds+W7fTo4pqe5n7XmxaO9NTm3qHejsiEp5FTUmt19l6LsFJtLOOAMGWlnd
         ysrUQw063AIJzmXazHziG5iEeq5Csw+sNc5ZDJnLuN2CYUPsMLuzBKflmwTX/muZVTx9
         /YkXSqaLUO/XdSw/FWV3PUTf8OK2SZ8fCyOgr/+6dEp0U9awqk8nqwPm48fBLOOSU93+
         PIqQ==
X-Gm-Message-State: AOAM530Xx8Vx8GWGEI3m5+PFBni95aMHFcZkYE4yB2ao93SaVIWAGoQE
        1Q30KlcQIUs1p5HJ6jan3iujgQ==
X-Google-Smtp-Source: ABdhPJyVWtOWuewFsWSzrpvXwa2e99VnOVSLg+3wtMkTVuKec4amgBuBqiX+2TcwGqLUpF5VxhI1uQ==
X-Received: by 2002:a92:b50b:: with SMTP id f11mr2643073ile.109.1601388634481;
        Tue, 29 Sep 2020 07:10:34 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm1668868iow.26.2020.09.29.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:10:33 -0700 (PDT)
Subject: Re: [PATCH v2] blk-mq: call commit_rqs while list empty but error
 happen
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de, yi.zhang@huawei.com
References: <20200905112556.1735962-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6afab9c4-df9c-ad9c-b7a7-9c2e0af64ef6@kernel.dk>
Date:   Tue, 29 Sep 2020 08:10:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200905112556.1735962-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/20 5:25 AM, yangerkun wrote:
> Blk-mq should call commit_rqs once 'bd.last != true' and no more
> request will come(so virtscsi can kick the virtqueue, e.g.). We already
> do that in 'blk_mq_dispatch_rq_list/blk_mq_try_issue_list_directly' while
> list not empty and 'queued > 0'. However, we can seen the same scene
> once the last request in list call queue_rq and return error like
> BLK_STS_IOERR which will not requeue the request, and lead that list
> empty but need call commit_rqs too(Or the request for virtscsi will stay
> timeout until other request kick virtqueue).
> 
> We found this problem by do fsstress test with offline/online virtscsi
> device repeat quickly.

Applied, thanks.-- 
Jens Axboe

