Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2348C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15F264E2A
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhBJOp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 09:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhBJOpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 09:45:54 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE32C06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 06:45:12 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id a16so2037425ilq.5
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 06:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ysd4jTSM/A3Qbvo3IAamzntPbVEsPTPu5msfcyC0amY=;
        b=n/cl3sU4LxnsDfTlbLqkffWFtoeo/limIQtoBM8kz/2fWU2gL1fPfJ2kXfAXu+gcVa
         nhqwc2x/5b+bogrjP+YNHvnzG7LtQmY33VDtQ62/D9hiL2S5l/2QbIzpsE289QYd6INV
         nCKWcb+Gosn6FHz6FRn6UaGFwchiiA21g7C/I/Rk/3JMwzK3Fhid1vmH6BBZR5XNUD66
         mKBuFGIU1gH3EN9fT9WHhMQLyByOlJPpbX8FOwRPocPek2Odww3BhWLT08k9vvqR5dY3
         ibIT8pO4WLWI49PogeDRiDHb7DJoJlU8HLwX0Gkep21uFk+o/WsAEuuS+dVFarSG+vSz
         c8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysd4jTSM/A3Qbvo3IAamzntPbVEsPTPu5msfcyC0amY=;
        b=hk3G4yF1ObzNWV2jpdvCPuX8yI7YmLqShKD6c33+DqqCtU7meVYf7tr958CpUsdmci
         torRNNlMd9KvSXFY/DHCGxEYZqqUWv7rbAFD8P8JdEOgVIoY9fEJoFQ84k7vRgFb78DT
         nX+lv86lodi99bfsdZcx4ObOXmKhJT3e0SDSxSG/v1mklHvPtyuh6BuYwF0egEAs3qjd
         czlMn0QqOc5Y4cNws60VAO6YvX80cuVgrObIoEnEPnynJi9XjSS9dBl9cQBSs4QpNs4E
         obqPfppQzhuWTjiHx7UO6kA9IO4WsALyLMCXh1fKCg3cajzaJBNyTMi3xlMBRusDFt+E
         YS+A==
X-Gm-Message-State: AOAM530uog+vITyQv33a7CWINtD1s+x4hvtvbL5uU8lyDbYUdITAT1yB
        zIqQY7RjO5NLmk5RYJzMstNf7g==
X-Google-Smtp-Source: ABdhPJzLNMS1CqKK3WC8WmbvmcLOE3sfTRaTeeyEbcdTj69ndKl5ePzTxDZuwjdkwGqxqKGNIyEpJA==
X-Received: by 2002:a92:4b06:: with SMTP id m6mr1345567ilg.177.1612968312334;
        Wed, 10 Feb 2021 06:45:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h9sm1086368ili.43.2021.02.10.06.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 06:45:12 -0800 (PST)
Subject: Re: [PATCH v4 0/8] block: add zone write granularity limit
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cfe15751-e07e-101f-49d8-a2f184e30618@kernel.dk>
Date:   Wed, 10 Feb 2021 07:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 9:47 PM, Damien Le Moal wrote:
> The first patch of this series adds missing documentation of the
> zone_append_max_bytes sysfs attribute.
> 
> The following 3 patches are cleanup and preparatory patches for the
> introduction of the zone write granularity limit. The goal of these
> patches is to have all code setting a device queue zoned model to use
> the helper function blk_queue_set_zoned(). The nvme driver, null_blk
> driver and the partition code are modified to do so.
> 
> The fourth patch in this series introduces the zone write granularity
> queue limit to indicate the alignment constraint for write operations
> into sequential zones of zoned block devices. This limit is always set
> by default to the device logical block size. The following patch
> documents this new limit.
> 
> The last 2 patches introduce the blk_queue_clear_zone_settings()
> function and modify the SCSI sd driver to clear the zone related queue
> limits and resources of a host-aware zoned disk that is changed to a
> regular disk due to the presence of partitions.

Applied, thanks.

-- 
Jens Axboe

