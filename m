Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA301C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A489B2064B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgFWRph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:45:37 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50642 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbgFWRpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 13:45:36 -0400
Received: by mail-pj1-f68.google.com with SMTP id jz3so1793480pjb.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 10:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FX6hyw2K/GlZbkxcQH0ReKiBgHEmp2VO727PD7fs5YM=;
        b=H8Y8UvcDdNmIh88qrQprLb6bXWjQOBU+Git0wOTzTtyXlvFgdgp66SMqrVbWgEDkQH
         Dben0OI8Ra9Ry99XvtN3RvCoCJyLMWaT5pVST6PQehLjYxcx7sW4sLjWQUGx/mRosnxf
         4lxU7Ml2vuRl2Sav/qse63Rb6uup0aa2FAo0kkx47/ddtajuhg8DsaV2XQNdCgcWdzex
         HlLwtb/MhWST7IUGRbQADv15z2slh7xqEUUZO4umqHPuOUeACoVFSQGTXkfx3RLVHf+G
         1Wwt4M0bBsxqssgiVahgF/svBLUUGsAzO1wf0ONBSj/FQ+iVwD6NP+2kQQvNbjqWbIJV
         +wZw==
X-Gm-Message-State: AOAM532ljqa3A6B80/9ogKqfkIrUV7Mg8j7Wm4aUJIwABimpb92OjQ5N
        QXzfL+ler793r/pwO045II8=
X-Google-Smtp-Source: ABdhPJygza4BgCBQdxxEfmouGRUizR3QaLs72AclE4EKxrZg/f4aRNSkOc1SrRsqfnh8DGB4TEVaKw==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr24576568pju.89.1592934336354;
        Tue, 23 Jun 2020 10:45:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id a33sm6958898pgl.75.2020.06.23.10.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 10:45:35 -0700 (PDT)
Subject: Re: [PATCHv3 5/5] nvme: support for zoned namespaces
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <keith.busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-6-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <327444ca-8524-a0fa-c302-33e0278b2217@grimberg.me>
Date:   Tue, 23 Jun 2020 10:45:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-6-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good Keith,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
