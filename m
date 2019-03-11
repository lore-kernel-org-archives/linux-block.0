Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8DC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124952064A
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Y/fbo761"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCKUzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:55:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40019 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfCKUzI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 16:55:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id h1so125839pfo.7
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2019 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=91Yi7p4MzIcskZm8NLKzik0GvFWS14Te7IA8anmFONU=;
        b=Y/fbo761ewW3C5sgyAviXPNxpCCc2xRiGa2MMshcqzHAtGnzvono6ysJQCgg0Oy2Wv
         NH2xWeFPeQAvAtvMeZgOWaXR5d9jVHhFCVI6y1igx3csRlwkB72w75IyPIGvICFSzjJH
         L32F38S5cmwgkE2ZUZwx3bcCdEJEBmg/9EjepzF4t+KwXZnquj6C55mpVS7kmZgwt9h0
         IW9VNYodR7kDwUdQQUuUEN0rnmndfNaKXn85UT3SO/Ml1bq5I47RMtW1hUmEVOs6PmYk
         mWoCHp/zg2+cjJeTgvkE/0Z4BSQkxb5MLWcygYe74cFnBdKxFWNJ5EsRuPk7MIFcGbsD
         PZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=91Yi7p4MzIcskZm8NLKzik0GvFWS14Te7IA8anmFONU=;
        b=HKhRGb58qjRuFLmjyVfh7YzfDox+rhrmn7McZWRJqKBZOFP7K3T4Pn9G/rfAKnrqcu
         FdXtVEA0Eb4Mb3WOpm6zg1msGczyiSDYX34jEUAlcPRjMA9SkRx4KM8dvnX4MkqYDfCa
         xDG/05jjyzAlJq5Vnwjx4GIPtLuG8d8Z44kR4FWsVi3yJDO3N//DUw3zSeIBiuVkQtIL
         sHK+EbhonKIWfne0y00kNBJ02dbJUZqm5fAaaYlZXj+lkVZvQamPVG/2P12ZTXYYR6i5
         hv0Ro7f0cI1nO9gW3ItUW9vrUJDPsFxxO4jVw9sRxAgONoYj/bxswEd5naY94OYFXRWs
         FksA==
X-Gm-Message-State: APjAAAUga+CAOf23noqnywxH0lwzQ+Y5QDxmZWLLm5fMKwHmw/GE1cOk
        0NO4B5DltqHS0fJE2QkeOyyjqpgW8LY=
X-Google-Smtp-Source: APXvYqzy7gr8TQyiOnUP74hUI9dnlOwKiFnhZTiCX0l4E641lsC8rTvnnfA/mm2RvQga9jqSExcscA==
X-Received: by 2002:a62:138f:: with SMTP id 15mr34848807pft.219.1552337706919;
        Mon, 11 Mar 2019 13:55:06 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::1:4c93])
        by smtp.gmail.com with ESMTPSA id l2sm9022739pgj.64.2019.03.11.13.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:55:06 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:55:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH V2] blktests: add userspace IO test
Message-ID: <20190311205505.GC1315@vader>
References: <20190305015026.10751-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305015026.10751-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 05, 2019 at 09:50:26AM +0800, Ming Lei wrote:
> Add one test to cover changes on block passthrough IO interface,
> such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> and blk_rq_map_kern().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/029.out |   4 ++
>  2 files changed, 115 insertions(+)
>  create mode 100755 tests/block/029
>  create mode 100644 tests/block/029.out
> 
> diff --git a/tests/block/029 b/tests/block/029
> new file mode 100755
> index 000000000000..c7c674464285
> --- /dev/null
> +++ b/tests/block/029
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> +#
> +# Test userspace IO on NVMe loop device

This is still missing a reference to the patch it's testing.

> +. tests/nvme/rc

Shouldn't this be in the nvme group?

> +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs
> +}
> +
> +__test_user_io()
> +{
> +	local disk="$1"
> +	local start=$2
> +	local cnt=$3
> +
> +	local bs=$(blockdev --getss $disk)

This still has a ton of missing quoting and shellcheck errors.

I fixed all of this and pushed to
https://github.com/osandov/blktests/tree/user-io. Let me know if this
looks fine and I'll push it to master.
