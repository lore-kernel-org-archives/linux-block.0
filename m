Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E39C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858D3611AD
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbhDLJ5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbhDLJyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:54:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F1C06138C
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:49:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c15so3265400wro.13
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kQK0baVBgNretjSwkLpVZKpaqdJdCMUf64CNx2owv/M=;
        b=1K175StvQ2dsc09TGV7qCabFabezM+A8UMKpejehs9LuVRCP6hI4ytFo1BKY4JX3MA
         oMYsaozVSv7gvSO33cHEigut/dzK3ihjDl3ySUCjrJFB7vBvUYG+TCAT7FHCRWKw5iix
         vRccXjWUeVAl4DJcYhi7rtJ45cwm6LMFU/uNc6tBWssPOubhhhNAiGhMSiJPtqzOxr1o
         vZXmfY8D+lbGODkfu3+j6YM5O12V2CeE5+l5chK3d2oaQFhGeoxI5Nsnpr+ydDI0wgbH
         cYT3E8K73zfXhQRR68qAc9ZZtQiDPrCxATkuLPV1Yehpu6d9dd7Ykrx3yA1QX8gjpTvg
         n6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kQK0baVBgNretjSwkLpVZKpaqdJdCMUf64CNx2owv/M=;
        b=bhvvujm9ChILuOAfR9pV4cI9O32ldWy7fsHfxaBvwtoJ3GM1wKrU+YZzdB6gsV7Vtt
         4vp7RRTz7X/7GbleQgRO/oFA7P2z8pTVLk35oGLfQH/7ld+wv9Kjs6dG241flzCtHUVD
         U6D+TyOk9UugzOlVNn22SifRg7Kje25zWeJSSlKJPezoxswKkKx9innZQ5aPapZgdi7e
         xbP1p+2/Io9LZON7bV1yf9GJ82aOrh+agQsz4rz4WQH46qEHAAK4gf/VlaVkSTmp4kkz
         CRQ8F0ljM/Yjn/kImQjWmWk6I8gMKSOjFcEmlRruj66hhzgblv4LWbDEPieZ4wLz3RKO
         HyUQ==
X-Gm-Message-State: AOAM531XjEOxbxp5R5WTMfWFhwvy7fTODzdVzm2dgFP57Qusv/A8YmYM
        XCGzEtA6rdjYd04OWB3TYX6TqgbsEZKQlg==
X-Google-Smtp-Source: ABdhPJyREUOmY0oopxpqVsWNoQT7nWbdfr1Vdy9iBbfBmMZLheiuwxMRQWwkpUmDO9OPfVIeDPIYkA==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr30895774wrb.24.1618220979600;
        Mon, 12 Apr 2021 02:49:39 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id l24sm14798836wmc.4.2021.04.12.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:49:39 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:49:38 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
Message-ID: <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.04.2021 11:26, Matias Bjørling wrote:
>On 12/04/2021 11.21, Matias Bjørling wrote:
>>On 12/04/2021 10.12, Christoph Hellwig wrote:
>>>Lightnvm was an innovative idea to expose more low-level control 
>>>over SSDs.
>>>But it failed to get properly standardized and remains a non-standarized
>>>extension to NVMe that requires vendor specific quirks for a few 
>>>now mostly
>>>obsolete SSD devices.  The standardized ZNS command set for NVMe 
>>>has take
>>>over a lot of the approaches and allows for fully standardized 
>>>operation.
>>>
>>>Remove the Linux code to support open channel SSDs as the few production
>>>deployments of the above mentioned SSDs are using userspace driver 
>>>stacks
>>>instead of the fairly limited Linux support.
>>>
>>>Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>---
>>>  drivers/lightnvm/Kconfig | 4 +++-
>>>  drivers/lightnvm/core.c  | 2 ++
>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
>>>index 4c2ce210c1237d..04caa0f2d445c7 100644
>>>--- a/drivers/lightnvm/Kconfig
>>>+++ b/drivers/lightnvm/Kconfig
>>>@@ -4,7 +4,7 @@
>>>  #
>>>    menuconfig NVM
>>>-    bool "Open-Channel SSD target support"
>>>+    bool "Open-Channel SSD target support (DEPRECATED)"
>>>      depends on BLOCK
>>>      help
>>>        Say Y here to get to enable Open-channel SSDs.
>>>@@ -15,6 +15,8 @@ menuconfig NVM
>>>        If you say N, all options in this submenu will be skipped 
>>>and disabled
>>>        only do this if you know what you are doing.
>>>  +      This code is deprecated and will be removed in Linux 5.15.
>>>+
>>>  if NVM
>>>    config NVM_PBLK
>>>diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>index 28ddcaa5358b14..4394f47c81296a 100644
>>>--- a/drivers/lightnvm/core.c
>>>+++ b/drivers/lightnvm/core.c
>>>@@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
>>>  {
>>>      int ret, exp_pool_size;
>>>  +    pr_warn_once("lightnvm support is deprecated and will be 
>>>removed in Linux 5.15.\n");
>>>+
>>>      if (!dev->q || !dev->ops) {
>>>          kref_put(&dev->ref, nvm_free);
>>>          return -EINVAL;
>>
>>Thanks, Christoph.
>>
>>I'll send it to Jens with today's lightnvm PR.
>
>Javier, can I add your reviewed-by?
>

Yes, please.

I'll crack a beer and cheer on it tonight. Good times :)

Javier
