Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A79ECAAA3
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiHYVxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbiHYVxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 17:53:46 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA33CBD3;
        Thu, 25 Aug 2022 14:53:45 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id g19so2799533pfb.0;
        Thu, 25 Aug 2022 14:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PoKbqdZjqcMil3GUCh8PrCnRMNvOIz0uCEqvIuzke58=;
        b=grvscDb5M8s3FlXE/0PaeHXXMbtBlRx5VzlQJJSPkbUN2tSiqqeMbFECQE7b1uA9S3
         cbOeezWyRSUE0QlfIcp7Py4Ulw+aOXDgl5qx/blHo8Oplci+ez14tgW1DRDxsHkMM1va
         OiNCrEejcztmU82w8KLuXWyJBgFm/4YHeMabCriTjjrwxDg7g1A4ysIrGV5Pn7GO3fMy
         g3HmbujHhi/JEtoNTxjP/MZsvtCsTZVOWlxSx26q4W2gJ3jiwoO+qQLJMyWm9BE+lBfO
         swYrdHL/+HYaEkm61EZcjrLGq1rSH/oqmkimQg9rUAR4Fe7qkZtYA8OWNfcWV1Fvg7tQ
         3wBg==
X-Gm-Message-State: ACgBeo3qw+uEtjc/2wQ9IwUygowvAMt1ARTjrrhhcc+u+PVnFV9QEPwf
        udk8g/Wi1/urYsR1Aq3fkvQ=
X-Google-Smtp-Source: AA6agR4oitY7DdgWzlDg0toNkuqiso8T3oQu+9kbXRQF5gO1MpCeX6jwibhLOIeQZecVmG/fiQTvbA==
X-Received: by 2002:a05:6a00:3497:b0:536:d6a8:6f62 with SMTP id cp23-20020a056a00349700b00536d6a86f62mr1039067pfb.79.1661464424600;
        Thu, 25 Aug 2022 14:53:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a3b0800b001fb0a363c18sm195698pjc.52.2022.08.25.14.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:53:43 -0700 (PDT)
Message-ID: <9e81fd1e-b206-dd8d-4c27-1aa5cdcf4e10@acm.org>
Date:   Thu, 25 Aug 2022 14:53:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121911eucas1p2a55dec72a6d780123e6c7655aee72457@eucas1p2.samsung.com>
 <20220823121859.163903-10-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-10-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/22 05:18, Pankaj Raghav wrote:
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
