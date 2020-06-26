Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A3BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB22080C
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="tT7nV1Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFZG2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgFZG2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:28:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A84C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:28:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a1so8224228ejg.12
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AzDDRheHUhY185mnHnU6umoSLP34BhkSmEM5f6A4LJg=;
        b=tT7nV1TeVyZmOIRwWW8pXIvN+bE2pCzlrSuPn/QfwVR89JBCT/6SKOncr3PfXxfZra
         N9qPJJ+hlXjdObv7AIC9tqSE1wnZ4c/+Egoxy9AerrV97nm71wPm0dmmJ41KHDaQwwqG
         wmGxBaO7Fs6enkeLGBQD7/p+C6NgX5YzkzLz7Z+8pa15DYjcEWR8WDrsWEWtPUA5qwDN
         qZaCE3qdGDspdz5fDXZWL/A6T2SaINEy5agaG9J+jBeWHz92F3DVChRW7Q42d9hHGsZB
         lVWlW6KFrigE4tqsTBz/AYZdXrzLVqPq0PBDlSajv3kSCN+gnXMjufrtoptTL4pTDGnu
         LVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AzDDRheHUhY185mnHnU6umoSLP34BhkSmEM5f6A4LJg=;
        b=AFFhx4oaNdR/D090vOKHpO7Jvhl7qBFJ+GFD0zU2IGC3Hmh/jNIEhuCG4nykDTk6wl
         eb5uqcxtPuDjj8cRo2WKcef4ClqT40lFYzaPJWBJXfbXl4fvimAWSuvaY6ClucD4eqLA
         bAYs+enBoKmok7wLKYqlUK9imfJKAUQczZM4JzVmxfHcteJaqKDyCn3y12ZdBfiBZUbq
         dh7fC9zxotvOYVotey6TVwbEyG9iwtt0DwPvuUlRPn10/Zm2umhqCSqpD9EmqEUKUoBx
         RC6WPMWFop1ywc3x6Qtppfsda4RtElSXXdbYS2m2hmyu5I0PbnWDc1+SsVnWxiBoQUq5
         LvFQ==
X-Gm-Message-State: AOAM531G0Jb9AdEuYS8iHtzgV2jBo6k5pewqsUvkp9FNdOWouJscFRBV
        JM/BjOrPY8L32HR8b9P/nFa5Qg==
X-Google-Smtp-Source: ABdhPJyYGx/O8hAK6UqSEG3yplNXNzReJQLm+jwjU8n0LvASNpJ9MetUicOYf+so3pzi5jhHS9OCXQ==
X-Received: by 2002:a17:906:f752:: with SMTP id jp18mr1213481ejb.538.1593152910112;
        Thu, 25 Jun 2020 23:28:30 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id i33sm2204590edi.21.2020.06.25.23.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:28:29 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:28:28 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
 <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 05:25, Keith Busch wrote:
>On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier González wrote:
>> We can use nvme passthru, but this bypasses the zoned block abstraction.
>> Why not representing ZNS features in the standard zoned block API?
>
>This looks too nvme zns specific to want the block layer in the middle.
>Just use the driver's passthrough interface.

Ok. Is it OK with you to expose them in sysfs as Damien suggested?

Javier
