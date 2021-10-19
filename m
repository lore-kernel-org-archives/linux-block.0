Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A443560FDA
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhJSNr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhJSNr5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:47:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD630C061746
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:45:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso2813882otp.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfhCL4H2IqoEAY7P0qSMczzQq7iOCcIlsad5SfE30VA=;
        b=eIL2wnUA6lsjieR++/JE53Lk9+pJsGf8Lv1/S0qdP0BjTXix72NcmJvmAF7hYLwx3a
         YdUd/5dnNfPkUd6aj4r215cwlAnnULuE3RD/n2qUnsnNe5nmALYj9MJ8rg3aLXDekSXf
         FOknZS+ckP31+6eSXAw4QT3uMznaKEWk05YNgVfL5A9zBx7SSExl6TjAJYqOiYPu8Q1k
         xbe404aCsC5I+XFH0gn2kAUd46uPCOypVSoFm2DQmgK8oucreqTV3Pw/1WGyDAa8y+L2
         FHKRWG6H22NcvxFsROzXM5FR3Yhg4lVmtFB0mUB7zNNmJxlL4kPvbObAqYxv8Tcd1JIg
         vOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfhCL4H2IqoEAY7P0qSMczzQq7iOCcIlsad5SfE30VA=;
        b=AqX6MlNZG0AR5/cq0TD1Ehjd6CiXDZYRFVBMXIfkZxXggJt44cYPLyhg+FtmG+t6X0
         Bn1bcYPUvIPiiKkwMnQgeiarToizFpaCstzq+ndc1VBF7h4wVlvorGYfqAIqVg2W0E1E
         YWo52x+u1hRVMeYsAqH1dXS5Kine08znRjD2JhZcSp5sikb6HnbTpmO9oYGil1xdz6CF
         HFfvFd9U3oOtYRlT3fHNh5stypfCQN8jwksK8tn3T1dWblO1U+yoHUDOkw4OIN8NjiTp
         fSmIjIpNDIfujNeMxW2/WrP1Nh3WakYaLaeW31uRsLKO6SF+aw3rdZxPWuGinvNmdfTj
         aAZA==
X-Gm-Message-State: AOAM5307+ojyJpf/qKvH/wkRKp8wq+Q2CIro6DR0iS7oKgBbPIgcr/mn
        H+xg0yj+4kt/XsQ17UcTqyOO/Ct1Ey99mg==
X-Google-Smtp-Source: ABdhPJyoeKPTtarp+CQmZSXzgHR+qxsombSw3qAek+X9Nzcr9KvxKemvZKrpS93vcrZhonPnmpTmWQ==
X-Received: by 2002:a9d:7998:: with SMTP id h24mr5635958otm.181.1634651143981;
        Tue, 19 Oct 2021 06:45:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j16sm3698142oig.29.2021.10.19.06.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:45:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk> <20211019133647.GB19216@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57e10bf5-86cb-95f3-fde7-090018d7c077@kernel.dk>
Date:   Tue, 19 Oct 2021 07:45:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019133647.GB19216@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 7:36 AM, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 06:08:34AM -0600, Jens Axboe wrote:
>> If we have just one queue type in the plug list, then we can extend our
>> direct issue to cover a full plug list as well.
> 
> I don't think this description matches what the code does.  My impression
> of what the code does it:
> 
> If a plug only has requests for a single queue, and that queue does not
> use an I/O scheduler, we can just issue the list of requests directly
> from the plug.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I'll expand it a bit, that is what I was trying to say, but it just
became too brief.

-- 
Jens Axboe

