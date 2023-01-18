Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914DDC32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 22:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjARWqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARWqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 17:46:42 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AB5F38D
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 14:46:41 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 7-20020a17090a098700b002298931e366so70550pjo.2
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 14:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rljNDn6RIVpFw9X9J6D/4Jr3E6S2O7gkEiq2bA58Ym0=;
        b=fgfm9gEMiTONGEVsSPIc5d0FOmUbhOA0GvQPDqlW5wDrsjPjrm0Nwt5vNOl5io1zRm
         q0FeIHtkwjPvUwW48SBHY0p8RNCWKdLHc/xisqmN4cNK+iKxlsxKaw2pNoeXWjRLlaLn
         GMpIbnkesLcKhQ/B2PkMZL22hUxLXadSe+b4ddtJUoZ1h8f/RtbdZcujLax7wbOW++k2
         75MUrUG/tEp9OwHeyu5pFhg9RaAlX4rDssbsiKUF8UkGklRPUHOcsf7VFgtjVoY/TA8K
         tWPwFf65FQN1yv+1fIH2UuFojqtbfxbbhyW8duQBsPL18JgUSESrkhSWYPtC0OmXtq3F
         Mmuw==
X-Gm-Message-State: AFqh2kqwdo+qi+d81R15bAEGYHp6O2UjT9wMZIyc1k6Gmnqmg9lSgipj
        4fZwWpHwdgr+fpEzhQj12/Q=
X-Google-Smtp-Source: AMrXdXtLzm3Ig6qk1udTx7CJVzTZYTvirfnPUzPtsaQaP40ViEbiwkqiAeNGKpiSVIDTQUQM0KBvZw==
X-Received: by 2002:a05:6a20:b71b:b0:b8:965a:ccb5 with SMTP id fg27-20020a056a20b71b00b000b8965accb5mr7667792pzb.24.1674082001242;
        Wed, 18 Jan 2023 14:46:41 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:22ae:3ae3:fde6:2308? ([2620:15c:211:201:22ae:3ae3:fde6:2308])
        by smtp.gmail.com with ESMTPSA id v18-20020a63d552000000b004a7e39ff1e8sm1830218pgi.49.2023.01.18.14.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 14:46:40 -0800 (PST)
Message-ID: <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
Date:   Wed, 18 Jan 2023 14:46:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20230103195337.158625-1-bvanassche@acm.org>
 <Y8hvNmyR3U1ge3H3@kbusch-mbp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y8hvNmyR3U1ge3H3@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/23 14:14, Keith Busch wrote:
> On Tue, Jan 03, 2023 at 11:53:37AM -0800, Bart Van Assche wrote:
>> This algorithm hurts performance for UFS devices because UFS devices
>> have multiple logical units. One of these logical units (WLUN) is used
>> to submit control commands, e.g. START STOP UNIT. If any request is
>> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
>> lower for data LUNs.
> 
> Can you give the WLUN it's own tagset instead?

Hi Keith,

Does that mean creating an additional tagset for the WLUN and statically 
allocating all tags from the WLUN tagset that are used by other LUNs? 
That approach would have the following disadvantages:
- The maximum queue depth for other LUNs would be reduced from 31 to 30.
   This would have a small but noticeable negative performance impact.
- The code removed by this patch negatively impacts performance of all
   SCSI hosts with two or more data LUNs and also of all NVMe controllers
   that export two or more namespaces if there are significant
   differences in the number of I/O operations per second for different
   LUNs/namespaces. This is why I think that this should be solved in the
   block layer instead of modifying each block driver individually.

Thanks,

Bart.
