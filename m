Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82B9C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjAJATQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjAJATG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:19:06 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE439F86
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:19:05 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so9555279pjf.0
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BTKr9QNZMIT6J8m+tw672huJIILDJ15WuphjDrv3U4=;
        b=kUzCZbI03GpQSA1Ss+IQS0ZB+9oVgQAk93p2t3O52ulq1Aw/XZrz17nugsKYMARxpr
         qeINGrCrjt7oZJrQ8ASTfKKNYQ5nRu2HohFJy1oKRqmEn0M/f5f1oiDPqVEWjtjqQ7TY
         DVIuhzfxSOI92IYcJi4vKO437kmoX6pXAoF/6J3j+4Eqv5XRMeAsvEZGGnMXDNcf/2MT
         7dtwr210/oVdLOgN3jbdQx/+U7L0Kkk/SoM/URpylDrPAra4mt8DnkpuFw7OU03JqO69
         0R76u3Lwzr3sUf265pUCyFNTXU3xmI3oUt0bxgM0e4at7aY7sjouzmiqnZRbEgzF6D1S
         hMOQ==
X-Gm-Message-State: AFqh2krKdhst38S8qVaxDc40iOliLhp4tixhxkrSPUJsqzJ66kBNCOSt
        8y+ILmaln4LVf0dOGheA1+w=
X-Google-Smtp-Source: AMrXdXtLu1W5QI8xFc078Ex3Ntq5TBv8tZzuFD4KB/SQN9r5i+3dEA4siTLdeBXewXBD/4a/MlilOQ==
X-Received: by 2002:a17:902:7c90:b0:18f:6b2b:e88d with SMTP id y16-20020a1709027c9000b0018f6b2be88dmr66881411pll.36.1673309945396;
        Mon, 09 Jan 2023 16:19:05 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id z10-20020a170903018a00b001868981a18esm6738053plg.6.2023.01.09.16.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:19:04 -0800 (PST)
Message-ID: <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
Date:   Mon, 9 Jan 2023 16:19:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 15:56, Damien Le Moal wrote:
> But my point is that if a request goes through the block layer requeue, it
> will be out of order, and will be submitted out of order again, and will
> fail again. Unless you stall dispatching, wait for all requeues to come
> back in the scheduler, and then start trying again, I do not see how you
> can guarantee that retrying the unaligned writes will ever succeed.
> 
> I am talking in the context of host-managed devices here.

Hi Damien,

How about changing the NEEDS_RETRY in patch 7/8 into another value than 
SUCCESS, NEEDS_RETRY or ADD_TO_MLQUEUE? That will make the SCSI core 
wait until all pending commands have finished before it starts its error 
handling strategy and before it requeues any pending commands.

Thanks,

Bart.
