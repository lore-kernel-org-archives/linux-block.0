Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5BFC43461
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E8121897
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 19:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i4FEcTyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgIGTlp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgIGTln (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 15:41:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F3C061575
        for <linux-block@vger.kernel.org>; Mon,  7 Sep 2020 12:41:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s2so6853418pjr.4
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2020 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XUy80lSnzuiQeNcYJ4dpYzC3NGeXnzMuYqOHMMJ32fM=;
        b=i4FEcTyDuNia7QEBk+rx7SEcdx627PF/7Ta5EJtQyiyeY7t64GVyTKM+q1B8N6R1iC
         eIs2BAS3YyFeha2UoZ69/rnynsSeDZIAMUPqWutOJbGchZ775bEUcAGFshbnrhoFkCNv
         d6Lk5LTgDl8elLsUbBJIRV0Ml3Jc0N8Qrib9CrkDTuk44j0n/QVx0eOoQarsViOBPJTp
         PSS5bcYJ/edB5rBJeTXHqg7O7zMvGHOiPetw8u+nLqbmqIo7rBzn2DK3rIUBT9kEoX2C
         3inl0Xu4AkCeh/FafzfyU3hvzp2yFrlO0HlO0uMpmrZGLPH9lHeoibUWAHZZl2SsgbZ+
         dqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUy80lSnzuiQeNcYJ4dpYzC3NGeXnzMuYqOHMMJ32fM=;
        b=eK7J2qNW/75bR2hlWonQNI2c1idSC5pMO2KSeZBS3WDCVSf2Kf7HANFoMMUczyr7jT
         oNBILGwduHLFkmBGynT56EIZnkk+ruMC6Lo4PbJmIMueUyuSf/tq3XBN41eZlQWGeMKs
         QNhjlxzNsjSjwLjPw5X652V1V1ZUHyxjf9dTdLFVgv5FMGRQnMZ6XXubEWW25okpALlj
         xOpt28zVlxL68K19RFZNeIU1oEZ5K30tZGqZrK7f5/8MFoZChl0gRmI+K/wW5KGIM5nF
         7apTFZP+WfGAbWJisNaeTq6YnDhLPw1o8h8Rdu2I7PLzahLvKbSx4Qs80QTW/7/Tfjr/
         NTRg==
X-Gm-Message-State: AOAM531hHa6gXQCUkRsv8JrR5BotQeIJIqzPiHDHJ9nwXcVcFn1Cf7lX
        Y9rzuHuZkLCJF/MY4TcHvDC6bDnhJHkW182F
X-Google-Smtp-Source: ABdhPJzOIDwkXrBNxxc5aNUN5aDCBvx8uAc1p3abLoGEJ4cnEsfBboKb9chN0EFypV6FA+3PEBSOjQ==
X-Received: by 2002:a17:90a:d496:: with SMTP id s22mr677948pju.167.1599507701978;
        Mon, 07 Sep 2020 12:41:41 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s19sm15899451pfc.69.2020.09.07.12.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 12:41:41 -0700 (PDT)
Subject: Re: [PATCH -next] blktrace: make function blk_trace_bio_get_cgid()
 static
To:     Wang Hai <wanghai38@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20200907140652.9060-1-wanghai38@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f6c68db-d67a-0bc1-dfc4-7c990e102cbb@kernel.dk>
Date:   Mon, 7 Sep 2020 13:41:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907140652.9060-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/20 8:06 AM, Wang Hai wrote:
> The sparse tool complains as follows:
> 
> kernel/trace/blktrace.c:796:5: warning:
>  symbol 'blk_trace_bio_get_cgid' was not declared. Should it be static?
> 
> This function is not used outside of blktrace.c, so this commit
> marks it static.

Applied, thanks.

-- 
Jens Axboe

