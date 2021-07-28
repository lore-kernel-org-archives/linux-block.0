Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06791C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 23:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D516101B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 23:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhG1XAC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhG1XAC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 19:00:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E3C061757
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 15:59:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so4537634plr.13
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DEmztepl9UAUkB59VB53cOs0QSV2Pxcmf7pzgqcNjM0=;
        b=TcIKkq5RFaPuqCVdDVy6d5jEVe7dzvKBX3i/uSmy2vRSmOWOPQJ1+HpiD86I49XGWg
         BJHyLzpzyMkAKDfDv3xvXTRZZK2ZslF4wtHZ72Vg+/4BzlgOludXtsmoeNjQtFX68dCi
         lYAUl0h382LqTlfrLzLacj51ZwmjFPn8ier4ioRM4A/lN1Rf2Ua4N0oSR9pxXmZ30LyQ
         Ui4HgFvv5S2Zlko7IH5Fpi6lZpwRfwKKKoUcF3NoxAkjOTIK5JZlmmuuhZ940Ho2aSq5
         uPtN4Sx24ZSOkcYx+2SWdHmiYQQPqMCOHrCYoMfFkSdAqWBoCFOxiOwxdHIOnYyfYobX
         jlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DEmztepl9UAUkB59VB53cOs0QSV2Pxcmf7pzgqcNjM0=;
        b=MHOBObi1dnW9kC5W2TkZQnXvFi6jSTfn66WT1gfm3UFDiWPthNyBVdnsWkAGUPld8w
         DF8LQJ85b0kZ8Oumpl8EGQdSkuWDnzmTyXUvmPkbs5/I9dHkNpLvkyYkfH2qZSJCwCYy
         Ww4lxqb8A74h/JK1G0Rp+g+aAFvVs+ZEbsLa/+v4FLrTXociqeJZDmn+6AGUoobzPkaP
         bugVIMM/JC3R1BoQxDSzqJAP6o2xjaFjIqB/cQOMMGfVR5UxT2NGu4kQ7PRxdCLT2p7y
         sPNxtvX7waJhyb7yzEkL7ah/ZEcbDn+M1NH6qqHuOmOI33Txo3juWcil5cYwxE+tBy2q
         ZkDQ==
X-Gm-Message-State: AOAM532hK26MYb9jOIQG/OTspRpAiw4R0VUDxN5+qsVnHXfJV5k9/Sev
        EiZLzABAPQc0OfucoFFyq/OahLkAGPo1hlrT
X-Google-Smtp-Source: ABdhPJyYcWy0UDkWDnYakigH2W3gpbeNWBP97GTLleQsTVHAOqVRyJupOyEu3y4UnABybmRFLp8e1A==
X-Received: by 2002:a17:902:e845:b029:12c:6e54:e18f with SMTP id t5-20020a170902e845b029012c6e54e18fmr1748903plg.84.1627513198374;
        Wed, 28 Jul 2021 15:59:58 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id u6sm1092574pfn.31.2021.07.28.15.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 15:59:58 -0700 (PDT)
Subject: Re: [PATCH] block: remove blk-mq-sysfs dead code
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20210713081837.524422-1-damien.lemoal@wdc.com>
 <DM6PR04MB7081160FC9DC368206B1EB88E7EA9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ccb8eb3-8249-f41b-f515-e2818cc93332@kernel.dk>
Date:   Wed, 28 Jul 2021 16:59:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081160FC9DC368206B1EB88E7EA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/21 4:58 PM, Damien Le Moal wrote:
> On 2021/07/13 17:18, Damien Le Moal wrote:
>> In block/blk-mq-sysfs.c, struct blk_mq_ctx_sysfs_entry is not used to
>> define any attribute since the "mq" sysfs directory contains only
>> sub-directories (no attribute files). As a result, blk_mq_sysfs_show(),
>> blk_mq_sysfs_store(), and struct sysfs_ops blk_mq_sysfs_ops are all
>> unused and unnecessary. Remove all this unused code.
> 
> Jens,
> 
> any comment on this one ?

Shoot, I actually remember reading this one and thought I had applied it.
Guess I did not - now rectified, added for 5.15.

-- 
Jens Axboe

