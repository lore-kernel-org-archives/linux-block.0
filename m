Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F42C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5BA20782
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YXOCt/vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTTbE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDTTbD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 15:31:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F564C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 12:31:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ng8so313466pjb.2
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tP4YOAYejpYYmGjqnTMgmuvgf6bkGxAGggfYj5zNTqk=;
        b=YXOCt/vmrvkiHPQ+LYP+Rw1Y4MwUNVgX+5xqpv6STtfilyH/A9aQ4IlwT7FC674Nxh
         +esNn1mEFx0EXnI8bcx2vpaalkfFeUAtibS4F/wxWjAxBGP0w/QDle4MEa1UTRR9fkc8
         9W7kIt9cy9rNqw1Wo8HMD3qG14+mu/45qY+gqv8wiQc9zeSKJ7YS5fHAVhB/3g4UxgoI
         opIJ4Tnxluz+njEy2mkzwW/9bV6QTA4TCKPuSFODJYAkyQYHUg4vOkxLOcS8Z1SFMOb+
         bUyoXUe5M9mLhLxYecwvnJoJqfUIc7Lrxa3fvPLwxs2OPu4mnK0rPb6EO9v7yfIS8UC9
         NhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tP4YOAYejpYYmGjqnTMgmuvgf6bkGxAGggfYj5zNTqk=;
        b=c7cBLUVv4lK919V+eXSiZdk3iRtmwhCET+u2rYwsQAY4Zfu7kbMn2cYZhver1YJmJj
         wqgUytrqn9AFFHWjSKGRBujNoLpK1avWI/meLjS+lRQsI3Z+9B2USmuNRbB/GJEQCley
         1N3oEeQ0uqs4SZPcwQBP3vJhqYTYOt1T/4/zb2Mbi4QCLPn/BcZAXyW+pHTGlsawrtWq
         PJbAIccIP2UgwXCYRZhbX7Yks8qENOz3c7ZTrw4QRHjBz83+hcUyYHXnWRO+CItofm3f
         YlqeEAYrpzdSM/3PqQv2kXC6vKhzQzU/LpP0vAjS+MYfZhTw2A0HHcEY6nf7TwuQOjJ5
         kpmQ==
X-Gm-Message-State: AGi0PuYNnCO3eVDZCIRIAOBXQ7c+UsvATWOMRBLL4UVvG9luB8w+9EjV
        fOd7BUCGoRY15CLqDeMbgyATVA==
X-Google-Smtp-Source: APiQypIRLolceCASZsVEdrG4amYe906vCp6zyCHbpiqrERmubQB9cn6xcQS5s1qTUAyVN58Kt/gWdg==
X-Received: by 2002:a17:90a:1954:: with SMTP id 20mr1210442pjh.106.1587411061882;
        Mon, 20 Apr 2020 12:31:01 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x123sm282247pfb.1.2020.04.20.12.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:31:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Fix potential kernel panic when increase hardware
 queue
To:     Weiping Zhang <zwp10758@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <CAA70yB7mNEt+H5xd+hpeRDLXDi+V+Qmuvuy27wJ63dtmcKDpzQ@mail.gmail.com>
 <CAA70yB7k5siarFfK0Bfko73HwzpTrC=c-8u=4X9fGuxkbrdbMQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d926e69-f25c-f79e-0878-fb3c158ab8ab@kernel.dk>
Date:   Mon, 20 Apr 2020 13:30:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAA70yB7k5siarFfK0Bfko73HwzpTrC=c-8u=4X9fGuxkbrdbMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 5:15 AM, Weiping Zhang wrote:
> Hi Jens,
> 
> Ping

I'd really like for Bart/Ming to weigh in here.

-- 
Jens Axboe

