Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44162C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 01:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D57C206EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 01:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBB44 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:56:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3497 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgIBB44 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 21:56:56 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id F37C150C5F0233BDBFFC;
        Wed,  2 Sep 2020 09:56:53 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Sep 2020 09:56:53 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 2 Sep 2020 09:56:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "satyat@google.com" <satyat@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix potential NULL pointer dereference in
 __bio_crypt_clone()
Thread-Topic: [PATCH] block: Fix potential NULL pointer dereference in
 __bio_crypt_clone()
Thread-Index: AdaAy417VtyE3qTBTwm/TVcNbh4hxw==
Date:   Wed, 2 Sep 2020 01:56:53 +0000
Message-ID: <1a8ac4099d274d2b994a417c034fa3c6@huawei.com>
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

Eric Biggers <ebiggers@kernel.org> wrote:
>On Tue, Sep 01, 2020 at 07:59:21AM -0400, Miaohe Lin wrote:
>> mempool_alloc() may return NULL if __GFP_DIRECT_RECLAIM is not set in 
>> gfp_mask under memory pressure. So we should check the return value of
>> mempool_alloc() against NULL before dereference.
>> 
>> Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>It's intended that __GFP_DIRECT_RECLAIM always be set here.
>Do you have an example where it isn't set here?

map_request() only pass GFP_ATOMIC to gfp_mask, though bio crypt is not used yet.

>Also, if this can indeed happen, then we need to make __bio_crypt_clone() (and bio_crypt_clone()) return a bool (or an error code) to indicate whether it succeeded or failed.  We can't just ignore the allocation failure.
>
>- Eric

IMO, just the allocation failure is ok or we would break KABI.
Many thanks.

