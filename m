Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4BC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F51960FD8
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFHV2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhFHV2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:28:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1EC061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 14:26:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d5-20020a17090ab305b02901675357c371so146581pjr.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kNN1i0jrT7egcOu3/Gg1Kx3fRixlSMvnvYZBcIOdB0k=;
        b=r6G1vcNcZMXWXE6oDi0tLTFoeRKb4dnpyBZqrrJbmJwhBrCDaD1I7nyzN9J+47Zcb4
         9BF+Aq+xjvhTtlyr21YeXS6lD2Tbf6jDVsiwBnaP++TOlcPVHx2vFMzTrqQU+p9LTzZ0
         rvwrXYvPKkN7RFyyhxX57RGgHaG6v67wzF+cwyK+/OpOvNiXio42o1IuJEIjHzGMnKmx
         yDdIpf/30EykF5NoLqd/ESrGLwpjySkztMTAyEem8PU41Z6XgFncxxtj1l2xBlDLp5pI
         jZok4B0WsCatTx0KTbO/e9/Ev2SxFjLF6/PFL5q5w/ivFUBkq8dJ8Q311zak2hiPFXrT
         l1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kNN1i0jrT7egcOu3/Gg1Kx3fRixlSMvnvYZBcIOdB0k=;
        b=a4ObDqPmM7MiigtU44J7MO5bXZCkrC57H2/RvKnraztfquQ3wTh1G3o91sRHRuxP84
         gkPw1gqcl80c2id9TXKZEqOACOA7kHBzJxjgEpnrJILqgA6D/oQL3Q4zByLxlQMPjmPh
         ukt2YY4Ki9QB2Hwd5gt94WGj8Gr8TZdMi7cy3b5K1WApSk6kDZp5rroO8S/22JJnab42
         N3sf91Qi3KodxIiNwZNYCUZMu4ti8a0LKO64oDP84+KJv5ksDLNZxXsdh1m9/AN+5sLQ
         G2hiArvpd0kSH/TansERKjgSN14w2L1ehpRkD2yDAEEiGKJsHcaLXWR+eivdZucXvr5d
         DYjA==
X-Gm-Message-State: AOAM5337inCIaMHAIz7+V+n1zhohK0CzWJcLLD3JrLibf9Hp3C859YYM
        rfC0e82yscG3xZQl06/cikP59Q==
X-Google-Smtp-Source: ABdhPJyTM1saT9p8ZYGVelfuMPmeTYV1q7Z3qAgPiVEANKFqHtJZduf+t/dNGiht2a5I2zxw/1RELQ==
X-Received: by 2002:a17:902:8d92:b029:113:91e7:89d6 with SMTP id v18-20020a1709028d92b029011391e789d6mr1700511plo.85.1623187591661;
        Tue, 08 Jun 2021 14:26:31 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h8sm5800635pgr.43.2021.06.08.14.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:26:31 -0700 (PDT)
Subject: Re: [PATCH v2] libnvdimm/pmem: Fix blk_cleanup_disk() usage
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, nvdimm@lists.linux.dev,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <162310861219.1571453.6561642225122047071.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162310994435.1571616.334551212901820961.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b2082fc-be01-ad2f-9dd5-aa66b1c0ce85@kernel.dk>
Date:   Tue, 8 Jun 2021 15:26:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <162310994435.1571616.334551212901820961.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/21 5:52 PM, Dan Williams wrote:
> The queue_to_disk() helper can not be used after del_gendisk()
> communicate @disk via the pgmap->owner.
> 
> Otherwise, queue_to_disk() returns NULL resulting in the splat below.
> 
>  Kernel attempted to read user page (330) - exploit attempt? (uid: 0)
>  BUG: Kernel NULL pointer dereference on read at 0x00000330
>  Faulting instruction address: 0xc000000000906344
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  [..]
>  NIP [c000000000906344] pmem_pagemap_cleanup+0x24/0x40
>  LR [c0000000004701d4] memunmap_pages+0x1b4/0x4b0
>  Call Trace:
>  [c000000022cbb9c0] [c0000000009063c8] pmem_pagemap_kill+0x28/0x40 (unreliable)
>  [c000000022cbb9e0] [c0000000004701d4] memunmap_pages+0x1b4/0x4b0
>  [c000000022cbba90] [c0000000008b28a0] devm_action_release+0x30/0x50
>  [c000000022cbbab0] [c0000000008b39c8] release_nodes+0x2f8/0x3e0
>  [c000000022cbbb60] [c0000000008ac440] device_release_driver_internal+0x190/0x2b0
>  [c000000022cbbba0] [c0000000008a8450] unbind_store+0x130/0x170

Applied, thanks.

-- 
Jens Axboe

