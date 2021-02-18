Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4264AC4332D
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E3F64E5F
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 20:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBRUl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhBRUkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Feb 2021 15:40:24 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4DC061786
        for <linux-block@vger.kernel.org>; Thu, 18 Feb 2021 12:39:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id g3so1610791qvl.2
        for <linux-block@vger.kernel.org>; Thu, 18 Feb 2021 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=izMGeH6dYVvvRYrg+SR4dkbWf4tBjA1jwd/PyFi3k5E=;
        b=wvbQo9QE9Wp3Chgcgpv7CYoqwp7kuaqfdQiTlgUq1h2J0aIotvMIuP5ipnZFwbxCik
         8+fQDHd+5vQn9VJ9W7BEr6EmbrgE6VqkqCNPBdmPmWEIUk60ccqRFE1k7UM3MXNmEgDA
         b05+G2h4KJBlkqJQq9vMrgGM9SoyfU9dQzuhXajoxI2uvdnURdWWsa6wm08CK5jYHofJ
         yfhVgjvI4gye1JSSsSR8UHHdUyNq1LYs2H+H5JzmMRcxr+CNIUXUaNcNkbCNBvI7+Q93
         hBouq+CbswlkAnbHkan+su0ONtwzeDED5Vc0O4tZ5i22dBVOlbxXIbSagal8+HQyYlIM
         5RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izMGeH6dYVvvRYrg+SR4dkbWf4tBjA1jwd/PyFi3k5E=;
        b=XZBNEkqFsW/u5g6RaJ+Dur76S4TL5A2Ch+i8PcGmVraFoJPlLYnyHhWHzMjMUXx+2M
         Zh+Q4P6h0mZmFSSGuw1AXwfmEHtyiqHeFG2kfd1GeEhpcT/hJf165xy866VfziUk92f1
         xmy8SfL7bLkJ1rUmDljzSUfKIo1oBIHl2EhsNMPLgjEluCs1mcE/2YWQh0IZMw9XARrS
         NXMuSE1JnnD0KJzOHFNIKN1fjex648ZNTSUEjz8XOMz7P9gNzQhNAy5xCfnnZeiWbzLy
         dpA2AlDWYn+ZpwB9EmAZkFmuy8hjIsoc82Np6qBsIRQKtHtTfJKsBo4MXMHtIzKBW04L
         TdKw==
X-Gm-Message-State: AOAM5330PU6Vdo+EL07bqk1W8X39geuk9h3FbxmqK9XlipmbOjdhNiA3
        /MWmxtbe+3g+83vnoaDPlKKpuw==
X-Google-Smtp-Source: ABdhPJxztKx9mX1HlP26QR3/cQf+f3xOlIqt2zgVBzeiQy++BDSTSrLA4mV45L/nyeRanv+vk9XGhw==
X-Received: by 2002:a0c:fc44:: with SMTP id w4mr5848013qvp.55.1613680783943;
        Thu, 18 Feb 2021 12:39:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::1105? ([2620:10d:c091:480::1:bcfb])
        by smtp.gmail.com with ESMTPSA id s14sm4068292qtq.97.2021.02.18.12.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 12:39:42 -0800 (PST)
Subject: Re: [PATCH v6 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210218122620.228375-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4f9d9983-2409-301d-73da-94f0f58c8782@toxicpanda.com>
Date:   Thu, 18 Feb 2021 15:39:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218122620.228375-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/18/21 7:26 AM, Sun Ke wrote:
> fix a NULL pointer bug and simplify the code
> 
> v6: Just add if (nbd->recv_workq) to nbd_disconnect_and_put().
> v5: Adjust the title and add “Suggested-by”.
> v4: Share exception handling code for if branches and
> 	move put_nbd adjustment to a separate patch.
> v3: Do not use unlock and add put_nbd.
> v2: Use jump target unlock.
> 
> Sun Ke (2):
>    nbd: Fix NULL pointer in flush_workqueue
>    nbd: share nbd_put and return by goto put_nbd
> 
>   drivers/block/nbd.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to both of these, thanks,

Josef
