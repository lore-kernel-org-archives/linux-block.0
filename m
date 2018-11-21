Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59ABC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A756A206BB
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A756A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbeKVJFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:05:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38236 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbeKVJFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 04:05:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so2109918otl.5;
        Wed, 21 Nov 2018 14:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfaYL+bq2NjilQAg2AlPU5S2HtOaiiFhYX0VhkaF488=;
        b=ttZemxKoWonXp7K3sWpWUIKrgJwDDBWP0FzFiWJSuGPojTNwoS2Jco4lfKoDeCVQtD
         Y0+O5b9RMnvRh/MVLQmyvvv9v7KxgSXqwcLCXL7p0aiyTM2ctrLqeTQs96pHOQI/ZO17
         MBSAqF84GOOkbTGUB9n7MvOCjU0gJVyRILSrYMgPjpI2O4GcogPlEpIw6j0HmXQaGFTC
         5SZhumMHmjL3jkHwu4lFYP8mXYu1T1Z+s2wS4OIlQklouzVpkaMKQLDM2+5Bd7VkR/i1
         lPhxDxIlm1ebjTBcz9fDbKYq3bk0sElDUY9dIhgBU6iYzqq/0iGPLF2lTGgy5P9DrVHI
         hXwQ==
X-Gm-Message-State: AA+aEWb+y5V26LwYoM7XaotY1sinaS/tVNIIbl4AJmmhK7+rnij9MCvP
        /DEQQEg1UueD8IBc89dmIYI=
X-Google-Smtp-Source: AJdET5d0Wr5pLNC2Wznbr539DR5bAZMB9TtCXhQkXs4rHn5jW0vaZhe1ROE+xGqMdcQ7+u2maJNykw==
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr5130146otn.214.1542839367377;
        Wed, 21 Nov 2018 14:29:27 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id f127sm1389917oia.19.2018.11.21.14.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:29:26 -0800 (PST)
Subject: Re: [PATCH v2 13/14] nvmet-tcp: add NVMe over TCP target driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-15-sagi@grimberg.me> <20181121130712.GG1373@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18549b2b-74dd-31df-9442-118cae370e1d@grimberg.me>
Date:   Wed, 21 Nov 2018 14:29:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121130712.GG1373@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>   #define NVME_TCP_DISC_PORT	8009
>>   #define NVME_TCP_ADMIN_CCSZ	SZ_8K
>> +#define NVME_TCP_DIGEST_LENGTH	4
> 
> This should go into the previous patch.

Correct.
