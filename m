Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2534C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A320850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1A320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLDBFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:05:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46442 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:05:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so13552325otm.13
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QROZSTMMbzYxC9uYS8QKi/UTqOmS8t3SXoZ9GnYKjTJw+CV6hnjdlnIO+UtE11WIfL
         pFBobkaT6UGwRTg6b8UB78BGJunV75nR2Cq9QIcypU65pBsUethn9+3Qo3wgflnYZqvH
         JRvu7MRnVOE8tvsyis1kh0+XpFQ1vRxzD6cg5nr+LiwLBE1a8MG1dC0k15zdV6SGsTgP
         bJXTH/ZbmTz+3P7ZcZfFiG8t0TkEsBZBvRKsfZdJ62p86n/L14hOep8KYFAQlhNIS60F
         HggzqLBojrtNWLDemohYBbecpK6NmJrzd+Jy9lW7dLzgmlGro8LQBViAIGiE+zTCoel8
         yf9g==
X-Gm-Message-State: AA+aEWZU8jbnZbT6qcnMGcA5uN+AwL2CAWWheAdtTrU7Cf3lQ5VKA72E
        63XGnNFksehLw6r9VU4w7JKcI3ec
X-Google-Smtp-Source: AFSGD/V5VQTnnD8I7k2hPbsJyT0b9VfOvrLOe9uXsczF5NxGytvp20jnSb73xS1VxIGlP7m+4Wr+hg==
X-Received: by 2002:a9d:3d0b:: with SMTP id a11mr12358641otc.43.1543885551874;
        Mon, 03 Dec 2018 17:05:51 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z18sm6081163otp.41.2018.12.03.17.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:05:51 -0800 (PST)
Subject: Re: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting
 queues
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-8-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e4a23703-6b6e-1c9e-a072-6a5c029e891b@grimberg.me>
Date:   Mon, 3 Dec 2018 17:05:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
