Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20524C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A5D6113D
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 11:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSMAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:00:21 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF4C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 04:58:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a8so18047963ilj.10
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jMzWUknorQN7+NMux/Af2N21AFCZminavZG+d15qdDI=;
        b=lKqbC/qTJEyFCyszS9nqx296ZMGAvnlSYfCh5LCAYAljaHzMOidA4emm1YoZgNsite
         ZV7qMMnNa2Owfk54pNTkmBGbiy4eyLfeQCIODKuovVmWL1lA0BJo2sAwYIIUWpsm8a0T
         LiPAhXegQTlPNNyKR/X+HFZQl7oaa8bHuGK/PSWDOVmDRVEezZjwMvdLV/94ybUBDIq0
         gvI3l6XURf7kXTDCR1EHC4f36EzJCAX3sdxwTG+8rmNqRBZlKB9G7bF979uM5+UGLO1F
         lfK0ufuF6+LTZpenLvXPNh+Cpj8pjwXoavpz9yYMpxj0HvMSBITFHH0nyTWGBpKMpxMy
         dAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jMzWUknorQN7+NMux/Af2N21AFCZminavZG+d15qdDI=;
        b=GhYVCS0z+0r3ml4n/5sI64HH/m1nEbeNDYX2ihhyVIySkWXGPzroBEwDrKO/hehnP+
         KxZTudZUgteOM2qjfyrTcDW7V4xDPKYak3JgkhNv91uaYkn/MsEDSarqTKjTWHL8h8+A
         jMH1KIxgGg4kQhTNuvEaXIFwyWbfi/dA5RNFyWacNJWTpGENsWFOhBsXsDkeyB7W31oW
         uCyTZRYrMFKZolNOJitIhTok+iOvfmDtV9mmFHO2WLAwsIwSGdpG5cI/cylDTVUo11o8
         zX2AvxLBFEIsQsS89v95aWqEDCCt73rOjrBe8kzHoE38uogx9oxgnqIXcFR5n6IV7wlK
         9bdQ==
X-Gm-Message-State: AOAM531tCux/KuAh2/O9mlEBAQuDck8NWmBFgX4EqEvibdO4jneg9iHg
        85mN71oDKgQu4INSy19engDUghiYk8ca0g==
X-Google-Smtp-Source: ABdhPJx6Hair1XGRHqYpH76az35Too35bP4jzbRaTd20sPQSRlw7l7eCkFp+4WZuy47P+1fqzlMN1A==
X-Received: by 2002:a92:6c0c:: with SMTP id h12mr17659847ilc.32.1634644687771;
        Tue, 19 Oct 2021 04:58:07 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 188sm8139388ioa.22.2021.10.19.04.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:58:07 -0700 (PDT)
Subject: Re: [PATCH 4/6] block: change plugging to use a singly linked list
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211018175109.401292-1-axboe@kernel.dk>
 <20211018175109.401292-5-axboe@kernel.dk> <20211019055701.GB20805@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4eedbffe-2866-fbeb-14d5-0b3a22139e6b@kernel.dk>
Date:   Tue, 19 Oct 2021 05:58:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019055701.GB20805@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 11:57 PM, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 11:51:07AM -0600, Jens Axboe wrote:
>> Use a singly linked list for the blk_plug. This saves 8 bytes in the
>> blk_plug struct, and makes for faster list manipulations than doubly
>> linked lists. As we don't use the doubly linked lists for anything,
>> singly linked is just fine.
>>
>> This yields a bump in default (merging enabled) performance from 7.0
>> to 7.1M IOPS, and ~7.5M IOPS with merging disabled.
> 
> I still find this very hard to review.  It doesn't just switch the
> list implementation but also does change how this code works.  Especially
> in blk_mq_flush_plug_list, but also in blk_mq_submit_bio.  I think
> this needs to be further split up.

OK, I'll split this one up a bit more.

-- 
Jens Axboe

