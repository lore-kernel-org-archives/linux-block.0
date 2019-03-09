Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC00C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4416207E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="HYI32Op7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCIQ4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:56:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45571 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfCIQ4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Mar 2019 11:56:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id f19so584644eds.12
        for <linux-block@vger.kernel.org>; Sat, 09 Mar 2019 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJx96JOhceO+6X4Mg5GYwo6Gmd7tuQKswseaCHtuxv4=;
        b=HYI32Op76j+Ut4WV2utnvLmhzGfhlZvkRo/GE0jPDCdLAWlZbWy+DdVM/bUwE8/zON
         mySJchEReugOrJMuE00fyYJKw4Q2RxU4t4dT6zQusHw792lFVf5L58op9ZkmC/xz2++5
         wVsJwRTU1nPI0tDljzw5qyTSF0x3g1c2b3Bz+agmhUgFTE3ER9kftPJe+z8bvpwwAz/d
         RX8PerkjeJ+4mEoSwbMfILSlx8RDX+E3tKBBYss9BcP4/PlGraKCmDqmYNjtUmCceO+w
         IFvZiAeAOOaYxUbym5+6ujJ+/4UqGkAvyZrDLk5TadZqY5VKMz4h46MFhq0GKquj0DD0
         tzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJx96JOhceO+6X4Mg5GYwo6Gmd7tuQKswseaCHtuxv4=;
        b=KXEqYe/eoHGZlmPC8fy1SdnhBmi+Qycv9FoL5nkwHSo9gOxBLXyOJjXaIz7In4zbg2
         iHuGOgwNaR8B9WblgREqqyYZiL2fQmYanmJjnrFZmXTGQEcoZQuKOSeFo0WRtxgbqxAe
         Gb5OtoFnyRKf/+QuTArCuQWhWXXzeqsNGMqvMN9/15JCd9q8D+ugDeMGHPQCFFmDNmkt
         Lxet8SV7X/eGJeCdxLO/nxVkjstuEiW+U+xhbSB9ys84cRHMcyldME+EsT3B2pcmuc2V
         6+oTSPKDu4kT8d5qyJH/0ObK+6PmAvCH35+3kq3J1csDIpMXWRErlC/iVt+dREVxPINV
         oCvA==
X-Gm-Message-State: APjAAAUiotFGittoQPShCyCre9uinAbRIlr6K3Vphr4DwqBhD5YEw4Pw
        ZnogfIE9i6tgJliyUMnkkNQ2ZCY2444=
X-Google-Smtp-Source: APXvYqweuCsbSzecEAgXlRNVNYxzIpGvq1XJOFjLIK8rA6ntCVEPT/bWSBt8UrEOJG62TD9mdkExsw==
X-Received: by 2002:a17:906:c9d5:: with SMTP id hk21mr16015874ejb.122.1552150606489;
        Sat, 09 Mar 2019 08:56:46 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id fy6sm2005920ejb.52.2019.03.09.08.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 08:56:45 -0800 (PST)
Subject: Re: [PATCH v2 0/8] lightnvm: bugfixes and improvements
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <eda5d77a-2677-4409-d8a7-b67071f4e47e@lightnvm.io>
Date:   Sat, 9 Mar 2019 17:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/19 2:51 PM, Igor Konopko wrote:
> This series provides a group of the bugfixes or improvements
> for lightnvm and pblk device.
> 
> Most of the patches are rather simple and covers some corner cases
> scenario, but we were able to hit most of them in some scenarios.
> Few others close some existing gaps which we were able to found.
> 
> Changes v2->v1:
> -skipped patches which were applied in v1
> -dropped not needed patch for pblk_should_kick_write()
> -patch which scan for opened chunks on pblk creation do not close
> chunk anymore, just print the warning
> -unknown read errors are counted seperately from read unrecoverable
> 
> Igor Konopko (8):
>    lightnvm: pblk: Gracefully handle GC vmalloc fail
>    lightnvm: pblk: Fix put line back behaviour
>    lightnvm: pblk: Count all read errors in stats
>    lightnvm: pblk: Ensure that erase is chunk aligned
>    lightnvm: pblk: Cleanly fail when there is not enough memory
>    lightnvm: pblk: Set proper read stutus in bio
>    lightnvm: pblk: warn about opened chunk on factory init
>    lightnvm: Inherit mdts from the parent nvme device
> 
>   drivers/lightnvm/core.c       |  9 +++++++--
>   drivers/lightnvm/pblk-core.c  | 15 +++++++++++++++
>   drivers/lightnvm/pblk-gc.c    | 35 +++++++++++++++++++----------------
>   drivers/lightnvm/pblk-init.c  | 24 +++++++++++++++++++-----
>   drivers/lightnvm/pblk-map.c   |  1 +
>   drivers/lightnvm/pblk-read.c  | 11 +++++------
>   drivers/lightnvm/pblk-sysfs.c |  3 ++-
>   drivers/lightnvm/pblk.h       |  2 ++
>   drivers/nvme/host/lightnvm.c  |  1 +
>   include/linux/lightnvm.h      |  1 +
>   10 files changed, 72 insertions(+), 30 deletions(-)
> 

Thanks Igor. Thanks Javier and Hans for the reviews.

I've picked up 1, 2, 4, 5, 6, and 8. Note that I've lower-cased the 
first letter after "lightnvm: pblk:" in the patches, and also updated 
the wording a bit when appropriate.

