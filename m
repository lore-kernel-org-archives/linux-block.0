Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58123C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DBD20782
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M8AdW+n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgJHPsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJHPsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 11:48:11 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C449C061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 08:48:11 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z5so6141598ilq.5
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZNHoHKR5jVBV9HJSR3SvdvPnSVPLY2dCoFYQlqfRoA=;
        b=M8AdW+n/tvCr2kgpjYflBK9OQKj9sld6K1kLL8LDYxaQg7ILWOVyu9HsBWfDPthqZm
         RpkJDyTQ1T67OkBfVHrBEadjfc3FCUm76oHBYJ7819ryR7/DgAZE+v8wbbkkBh6fJ1Hn
         tV3elI5PRKFSz+EqV6fGwJb4FVwHVwiHlPsI9B5S7v0ic6eqDjZFFiDdODnZut8m6KEv
         X32mAEk3+y3Fy6YyzjLHwJzDqjI8fUgy1qFhbLz17S2T5YJPIuUwTmiah1CFXQkjbmV6
         nJS7fCO/3QaXxTe7R0QO6gLGAwf7mFAManqG12onaIJMb0N9QJQT9gRiyHWH7Xqfp2pV
         cg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZNHoHKR5jVBV9HJSR3SvdvPnSVPLY2dCoFYQlqfRoA=;
        b=Ujg3fQlesbfP/gQzEcpYW/6T2MCkeClCNLdwIPut4hIqWMdo7xM4LiZB9VllWPCvaQ
         DnfLkHRDOeR/WiIH9SHp/U9AFOCyWTjoo/ekt8F7oae4ZHluVzLxwLJ8U+zpdZY1mGlc
         2MT61YqWf84YWQSewYaSG4UN3RYHqXhjNZWIfBI03lEYeASGBhWIIbyeo2+Qk2VvIBYx
         uTgIa68lVI2BHuXuFsPIdjrrdNnzxa6pUjYAbhRP93eJhO137K9aOQ6bxkK9/mbCaMyE
         yhKmpdjfn6VNdhaEa2HqarM9zIjiQ7EzBdLmmgaE9k6l3B+qMwv3HWTuak7tKhCyUSsg
         MxxA==
X-Gm-Message-State: AOAM532FgEita18StCb+CR8obk/N5NmPUOBMnRRj7qZfphrKAapvSpVT
        otFP4FbC+bPP89OO8xJ+KvBwwIMKJaQnxw==
X-Google-Smtp-Source: ABdhPJyqdUGO1UO/ML20DKjXGkngT1OTfRPxZetNXrAdhtJfDzy3vJ+LICZj3xKbh0sqG13qkDGm/w==
X-Received: by 2002:a92:5e42:: with SMTP id s63mr7413773ilb.205.1602172090379;
        Thu, 08 Oct 2020 08:48:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r15sm2814537ilj.43.2020.10.08.08.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 08:48:09 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201008150125.GA1495381@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78afe105-d7c6-997c-e4e6-13a6e3f84e7f@kernel.dk>
Date:   Thu, 8 Oct 2020 09:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008150125.GA1495381@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 9:01 AM, Christoph Hellwig wrote:
> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> 
>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08

Pulled, thanks.

-- 
Jens Axboe

