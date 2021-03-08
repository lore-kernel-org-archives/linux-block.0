Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C56C433E6
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493B665287
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 19:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhCHTfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:35:41 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34252 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCHTfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 14:35:14 -0500
Received: by mail-pf1-f181.google.com with SMTP id m6so7907556pfk.1;
        Mon, 08 Mar 2021 11:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqpkkYWGnOlTlzWLy40cJ0EmokNsDDvU2Mb4GyPS4Mg=;
        b=NK/GUx3R+lvj5/5s7sEqEXllJ3H0xkuFVUrjX5PGd9iM/NW4Kr4zU4iHPFLWwbdfjw
         PCqzggC/p6fQusJVwb/kchxsiTxSeTyPvryGKl7XT3HuamAM6K3Eizh7niJ606Nz2S0a
         fVuc35m33uSv0ehKr4yP+ivIEeJhVJJWflQ8ypV8BkI00tLDlczBFnlmqPlDCExKhcF6
         A3Ekq8Dn4MKApfsMtKJrs3aU9CA+vN/cDEM0JGWT9+dcnCyZ1cYGG7StIjYb3KS5pNHq
         kulKPGM+6qjm0/VUH3hv4KkJLdPhyR0l8whRCBdGDDaPPONtSyxSmVTzwq1vS4Serjvm
         FWdA==
X-Gm-Message-State: AOAM5305E0GGg+Vg53SRHiotrQlzcqfxo5rJ2/Q9op+C6uQACblH1xi6
        Ts9lw5lF03qmSZBHjbRspN3TUXNI90U=
X-Google-Smtp-Source: ABdhPJyys2y6Oghr6FgnxHSnbk0vV9AazIS4kJDgos6RFCLPrPRCbuaZWIxac9CkC2nxz/dGrtMIBw==
X-Received: by 2002:a62:6304:0:b029:1c0:d62d:d213 with SMTP id x4-20020a6263040000b02901c0d62dd213mr22523518pfb.79.1615232114106;
        Mon, 08 Mar 2021 11:35:14 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t12sm82201pga.85.2021.03.08.11.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 11:35:13 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <52618092-07ca-ecb5-320f-957af26ab146@acm.org>
 <3c6cbe11-ac31-9a47-0096-17fbd584b83e@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <072178c2-a112-8f35-8f60-e5c1396561d7@acm.org>
Date:   Mon, 8 Mar 2021 11:35:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3c6cbe11-ac31-9a47-0096-17fbd584b83e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/21 2:50 AM, John Garry wrote:
> Please let me know further thoughts.

Hi John,

My guess is that it is safe to nest these two locks. I was asking 
because I had not found any information about the nesting in the patch 
description.

Bart.
