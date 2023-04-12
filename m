Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF7C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 09:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDLJnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDLJnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 05:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40854A2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 02:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB4561058
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 09:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC757C4339B;
        Wed, 12 Apr 2023 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292598;
        bh=cQYy5EIASxhVv4ZtqNdpgM7yrx4hR1zsGS/O2nBk23g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bmsbkzpDwuGA7r/QZ+cpt2Dk7OU2BNYt7z083JPEqsINwlmIpKDNxS6mBP1mfYMTI
         5Y1FghndOcNNgaeOv8eWZtmeiPyx7rGDjV9nM1HgIpjSaOwrJOJ1KwIQ6zjT6ixZcf
         cVdO0it+dZH0C0/Kd6pPpkgFO7dRbAzPWHHT2WYLcjyLqpvrqtyurQQwnYYQ8SAD+g
         mZCwyuOZFSJFRD0c6PMtGsFfXa9HT00WttabSb0heddNVY0zundkhuo9tU8VwBmtbp
         IwUiJfY2Hk4LpKtZo6T0h8D17IVsTDmUcS49ybdVXYIrNGMEkQCnOWsYPh5hORChJy
         AUbvfkmW0CstQ==
Message-ID: <8e239f96-8578-c40c-f6b1-b62cff102eb0@kernel.org>
Date:   Wed, 12 Apr 2023 18:43:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, shinichiro.kawasaki@wdc.com,
        error27@gmail.com
References: <20230412040827.8082-1-kch@nvidia.com>
 <CGME20230412091807epcas5p10b99767a999ded5789cb8ffce2189394@epcas5p1.samsung.com>
 <20230412091716.unhpznj4gzjjfehj@green5>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412091716.unhpznj4gzjjfehj@green5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 18:17, Nitesh Shetty wrote:
> On 23/04/11 09:08PM, Chaitanya Kulkarni wrote:
>> Make sure to check device queue mode in the null_validate_conf()
>> and return error for NULL_Q_RQ as we don't allow legacy I/O path,
> 
> Can't we do away with NULL_Q_RQ defination itself ?
> I mean, since I see in code we are not using NULL_Q_RQ anywhere,
> if we can remove NULL_Q_RQ defination from enum in null_blk.h,
> we can remove your suggested check, as well as check in null_init.

I think it is being kept around to avoid reusing this value to not confuse old
scripts.

> 
> --Nitesh Shetty
> 
> 

