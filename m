Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF7C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691D661222
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhHWSty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:49:54 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:33380 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWStv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 14:49:51 -0400
Received: by mail-pl1-f175.google.com with SMTP id o10so10768736plg.0
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 11:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RByE0PR8RQbV2dtSGa+APW+QS2+VeFBYpXSgbU32Ov0=;
        b=YaKgodQf88ylunS1LCeQ1nLjOMQG8bQtULM+n4dDY5CYXetuIQneOOM2fRBxLo2r3y
         dtipKv2phHxKKh3CYMTKVlgoer8mGQsbgDijLJtVndtLhGVo72k+lWRqxzFh/9aESw+j
         LN4JFp92eMRSEFYLKSPpfnbA0XxVtFcJCC+MtgqdTz7M64FpxlhLSlcOFVf3WJdwroca
         fatGNKmHJAdy/uvxkwLCZf95rX0KAIjGUff0zESYYaN227lB0YGHvktj46DJa3A4EbgB
         DRLRBcBYAOX/oza+lqnTICNftpZ/lIVssp1vtWsLsgsEc0tbWOJkaNPDrO4gZlahgnhr
         jzLw==
X-Gm-Message-State: AOAM532GNHZMd9e+DykSE6llOE1LhAjni6LqhaPyBsEe32PpYrEX/9rd
        Mt/KB973jd+oDfPiEMxJ13RQ97r7IkA=
X-Google-Smtp-Source: ABdhPJzutyqEfYXsT8kyHLOLt9T/BHV8qlT9Trs4CoEkWF9/X9w9y6xEfxTN9KYwQ4lKcAC/uNc2ZA==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr11704pjp.52.1629744548196;
        Mon, 23 Aug 2021 11:49:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e98a:ca44:7012:ad8e])
        by smtp.gmail.com with ESMTPSA id a10sm16582985pfn.48.2021.08.23.11.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:49:07 -0700 (PDT)
Subject: Re: Use-after-free related to dm_put_table_device()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <a5057305-9864-df8c-0657-ff33c85dc4f6@acm.org>
 <f340d947-501a-6076-8f43-8ac65c2ea47a@acm.org>
 <20210823071807.GA22543@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3de9f1e9-0c79-32e2-174e-720d705dddac@acm.org>
Date:   Mon, 23 Aug 2021 11:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210823071807.GA22543@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/21 12:18 AM, Christoph Hellwig wrote:
> On Sun, Aug 22, 2021 at 06:17:50PM -0700, Bart Van Assche wrote:
>> On 8/21/21 8:12 PM, Bart Van Assche wrote:
>>> If I run blktests nvmeof-mp/012 then a KASAN use-after-free complaint
>>> appears. Since I haven't seen this warning with previous kernel versions,
>>> I think this is a regression. Given the presence of bd_unlink_disk_holder()
>>> in the call trace, can you take a look Christoph?
>>
>> (replying to my own e-mail)
>>
>> Reverting commit fbd9a39542ec ("block: remove the extra kobject reference
>> in bd_link_disk_holder") makes the KASAN complaints disappear.
> 
> The block tree has had a manual revert since Friday.
> 
>> However, the
>> srp tests and one other test fail with that commit reverted:
> 
> Can you send the output?  My usual blktest setup can't run these tests.

Hi Christoph,

I found the following in the output of the failed tests: "ib_srp: enp1s0_rxe:
ib_alloc_mr() failed. Try to reduce max_cmd_per_lun, max_sect or ch_count". I
will run a bisect on the v5.13..block/for-next RDMA changes.

Thanks,

Bart.



