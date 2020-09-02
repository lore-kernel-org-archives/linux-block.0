Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5EDC433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9E420758
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBGeV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:34:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbgIBGeU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 02:34:20 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 7204CC567C53ADEA63F4;
        Wed,  2 Sep 2020 14:34:17 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Sep 2020 14:34:16 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 2 Sep 2020 14:34:16 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH] block: make bio_crypt_clone() return an error code
Thread-Topic: [PATCH] block: make bio_crypt_clone() return an error code
Thread-Index: AdaA8rlLEO+XAhxETkWGrxJysf7J6A==
Date:   Wed, 2 Sep 2020 06:34:16 +0000
Message-ID: <b90bb41c7755452eb6f3fb3116ff9d6d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Satya Tangirala <satyat@google.com> wrote:
>On Tue, Sep 01, 2020 at 10:15:11PM -0700, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>> 
>> Callers of bio_clone_fast() may use a gfp_mask that excludes 
>> GFP_DIRECT_RECLAIM.  For example, map_request() uses GFP_ATOMIC.
>> 
>> If this were to happen, the mempool_alloc() in __bio_crypt_clone() can 
>> fail, causing a NULL dereference.
>The call to blk_crypto_rq_bio_prep() from blk_rq_prep_clone() could also fail for the same reason. So we may need to make blk_crypto_rq_bio_prep() also return a bool and handle the errors in the callers (the only other caller is I think blk_mq_bio_to_request(), which explicitly calls the function with GFP_NOIO, so maybe we could explicitly document the fact that blk_mq_bio_to_request will return true when called with a gfp_mask th
at includes GFP_DIRECT_RECLAIM, and ignore the return value in blk_mq_bio_to_request()). (And maybe we should document the same for bio_crypt_set_ctx and bio_crypt_clone?)

Agreed.
Except for above suggestions, the patch looks good for me, many thanks.

>> 
>> In reality map_request() currently never has to clone an encryption  
