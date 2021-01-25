Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBDC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E1B221E3
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbhAYQXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbhAYQXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 11:23:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D170C06174A
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j12so8689243pjy.5
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muZDljTxthO8gQv9zsP/8NViE/9Cv3HjXLRFiNSkxF8=;
        b=jR0FVc9+lbi0iukikOxfz6mRSyOWNNUZZQ8bJmctXjFhUnIk3IirPJzx0Cx/MaZdoW
         IaLJgnlfmtEGeRAf1HB4BQkAZAuRA1qJuGKmfeT2pSGqZI2KYo/plbx16x4cqwgjku57
         Ih95jCuWHI7UwXYVFp3+fpRRkCc49X+jFBE0F0DfQAcY6RRTUODbHxHiwzKQlM4oMVV8
         XnFle7KlM2N0W3k42IpIJN6DYaTYUGvAW76y0FhASQyR3aK6LI6TNjZdMB/k1lnXaS19
         fr4VhiILCU7RVUSX5dIEr/XgN8xgioj5HN756VS9qN3iYP1z8NmzzS/txAo01xxNFOdx
         PV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muZDljTxthO8gQv9zsP/8NViE/9Cv3HjXLRFiNSkxF8=;
        b=aCVTDs0PARTNFkki0E0FUbDcagPaceRA4JD5zhIhH1VlWpEbMm2EwGC7hdW3q2z35j
         GIekrfBVUo4QI2xSQcNl/gdwkrCDd5TZFh7SiBGfhYRc8Xyi7b2N8nwdl2KIwI5y4ofF
         Kqa5ptW0x6aJEVxjwnZjhcdIPwY2mJeUKxUbMQC4GQLqxvA6V6BvXMBOpR+AlUFYQm2+
         Ht0U1hW2nm43Z7Va/IlZXNEUwMljlVoCwSktdv2hrW4WlEFsa8yBFPFzsY7FNNv+Wrox
         eOCDkKWsDJMDtTZndW2AzMi3s32bTjpT2q+FSSQMrsOq8PnWYL7QpeTCRaE3niuoFKU6
         2k0A==
X-Gm-Message-State: AOAM533ZPW/m0jVDQ/qlEgUI3oNhhAkiUuOZabuOd8txPBSoQbpqC4pK
        1fRO4XlsD2XAxz3QQpv9ubITZA==
X-Google-Smtp-Source: ABdhPJz4OBoHAKG4vNHgo7pprDARimABOOGHyLnkPLgOAp1mqihuHs/+0DFzP9RJLGa7A2wiZp/h3Q==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr1006377pjl.154.1611591762812;
        Mon, 25 Jan 2021 08:22:42 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y11sm9726970pff.93.2021.01.25.08.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:22:42 -0800 (PST)
Subject: Re: [PATCH 0/1] s390/dasd: fix kobject removal
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74ac02e3-11e3-75a3-520b-47b0f35b711d@kernel.dk>
Date:   Mon, 25 Jan 2021 09:22:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118165518.14578-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/21 9:55 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes inconsistent kobject removal.

Queued for 5.11, thanks.

-- 
Jens Axboe

