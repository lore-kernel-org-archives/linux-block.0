Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35662C433DF
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4187214D8
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EXeSCJlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgJMTMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMTMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 15:12:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09BC0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:12:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l18so299933pgg.0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CIUw9wLfc3OZIwg0Uswy6MSqpPUNtbGdZo6diLuevVc=;
        b=EXeSCJlDVG9TCpBADW8wsFfEAvnVjHepPWPVcg3NIrEuwsKLf6vzdNl0dlyN2C7xaY
         nwbyhAPN+29WdAmM9JdTa1oU6pgF3JqYy2eJum0h2c4IB35tFsqHPgNHBNMuPRCV+gLD
         LLdK6bQ3ICjAI1KuWlCNh0gRbS5NU+o411j8Y8jK2alh3aFULadINjJMQi39f044+gPs
         JNe0orhgaveZJTmSZNFKao3PR6SXN0KpNTbeHsMmiIysPxOqgAVNIELrcTkPIvAy/6iD
         dAbmOWP1cuabe7IzPib/+ZVI5Ct+R0ApbBP098NnT8YvgX4bhsatwCwJvqNnbMNRtpPo
         SwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIUw9wLfc3OZIwg0Uswy6MSqpPUNtbGdZo6diLuevVc=;
        b=FVliJfQW6USLP8aNqstoXB3xkInagCUvjLI6qmkqWu9KtnzOqr4IWYmwLd6ccLrtzj
         PBRRpFEvyQ+UH+uhZvHxZvTffFtE2l8JcuIFiCvk8c4K8P1DRnj5CYVR3cQtzzgW5X8J
         +eLWX/ZFMHWLz+LseXxHYCbH1rz4nsel+mncQ6PZRKuwsreF1WgfbMV3LiUM4FGJ5PNW
         dcp2oh41ZpmxfDiQ/AiPQRLbw54GBFLfVuo+uGWg52HEUKeQdh4/yAduHD7Oyt3f3MB9
         LdWq4n4RhlHdkCdZtyFQlcoydis8pULtN5UsPRfzwTqAOICGacPFSqevw100PTkCwzy3
         +fAQ==
X-Gm-Message-State: AOAM533yQdgc6AP3yYHoWNEQyHkUh3tXrdnSoyiSgODQeaMMIpzsp9Lj
        yqfeHSF/QJIP2F6oLHqm4QcTSQ==
X-Google-Smtp-Source: ABdhPJyhAEdx3kXb4x/uh73WpkkE0fKigWWIsTZPI9d101pzSUD3B7hTrUhg/uUS9AUir4IhYkrKHQ==
X-Received: by 2002:a65:400c:: with SMTP id f12mr831973pgp.355.1602616368957;
        Tue, 13 Oct 2020 12:12:48 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d9sm661579pjx.47.2020.10.13.12.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:12:48 -0700 (PDT)
Subject: Re: [PATCH v2 06/24] blk-mq: docs: add kernel-doc description for a
 new struct member
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <197771e2-4344-91aa-1ff8-3a826f7f7235@kernel.dk>
Date:   Tue, 13 Oct 2020 13:12:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 6:14 AM, Mauro Carvalho Chehab wrote:
> As reported by kernel-doc:
> 	./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'
> 
> There is now a new member for struct blk_mq_tag_set. Add a
> description for it, based on the commit that introduced it.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

