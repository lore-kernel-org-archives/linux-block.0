Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF4DC432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A02073C
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 22:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOWiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:38:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46029 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfKOWiu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 17:38:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so10011709oir.12
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 14:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meoFeeKaHX1SrgHnE6E4SBXPBPB85SWkIWyxJ9m2MxU=;
        b=oZK9tvUOq9Dbz2QLpAxRmMXC6st/6VYUitJl2Hnz5QjhdUhx3QOCY1XRAEyOQbxxle
         LSRl8KRIlZeXNXXZqCzrX6JwZLbTYDzfj/6UVBVc1h2vgCFo6Kgk1brUXLHFFrsys77m
         GkcIqtJknAH79QyM6KJOmfihqhbSXfgaLGodGsrbOVcsCpwUv0wEUy9iGSea/RzYJZ+g
         d67AYIGeF/AysHMQYlzxSQwyw3VqXrCR7e7md1hPwiZfm0ySbO/HtNfPK0V+4sqAc4k0
         37LnRchd5md2M+sYh9TTgU4XxRSBw1cULFTPBMiqhBomyUfDRFnmbD47GFquuhM1V3DR
         MsTQ==
X-Gm-Message-State: APjAAAUkUy0JU/lcipE4VzN9djWVlMco1/D61onyhQ1SlUIUmYPL2Rk8
        wK6Rm7G8UAcYhB3DziIxG+Qw/L2M
X-Google-Smtp-Source: APXvYqw1g0snubNFd4+t8h6TUmV6wyiB5LP7B54oR4DrsUR8eHnKIqcSiwYTTwvjQgVFOc5G216YJQ==
X-Received: by 2002:aca:3889:: with SMTP id f131mr9936834oia.14.1573857529048;
        Fri, 15 Nov 2019 14:38:49 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id m14sm3341578otl.26.2019.11.15.14.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 14:38:48 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
Date:   Fri, 15 Nov 2019 14:38:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi,

Hey Ming,

> Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and tcp's
> connect request, and selecting transport queue runtime for connect
> request.
> 
> Then kill blk_mq_alloc_request_hctx().

Is it really so wrong to have an API to allocate a tag that belongs to
a specific queue? Why must the tags allocation always correlate to the
running cpu? Its true that NVMe is the only consumer of this at the
moment, but does this mean that the interface should be removed because
it has one (or rather four) consumer(s)?

I would instead suggest to simply remove the constraint that
blk_mq_alloc_request_hctx() will fail if the first cpu in the mask
is not on the cpu_online_mask.. The caller of this would know and
be able to handle it.

To me it feels like this approach is fundamentally wrong. IMO, having
the driver select a different queue than the tag naturally belongs to
feels like a backwards design.
