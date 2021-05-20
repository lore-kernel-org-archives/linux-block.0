Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D88C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BB460FE5
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhETN44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhETN4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 09:56:52 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3CC061574
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 06:55:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o10so14334150ilm.13
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KlRT2t87jzR9AoIxkuqmz5/xBBHeZ8SD/zJz2pWVYTY=;
        b=B4Vz4LKPVzfnxGC3z6gKpL8MFZ4JxhGdfM5sLuxLo+5a0XcwIoIPBb2pecz6U4jsz1
         U1HTBTOs8qMutNDy6rrQcEaNSsHJDIqF5j1MI+iwWaGls5kDdvJbhUefY5uiv0cvsZzX
         iSBacin0T/s81F1zPF2dpJDHoVL8N+2S2V2c0Jqe3AE48eFQqP7Q+gvyGHox3R1hkJHW
         q0RDzxxYIkkrfJUeQBP7+sfSRKc/EaLxtxPVH1R3s/q1FQMgBgiE2mzin3Dl+UUadXjN
         4C3u+qXz/tfiKBnZwBQHiRpsJIMgTyfKPB4eQm1jMNlb088kSLOorJ1GQciD7J/kjT7X
         8rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KlRT2t87jzR9AoIxkuqmz5/xBBHeZ8SD/zJz2pWVYTY=;
        b=Gw8+7jJthxnYbij1A5DVEB2IZ/8sLBUkKSY3XR/pnd/Ik/bsroxROzAkMHRydE1AfM
         R1N1y4V4a7MrPehNI9j9y0qTkxCSRh3PenSWXZiIoxM6V1fmIU7oQBARx3DbLSEjhcR3
         kpn0v6+xfpXWXcYUrssYDrlXnr6Uq9RsFHwr11GTHbTKOpwzxMafzT1QQUiZqQwuJblH
         E+kK9MShO7mMW55kZ5xgUahfheLsXOeBa4M0PmhAzBNQrmsYdIMWYGfIBQI4XxzQfpjl
         J2s8z+t1KNH/66WAcyVrVT9IHJrTaG1NHehbBPGmSP7R3fvtmJf71phS2rPC/C2Y7pTY
         Xuow==
X-Gm-Message-State: AOAM532ifA3Zr4enPOlm3OMksUacWNQz3sl8/ZlnjVKXNnolaXrFtNwh
        +CyS5G1Z/8PsSIp3zRbcB05scg==
X-Google-Smtp-Source: ABdhPJyUhtsCctwo71Bt9kB2q5XPk2ob6bHsjyAe5htfoo7ksaRYypXcBvQFnuSAUJhyO33G8fXPjg==
X-Received: by 2002:a92:db11:: with SMTP id b17mr6139820iln.277.1621518921087;
        Thu, 20 May 2021 06:55:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm2758707ilv.66.2021.05.20.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:55:20 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.or
References: <YKYXGnF6ywgyBTsB@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30838259-bd6b-8000-c881-3610c16d6c5a@kernel.dk>
Date:   Thu, 20 May 2021 07:55:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YKYXGnF6ywgyBTsB@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 2:00 AM, Christoph Hellwig wrote:
> The following changes since commit 4bc2082311311892742deb2ce04bc335f85ee27a:
> 
>   block/partitions/efi.c: Fix the efi_partition() kernel-doc header (2021-05-14 09:00:06 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-20

Pulled, thanks.

-- 
Jens Axboe

