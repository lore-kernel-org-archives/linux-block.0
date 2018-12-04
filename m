Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7C0C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207B20851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8207B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLDBBD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:01:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34914 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDBBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:01:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so12794372oif.2
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rv+m/mtl5KSJ8n3oo3i9l2O3bwvwck13l4z7MHFt1ac=;
        b=ER4c0oTELYTfwHLBByrQBEtsz5jR5HXsfHEXwtzTYOgszE0P+StLsW7GXpnVZZa4h5
         J2M/Z1mjyG83WkMlr4Knpf+N+Y4zugWpRyrsSVa1nxjT/zLlH1ooITFajU17WpHl8uAb
         lGOQV1BsIOdOlAEm6TzzNEFy+X06HB+tEVdPwF4KLWVsQR9RoF45FbcaQMa5NAACKqmQ
         Yrn3m+7QLiRxDFnIcMx6Zk8VygVVUxL9gCpfwokfWU/AC5ZYeANRxTuxLJdjcni8x5pf
         Oy6ydfj7oZeIezwqXUYUbLbCQatLvd1rnj0gw1gcsm2/WDwxrT5HkvxDi8aUP42xLHmf
         wb5g==
X-Gm-Message-State: AA+aEWZYz0dSFTykbrvQeThp+Pces0Jxc90WXvUxafNqt7hyxvehtxap
        FpJSdJja1wHwK4WByBf9mAaayCdZ
X-Google-Smtp-Source: AFSGD/W29tcZMitSJ1mYW3SpDGXn0EBudUu9Hc4xaGggiWmne6BzqZwctL53R+pWNx0VO/ZMOTZGkw==
X-Received: by 2002:a54:4581:: with SMTP id z1mr11636823oib.192.1543885261863;
        Mon, 03 Dec 2018 17:01:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a52sm7123997otc.51.2018.12.03.17.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:01:01 -0800 (PST)
Subject: Re: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-7-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>
Date:   Mon, 3 Dec 2018 17:00:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	nvme_stop_queues(&dev->ctrl);
>   
>   	if (!dead && dev->ctrl.queue_count > 0) {
> -		nvme_disable_io_queues(dev);
> +		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
> +			

Would be nice if the opcode change would be kept inside but still
split like:

static void nvme_disable_io_queues(struct nvme_dev *dev)
{
	if (__nvme_disable_io_queues(dev, nvme_admin_delete_sq))
		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
}
