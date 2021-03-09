Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6152C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09AB64F6C
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 19:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhCITWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:22:02 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37523 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCITVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 14:21:44 -0500
Received: by mail-pf1-f181.google.com with SMTP id a188so10115973pfb.4;
        Tue, 09 Mar 2021 11:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QwANI+6KZrQSKTeDISq1JRNG3B/zrhvXBbmxR3o6Zg=;
        b=IobDhRVhcOcXLabn5fLaxlNyXQXR3dmwmM4msH0Zuw/Oe7CgaSGmPC3PN0aNTT2LNP
         lcSWlsldE0JZsfUn2TM94DDaHFadzHdxkKI4FBTtLwe5lklXTrGQAegbM7yMdUwyRzEW
         7L4SAFHIsWnUPVgC6gza2qK/9SNIvGUSP5zRQ6vtzT0krB0PV1wscHECVpB9TSJRk7IA
         Q1xeB+RdpYpHeAsoDonyv0ofu8/SiFgSOEZntwmNuMS+8ODTGgbG2hT6KgAMsom6x+54
         s9yS06+Ril8Gmpe0Okneb32kbESUOh1V2AOmPVs6X4IYuIGONTe3AhHX3ucaonjR4tTI
         qeTQ==
X-Gm-Message-State: AOAM5313H0xYdyJjSyCZT3huXKxR7bvCuw7qS2gi61YyOcdum1tfZGuD
        N0UxJBIKINMqfA6q8IewgHI=
X-Google-Smtp-Source: ABdhPJxPgyGzE/+kY/0TUMf+MhJ1p8MzSCywLlQsacQWliUQvS+Gi0wvvJeoqOzGJQ5QFhnLa0D57A==
X-Received: by 2002:a65:57cf:: with SMTP id q15mr26535218pgr.380.1615317704126;
        Tue, 09 Mar 2021 11:21:44 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:d77c:6d52:1741:c90? ([2601:647:4000:d7:d77c:6d52:1741:c90])
        by smtp.gmail.com with ESMTPSA id fv9sm2936527pjb.23.2021.03.09.11.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:21:43 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
 <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
 <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
 <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
 <f60dc68f-9206-2bfb-950e-cb312f1c4c8b@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <de3dec73-c8fc-d14f-5bbb-7023ccc6b57e@acm.org>
Date:   Tue, 9 Mar 2021 11:21:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f60dc68f-9206-2bfb-950e-cb312f1c4c8b@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/21 9:47 AM, John Garry wrote:
> This does fall over if some tags are allocated without associated
> request queue, which I do not know exists.

The only tag allocation mechanism I know of is blk_mq_get_tag(). The
only blk_mq_get_tag() callers I know of are __blk_mq_alloc_request() and
blk_mq_alloc_request_hctx(). So I think all allocated tags are
associated with a request queue.

Regarding this patch series, I have shared the feedback I wanted to
share so I would appreciate it if someone else could also take a look.

Thanks,

Bart.
