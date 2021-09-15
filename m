Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36131C433FE
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 05:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B93F61214
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 05:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhIOFZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 01:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhIOFZw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 01:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F87660ED7;
        Wed, 15 Sep 2021 05:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631683474;
        bh=ljOmFAmib0bAEtZdHoo36RbeamT/R4nHBzP9ZGommlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1+KEGrOc5Yj/SOiMdcjfdtlIagitKQx1Y202wFhDoiPVOfxl0IzUC1ZTpYKJjli/
         YY3gJGa6f/x09LavZYrRmFM/T9xpq4qlbwmiJDfEDaczy8K998BZmn7PxM3TJaIrTI
         KBTjJC4IjxFvdJj62660fSpnNfQe6t67Hb42kDUo=
Date:   Wed, 15 Sep 2021 07:24:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     axboe@kernel.dk, pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kabel@kernel.org, chaitanyak@nvidia.com
Subject: Re: [PATCH v3 3/3] leds: trigger: Add block device LED trigger
Message-ID: <YUGDfebAmSWL4cbP@kroah.com>
References: <20210914201713.14922-1-arequipeno@gmail.com>
 <20210914201713.14922-4-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914201713.14922-4-arequipeno@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 03:17:13PM -0500, Ian Pilcher wrote:
> Add LEDS_TRIGGER_BLKDEV (tristate) config option to control building of
> the trigger.
> 
> Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
> ---
>  drivers/leds/trigger/Kconfig          |   9 +
>  drivers/leds/trigger/Makefile         |   1 +
>  drivers/leds/trigger/ledtrig-blkdev.c | 889 ++++++++++++++++++++++++++
>  3 files changed, 899 insertions(+)
>  create mode 100644 drivers/leds/trigger/ledtrig-blkdev.c

This change does a lot more than what you described in the changelog
text above :(

