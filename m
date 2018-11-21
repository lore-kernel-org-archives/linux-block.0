Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB45C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B5A206BB
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B5A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbeKVJFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:05:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42508 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbeKVJFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 04:05:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so981389otk.9;
        Wed, 21 Nov 2018 14:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJErdejfngrdgEdO8MvsF7mOGmgnAseuyWlSwBWmAIE=;
        b=sw0bvEZ8xpCwVU59qHLfsJdGoDh8n2LjHrCd29GKHN5Ay6eAqmj5i4xVu2qLfdAAV4
         oTj4xBudV2lUyNWqpn/uIpvxZ2kZarTRMkgTvASD7VeNX1O07M1+IfuDWyMoUYIYPrqK
         AigL+bDVVAX796h54dnGFqEZq52BtTmoaoB0pIUxKBGXHVuN4ywrpmDlWtYrT45vEWfU
         kjnnx+YCrIj2vy7O/jPl8WdJ8NDoqK/2ZNv49QMpgeXEXcPHh/umeApIAO2AuWwYu/DR
         4HB1y31YjfNsNCVRr9HNwLP+ZPSUWMxtdXWY992WWDdgcXre0R90jnNg7beAdfOWAydN
         kYZA==
X-Gm-Message-State: AA+aEWZP2I8osqemkHy0BKTGfsgMQhs1LEeYjmRpvXHJehbsT8B1mmw4
        ssD/TKNP/wOTI1V3N+X4W9Y=
X-Google-Smtp-Source: AFSGD/Vqhl2klLExTfIPvLHyUzBJvqfceUcN83uqoQkTSEVmxpD3y4H7yXlZ5Wi+vVQalVYQz4dJpg==
X-Received: by 2002:a9d:5090:: with SMTP id b16mr2730430oth.96.1542839341642;
        Wed, 21 Nov 2018 14:29:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 41sm18508078otk.4.2018.11.21.14.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:29:01 -0800 (PST)
Subject: Re: [PATCH v2 07/14] nvme-core: add work elements to struct nvme_ctrl
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-9-sagi@grimberg.me> <20181121130432.GB1373@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7833b3a4-cce5-238a-eef3-70702c443931@grimberg.me>
Date:   Wed, 21 Nov 2018 14:28:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121130432.GB1373@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> connect_work and err_work will be reused by nvme-tcp so
>> share those in nvme_ctrl for rdma and fc to share.
> 
> As said before when you sent this invididually:  I'd rather not move
> struct members to the common struture until we actually start using
> it there.  So for now please add it to the containing TCP-specific
> structure, although I'm looking forward to actually see code around
> it consolidated eventually.

FFFine....
