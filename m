Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E67C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB652213F2
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 21:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCRVeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:34:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40559 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRVeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 17:34:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id x8so15810520otg.7;
        Mon, 18 Mar 2019 14:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hmr+xKA1wV+OPL1nVSr77tO59NGQi32kSUf6vaLWg0s=;
        b=C085qAMSSzyAIFLTeiZgNLI8Dp3YDq6xN5t64JrSg9oFz15A8daiPg2meu/qiYtVzs
         GC4+sh5b1IBKpJUTM7Dth8yixycjQbn89+atEcMGsz2Wwvy20gMWYg8TlhJULK7JLfhv
         cnlRRWLX6fLkv12ymOE3W6IL/t2mw9jeuAtCUFN6O0WJUlCjZYtVd4S3cbqZWgMWRg2e
         n3uXVd/8w6M2vSZTxK2QwvVdbDJqDVR49NqtG+6OWJpvyqDazEUw9ina0IFRFgv3jOcn
         iFQ7NvmDSllVjEPKFuYl7ZW3Fo3m+VFdYSDJRFrsvNUa2xRiik5BQDU5xn5fCtaTuTkP
         unog==
X-Gm-Message-State: APjAAAWOImAkjKTLOPHBapuUq/uxk6rPeofgIm3nbczUJZfjr/3pr+aN
        UsRqJTaGznlQ9L/PwTTGFpk=
X-Google-Smtp-Source: APXvYqxTRuo2e08peCwvjtiAgWDZIyru650+MHPJ0XryXVOE2DVDIsI0gCDDranUi1UDo+019r4SKg==
X-Received: by 2002:a9d:5616:: with SMTP id e22mr12168201oti.365.1552944846407;
        Mon, 18 Mar 2019 14:34:06 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id r124sm4522695oia.35.2019.03.18.14.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:34:05 -0700 (PDT)
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Max Gurtovoy <maxg@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
Date:   Mon, 18 Mar 2019 14:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> As we discussed, let's check with RDMA maintainers if it's better to 
> extend alloc_cq API or create alloc_cq_dim API function.
> 
> Sagi/Christoph,
> 
> how about adding a module param per ULP ? as we use register_always 
> today, create a use_dimm module param for iSER/NVMe-RDMA ?

I would say that its better (and simpler) to do a global sysctl knob for
it. No need for a per-ULP param for a starting point.
