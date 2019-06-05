Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0BC28CC6
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242E7206BB
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="VwTNjfg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFEVxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:53:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEVxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 17:53:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so46369plm.6
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EwS9MXrCjJdsQyAUGBogfwtqnt0Cn8ZOwHGAI7RAhY8=;
        b=VwTNjfg3kgjA1g4Gw0KvQDjQjy0Ujw+YNg2SHcqxZ8JXv/w3UvNzpXRvE2ZUXErsKF
         pD0OFB8GVe+K3Gzf9w5lTcBVeEaZzh+tml5K1T5tTl9WqDSYTjyOX+nuaiMwXzC2Z6R9
         q1q9xWZoqDPJWgBbDhtX33BgRayLRUEhCQ+QUC6EbvGcjPKoC26OmBo6Bq1tYY53gCTi
         na6n57Jt0BnHFOlWGaipekLWDgs7M514Sv4O7CDGZsT7gcWnqnvgOY5tOuWoU7LAb4ZF
         LzqNLWWysE4oM1maJyzol8MlRg+un/8iABDljui04LwI5ollf5qOq8UdjFIi3VXthHTL
         lscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwS9MXrCjJdsQyAUGBogfwtqnt0Cn8ZOwHGAI7RAhY8=;
        b=r9H4WMVh8nid0qHiMSfrgAMJ4PCs/pfRZIcWtmVkWtJXe3KcoED9t4keQPWw9q5Do/
         0dm6yirScSYWIlTf9KJvt2lXsNjC6Z3b8t6sE9E4Y6Mc49Ks2VQW6G+BkStt/9eLB5g3
         8hUCtE9kkp9bbZvWojar+BRCXRr24fejBivIeQZe6mden8JjmxpqBEvmeoV0RlcU3Ikb
         HwUQnv/ZmWtMclZfgjm+rzWTBWgKe14bWmAK4cXf5epUFixW8dk2BAPS5QpwU/0LsvhQ
         SS3ZTFqT6uXDMAc/jW/8KRh9Zu4DFHxLj3wsaNhsPoMWjJDXiaP7gsTZ9wjmuQb2e3yj
         hWMA==
X-Gm-Message-State: APjAAAW3MeafivEVrua0/1839Ib0QMDwZ1HrEc0FPdZ+5ipDnhE4VgDk
        ZK9n9sZLAELgDKRvrN74zQI3dA==
X-Google-Smtp-Source: APXvYqzS6wyprO/w2Ld58A9QbtInGVmSA6V6y3wuwJeZtgvrZ6YW5QgMYSSSOfRYfYv86ejAtjEDow==
X-Received: by 2002:a17:902:522:: with SMTP id 31mr44431019plf.296.1559771612465;
        Wed, 05 Jun 2019 14:53:32 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:5528])
        by smtp.gmail.com with ESMTPSA id v4sm28140923pff.45.2019.06.05.14.53.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 14:53:31 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:53:31 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 2/2] zbd/007: Add zone mapping test for
 logical devices
Message-ID: <20190605215331.GB21734@vader>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531015913.5560-3-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 10:59:13AM +0900, Shin'ichiro Kawasaki wrote:
> Add the test case to check zones sector mapping of logical devices. This
> test case requires that such a logical device be specified in TEST_DEVS
> in config. The test is skipped for devices that are identified as not
> logically created.
> 
> To test that the zone mapping is correct, select a few sequential write
> required zones of the logical device and move the write pointers of
> these zones through the container device of the logical device, using
> the physical sector mapping of the zones. The write pointers position of
> the selected zones is then checked through a zone report of the logical
> device using the logical sector mapping of the zones. The test reports a
> success if the position of the zone write pointers relative to the zone
> start sector must be identical for both the logical and physical
> locations of the zones.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/007.out |   2 +
>  2 files changed, 112 insertions(+)
>  create mode 100755 tests/zbd/007
>  create mode 100644 tests/zbd/007.out
> 
> diff --git a/tests/zbd/007 b/tests/zbd/007
> new file mode 100755
> index 0000000..b4dcbd8
> --- /dev/null
> +++ b/tests/zbd/007
> @@ -0,0 +1,110 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Western Digital Corporation or its affiliates.
> +#
> +# Test zones are mapped correctly between a logical device and its container
> +# device. Move write pointers of sequential write required zones on the
> +# container devices, and confirm same write pointer positions of zones on the
> +# logical devices.
> +
> +. tests/zbd/rc
> +
> +DESCRIPTION="zone mapping between logical and container devices"
> +CAN_BE_ZONED=1
> +QUICK=1
> +
> +requires() {
> +	_have_program dmsetup
> +}

Looks like this test doesn't have a fallback device, so I can't run it
here. Is that intentional, or was it just overlooked?

> +device_requires() {
> +	_test_dev_is_logical
> +}
