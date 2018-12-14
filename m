Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A02C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CEF206DD
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s/ifdbMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeLNQrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:47:53 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:38780 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeLNQrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 11:47:53 -0500
Received: by mail-io1-f50.google.com with SMTP id l14so4927528ioj.5
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PwXONsIWQY8zwbUGfM+SvGcQ1/KT/1FMCdgAJdTVKLM=;
        b=s/ifdbMagByaIgO5XTav9W+Y1OmpykF1+dGNVqoGiaD2jSxlggjiU33vMolPBQAc3d
         PXYZVQCi6gG/rSSiAOXwauTfcuPiegXQbybrsmI03ZFSrYQCoBcOx1v1eXGPTo92NBrn
         y9fGc1O6dgAO18p7wqlJ97oqFbpAb8W/EDMR34zl3hoT2IRB6ZeOmNlZR4uEbKaUoB6d
         QEAcyCQwv/xKOIbYllX7jyNkVqyS51Y9YHSfoV7BDL2v0extHGS0vzx6C421bpsUk0a0
         PvvabeYF4F3zWoFsDC8i2ADj98v93ocpRKuUPAmdLvSZwOcUSR4SvcaoLqqxt79/3tyU
         CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PwXONsIWQY8zwbUGfM+SvGcQ1/KT/1FMCdgAJdTVKLM=;
        b=VD1ph7xDySLAfVMl707ykv4peT7RQecvB2XRs7Lpdu8yjdObk+jxabWAHEzba2uq/p
         YNdZvfXiJydfqHaeY5PUGtiqMeZPCkyKnvc2q5J8NTub2QJszBz3vVzRMDAmvYdEpqff
         52gXKgRy56l8eOTsrzIUWPAvU6s2ep+zJQGtSRHmWUjkFOmwTJPGPPmTQgjSatGnAefX
         b+7MyPeTxeOL1rfMmAJ861KB+B7kjkAaOXJTB6KvabXuzsSQUyeJJjziqP0SW9CQlvT2
         yRfurBeJdgR4isrKXGhB41sAlidx5RFAMq8M8p4QHRoxDW8UVK4NS3UyNnnDRLV24IyS
         EDiA==
X-Gm-Message-State: AA+aEWas/hEtQHJmdfMAB7hWIqa0RcUe5ztghlyGAnV+Z8Js6DBAe7ya
        4Ph1F3J0dIyxPV3Qax6V2WougUyLHoAR+g==
X-Google-Smtp-Source: AFSGD/X0WlTE7kcf0hCBtDtI5TTCOCmBRoPSWfuPNiwlq0sXrpUJWdeS/g2TW9udAx/J+FG6xVS9dA==
X-Received: by 2002:a6b:1741:: with SMTP id 62mr3164769iox.251.1544806071629;
        Fri, 14 Dec 2018 08:47:51 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b91sm2791608itd.26.2018.12.14.08.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:47:50 -0800 (PST)
Subject: Re: [PATCH] block: clear REQ_HIPRI if polling is not supported
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20181214162122.14937-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1afcdd57-1193-0d85-49e4-2808d1123865@kernel.dk>
Date:   Fri, 14 Dec 2018 09:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214162122.14937-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 9:21 AM, Christoph Hellwig wrote:
> This prevents a HIPRI bio from being submitted through a stacking
> driver that does not support polling and thus won't poll for I/O
> completion.

Applied, thanks.

-- 
Jens Axboe

