Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9092C433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A478F64EB9
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCRUZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:25:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50441 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 16:24:59 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.210])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMzCT-0007u7-KV; Thu, 18 Mar 2021 20:24:57 +0000
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
Date:   Thu, 18 Mar 2021 20:24:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/03/2021 20:12, Jens Axboe wrote:
> On 3/18/21 9:16 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The 3rd argument to alloc_workqueue should be the max_active count,
>> however currently it is the lo->lo_number that is intended for the
>> loop%d number. Fix this by adding in the missing max_active count.
> 
> Dan, please fold this (or something similar) in when you're redoing the
> series.
> 
Appreciate this fix being picked up. Are we going to lose the SoB?

Colin
