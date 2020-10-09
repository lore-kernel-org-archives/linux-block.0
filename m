Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91BC433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A146222BA
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2B2Icuvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgJISqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbgJISqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 14:46:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86FC0613D2
        for <linux-block@vger.kernel.org>; Fri,  9 Oct 2020 11:46:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so7587261pfj.11
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DvcPVK52TeNGe98XcbxvkqT3utUuhvx8w1/It1iKwEY=;
        b=2B2IcuvnFVgxHqo1kutPy1Gw0AqK79pzvXF6mUZX3GfTzQ/i31LqvwPiAIknrVTBSC
         a6gbVSFp34Ic3S4oG5bbubPTfvqv2NfdryMsXx6uoMHudUtqpjpJqmXkYn75oAL24SWC
         5a6D1kD0A2SX6mZRVoE5ClYo6KpbFXLW78FnPwL8URFtR8FgAY9ha3/sbvftE7y/wAOa
         DsuZlEVfEKvuoModoTWjcIemDCp1nKuF2OBXhU4wh21y6+/mtU8u4euj0B+4HYTtLS1f
         FJnblch/iSmgukYy3cPTn15LzV433HDSi2OOlIGcgco5/SjcGuwvsUufGOaRWYJzGaHc
         hP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DvcPVK52TeNGe98XcbxvkqT3utUuhvx8w1/It1iKwEY=;
        b=Kf10SHqI81swS2fwXdwfME8zrLI3CkI9VMd0oUYbu4pB+kzW06dLhWyVl0L43rtvM5
         p6xaHEgwk25Y6NmEJwody6zkVMTTgP5wYp0cXZhhm0cqOyPjfX6FhpFVw2Q/t1C0w2gZ
         zSG9sTdRsUoGtv9uHD7IRvsMZWjh9UaFaFLokrBpLJL/uEq69egtkK28i/7g+53fZ4l7
         wjT8qAcWv/FbDavHOPdHboqPkV2Q+09eNb1nYhYDyz9neyvPFINQ6X3XmxeVZdUQkm9P
         gfGKp50U6/sWcoEjMXv1kVoRHFya1QQTrVoDhw9289WwNp1MBWJ4+3HzmGunBfiKOQUL
         yIdA==
X-Gm-Message-State: AOAM5333zfP5BvRNoGHxdxLM7YQJ/KFHrzv264ghesHp8fLqntKAOtX1
        U9AX44uatUCIsxUFwNlUqu44KA==
X-Google-Smtp-Source: ABdhPJwf8GOLGvume3xRY7oSa3O7Uo2JdCRLzeltY01exD4qH4O2ABj6D2+2Mcc+VMZHneC/88DTlg==
X-Received: by 2002:a62:7f08:0:b029:155:79a4:1364 with SMTP id a8-20020a627f080000b029015579a41364mr6748421pfd.38.1602269206388;
        Fri, 09 Oct 2020 11:46:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p6sm12674785pjd.1.2020.10.09.11.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:46:45 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move cancel of hctx->run_work to the front of
 blk_exit_queue
To:     Yang Yang <yang.yang@vivo.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20201009080015.3217-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab2c4655-0ae0-f5c8-2d59-5e699fe9059e@kernel.dk>
Date:   Fri, 9 Oct 2020 12:46:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009080015.3217-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/20 2:00 AM, Yang Yang wrote:
> blk_exit_queue will free elevator_data, while blk_mq_run_work_fn
> will access it. Move cancel of hctx->run_work to the front of
> blk_exit_queue to avoid use-after-free.

Applied, thanks.

-- 
Jens Axboe

