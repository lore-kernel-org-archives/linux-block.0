Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F8C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C87123B02
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgLHREP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgLHREO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 12:04:14 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1CBC061793
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 09:03:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q22so14416396pfk.12
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfgGBVicSk7GapGjJxYdXwMzE2f19C21TVkhYjAESjI=;
        b=VxcDCIHp54zX5XQ0CjWQVXOHKr2i/bzK6C8qhc0SgUrCZVMDfPN//g/8rajgQnKD4z
         viRSSDwsRMm3/Nu31SQkOIap2WYTfiijHDE1a1EwrM1j5eyUXRQ0FIxAvZV9D9mpLeFQ
         vEXBIuNhmrNh5i8+PcH/ZmWMrfOz2eiVgKUakRLAsX65EkcRaHjiUWNcynoCytpZYNrE
         /horYTTBWK7ZugUCKjzANITerCHbubTDkJR+djQlp23m7LKoX/09TfI1YmsaLqVYec0p
         LFqGV7lmbaMtGoJsa0hSkatT2pYWma6+Oz48yfrHHhl49avXk/oCaIHvkirp2YFl6ih0
         cO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfgGBVicSk7GapGjJxYdXwMzE2f19C21TVkhYjAESjI=;
        b=OI0CzUfSL4q6ItedzIhcmml9vZ5xJmLVK0z3V8oZ6JvC7C2H13zytXvHeUA3F97MAH
         NXjFmlEp0cJUiG+KfIcfX6OihO7hbeslGLzB8lcN69vjaiRrrQhU3kfhUqbMhS+yCL8v
         V2iS/6IK0RDb9q6GAY2k4FalCbH4To0D00JNXOcCPOC2bG1KKtuGvMsnqiTpcUam92Gn
         dG1DnnQBslqwMuiQC9GMyxUD4lBp6wadztEx5OwqpKzXZLXa+MeJLrv6i5mQVd0AV5Lj
         +9LJCFCkRvQ2tlHRv82LrwzKdstgbf5cA1ex9mtQA9AzKy8e8PgT7oQTH1CIE5Yig94g
         RCQg==
X-Gm-Message-State: AOAM53036qcdZutyJsD6ZOoZImadFrEVDuYDnbmEJzIC8Cal72aH6oVz
        ySZckXfkHXfjE0c0cWdl5lDvqAY0y3Vlrg==
X-Google-Smtp-Source: ABdhPJzAsWcM0buSntsOVmRLYeUJ2glGWw7Rw5Fc+RBAOV89O/rTF3TTd77xFFsNQxQVL3hfka98qA==
X-Received: by 2002:a63:4956:: with SMTP id y22mr23200574pgk.266.1607447013907;
        Tue, 08 Dec 2020 09:03:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::130f? ([2620:10d:c090:400::5:1a3])
        by smtp.gmail.com with ESMTPSA id gp14sm4045479pjb.6.2020.12.08.09.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:03:33 -0800 (PST)
Subject: Re: [PATCH] drivers/lightnvm: fix a null-ptr-deref bug in pblk-core.c
To:     tangzhenhao <tzh18@mails.tsinghua.edu.cn>,
        linux-block@vger.kernel.org
Cc:     mb@lightnvm.io
References: <20201130072356.5378-1-tzh18@mails.tsinghua.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df10ea18-bebb-16b9-b128-9bd65ec05656@kernel.dk>
Date:   Tue, 8 Dec 2020 10:03:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130072356.5378-1-tzh18@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 12:23 AM, tangzhenhao wrote:
> At line 294 in drivers/lightnvm/pblk-write.c, function pblk_gen_run_ws
> is called with actual param GFP_ATOMIC. pblk_gen_run_ws call
> mempool_alloc using "GFP_ATOMIC" flag, so mempool_alloc can return
> null. So we need to check the return-val of mempool_alloc to avoid
> null-ptr-deref bug.

Please line-break at 72/74 chars for future patches, I fixed this one
up. Applied for 5.11, thanks.

-- 
Jens Axboe

