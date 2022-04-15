Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbiDOSMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDOSMG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 14:12:06 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB122DEB2
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 11:09:35 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 32so8012140pgl.4
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 11:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8/fxU4uHmR+05GpRkk98JV9hgBLhkM5hCKIlMh/JgPs=;
        b=HZXX6/lr4gUoMGc0bAme4U0QWQSPSHVbWMBh8eUqrdKdQU7rwcQMZB4fg+S8HjFo5H
         nTcELjtX5StoT9eMj5nxpTgGB7IVHMZZ9D2MBkniv3MVE4xD/8px4w4Gc5sPPSCmlD/x
         Mq93BPskqGe5MU5ervbDp8OiPXdVjRRKlPEbjOWwZOs8gBuvOGrJbDn5FIkONjaNKC99
         w22fi33EfCf/W41Otd4oQ0Y7Wgx/gVu/K2/VZmHMrr8JbTDi0KlONaSwDjLrrSCRUEII
         owLnUvKVXC7a7pCKYkxRITnRZrf9igwVFdM7ZtxBnSQox6ah26hxNZGhR5AVD1giJ3UX
         ChEg==
X-Gm-Message-State: AOAM530FjRU3GwoaxnvVkszxO47gaAXgLQTLhPiuVy2uO5GoBzFCm9Fu
        us57gi2cWk3Fjho4mljNp1E=
X-Google-Smtp-Source: ABdhPJz7guXHxadZJmvX9ixogv97fREX+Q75Q1hdxHkf9WIX/Yw0FCuc8VHQpKlg2FQngRENLLw8Ag==
X-Received: by 2002:a63:3fcc:0:b0:398:ae5:6905 with SMTP id m195-20020a633fcc000000b003980ae56905mr167440pga.463.1650046175394;
        Fri, 15 Apr 2022 11:09:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a014:c21c:c3f8:d62? ([2620:15c:211:201:a014:c21c:c3f8:d62])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b005098201d2f5sm3269719pfr.205.2022.04.15.11.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 11:09:34 -0700 (PDT)
Message-ID: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
Date:   Fri, 15 Apr 2022 11:09:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/22 10:59, Luis Chamberlain wrote:
> That's about 3 block folks not being sure whether or not it helps. And
> the complexities of it, to test it, requiring a different kernel seems
> just stupid. So I'm going to drop the tests from kdevops and not bother
> with them.

How about modifying the nvmeof-mp tests such that these use NVMe
multipathing instead of the dm-multipath driver?

> With regards to srp tests there seems to be two modules to use. Do we
> want to prioritize both just as much? If so then I'll just create two
> guests for srp tests.

The rdma_rxe driver is older than the siw (Soft-iWARP) driver. That's why
the rdma_rxe driver is the default for the SRP tests. Ideally it shouldn't
matter whether the rdma_rxe or the siw driver is used for the SRP tests.
There has been a time when the rdma_rxe driver worked perfectly when running
the SRP tests. Unfortunately that is no longer the case ...

Thanks,

Bart.
