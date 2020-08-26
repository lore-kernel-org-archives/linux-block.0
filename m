Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D2C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECF32177B
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C81DA6k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgHZN34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgHZN3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 09:29:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1CC061756
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 06:29:45 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so2096935ioe.5
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWDRtfDgOmjmVc54FsnEiVUILusjEvmBBK9m1LuosGE=;
        b=C81DA6k6wvDiW6w5quzdFAwrF1V0JA/I/jNzibknzyF2y/nipAIBai1lhKDX4pFbpK
         IpdhPaX8b+eZKf1SSW/jKumV7MmL+GO5p+qXZK0ZyCPULi3gZVa7JrtLkiCTmI0/hxyf
         x/dxBMvUM87vTYQbW1qO25yp3OkVMTEkoqwB3lB+FQHRSkAzZRhvvHgpycwHHph53dBD
         Zbvlq61l6SYQWG9ck7GLYIVG4rDG8C3+RocGqVO7r/Pd5MSUmESMeNKY3ajYrphdGpnO
         tWIf9J1FWtlTY9SY7RR0trZXf1NF5bncrruslMYsh1HKdB63orhDgcpn6i7wKhejmUPA
         0Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWDRtfDgOmjmVc54FsnEiVUILusjEvmBBK9m1LuosGE=;
        b=TSXRG0k5V53ijwKwgrktrxPIuSmLbKpcB6E4VZRY3v4RkQ60goHphN2KnPJs6QH17o
         wtXPEoA/WRowzYA+8P+ll31+UV2vkU5xB7gvXMxFmdwFdLP2gvPrAL38TNEl8nnlpQx0
         dKhRsVfg/f9XgaiAIE/+zS/QyqhD2gaz8WQSCDdOMvZDlxA830aANsWJEB/zAQD9olX+
         0XzcEggODegSFYn7ALl3vhB10i2lQoEc7f5JwKPuUHOqVZtHa7mnpauMtqSHdSDy3tKv
         GytVl5jVSIet7D03pJUe3zn0IannZ8uCmSrq+iTSVnDfkcaH3hJSv/90RDjeIgYCpCPp
         Ataw==
X-Gm-Message-State: AOAM533MPEmnBxm2O7VqpEdVb9x5OWMHcg6o72HYpDEeBJuiS1jtQIgr
        zawOL3rYuUCNQQgcKyioVRPhRQ==
X-Google-Smtp-Source: ABdhPJxsUaliUkHsd4TBHflAs63JPsL27kYy11Yz5vbcV8DQ0IqO42oCh2rpo1cPfC0kI03MlK6chw==
X-Received: by 2002:a02:9149:: with SMTP id b9mr14778841jag.50.1598448584770;
        Wed, 26 Aug 2020 06:29:44 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d19sm471491iod.38.2020.08.26.06.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 06:29:44 -0700 (PDT)
Subject: Re: [PATCH] rnbd: Fix an error code in process_rdma()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200826113242.GC393664@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <172d1b3a-58e6-1a50-2b6a-1e797135d5af@kernel.dk>
Date:   Wed, 26 Aug 2020 07:29:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826113242.GC393664@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/20 5:32 AM, Dan Carpenter wrote:
> The error code is uninitialized on this error path.

The fix is in Linus's tree:

commit 17bc10300c69bd51b82983cdadafa0a7791f074e
Author: Nathan Chancellor <natechancellor@gmail.com>
Date:   Mon Aug 17 23:49:25 2020 -0700

    block/rnbd: Ensure err is always initialized in process_rdma


-- 
Jens Axboe

