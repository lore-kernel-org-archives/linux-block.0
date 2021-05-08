Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C0C433B4
	for <linux-block@archiver.kernel.org>; Sat,  8 May 2021 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ACA61410
	for <linux-block@archiver.kernel.org>; Sat,  8 May 2021 02:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEHCDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 22:03:49 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:41870 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 22:03:49 -0400
Received: by mail-pf1-f169.google.com with SMTP id v191so9127558pfc.8
        for <linux-block@vger.kernel.org>; Fri, 07 May 2021 19:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cUjmpwbBUQiMNcEbiPBnEbcDZZfX3CVLvLwqj1mRPo=;
        b=PxP1m85ATWK88oqDxtrPNCqbX8clnJVuI2s/g36ihxYAvpjQzv75Tnef0bd8ZkRfEc
         Oi3LHCm/E3zF3jt7I43rga0jsECwDjsMP1AViGVOcZT1iv4sAKk/8evGvyp8w7AaPvcD
         p02G5yc02CsttIfORFHEEpKqgeHR1s3q07t397dFIl9zc/8SXP+bYFPvthif6yYXyq/V
         jpRDN/ul5vv1ro+hqEhqorNGFqvsHdSPqc+jtTrodWIOE46qcUsPaHlzpcSYSc9ViPhX
         EvdrD6N6dSCGqIQ1CttIN54OwNHUd42bsMIJ9hhm2yhdLusCF4qyyvW4REih9zPdRV4M
         kE6g==
X-Gm-Message-State: AOAM533/cQL4m3+SF09W3c/E58a99vxLOa7DLDNGun2zYxGqhGUsJ/In
        hoBPR/i2JABdea2FA5haLmw=
X-Google-Smtp-Source: ABdhPJzxflUsz4yC0QMGZS2zOcuUCUQtjckMOvUyK5O01oSGUZWgSBsF7xM2xRfl0ADYJkXIjTPSiA==
X-Received: by 2002:a62:3706:0:b029:211:3d70:a55a with SMTP id e6-20020a6237060000b02902113d70a55amr13115646pfa.16.1620439367344;
        Fri, 07 May 2021 19:02:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:99c3:8a3f:1552:836d? ([2601:647:4000:d7:99c3:8a3f:1552:836d])
        by smtp.gmail.com with ESMTPSA id o44sm13778166pjo.37.2021.05.07.19.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 19:02:45 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org> <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org> <YJSFm99PUlLedF+D@T590>
 <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org> <YJSggHqgMFfWIALu@T590>
 <a2a7e66b-68e8-6468-2add-19ffbe096ed9@acm.org> <YJTepqtgw3+K5vWr@T590>
 <YJTjqtbjjbU8Fwgk@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d39be9d8-ff77-3377-f5a0-b0f767c0d0b0@acm.org>
Date:   Fri, 7 May 2021 19:02:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJTjqtbjjbU8Fwgk@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/21 11:52 PM, Christoph Hellwig wrote:
> Can we take a step back here?  Once blk_mq_clear_rq_mapping hits we are
> deep into tearing the device down and freeing the tag_set.  So if
> blk_mq_find_and_get_req is waiting any time on the lock something is
> wrong.  We might as well just trylock in blk_mq_find_and_get_req and
> not find a request if the lock is contented as there is no point in
> waiting for the lock.  In fact we might not even need a lock, but just
> an atomic bitops in the tagset that marks it as beeing freed, that
> needs to be tested in blk_mq_find_and_get_req with the right memory
> barriers.

We need to make sure that blk_mq_find_and_get_req() in its entirety
either happens before scheduler tags are freed or after the cmpxchg()
loop has finished. Maybe I'm overlooking something but I don't see how
to do that without a wait loop, the kind of loop that is embedded in
spin_lock()?

Thanks,

Bart.
