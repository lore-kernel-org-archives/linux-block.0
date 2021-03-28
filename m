Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E6C433DB
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EC761949
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC1Xm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 19:42:28 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:45823 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhC1Xl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 19:41:58 -0400
Received: by mail-pl1-f171.google.com with SMTP id l1so3536870plg.12
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 16:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kByb82zAltIstv+fhdtULSMCk+fIiHp04zpaqq1qzmw=;
        b=Q7Q9ZHp15+Ka/YBX+mDlHJrityQUNI7lMPVGNWG8vj/hjoXNBqlGQPXRs+HmJZiDoP
         nrvmm0RXI98DDIciAKuqZBPIhebA/0XEjdbR9eJKd3BXNT+pM3Fq9hO9qaFe7rIxDReV
         00pJwDxhFAKeUzY1dkhc9oU5oTMV26LpY8AqFZNAyiop/bKMYZVO0VHQGMG0mFkwa5TE
         tWlCw+lJyIbegUrbBczPTE4HZVzCtUKP8D6OcR+OofMS2UIXTY5RkLc5LaIXQwqM1Yik
         SXmIWnsDfUrUS938JAeVOuqIJAGJ8MNorArFivvY7lBB8mwAC2+PdSjnI5BNLNveXHWV
         31oQ==
X-Gm-Message-State: AOAM531yEZvVoQ+lPBU9JrTgVppfdLSNsFMPF9Adomw52/qq5jNzAKh7
        +1ThjPwnLl23WlblfQFQ5QH0PtW2T5c=
X-Google-Smtp-Source: ABdhPJygo9dDTBjpVQJEGKm7vN0mJyCJTctzqyYCf75PTKz8Eh92vDKwgGQpmZxaJJi+1LMKEdM/Rw==
X-Received: by 2002:a17:902:968d:b029:e6:faf5:8d0f with SMTP id n13-20020a170902968db02900e6faf58d0fmr25139013plp.71.1616974917397;
        Sun, 28 Mar 2021 16:41:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id fv9sm15889429pjb.23.2021.03.28.16.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 16:41:56 -0700 (PDT)
Subject: Re: [PATCH blktests v2] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20210328231210.3707-1-bvanassche@acm.org>
 <20210328231210.3707-2-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab74e069-15fb-f1d3-e5e5-fbec8989d14e@acm.org>
Date:   Sun, 28 Mar 2021 16:41:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210328231210.3707-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/21 4:12 PM, Bart Van Assche wrote:
> The approach of verifying whether or not an RDMA interface is associated
> with the rdma_rxe interface by looking up its parent device is deprecated
> and will be removed soon from the Linux kernel. Hence this patch that uses
> the rdma link command instead.

Please ignore this patch - it has already been applied.

Bart.
