Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD08C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6220873
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Yq9+DmSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeLSXXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:23:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeLSXXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 18:23:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so10541512pfr.9
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 15:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E+y2YLnfDr99iMbLvUi9vyG9Zj4IaHbFxQRxvN/G/1o=;
        b=Yq9+DmSX68VYqZSL14zSngcSbJHnyRDo+0LZNQATVnrEBlCGPJUC+iFJX9ZlH60PpX
         nCHttlfaHBvKQ3yRnJXbvs5Zix37mTSFCG++KFSMcEmcK/JSvCe+mms4QvDrpf7JuIsq
         JkWuHQK/Kmfvjc3saazOiv1RzIe0AvgSZe0v2RtFIJHkeG4BN9oDWcgWphUvSGNARFxZ
         BBQDK8BmETECDxsZlI8QDxHiBqPqEyfU2QCyVbSYl5hHkrbL8JTMBVNmXHUgLFUzAkLR
         FVALtye6EjwqQfomGR6MxBCgyk3gRUMZ9Lg8sl3LqrUPksK/qlnXjXucxO5MAg5qkRSP
         1E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E+y2YLnfDr99iMbLvUi9vyG9Zj4IaHbFxQRxvN/G/1o=;
        b=NfTkpSbCf+CUpRV5iesdwq6DUnZwPeVFbm+szUu5wa93FpNoVkjvPAjIAdL2lR9RHg
         FOpNjNhdVd2GSQJEMjFF/VRzsTeiErNYnO5okV8mJh6aD9+Rv+iKzT22nm++hwnoxOnE
         zlwf1AHOqxotmJlXTOTjE2rI9DPWVg6Kbn5Zl26hYBdG2/jaFq4q6NA62t7guOtjUoYW
         3jJeuOkYttyq6MCPSKmeEZylo0wg8JDW8dcnWQFR0vN+oNj41wO9MIamIa/3lEQCX/nX
         2Q7ax9z1jNMJXFCg2rWYCz2Bu273tpNSSos6Ch2Ltis2keLApBjNbJRa1o0Jqh6kJ3nQ
         IwJQ==
X-Gm-Message-State: AA+aEWaQTFBRYOtRsHQndDOZyhjjmMBtYqVrAd1agGq6MoZDF8AciyIN
        mGjuo6rXoS3/Nhsygq0EBHfY9Q==
X-Google-Smtp-Source: AFSGD/V0OORcxbhEVpvWWNZkEErIt2LcAKvKT0lVXKMXTo0X2nGuTvveHrwcgUyN1Qi9EZ7XfnC/hg==
X-Received: by 2002:a63:3c58:: with SMTP id i24mr21474833pgn.284.1545261796914;
        Wed, 19 Dec 2018 15:23:16 -0800 (PST)
Received: from [172.20.10.3] (mobile-166-170-49-237.mycingular.net. [166.170.49.237])
        by smtp.gmail.com with ESMTPSA id u137sm34008912pfc.140.2018.12.19.15.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:23:15 -0800 (PST)
Subject: Re: [PATCH] bsg: deprecate BIDI support in bsg
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181219143934.3910-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1bffb86-9b3d-d8c2-98a3-480364f21346@kernel.dk>
Date:   Wed, 19 Dec 2018 16:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219143934.3910-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 7:39 AM, Christoph Hellwig wrote:
> Besides the OSD command set that never got traction, the only SCSI
> command using bidirectional buffers is XDWRITEREAD in the 10 and 32
> byte variants, which is extremely esoteric.  It probably doesn't make
> sense to keep the support code around just for that, so start
> deprecating the support.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

