Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A390FC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80451208CA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zWf7fhWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgIAOmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgIAOl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:41:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F99AC061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:41:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so628726plk.10
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rN6mVq1C675COOeO9181t4h75F89OjQk6hHpgH+S2X8=;
        b=zWf7fhWFHujfWaocQn49l9sQhhPq6xyQeaCS4rvpip82Yg4nGFcQsS/l32lvBaxghQ
         w8UaOQwYaD6gwz9dGJN2uVaNuBPQZYnoFcap4fWwhOCDmaaq4RrKwPeefiocvDkkgHrJ
         24Uuwoy8QMsErURjw7uLdcKrhxkFqbkopqSxv/HyZO/ftoDj+/LMXPdlvUmq1LM3M2Yy
         th1SUVnuedh8P7SRbR7zqCtQchZ55aIsGN9Tez4fMp9NS+3qhEQZAaOneAMbclltMKdH
         Ly8iQ51E0C6AGzrvyHAL99zOB1yxiMqKYX5tIUS75Po6vwYmPu9+lw7PDYD+usWZ0So7
         5hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rN6mVq1C675COOeO9181t4h75F89OjQk6hHpgH+S2X8=;
        b=qXRE1P884lJ/qhhDOVydcbqUYr6MR+VjHwandrI61kfWmNeYVpcRTxrf4TYWFKJ7O+
         gC08UlqzuO3hq56cR3M6nGFGtD5f4H5sjS3hUh/uMGdW345eA63Hur2HilQr5OjRf1mw
         8TAPy/F6DGn7iBqdVGpTwbsI4P1Ji5Mn5hqe/hEHvRGzIHSAyJiDKPDqlY1gMY67BV2k
         kPwVxLpQRJz/fdIinb/32NFqg+VKXnikb5VtnwKk6KSlrmvrkAgssOj31r5fAEM6eSCy
         YmqAXt+jWm0WTpb3WemnJLt3du5xtFzbg3qR9agROePH48BKcNKD0cH2C0SslwCPRlM5
         in+g==
X-Gm-Message-State: AOAM5309+bvYx6xiEs2Lmtf9skvUakDAijADwRwGooFhAbcYSfIFqV5p
        XorWwO1I8UZFPrCZ6SLstaA2DQ==
X-Google-Smtp-Source: ABdhPJxyUYNNoAYg+p0rUio5na1hUQeQkT9Gz50MFaKFx0Ho8v3YbST/94HbTYB5NkVRq+gbMPEODQ==
X-Received: by 2002:a17:90b:1049:: with SMTP id gq9mr1941000pjb.28.1598971317157;
        Tue, 01 Sep 2020 07:41:57 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r123sm2340138pfc.187.2020.09.01.07.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:41:56 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Some clean-ups for bio merge
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa37ce36-c02f-835b-e62b-3e47daa27022@kernel.dk>
Date:   Tue, 1 Sep 2020 08:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 8:52 PM, Baolin Wang wrote:
> Hi,
> 
> There are some duplicated code when trying to merge bio from pluged list
> and software queue, thus this patch set did some clean-ups when merging
> a bio. Any comments are welcome. Thanks.

Applied, thanks.

-- 
Jens Axboe

