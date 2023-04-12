Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB2C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDLH5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLH5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F5C3
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 203C762ECB
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA0C433D2;
        Wed, 12 Apr 2023 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681286241;
        bh=zAJFPVL2V+E5NGepnTp//ORgVM/amY9FxTm4eO2CXgQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BlX4S7TYY0AY9Z7jkqsNoskYnBE87RrlJJvgcFG6qN9ARalDhooVFaXCi//lvSEsG
         +Kcvj+oH0Rn0YFK4LiZUh4x17HOdtMChSSyYK4Nd0VKKJpwIFVKL2N96KUKMblUcag
         7VCryRojU2ND80p0HUh6jeoPk431+OfUa+VeIathe3wS6pjnowUleZmsEvqNAjCC0L
         Iw+rFm910tfwhGKsrpayOQr7zk4nVUMbOI16DY0aRUXvAhjb3nd1EWHEesu6BaZ9vz
         vSz8GzFMbXLCLDtYMCFqgM/VAO26he4B+3RsXN/K4bFOZ4tKXgMj8x6E8NtK0jl81P
         0G/aeyLz+zLZw==
Message-ID: <824e2454-14d8-35b8-bfdb-ae26df255003@kernel.org>
Date:   Wed, 12 Apr 2023 16:57:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, shinichiro.kawasaki@wdc.com,
        error27@gmail.com
References: <20230412040827.8082-1-kch@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412040827.8082-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 13:08, Chaitanya Kulkarni wrote:
> Make sure to check device queue mode in the null_validate_conf()
> and return error for NULL_Q_RQ as we don't allow legacy I/O path,
> without this patch we get OOPs when queue mode is set to 1 from
> configfs, following are repro steps :-

Looks OK but the patch title is a little odd as I do not see what memory backing
has to do with checking the correctness of queue_mode. So what about something like:

null_blk: Always check queue mode setting from configfs

for the patch title ?

With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



