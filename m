Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048FC432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DC260F45
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhH1CUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:20:44 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42823 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1CUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 22:20:43 -0400
Received: by mail-pg1-f173.google.com with SMTP id q68so7492079pga.9
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 19:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlIVUEfF1xWoBQ8ZBlcDpfHgWjgs/Zg/GqF0cmyO0pI=;
        b=GEwO5+W0ovRcyahcmWlj3iEwx6qNPa3ExQGpDtUqr5fOsESpU4/xLyy6tGrLAR4Vv+
         b3ssr118dCqrQgu+3h9OY2gO/+G0UUwJV3mXcNBhV1lud0k5fQnZ2+63WiF941K3IYGZ
         XLzD82lG8wNos7O+16VDphyUeDw/7yQGy5WP04epDfm7A1uJGd+PNq5/1FojyPEeZYlW
         5IJN27RHluR0ZgiONT55Up2kI1oNdHWZp8dXZuwMzBqFV+fq+H2/doOr2rAaollMYv3w
         6BN9H/upwDMR5gB4k6ffrWIqKy7fE+lkHhnt54lC6QbOWaqG7AfJGjR57ldd7S31HgMk
         /ugw==
X-Gm-Message-State: AOAM530iv3C8mWOKDGH2bF/UpKNBtvcg4rzyzAqZEQyLpACZdB1brJdJ
        DCPnkIY3+2o+h87KWV6Ixz4=
X-Google-Smtp-Source: ABdhPJz2+rj/OKZba0+OUiZ7vhvCr6uPmrDVrM5W9q5asKrCZcedrRzuzpR/kJl2rE64XMrJmYQ+2Q==
X-Received: by 2002:a05:6a00:1789:b0:3f9:5ce1:9677 with SMTP id s9-20020a056a00178900b003f95ce19677mr1022596pfg.50.1630117193593;
        Fri, 27 Aug 2021 19:19:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7c18:2fe1:2126:c371? ([2601:647:4000:d7:7c18:2fe1:2126:c371])
        by smtp.gmail.com with ESMTPSA id u9sm8237326pgp.83.2021.08.27.19.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 19:19:53 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <e2571b1b-2dde-9b6d-8373-579fdee1218c@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b9b243b2-4eaf-9acf-fccb-f028c359a2a9@acm.org>
Date:   Fri, 27 Aug 2021 19:19:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e2571b1b-2dde-9b6d-8373-579fdee1218c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 6:45 PM, Leizhen (ThunderTown) wrote:
> On 2021/8/27 11:13, Jens Axboe wrote:
>> On 8/26/21 8:48 PM, Bart Van Assche wrote:
>>> With the patch series that is available at
>>> https://github.com/bvanassche/linux/tree/block-for-next the same test reports
>>> 1090 K IOPS or only 1% below the v5.11 result. I will post that series on the
>>> linux-block mailing list after I have finished testing that series.
>>
>> OK sounds good. I do think we should just do the revert at this point,
>> any real fix is going to end up being bigger than I'd like at this
>> point. Then we can re-introduce the feature once we're happy with the
>> results.
> 
> Yes, It's already rc7 and it's no longer good for big changes. Revert is the
> best solution, and apply my patch is a compromise solution.

Please take a look at the patch series that is available at
https://github.com/bvanassche/linux/tree/block-for-next. Performance for
that patch series is significantly better than with your patch.

Thanks,

Bart.
