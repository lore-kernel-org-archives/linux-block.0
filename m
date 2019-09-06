Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35757C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EA214E0
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfIFXdt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:33:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41889 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392874AbfIFXdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 19:33:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so7334321ota.8;
        Fri, 06 Sep 2019 16:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ygxwc36T1EU+wVJEhf7rWfb32mtFUN0Zd6KKzPVLwjbZuixDgBzGJFULGUPWiArvfd
         lDiNve3TWB4TSyLBHhvaLen1JWgk9x2e8/J1h1sy2WaVUQ9q4vFnN5bGeXwtSIATBRHW
         Y6/kdD5yGvQwbmj4sH1LqsQ1FvWCwQsXWkvdagFg8C+UdLzZIUitVIujkaLY1Sn+rCcw
         VvXs6EcEHVveykawY6Sqw1rOALlqsZ4NtOvQppMzOHN4JJ03UU9S/6rcCH1HxfZ+Q5dx
         yN9w+P26VZ7tNNVEexe5sGvif/8bJ2kV6oVfiTG7pMmOEO5YRLx1gUY4jQTRQ7TIusN5
         TYTA==
X-Gm-Message-State: APjAAAVeuKLj4Mj9roOFwBR6FipEp3++jZaduJUG2NJ06r6OwKYIsy2d
        nSKwg998SWm4btlKJo0nzH8=
X-Google-Smtp-Source: APXvYqzA40JNHk49fJlG4+6BN7CDISq/7dq+lZHiAe7UN6CwYTcokHmUW4SZHRC4bSdOva3rjzncKw==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr10281620otp.206.1567812828369;
        Fri, 06 Sep 2019 16:33:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 94sm2676556oty.44.2019.09.06.16.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:33:47 -0700 (PDT)
Subject: Re: [PATCH v8 02/13] nvme-core: export existing ctrl and ns
 interfaces
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-3-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <94ec3b26-3c8d-46bb-991e-ba395dee15bf@grimberg.me>
Date:   Fri, 6 Sep 2019 16:33:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
