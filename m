Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDBC433B4
	for <linux-block@archiver.kernel.org>; Sun,  4 Apr 2021 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB961242
	for <linux-block@archiver.kernel.org>; Sun,  4 Apr 2021 01:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhDDBLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Apr 2021 21:11:20 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33755 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhDDBLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Apr 2021 21:11:20 -0400
Received: by mail-pf1-f178.google.com with SMTP id x26so5990882pfn.0
        for <linux-block@vger.kernel.org>; Sat, 03 Apr 2021 18:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wvCyg0pgzkUKo3CjDUtwBswjrtrJTXUdNXxCgy+2fI=;
        b=omOeqmwnALcJ2TcNdSOU9ViqO+NPDeWiA7r4MVmSnl228CK3VBrn7Ltm0IZkkj6HXU
         bicxOxWe/9LiFmSCPCTcDkzKpElYFLQPcJQM7Z24RyhXzeyPbfXUI8MB9KAou/DcYSzC
         OhGIfLQoWfxsu7uFI6jDZ5dpBsjWvITyDjSXKceyDv9xKEXPPrzCbgTxzPs2C0CnD0dV
         M1qVclo4/mQpy4FxmhctghRiFOX9BCFQZogeio54zYxqRA+NSp+q1MS1/n+yXjfDdaI5
         beBW0zfCBpWrwxYD1kWmJLPxv9PFJpiWYgiSgQW3bx9DcbZs0zJgKYVWCVOwehC1+0tl
         QIYg==
X-Gm-Message-State: AOAM530SQjt2hGuMbIogaOaTfTSw5tZWo9NAoYKPZZ+5whTv1pwHTXmV
        6w8VFwl2HF0ftgsWhbSsdz0=
X-Google-Smtp-Source: ABdhPJy6NxMOv804/rtLubFsXGFgf1LUzRpkLJEofRBsnnmynh7sIA+6kWYOmDYGeLzDTGlv0o5wnw==
X-Received: by 2002:a65:5088:: with SMTP id r8mr17448627pgp.434.1617498676654;
        Sat, 03 Apr 2021 18:11:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f0e0:a6d2:1540:7561? ([2601:647:4000:d7:f0e0:a6d2:1540:7561])
        by smtp.gmail.com with ESMTPSA id w191sm12705686pfd.25.2021.04.03.18.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 18:11:15 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210329020028.18241-1-bvanassche@acm.org>
 <20210329020028.18241-4-bvanassche@acm.org>
 <CACGdZYJb8saxEkkmenPDK=o9r0Av3PNJsGitAgpiXHd4D13TYg@mail.gmail.com>
 <229d08ec-7ae9-31f2-9f7c-ae340e372c56@acm.org>
 <CACGdZYKbV6QHaPJveUyf34iwgMRV2sDcSmrue23k=EfSWeLgjA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <12039bbe-bead-a9fc-f7d8-2e080e782f1b@acm.org>
Date:   Sat, 3 Apr 2021 18:11:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACGdZYKbV6QHaPJveUyf34iwgMRV2sDcSmrue23k=EfSWeLgjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/21 8:37 PM, Khazhy Kumykov wrote:
> On Fri, Apr 2, 2021 at 8:26 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 4/2/21 4:59 PM, Khazhy Kumykov wrote:
>>> lockdep_is_held(&tags->iter_rwsem) ?
>>
>> I will change the second rcu_dereference_check() argument into the
>> following:
>>
>> rcu_read_lock_held() || lockdep_is_held(&tags->iter_rwsem)
>
> rcu_dereference_check() already has a || rcu_read_lock_held(), fwiw

From a quick look it seems like other rcu_dereference_check() calls do
not specify rcu_read_lock_held() explicitly so I will leave it out.

Thanks,

Bart.
