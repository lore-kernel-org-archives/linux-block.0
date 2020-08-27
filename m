Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D649C433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1132054F
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zJeJtPAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgH0Ovr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgH0Ovq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 10:51:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02ACC061264;
        Thu, 27 Aug 2020 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CXo1VsNJMnumrlPogWjBzw/zPcnBvymTjxJVEjV9DV8=; b=zJeJtPAjIfwokijM3k3lS2EFrm
        p9b5Je7DxKqNlk4czOD+QNZUCgF5kKnpUWj0iQiV8X9efsyedLsuRlOLEEIxaRVC3qtB1UZU8eTIo
        f5FTAHewB3b+83F7e2HolU51i5Hxr25cV7RlGmTPHLJQwLbjOxid5eDC51q5OOmzIrUFiChw+gBl3
        riyvif8xmDNzt3vRE2YCjf8JJJ51SPyNvpVmOx0TZIVr7JemYwDbUiDS8fCgJfWKa97RtmQtzhius
        3YQ2HkBL3/4rWTd6I55RDITc7Y2/JJdWKJ4B+7sYH7q56rXJGcqQb7ZHnP1P9Df9IO54dLGAYRJOR
        v3JnR6og==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJFf-0007Dp-1X; Thu, 27 Aug 2020 14:51:43 +0000
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
To:     Niklas Cassel <niklas.cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     damien.lemoal@wdc.com, johannes.thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d9fb163-f9d9-1f2d-d88c-db9d3a6185b4@infradead.org>
Date:   Thu, 27 Aug 2020 07:51:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827135018.63644-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 6:50 AM, Niklas Cassel wrote:
> Add support for user space to set a max open zone and a max active zone
> limit via configfs. By default, the default values are 0 == no limit.

Hi,

How does a user find out about how to use/set these limits?


> Call the block layer API functions used for exposing the configured
> limits to sysfs.
> 
> Add accounting in null_blk_zoned so that these new limits are respected.
> Performing an operating that would exceed these limits results in a
> standard I/O error.
> 
> A max open zone limit exists in the ZBC standard.
> While null_blk_zoned is used to test the Zoned Block Device model in
> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
> mostly follows ZBC.
> 
> Therefore, implement the manage open zone resources function from ZBC,
> but additionally add support for max active zones.
> This enables user space not only to test against a device with an open
> zone limit, but also to test against a device with an active zone limit.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1:
> -Fixed review comments by Damien Le Moal.
> 
>  drivers/block/null_blk.h       |   5 +
>  drivers/block/null_blk_main.c  |  16 +-
>  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------
>  3 files changed, 282 insertions(+), 58 deletions(-)

thanks.
-- 
~Randy

