Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E5C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A357720873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A357720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeK0SmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:42:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeK0SmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 13:42:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so21559332wrt.7;
        Mon, 26 Nov 2018 23:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3P+6zZI9eQooUjTO9YhGCiOVJt3pSt6zu8YhwCOy7I=;
        b=RqujiPEiJYW+rO9SKYagsm1chyDcWyxhy+Jez1tYmZoOfTjmYerMg7y22++AJYUkJD
         mXZRNP0bFup/9AiElu2Cq9Pxx1djFWpF/Ojbx/t3ypT82QjiVeks7UYBL+YeP4QjxR62
         ReSJZijUXiXy1MIBKEtKeNHLfXFw7UZjiIYoii/w5xMdMYu2ZmD/A9vWbtZgecALJXnY
         XIH0at4gzCXTQQiNqp7I/XwV2Gw14nJqPRjKfDY4+kus9gFLSXhxcw6wpxkjUebnAWEo
         fcpNf/Ck/5/kKdRJBhDH8sLMinB3P6xUbE13CE3jc8BQsRDQYH36n9KxRkc1sj8Jw4aO
         IQog==
X-Gm-Message-State: AA+aEWYahwKiX8BC5ajFPnrEP46rtIkBxGCnZYiExQN8hK97YvLsHLO/
        6Z0NGZpBj/kdXtVL2a/vFJS3nVrv
X-Google-Smtp-Source: AFSGD/XcZWKQLyOR5F/J9Lk16wN2SnJO4QbO9OOELr/nl3eXFAwPKTpkRz6Oxe3muREbG2qgWT88XQ==
X-Received: by 2002:adf:e891:: with SMTP id d17mr22643197wrm.140.1543304705555;
        Mon, 26 Nov 2018 23:45:05 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id a18sm4233894wrp.13.2018.11.26.23.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 23:45:05 -0800 (PST)
Subject: Re: [PATCH nvme-cli v3 15/13] nvme: Add TCP transport
To:     Keith Busch <keith.busch@intel.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-16-sagi@grimberg.me>
 <20181126154723.GP26707@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d7f154bc-d9ab-bbc6-b85d-5a96034c552e@grimberg.me>
Date:   Mon, 26 Nov 2018 23:45:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126154723.GP26707@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The cli parts good to me. Is there any forseeable issue if I apply these
> ahead of the kernel integration? I don't see any, but just want to
> confirm since its all in one series.

I don't see an issue, note that its on top of the sqflow patch [1]
that I've been meaning to ping you on.

[PATCH nvme-cli 5/4 v4] fabrics: support fabrics sq flow control disable
from series: Support SQ flow control disabled mode (TP 8005)
