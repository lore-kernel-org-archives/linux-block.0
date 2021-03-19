Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3EC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C18361961
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhCSP40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:56:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSP4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 11:56:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lNHU5-0002ev-Rs; Fri, 19 Mar 2021 15:56:21 +0000
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <YFTJHRfNANFIUgOD@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <70d5493d-1c33-35ed-cbed-18f4e0bad79a@canonical.com>
Date:   Fri, 19 Mar 2021 15:56:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFTJHRfNANFIUgOD@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/03/2021 15:54, Dan Schatzberg wrote:
> On Thu, Mar 18, 2021 at 03:16:26PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The 3rd argument to alloc_workqueue should be the max_active count,
>> however currently it is the lo->lo_number that is intended for the
>> loop%d number. Fix this by adding in the missing max_active count.
>>
> 
> Thanks for catching this Colin. I'm fairly new to kernel development.
> Is there some tool I could have run locally to catch this?
> 
I'm using Coverity to find these issues. There is a free version [1],
but the one I use is licensed and has the scan level turned up quite
high to catch more issues than the free service.

Refs: [1] https://scan.coverity.com/projects/linux-next-weekly-scan

Colin

