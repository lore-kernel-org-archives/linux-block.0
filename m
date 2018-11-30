Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A2C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 13:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C434B20867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="kopUjiUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C434B20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLAAQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:16:03 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39280 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLAAQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 19:16:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so4053856lfh.6
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKXSOhnDG1r6cZPWnWUbyb+JBd4zh+JajFeJ7tc9F2A=;
        b=kopUjiUGUn24buqIS82nhW3pQlkqk1CZLE14wZNKTgsngqK6Z0pt5y0WOU/QdFSAZi
         Qy7li6ntTp5Pw2jtHVrgh+NqO+l+ZZjjHD60e+p+6MwOF1SyEhSQyTiRMC8aDUZFKMKV
         nFY+cFWmr0VzX0DpAY8+8tOaAgYVhZPARnW/rAg8VzywckB67FGtEEDHPydqMHpnEqHK
         jPptTnHBrSOYwiLfs4FPJcEFSKfaDs3dMRkz0N5gF10n781pY+MhrSqcmi8iNtTyMo1B
         QVE+GcI2EJ1f9/NK1T2MsPtR+ftfJK+Bgptmyag2l3sr6GjCADV2HpjdbbRHk9lP43Jm
         ejXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKXSOhnDG1r6cZPWnWUbyb+JBd4zh+JajFeJ7tc9F2A=;
        b=KkHbVfRL5HXjFszRts+RgEtKHpUIHye1JpU3WXTuAEXYXlTEBZq6mc3mLOtoYAeX0c
         AsqL2BnjnIDlyAfglClrbOc5Q0Epqeao6JzhgpIJ8rrdgRncMPG7vqjtKiTnZ4Ak3CCz
         Qqv7m3EQbRVc88gJ9O+/T4e5ffYgQQ+53MtZr3ydbF5YwWbtwEYF1YmyeYpX33N39KBq
         uKfT4Ny46GDlGVkoWfwC/wC7gmPTDIOuXQvD4ChDN3j9yT7WJlK/fYMNkVE6fWwo3OgT
         nnCUYQQYueSJav0PpU7K/FJ/ZygeOoqB4vytMFH4KjASIFLiACkFC325nUdmlLo48mwH
         aa2g==
X-Gm-Message-State: AA+aEWaVJP21Xq+SUOHcPtq3id3EBOGDsnIRRzm6OMaPCEQ2NlZLRJfj
        IfKdtkd7kLZ+P8IZ2GtbuHy6Hw==
X-Google-Smtp-Source: AFSGD/WT1ML/seXvDju3TBx4VBa04jyUYDMExmdGqvMdWK9ydZCLCGSheZ5C7ppxcO+IcrsT5XSiBg==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr3453440lfb.76.1543583206749;
        Fri, 30 Nov 2018 05:06:46 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm772258ljf.96.2018.11.30.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 05:06:46 -0800 (PST)
Subject: Re: [PATCH v5 0/5] lightnvm: Flexible metadata
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <20181130114402.43793-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5ca4fef0-31ff-399d-3459-e3edefdadafc@lightnvm.io>
Date:   Fri, 30 Nov 2018 14:06:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130114402.43793-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/2018 12:43 PM, Igor Konopko wrote:
> This series of patches extends the way how pblk can
> store L2P sector metadata. After this set of changes
> any size of NVMe metadata is supported in pblk.
> Also there is an support for case without NVMe metadata.
> 
> Changes v4 --> v5:
> -rebase on top of ocssd/for-4.21/core
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
>   drivers/lightnvm/core.c          |  9 ++++--
>   drivers/lightnvm/pblk-core.c     | 61 +++++++++++++++++++++++++++++++------
>   drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-map.c      | 20 +++++++-----
>   drivers/lightnvm/pblk-rb.c       |  3 ++
>   drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-----------------
>   drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
>   drivers/lightnvm/pblk-sysfs.c    |  7 +++++
>   drivers/lightnvm/pblk-write.c    |  9 +++---
>   drivers/lightnvm/pblk.h          | 24 +++++++++++++--
>   drivers/nvme/host/lightnvm.c     |  6 ++--
>   include/linux/lightnvm.h         |  3 +-
>   12 files changed, 209 insertions(+), 68 deletions(-)
> 

Thanks Igor. I applied the patches for 4.21. Please note that I updated 
the patch descriptions a bit. Let me know if you find anything out of place.
