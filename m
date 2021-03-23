Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75327C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357F5619B3
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhCWTLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:11:04 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33480 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhCWTKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 15:10:43 -0400
Received: by mail-pf1-f171.google.com with SMTP id x26so15298773pfn.0
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 12:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1szg665cEnF+mr/Rmk/mTKKNIyLfWLmCsMVMt8xWiNw=;
        b=VK4POyeie0RcmAsZ9FXZvYHGGpcse6x+O1wNvGP3YCEGbq2UNqi8M8EnP60QhtGzzc
         PAlBK0LS5QlruY2FHsz4WtyqgMUjCO6WcnDtPO/S+I1g5mA3RcoC7bH9YbOQSI1dIBne
         uHsm43Via4HT0zxv4J+JPjYV1T5RGx1rEX53xroMFJo2ONNIGmS89ZR82g9PjG1uYPdO
         8jcXBgK5kHADMLo4qLl8/55gXwHXKTWVMEx1N1ZUjVNyO8i55wEVYG+twETMt+aKmMtX
         oMElMCSfGGGjITr71UHxCQplL9mwgI97213bESeDaczAwVFpTmlPZ3irNE8e9RlW4hhZ
         ns8g==
X-Gm-Message-State: AOAM532IJnxbGhTXNOvvti0pYTAGr0q4VAFmkKQuOSw6hCQGsuaoAM2W
        7VbSar7sm6jp9QKyvFyXJAM=
X-Google-Smtp-Source: ABdhPJxqi+ipxNNSF+1Sf8OqQT4E7lCymfoZBvETFAkNKVCKNWXQkl3Xbx9aNZ3SeCWftxLNx3Ybng==
X-Received: by 2002:a17:902:e906:b029:e5:c6d2:7dd0 with SMTP id k6-20020a170902e906b02900e5c6d27dd0mr7334293pld.12.1616526643248;
        Tue, 23 Mar 2021 12:10:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9? ([2601:647:4802:9070:3b29:de57:36aa:67b9])
        by smtp.gmail.com with ESMTPSA id o4sm3261pfk.15.2021.03.23.12.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:10:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
 <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
 <20210323182244.GA16649@lst.de>
 <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
 <20210323190145.GA17528@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f405043-48b8-6cdc-71ed-74002571f41b@grimberg.me>
Date:   Tue, 23 Mar 2021 12:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323190145.GA17528@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> The deadlock in this patchset reproduces upstream. It is not possible to
>>>> update the kernel in the env in the original report.
>>>>
>>>> So IFF we assume that this does not reproduce in upstream (pending
>>>> proof), is there something that we can do with stable fixes? This will
>>>> probably go back to everything that is before 5.8...
>>>
>>> The direct_make_request removal should be pretty easily backportable.
>>
>> Umm, the direct_make_request removal is based on the submit_bio_noacct
>> rework you've done. Are you suggesting that we replace it with
>> generic_make_request for these kernels?
> 
> Yes.

OK, that should be testable...
