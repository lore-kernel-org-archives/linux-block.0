Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF0C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475022083D
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cOYwYSa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCVPXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:23:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51518 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCVPXV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:23:21 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so4252803itl.1
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=idTbDdgSVc7JtWlfRBQrCe7voUYIIuq1qsXWuWOqido=;
        b=cOYwYSa3eBCfnTy0utQlOxD/GS9ptMrq6BQq8w4ulKcIQbUi8ix6yVDfnLwTUUrtUs
         eL1kBcW16Fxfoc8AXOh9rsh+9UY5I6uLckS371dXfEorYSvvCWWd7n88Sg4JLqEkyBRD
         6eyqhN2uDNen9bHhRaFzjM31EKBiLDfmgfHM/C9IdIBDLhhqktR1/OqQShtjC0HQo2zt
         IKBquE4V0BXRCWGZRyjln4ZaGm7QjrYnFLBqTKPqvCArKAtVc1ZGwOVmu/vIYLvxNLV6
         zQTDJg8qpR+TQ6wEoOijdDK85fRRsNQt/RlYYQe+JsEYnO7O7vscIy07jOl59OSkwWbT
         aFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=idTbDdgSVc7JtWlfRBQrCe7voUYIIuq1qsXWuWOqido=;
        b=rPM2V7L9MHXAF7/vZqAsV2EOlWZjPa84DMcoDDHoJlXtCo4T1t4kt3XHZT7ehp0Xyd
         zkE+fNnkhi7HPLV3zpxCJXV3FZIzHy2yggLrbqv0tl0h2js/K60PlciZEtVs1jITSekP
         hAl+8CLSGJoXsDAmSyPKd0RYSO/hfLDRxojJC8sD4emprJkIAFYpry3i2qfaYfwfT+AF
         fqL0OxkkMG28dpq7NtTLEQwAsSgIVDaFJb99DGfOUaskb6qhcCWfDlBX/PN3vOk+kNlh
         i/cryQXwpk+BHK6Izv8bOlYtZ/IDTwRkVBrhc0y68z4yjOxPg0UerCfr4U3VuQc5OZoA
         M7Lw==
X-Gm-Message-State: APjAAAUrysRM6P2cpFQsroeQUFZiH9sI4GCP2E+dwlBrnfi+KYU/JfRJ
        DnT5NezKDww9pV7hJku4GHciKireTny6qWLb
X-Google-Smtp-Source: APXvYqzviBZgtlY6dc8FCWz3DHq37+p6gHftqyAun3QgPg0pUFEP+E9hfg9uj9iNggUP6TMRqxpVhA==
X-Received: by 2002:a02:1c49:: with SMTP id c70mr1527693jac.92.1553268200368;
        Fri, 22 Mar 2019 08:23:20 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m25sm1527428iti.16.2019.03.22.08.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:23:19 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: convert atomic_t to refcount_t
To:     Yufen Yu <yuyufen@huawei.com>, dwindsor@gmail.com,
        peterz@infradead.org
Cc:     linux-block@vger.kernel.org
References: <20190322144818.987-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24f14149-a309-5876-563c-e11124d0c6ac@kernel.dk>
Date:   Fri, 22 Mar 2019 09:23:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322144818.987-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 8:48 AM, Yufen Yu wrote:
> Hi,
> 
> This patchset covert atomic variables (hctx.nr_active and blk_mq_tag.active_queues)
> to newly provided refcount_t type and API, which can prevent accidental counter overflows
> and underflows.

Neither of these are reference counts in the sense that things go away when they
hit zero.

-- 
Jens Axboe

