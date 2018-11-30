Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74DFC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE312146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="A2EkrMLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE312146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeK3TrW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:47:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32784 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeK3TrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:47:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so4270328ljd.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 00:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRyTHqgWhvret3WcN9LJhveZcs5nd4vuWeAbFwQmTYA=;
        b=A2EkrMLkub6jsgcJHDLjngW1xPiv8KthQggqi9M9LT4an29CXUJ8h5yKpUbCtwYM3/
         kPCRCrh6p10zwykVYaBKJJXL2OiRWZVM6MeQdh3mR+fHen3/rsYjOzdCDux+9dkLgUfj
         ypmzSjBCQSz82liR6pl7XtVbSMRUO+BaMfe14+p2LgZOdgcqE8BIJ32CzO3YVC/iqBfM
         i1c5GRp5k2UU/Y9eAQM58Ie2d1QXX7x7uPtd6LUVIlgZXKAoB69RNfNCpvKTcyq4albk
         QZIeHT3CmRw8kv93oyZXDztWsdhU2KdbEL0zjBqOJ9/XI8R69jmP48M1Xd/l+UMVsKwk
         Rivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRyTHqgWhvret3WcN9LJhveZcs5nd4vuWeAbFwQmTYA=;
        b=AN/q03wGwI7RWXSB862ROsXf4pEu52SA0HGo/A+WuoDrVKj1c3XkqwkIy4zhyhqqE2
         wlDSf0cjNc0GJTaeccrYNVkCJczzXZ0qypyxCfm6IiX7FJwvsdyL73Wed59CY1BGcMnV
         k6330AVUqe0Ws+bcR1XC0E9Y//pWPLZGgP1vipDk9BadeSz2hbmcCMeA+ZlPluqc/sBF
         R8NYXU8sTZMaFgAO13ixOgo4CAr6CnolZN4TOQkxN9kSuBKOYScUW0RGHN/sA3LcAkUI
         Ev0CdhTTTazu3FMgaCaF7JTqT1/8S79R2prtzeAPaGJ7DCngFfw5r3l9WiAksvktX/jX
         8udg==
X-Gm-Message-State: AA+aEWb1xxO2jpz8I4eril0VjID1Tkp3e1GaUVFa3WAU/KQ3kAmfqdaQ
        9SDmV0m8i1i6sQvV2kv1AmJXpO+BP6U=
X-Google-Smtp-Source: AFSGD/XRt8jQRpFL71yepjwA1rmxkms0num6tkQoIWWU2GRLItWH4Dz9eEaw+ZTaTqgXspOngVEGug==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr3189745lji.167.1543567127606;
        Fri, 30 Nov 2018 00:38:47 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id i13-v6sm671409ljg.82.2018.11.30.00.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:38:47 -0800 (PST)
Subject: Re: [PATCH v4 0/5] lightnvm: Flexible metadata
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <20181129071606.56942-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8d0d1a08-a8c6-211c-028a-53639a10af13@lightnvm.io>
Date:   Fri, 30 Nov 2018 09:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129071606.56942-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/2018 08:16 AM, Igor Konopko wrote:
> This series of patches extends the way how pblk can
> store L2P sector metadata. After this set of changes
> any size of NVMe metadata is supported in pblk.
> Also there is an support for case without NVMe metadata.
> 
> Changes v3 --> v4:
> -rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
> -split pblk_get_meta() calls and lba setting into
> two operations for better core readability
> -fixing compilation with CONFIG_NVM disabled
> -getting rid of unnecessary memcpy for packed metadata
> on write path
> -support for drives with oob size >0 and <16B in packed
> metadata mode
> -minor commit message updates
> 
> Changes v2 --> v3:
> -Rebase on top of ocssd/for-4.21/core
> -get/set_meta_lba helpers were removed
> -dma reallocation was replaced with single allocation
> -oob metadata size was added to pblk structure
> -proper checks on pblk creation were added
>   
> Changes v1 --> v2:
> -Revert sector meta size back to 16b for pblk
> -Dma pool for larger oob meta are handled in core instead of pblk
> -Pblk oob meta helpers uses __le64 as input outpu instead of u64
> -Other minor fixes based on v1 patch review
> 
> Igor Konopko (5):
>    lightnvm: pblk: Move lba list to partial read context
>    lightnvm: pblk: Helpers for OOB metadata
>    lightnvm: Flexible DMA pool entry size
>    lightnvm: Disable interleaved metadata
>    lightnvm: pblk: Support for packed metadata
> 
>   drivers/lightnvm/core.c          | 30 ++++++++++++------
>   drivers/lightnvm/pblk-core.c     | 61 +++++++++++++++++++++++++++++++------
>   drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-map.c      | 20 +++++++-----
>   drivers/lightnvm/pblk-rb.c       |  3 ++
>   drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-----------------
>   drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
>   drivers/lightnvm/pblk-sysfs.c    |  7 +++++
>   drivers/lightnvm/pblk-write.c    |  9 +++---
>   drivers/lightnvm/pblk.h          | 24 +++++++++++++--
>   drivers/nvme/host/lightnvm.c     | 16 ++++++----
>   include/linux/lightnvm.h         |  8 ++++-
>   12 files changed, 233 insertions(+), 80 deletions(-)
> 

Igor,

I pushed the preparation patch to core. Please rebase and I'll pick up 
the patches.

Thank you.

