Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BFAC04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AC20851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6AC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLDA63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:58:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDA63 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:58:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so12757641oig.11
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QsqqBmTBap/WjcQaXcV/k11nKuV5heW9WryOulFtSI4=;
        b=cxzGMMnHcE2zFUPYjixbjb7lIxrfNsZWX5fJbHyUJ1d31U2KdULh9IppuXne9pNYGB
         TjRe3wagBb728O07EsYDa2MvAoRqR63QM1Mha7yLnmiOjOZr4QIv4e7mlFto/aA1trXS
         WAZW03SJQyyWjLslzrLgvsTUduhoD+nRzqJVuo2AkRVdddHHEYOwvC07NPYtObd21JHT
         AgqzO5AEDpH3vWAR4QBL7WoafjPyTCIXcTOV9oM4uCm/vhNntIZl28WLGyVDAQ9c9u/m
         8vazgPJ+rX/XBEtQFO6cXEBUewc1ErBaMQr3W78naGSGfDZVOnMHhE7oGxDgFe6bNC3V
         2CBQ==
X-Gm-Message-State: AA+aEWZkVWwXcrgXIaxKqVkNJWss10xnVEPZqOfE895QDVgX1U4sAv/n
        hIf3VgG6AiEMxywSqtnMZxX3qEfx
X-Google-Smtp-Source: AFSGD/UsUOzfof75A1x4HuG4m+4l8gRIebbRQemDMkqNEifq6h+zivpKeGyv0/9LVIrUuG5rrtWvIQ==
X-Received: by 2002:a54:4114:: with SMTP id l20mr11848598oic.110.1543885108213;
        Mon, 03 Dec 2018 16:58:28 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p203sm14764557oic.49.2018.12.03.16.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:58:27 -0800 (PST)
Subject: Re: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
Date:   Mon, 3 Dec 2018 16:58:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)

Do we still need to carry the tag around?

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
