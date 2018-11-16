Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E5C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A282087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="NC/MxemW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A282087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeKPSo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:44:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKPSo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:44:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3067368pfi.5
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OUcpWCX2hs7loAbUHitwGfzfdvnaiwWljd/Ji8iWzLU=;
        b=NC/MxemWH4evIWU5gRuZMY/TtKzVZDYYlwRDfTAliPlaBYzi5KbEgPWpfQWWLeqLPS
         QuCpQr6CKuIWq71X4hRBT+K9OHz12cLuitRTCgERlMpKj3e96AJHTLN16Rnh/1mkn85o
         SonNHWKNqUvJNjhDSNS5KrmM/mrBo5Mn3PQU4ABm/orbFI5uBTC4urlG/FKP0RRrNO1Q
         CnmXRS5bhtTNDtVJbepqm91+0XcntlTXJAgKMoeWVZr6iioOzRRBwCCuGuZZri+9h90p
         4WkSLHs03M7satDqhYUjY221EW9H4ZOlxFBfzkoJHjo91xtltbDQVPwlLBl0cqNg7UZB
         kBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUcpWCX2hs7loAbUHitwGfzfdvnaiwWljd/Ji8iWzLU=;
        b=Y+jgnwjRb7bEapKGMoCguE3GrrUESAkYi/hzO/cSRVqU/8ksFZHh9HmhsPIrH1roCl
         wJhfFO52CSGyj2e6rW6aQTSVnyu6SlEkU2dNznZH2RGM0Wt/0vZ91lXMW49UanSxUVg8
         HmAiuZ4s9g72piK0C+dX3MR7IHdo3RruHYP5UvlnDN+tl9bMPpKlfxYH22GBKDcYhkjA
         FkmslKRreonfeHcPAggySMoqBYPdcUdJ5MdC3AW2sHj6GxiOXlMRiK8FLcr9Z5l10rhD
         w3vlMIs3ZzOsIfsd57FW9mauF4sfo401cFaB8mWfrLHctBgD4ImS48w/38Ps5SDynEfD
         Gzng==
X-Gm-Message-State: AGRZ1gKvE00W1/r4qlcjx2ZkY/tTrYAf+Afwfz7JlfNVY4eEwnms4Svb
        OZMb31pTox7EFug8eLX4eq2Hdw==
X-Google-Smtp-Source: AJdET5f/w//SXg9HxLpUOO4js8kEtw03PYKd+/PXFxHE7oUe7acvQLNVe47ypLqd4HtJonwe9pv+dA==
X-Received: by 2002:a62:c20b:: with SMTP id l11-v6mr10328624pfg.251.1542357217037;
        Fri, 16 Nov 2018 00:33:37 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u137sm20416667pfc.140.2018.11.16.00.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:33:36 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:33:35 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/6] pktcdvd: remove queue_lock around
 blk_queue_max_hw_sectors
Message-ID: <20181116083335.GP23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:03AM +0100, Christoph Hellwig wrote:
> blk_queue_max_hw_sectors can't do anything with queue_lock protection
> so don't hold it.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/pktcdvd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 4adf4c8861cd..f5a71023f76c 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -2203,9 +2203,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
>  		 * Some CDRW drives can not handle writes larger than one packet,
>  		 * even if the size is a multiple of the packet size.
>  		 */
> -		spin_lock_irq(&q->queue_lock);
>  		blk_queue_max_hw_sectors(q, pd->settings.size);
> -		spin_unlock_irq(&q->queue_lock);
>  		set_bit(PACKET_WRITABLE, &pd->flags);
>  	} else {
>  		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
> -- 
> 2.19.1
> 
