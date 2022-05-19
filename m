Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F835C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiESO57 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiESO55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:57:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61580A5A89
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:57:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e194so6004869iof.11
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=;
        b=aqlhhmf0XcwVhCOLIoSM5gOFq9mwD5Cex0twLmG85/ZIdhHn++iG7/MTq7TrDyJfDZ
         lSf+lLpGVkg01G+euyz/PwHMTverhxG1jNMqFwM8w6eVr85Ov0I55ohHcp4U/Dnfd+Gp
         7JlW7DuGPRObM+Cl+BbU/hXWlIHaYuwM0W20R7Y/dl5DlEpVgUoowlblZ3F1RxugjmBy
         mPjlbRIPaV00xBfw7LdWbx7SdhCnQXJghL3k9t0TEU7Zfiw/dGHr2Mzf08I1OABwCO0E
         U0z2QAwTxLcgxqX0t2Wm3I68t0PfFVPZY6jOiromfQtx8Xb0Df/OlN9LzkqaOySKboiu
         eqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=;
        b=1G9eGn7itqSh2gh++E2kxaL0L++IpYt2fM67NIdGO0XsWK+KIDnzkTFslCekq7PisJ
         leNqzn2VNhdJySbixsni4Dn7OWfEdw/cOWi+vZ+Y2sUMiE9Nf0LXYoENQWBcxdOrkzC2
         6mdpzOCDgYPzpH6KTpdHJ2C4DYg1viQXtIoTBEjs6MLdMbgyyr7R0tQEq1jxwzzx5UeC
         wQfrRPql6yN86LYJIgx7gQUgpT8Z9BmtJDw8X/BbETBS7QQF6633DkkxGRuF3teGst/Y
         /cNet0N86mFnSw6DoxPT8m95SLB3Su10tyaYk6ot4cUN8K21l81/+SYdS1cMUZRNtTTX
         R3Ug==
X-Gm-Message-State: AOAM5319c9ofPP/wBJqi1azbGB1KHR3lqLLJGRhpSSO6kCfX6HxP/+7l
        Lgd0qwGMz2q9TvEda6v4p73pew==
X-Google-Smtp-Source: ABdhPJxBwbitopVhO0+bUUUKGrOmSS6xhLHdmNyA3Q0WGCIaS6Hszyg4+nUy425DUlRtVZRaT+4PLg==
X-Received: by 2002:a05:6638:411d:b0:32b:7465:fee2 with SMTP id ay29-20020a056638411d00b0032b7465fee2mr3145530jab.318.1652972275705;
        Thu, 19 May 2022 07:57:55 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g8-20020a05660203c800b0065a47e16f64sm776198iov.54.2022.05.19.07.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:57:55 -0700 (PDT)
Message-ID: <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
Date:   Thu, 19 May 2022 08:57:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Muneendra <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
 <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 8:55 AM, Hannes Reinecke wrote:
> On 5/19/22 07:50, Jens Axboe wrote:
>> On 5/19/22 8:45 AM, Hannes Reinecke wrote:
>>> If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
>>> is undefined, so it needs to be masked out.
>>>
>>> This patch is just a diff to the v2 patchset, as the original version has
>>> already been merged.
>>>
>>> Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")
>>
>> Either this sha is wrong too, or it's not in my tree yet the breakage is.
>>
> Picked up from linux-next.
> Which tree should I look at?

I'm assuming that commit is from the scsi tree? It's certainly not in
mine. So your commit message may be correct, but since it was sent to me,
I was assuming it's breakage from my tree. Which doesn't appear to be the
case, and I don't see any of the SCSI maintainers on the to/cc.

-- 
Jens Axboe

