Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B62C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3BC214DA
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfHAO2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:28:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHAO2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 10:28:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so34308429pgm.3
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 07:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+pyBVpWrGWFwo6CRFg6HFI3k917P3uucTxDT1CY470=;
        b=mP5Dz/vVb2cvSqlXJw71+4Oa4tJxb3ERW+1aoBDcoKmneSLU3uPz++oAdCx3qz9vXy
         nAYGtIMiADMLseLq/fyZEn2mAxWWNi4ngSyRcvR42XSWaUiuZwkKqXMc7adPujFUMI1Y
         ig5YslNaxl39eFYCDe1M2x/B14l+rXOMPw22cLl7+K4BhzeaYVWigCJO2Iqaykaa+IiU
         M8KSVmyxWb2rQt+gefi+S8Tmg+k779jA5Q2hTdS51DA+vrOc4PscEGd0hzol3sx3ofOf
         1eu2uNtifm7o6xvr7NrCFDsry4gDz+LDq53S1MZLv0f/RUGcSFDJmRqTR9a9915iRx9i
         x2EA==
X-Gm-Message-State: APjAAAV9NWTFJpKMtPkPrSHwHtY4pwdSOtB8qQS+c9vDLkt7gdGjVYxu
        Cau3GPJwnuGk2hZME5pd/38=
X-Google-Smtp-Source: APXvYqzioTwzejHNkwFExVF/K0FB6CyilQfkFintItvAcOz9DFpqR6FzepR6NdWlQbjAlKMHrkbxDg==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr9005763pja.106.1564669709983;
        Thu, 01 Aug 2019 07:28:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:45eb:53c1:ba3f:2a0a? ([2601:647:4800:973f:45eb:53c1:ba3f:2a0a])
        by smtp.gmail.com with ESMTPSA id 97sm9803018pjz.12.2019.08.01.07.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 07:28:29 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190724034843.10879-1-ming.lei@redhat.com>
 <20190730004525.GB28708@ming.t460p>
 <7eeb2e89-a056-456a-8be3-6edbda83b7bc@grimberg.me>
 <944c6735-f03e-c055-33d8-fe7f9a760b8a@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4788e1e5-6874-c510-5fa9-f07c98ec42e5@grimberg.me>
Date:   Thu, 1 Aug 2019 07:28:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <944c6735-f03e-c055-33d8-fe7f9a760b8a@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Hello Jens, Chritoph and Guys,
>>>
>>> Ping on this fix.
>>
>> Given that this is nvme related, we could feed
>> it to jens from the nvme tree.
>> Applying to nvme-5.4 tree for now, if Jens picks
>> it up, we'll drop it.
> 
> It's on my top of list to review, I'd like to take it through
> the block tree though. I think that makes the most sense.

No problem at all. removing it from the nvme tree.
