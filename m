Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D2FC433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C7E20709
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICV7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:59:40 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41359 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgICV7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:59:40 -0400
Received: by mail-wr1-f47.google.com with SMTP id w5so4759064wrp.8
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivftT5JA6/pSfHGFCicggdsVATHYc67pLDeA6p6l8qo=;
        b=Obv7tMieQPEOvsJHAPw5H46kbE7J2empyJ+zISjPZ5y7y0/iG7EDa2nYCRwFwJFMF8
         B+Ay1BfUszsbv+3ipYpyOPbshwnTx8ruFXRl6kFp/X3DbNzaPRrmlxlrmAlk25q7P/B/
         Rp7deV8Hh63mV9ljj8W2j4gCducxfhZnJIQ7j87xAcN3Q+EmTsM3lt0oTWUwQkd7KUL9
         0Dg8T8vmhz35S1nyN2VQ4Rf8GT+ariv4piiuYH/Dt8rNIHoplqKffZneqa1h9O3VDncb
         wi9pxoa8EFYHy3HtjLsK4BvelZAeC7EhZGthj6RsBb1+KpedO9ZHxGVrx7DZYXnqTrBZ
         Pfxw==
X-Gm-Message-State: AOAM530bfAB8xXNcINBJtmZo6U8rpKras4LGDmvVcJBEkyk8iAAMymdl
        6rfdek7EpW9dK5JB1Bxs9vc=
X-Google-Smtp-Source: ABdhPJyrdJ/n5NIbsf/zuGkL0HTpU9ZSMEFsU13KKGAn3fg0orGWuWMjGuMArd7RwdQKughjPJsj7w==
X-Received: by 2002:adf:e407:: with SMTP id g7mr4407321wrm.349.1599170378230;
        Thu, 03 Sep 2020 14:59:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:79a5:e112:bd7c:4b29? ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u66sm6722492wmg.44.2020.09.03.14.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 14:59:37 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] nvme: make tests transport type agnostic
To:     Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903212634.503227-1-sagi@grimberg.me>
 <20200903212634.503227-4-sagi@grimberg.me>
 <846fa009-5687-5532-236b-e001fd7a8200@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8421bc71-8055-c9ec-d699-795a5d4b30e3@grimberg.me>
Date:   Thu, 3 Sep 2020 14:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <846fa009-5687-5532-236b-e001fd7a8200@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> -	_nvme_disconnect_ctrl ${nvmedev}
>> +	_nvme_disconnect_ctrl "${nvmedev}"
> 
> Sorry... looks like you fixed the quotes in the wrong patch... The
> quotes here (and in a number of other places) were removed in the
> previous patch then fixed up in this one... Maybe run "make check" on
> each patch individually?

Darn... will fix shortly.. thanks
