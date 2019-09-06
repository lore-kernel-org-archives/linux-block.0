Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E2CC43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904420842
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391973AbfIFXfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:35:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34732 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFXfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 19:35:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id g128so6443695oib.1;
        Fri, 06 Sep 2019 16:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bqc8r4QnNhGzuFCtcpr9C9RP+toRp2ji4H218PlHbjs=;
        b=tMQN2bOMnuWaWtM1fjjFfcZUqbQnXrYFw0oaI45BrAH6ld+VRZAPOIwgzVBGyaRYB6
         j09iz70OBGvEbtHl9XFvb6Ute+nZy9FI+TxXpHcHFqcLubbcM5TReQjIq4WK7xhE+w2M
         hRNeMMhaHe+gd6KjhNPRbPSAnpV3C0qTo+OKYriuEdX0SeDncft+Mu+iNLG4Wi7F6Wwa
         9Nklj5zgRO4C4c3epzybFKs+t7OsVvU7M8R6FzO4fgiWLVWLpWCd9XvIFBYmT3anPohU
         5VKTLUrmQkhdtb/gg1hUKoNQ65YnyMtmGq1J+5eOJqidAWIuyVMiYwfDgjI8quG4IBQl
         37IA==
X-Gm-Message-State: APjAAAWsFAlHJazppnyiNke1TjcMyMWHUZAFSyk2xrYNZEgNFQRxOgGe
        k6jgHReLAWM8hLd+J1Fpkqk=
X-Google-Smtp-Source: APXvYqySygkb5Z56juhBPVZxqqh4ZEW0zHL3wMtJwZ+n4FHDLpG/kAXIw2DFy1v3l6TiHbp3ZjfQ+w==
X-Received: by 2002:aca:db0b:: with SMTP id s11mr8875407oig.140.1567812943543;
        Fri, 06 Sep 2019 16:35:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o1sm2203393oic.50.2019.09.06.16.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:35:42 -0700 (PDT)
Subject: Re: [PATCH v8 05/13] nvmet-passthru: update KConfig with config
 passthru option
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-6-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8ee32fa-df19-fe73-3365-bdf0cb841f26@grimberg.me>
Date:   Fri, 6 Sep 2019 16:35:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This can be squashed to the next patch. No need for a separate
patch to enable/disable code that only comes in a later patch.
