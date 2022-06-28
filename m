Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F36C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 02:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiF1CuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiF1Ct7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:59 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138C10EC
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 19:49:58 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id w24so11193108pjg.5
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 19:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o9O8He0A2n+R/3RTmq2ItfMPUMgdHm+kfPj1RpwnPpU=;
        b=dT31Kf0WPcgFBQJjlLVavjyGIr+ZL/i2+yahSHFw/npMFnshcEJv39LgR55Lz1NIND
         vUo1kMBnSI9Cuope3DCqBK4ivyoTd31bwS5TETmXBLI0EDLx7lhRX6K8D55BxpPOry8v
         Y6PPUIU2dTqwn/DyRZx1R4YQKpNYrYNmreS/+qYvrNPEhkxaaV5FtgfEPl6fp95Sdvz1
         prfqTNdqFDikpuAptYPHTzQ/kTT+eE1hsJDTYbQlMFs7k5MIU7JZmIAuwZkA6vjpVGWD
         2nKeqHfZA+E5NDc7e23ldtYgUsFzPoGtR0/BPFPHaalusWayP/2/8J9Y0TyOUOg+mCLS
         wg6Q==
X-Gm-Message-State: AJIora8lsHCVr010/y1ZJvErezoY0fwNBs0wsRmYJxeSv/uIdwbv+Wwy
        YFKyV5J1EGBv+ZMuZNDXrmgbTBNnxnk=
X-Google-Smtp-Source: AGRyM1svc+BFyjvdoK6B0UzTG9/0vtVJLj8np2/zRUc5aFuPcO+mSvOvZ+sZGQMGDyfXYHSDRn9Lnw==
X-Received: by 2002:a17:902:f689:b0:16a:4021:8848 with SMTP id l9-20020a170902f68900b0016a40218848mr1339378plg.23.1656384597897;
        Mon, 27 Jun 2022 19:49:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0016a0bf0ce32sm7923023plp.70.2022.06.27.19.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:49:57 -0700 (PDT)
Message-ID: <9dcec239-0f94-11b0-c4db-a4775e7eab4e@acm.org>
Date:   Mon, 27 Jun 2022 19:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/8] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-4-bvanassche@acm.org>
 <a7f3169c-2e67-7d7f-e9d4-09a5a38a7e1b@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a7f3169c-2e67-7d7f-e9d4-09a5a38a7e1b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 17:36, Chaitanya Kulkarni wrote:
> From the comments that I've received, when introducing a new helper or
> a flag should be a part of the patch that actually uses it,
> is there a specific reason that this has made as a separate patch ?

Hi Chaitanya,

This patch is a separate patch to make it easy to review this patch series.
I'm concerned that if I would combine this patch with the next patch that
the result would be harder to verify than two separate patches.

Thanks,

Bart.
