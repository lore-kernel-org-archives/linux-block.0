Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F72C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98AB2087C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 21:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfCNVxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:53:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33264 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCNVxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 17:53:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so4775425pfd.0;
        Thu, 14 Mar 2019 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GdRQCn2XUyGAWChQh7sSps/lIJmu7pR7G4MRDmxsX10=;
        b=cuveYsKtqZMJuSCgJxT66vRei1bYlr9UAMWFaIH1F1QT4W+HJfb9k0K3bV6S6usk12
         Gdz+wdQ5PGRS8VFSHQRWS0orNttlH9/1b9FeFbWbXtTA6a5StQOdtNQrFUUIHLdBVLOJ
         0SbJPn51lBGj5SfW7wN9FXYyG1Mg1OwcllC6NTxF48IjnAVDgR5StPOWiv11fCcxwE5/
         mj10scq3NKoeMiqNvTdkXPkusynXGeVD3Q+a1KMkEo4V4uB+1wvoUDmrAFXhIqGgrMhD
         w5n0+iWAsCEsvCDDQzqwQGECTVrvCP4bZSJcwront2fULqfQmrT1EpYtK8JyyBET30PZ
         enaQ==
X-Gm-Message-State: APjAAAVdiRKudywJ9nY/HKsJ+4px2q5adaahXfM6bJRoJYWOr2zSsplz
        mBIz71WQRHNHjPsKCOIow7w=
X-Google-Smtp-Source: APXvYqzxUcSMnseOwzuci/pN9HGIBTJB77HkTWKR7VU7usncWoyvgeH/uB1HVF5q1Mg023CcUueKlQ==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr134880pgq.146.1552600390713;
        Thu, 14 Mar 2019 14:53:10 -0700 (PDT)
Received: from [10.80.2.71] ([209.37.102.131])
        by smtp.gmail.com with ESMTPSA id o1sm203141pgp.76.2019.03.14.14.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:53:09 -0700 (PDT)
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1271ff04-c1c2-fe9d-c7e8-4898c690d242@grimberg.me>
Date:   Thu, 14 Mar 2019 14:53:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> What is a "block CQ"?
>>
>> There is no such thing... Also, this has no difference
>> if a block/file/whatever is using the rdma cq.
>>
>> The naming should really be something like rdma_dim as it accounts
>> for completions and not bytes/packets.
> 
> Sagi,
> 
> I think that in the future we could use it in nvme since there is an 
> option to set the interrupt coalescing in NVMe spec.
> 
> This might improve performance for NVMe driver.

That would require changing the spec to make moderation config per-queue
and not controller-wide. This does not apply specifically to block so
naming it with blk does not make sense.

>> Overall, I think its a great idea to add that to the rdma subsystem
>> but we cannot make it the default and especially without being able
>> to turn it off. So this needs to be opt in with a sysctl option.
> 
> We can add flag in create_cq command that will 
> try_coalescing_is_possible instead of module parameter of course.
> 
> Storage ULPs can set it to True.

The point is that it can't be universally on.

> Also in the internal review Yamin added a table that summarize all the 
> testing that were done using NVMeoF (I guess it somehow didn't get to 
> this RFC).
> 
> I guess we can do the same for iSER to get more confidence and then set 
> both to create modifiable cq (if HCA supports, of course).
> 
> Agreed ?

Sure.
