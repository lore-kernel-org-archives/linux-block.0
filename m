Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348EC433DB
	for <linux-block@archiver.kernel.org>; Sun, 28 Feb 2021 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D2F64DF2
	for <linux-block@archiver.kernel.org>; Sun, 28 Feb 2021 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhB1Wfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 17:35:42 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43187 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhB1Wfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 17:35:41 -0500
Received: by mail-pg1-f170.google.com with SMTP id n10so10291244pgl.10
        for <linux-block@vger.kernel.org>; Sun, 28 Feb 2021 14:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dE2tqcKHfqXKzHASrXnq09hLErnllLvTIoFHOenfo+w=;
        b=kbzewBpjaFz4fcIWzK23GZwtEveRiZLN0VlbhuB50KHvPghhPCSa/fF7oX7bABAXqP
         oDwI2vIJhF7zwy1uU9EbG3Ytu/I85CpdqtjV895/sd0gWrPWuwkDZaIv6O2XBHZdFIu1
         RBKL8+hmzGOYXSuypaLuYlzjVhr/3xH2Ir5Oxcstyu7kn3Rg+BksmHuDNa6z2PN5xPEC
         prBNlXN9CKyCYo2VK3sVmn3x7ZhGzNBLVr4eXrOWC/oIpKV2Clt5MT6u6KxVIrU7HwS4
         rxjV14RJliersH2lsuh6axBD+n37t8dz9vWzL13WNrnSJ7yJxCgtrUX8aDL83CLkrALC
         sjEQ==
X-Gm-Message-State: AOAM530ETYAXnH5DhgpRC6V3EBwZXVFwG/H2eRR3A10/apoAqAuoc0hk
        A0ws4FRVfSvtVlQZ6zjTKJc=
X-Google-Smtp-Source: ABdhPJxo9Kr8QqQ12dfHDJEeZyox9nnoevfwrnbweHgH5lHeWcuEagR4B5djSDjweB1/MgA0LROj4A==
X-Received: by 2002:a62:7c03:0:b029:1ee:5930:66c6 with SMTP id x3-20020a627c030000b02901ee593066c6mr7275569pfc.15.1614551700695;
        Sun, 28 Feb 2021 14:35:00 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:33b2:579f:d8cd:be8a? ([2601:647:4000:d7:33b2:579f:d8cd:be8a])
        by smtp.gmail.com with ESMTPSA id w25sm15393352pfn.106.2021.02.28.14.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 14:35:00 -0800 (PST)
Subject: Re: [PATCH blktests 3/3] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Yi Zhang <yi.zhang@redhat.com>, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210126044519.6366-1-bvanassche@acm.org>
 <20210126044519.6366-4-bvanassche@acm.org>
 <YBrR5anAHkyL4EVg@relinquished.localdomain>
 <3c7d51d1-1470-3dbe-f471-68551d233f4b@acm.org>
 <bb4bb982-245c-d9bd-f335-7b2b7d6a3560@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b6d7ff8d-581d-c365-bd57-2ba7dd4db6b9@acm.org>
Date:   Sun, 28 Feb 2021 14:34:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bb4bb982-245c-d9bd-f335-7b2b7d6a3560@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/21 6:45 AM, Yi Zhang wrote:
> Currently blktests was broken on latest kernel, could you resend this
> updated patch. :)
Thanks for the reminder. A new version of this patch has just been posted.

Bart.
