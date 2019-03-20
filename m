Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66AC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECD62175B
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCTSea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:34:30 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39748 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCTSea (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 14:34:30 -0400
Received: by mail-pf1-f172.google.com with SMTP id i17so2532569pfo.6;
        Wed, 20 Mar 2019 11:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nld5d3qqyi36wAgtaDMndquzkmKVgFxFQ+Z8LqFT7+E=;
        b=nrZOcCavUr/yPFRdOoaRpswU7CDWGwdvegRGBAQ3BazokGd7pSvj4pqa2OGEfZoEDT
         3/JgjIYsorSzmNjypx9Sl388WvurS/P+YBhow1+hqFkTX2EefH3exg5YV79189uuxM1Y
         lCoZBaxPEHYsDlc8WnQhO51dLCToGLqKHYGfgD8MDCx+1kUI3DArDXVC+e0LqhXSPNY2
         zxMjAXkH02A4Se6Idm60lgAho2AEYcjKcSjzOkUXi3LVuap8riJ4SOR1YDj3x9OdukAh
         GIyISBFbRwd4zmlMf/nYyBj/pIW8v4dVQ873pG0ZGp8wcnXHGc21ZSViACUiSHlqv/l3
         XG8w==
X-Gm-Message-State: APjAAAVjfOjdeNcKUCxlkCnjuZmaPY3p3/vKma2QpQu5fRBrHo/OODQn
        DuT/RRfu2lbvUZLOucHebQ7vfuh5
X-Google-Smtp-Source: APXvYqw/eOKdJS6DdDo6OcOaitLbzkO4A76ArtLSjKHTDxrqk1lCtPQdFUkGj5M0I4mn2gcerbOgtg==
X-Received: by 2002:a65:4104:: with SMTP id w4mr8643598pgp.415.1553106869798;
        Wed, 20 Mar 2019 11:34:29 -0700 (PDT)
Received: from [172.20.40.56] (50-207-206-41-static.hfc.comcastbusiness.net. [50.207.206.41])
        by smtp.gmail.com with ESMTPSA id i64sm3913976pfb.112.2019.03.20.11.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:34:28 -0700 (PDT)
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Leon Romanovsky <leon@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
 <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
 <20190320111058.GU4823@mtr-leonro.mtl.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6599b66b-04d8-13e0-905a-9ab3862b30f5@grimberg.me>
Date:   Wed, 20 Mar 2019 11:34:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320111058.GU4823@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> It doesn't sound reasonable that we have per-ULP feature (DIM is
> per-ULP) to be configured globally. Especially given the fact that
> users can find themselves running different workloads with different
> requirements on the same system.
> 
> Currently each ULP has some sort of tool to configure itself and I think
> that once ULP is converted to use DIM, it should have on/off knob in the
> tool used by their users.

Its not any different than socket options that can have a global sysctl
knob that can be overridden by individual socket consumers.
