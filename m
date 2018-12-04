Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDEBC04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD732146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD732146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLDAyT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:54:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37435 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:54:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so13563505oth.4
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYJy6z7S7tePI3ccljUJapUHoY8etjwYpaEHY0W/ZjE=;
        b=Xg8QSzGEZBSfG3tKjpmGnuyE0TZmfl01F2jQYvrdyUd6SheDUspN06fTP/PG4dcPRP
         10fMn8mC270I2c0jbmalVihBrs0zLna5dAba5WoBT8jz2sDrGqc9/HsL9nx9jPruVTnC
         gn2rQZ0kbALECUDQZNGaZpewLpwT+M11D2a/S+Y7milwVyr+46lRWuDRdAe9TZKoCENc
         iaI7VKZEO/gxAJv3SwY0maDczYKLKBbTTG7TpPfkBvpYT0W0LOF32mP85id1kfwhajWd
         Q9VWpwQ93xZsgujjywG3BtaY4RS1T3+VgBXYhXNSnSoYiy5JNLbX1kpDkMcoidFOe+tg
         CE+Q==
X-Gm-Message-State: AA+aEWYeVCaNJKmEpC7Kq7fyw5Tf2cBZgShKB4A5Eg0rv4BX08e3+Uk8
        iOQr9zSIDApratoc0HIlGan397AM
X-Google-Smtp-Source: AFSGD/Xxs24A9bxm3r6YTpSQCG6ZvFwCoEg8kPwLbt/QRCnOEQ3gKXFjkkDfm8SF9/fAt5D4mMHtQQ==
X-Received: by 2002:a9d:6f09:: with SMTP id n9mr7101642otq.87.1543884858407;
        Mon, 03 Dec 2018 16:54:18 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 4sm6725102otw.39.2018.12.03.16.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:54:17 -0800 (PST)
Subject: Re: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
Date:   Mon, 3 Dec 2018 16:54:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   
>   	if (nr_io_queues == 0)
>   		return 0;
> +	
> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>   

This is a change of behavior, looks correct though as we can fail
nvme_setup_irqs after we freed the admin vector. Needs documentation 
though..
