Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA24C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A2B610A3
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbhIGROA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:14:00 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34420 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbhIGRN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 13:13:59 -0400
Received: by mail-pl1-f180.google.com with SMTP id j2so6243416pll.1;
        Tue, 07 Sep 2021 10:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYDs401BvuatCbxnRZw1i+4w3pvPmJU5MtqWESg7zUI=;
        b=er3fgh6ervAPgAOioMqaKxmMXwmahHMRCqVz3OV1fuylFcD32WjiFjBKlWCt592KpJ
         GY3DXObwM8Avs8w8mEAdxpDI/i6k94Qf3G1qmwtsLIPSaIhRSpLuWpACX3+P2QO4onBF
         qLYcXMPVPY22/1WxhY5dJ0BpNRDXBBbrjvbBkbcxyvbdh9k5WuFDbu8+qKg1/7LBH7oM
         v5S3V1OabZnjXXShEIZMepYD5+g66T2yzn6cAp8ByI3ywq0niN2ptpYuzw7r4g26EEvM
         16x/YcAnRzPJdi9yQRir498gZY2cdHcdD9c28KHCWlBVOATsYYor9Voy5sxzXmp0vMCk
         0nYg==
X-Gm-Message-State: AOAM530ALOmaN5BKsNyoWqswAV/1Hpo6R6d4ynMCioR6yWtj8+FPtISH
        q/wEtoRLPs+7taB8V1xdgnP1I88R7II=
X-Google-Smtp-Source: ABdhPJzX+pq3y15RAgw65Nm6RPZrqiexpxFDrdoCnA/JoaE46vLD40rxF/DvvyQW2TsuulRfkwN9iA==
X-Received: by 2002:a17:90a:2f23:: with SMTP id s32mr5619327pjd.168.1631034772758;
        Tue, 07 Sep 2021 10:12:52 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q18sm11569127pfj.46.2021.09.07.10.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:12:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
 <fdd5ab2a-af90-69bd-2d37-c5060ce68de4@acm.org> <YTeTQGrw41k08hgf@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <55fca3f4-4ed0-fd56-3069-c0ab343b2aed@acm.org>
Date:   Tue, 7 Sep 2021 10:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTeTQGrw41k08hgf@x1-carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 9:28 AM, Niklas Cassel wrote:
> On Tue, Sep 07, 2021 at 08:15:03AM -0700, Bart Van Assche wrote:
>> On 9/7/21 7:21 AM, Niklas Cassel wrote:
>>> blk-mq will no longer call the I/O scheduler .finish_request() callback
>>> for requests that were never inserted to the I/O scheduler.
>>
>> I do not agree. Even with patch 1/2 from this series applied, finish_request()
>> will still be called for requests inserted by blk_insert_cloned_request()
>> although these requests are never inserted to the I/O scheduler.
> 
> Looking at blk_mq_free_request(),
> e->type->ops.finish_request() will only be called if RQF_ELVPRIV
> is set.
> 
> blk_insert_cloned_request() doesn't seem to allocate a request
> itself, but instead takes an already cloned request.
> 
> So I guess it depends on how the supplied request was cloned.
> 
> I would assume if the original request doesn't have RQF_ELVPRIV set,
> then neither will the cloned request?
> 
> I tried to look at blk_rq_prep_clone(), which seems to be a common
> cloning function, but I don't see req->rq_flags being copied
> (except for RQF_SPECIAL_PAYLOAD).
> 
> Anyway, I don't see how .finish_request() will be called in relation
> to blk_insert_cloned_request(). Could you please help me out and
> give me an example of a call chain where this can happen?

Hi Niklas,

This is a bit outside my area of expertise. Anyway: map_request() calls
.clone_and_map_rq(). At least multipath_clone_and_map() calls
blk_get_request(). I think this shows that blk_insert_cloned_request()
may insert an entirely new request. Is my understanding correct that
blk_mq_rq_ctx_init() will set RQF_ELVPRIV for the cloned request if a
scheduler is associated with the request queue associated with the
cloned request?

Bart.
