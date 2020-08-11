Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F21C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C3120774
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKVpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:45:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32795 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:45:16 -0400
Received: by mail-pj1-f67.google.com with SMTP id i92so2032636pje.0
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aG2TZSuxwKetVw9WAETDbHNqIj8OwXsHuETcwl47mxg=;
        b=XFhcQaqy6WQWM5xvmo5hS/DFOWN5Nx+aRpgmqZebWWfQx8UvyOt+eQS6qzVxCt9yH9
         46u7++QZ6L6/Tklul+BbjZNgBVI3Kyo97i8SinbL7BuPuB2rircA641nUb+pmevDvJGf
         ReIqfKGI5xaXp/av4lzu0gugzyU/cgIigV3bgS8nqKFl8H1EY4AnBke4JC91beK0RmlN
         f2YaYMY8mTIYICUjo7iAMsM2wNRI38UqQcaX3J+mDjbhjP272ANUH/arw9xcncxxMePo
         NzBf7F7igUjiYrAc4L7zWVX8hi+V6e4+zoQBV5KWK28GTFeDhkHmfkHAM18sIl9AawoS
         TROw==
X-Gm-Message-State: AOAM530rPTXNNgyqV/3wY0hCJTY5QhCRUVF4HW+kAss4rnbQUoMyZGXK
        RAfCypV2LzV9j7gEc2nVT/k=
X-Google-Smtp-Source: ABdhPJw8LIt2gQ6FOkVrUrZ12i+84Mc/CAKsk88WGSaz14Ggq/82u+hhNv2YtYs7btuxoPB1heQPsg==
X-Received: by 2002:a17:90a:6f85:: with SMTP id e5mr3077388pjk.128.1597182315339;
        Tue, 11 Aug 2020 14:45:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9? ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id o16sm32849pfu.188.2020.08.11.14.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:45:14 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] common: move module_unload to common
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-7-sagi@grimberg.me>
 <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19e536ca-cb18-68ac-7688-d5c9b788ee99@grimberg.me>
Date:   Tue, 11 Aug 2020 14:45:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <47900df7-e3be-c200-67ff-c9e099cb8aee@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi,
> 
> I think there is another copy of unload_module() in tests/srp/rc. How about
> also removing that copy?

Yes, this is minor enough to remove when applying, Or I can respin the
patch set again if Omar prefers it that way.
