Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F17BC4338F
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 03:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DA960F94
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 03:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGaDn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 23:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhGaDn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 23:43:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA48C0613CF;
        Fri, 30 Jul 2021 20:43:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so17945204pjv.3;
        Fri, 30 Jul 2021 20:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=oE01F0SF2I0CJYZNXztVGMTSrHuG1clp4AQ85RY2cJ8=;
        b=Bhoy9hgpDE7rm1g+FNTQi4ueRhpgTPD+nvjWT1fGTqHbqmegbgLgDHcTy2MpYvFajB
         UQTcuheBvkltwY2R3TW84GFKd9fP9gDSQ4W/w3oeLl+nPLKdGHlM3NoULNPODRonTfxR
         0iRJR5xwkj7xt2mdTXGBY14QsF542GwX8aLCieQNEgsxHybAEKgc5zaG9ok0Nnt+l4Iz
         DotKwKU2fYKmDQsxpPMJgBAkpHN4sQEncSzlj3GreDt8HRJgM6dAfhmLDavG+vnTeNBN
         GI/dOHjGAg9rj2pWtHPKsHeBopB2V54WCQ0wL+ihyYReXUTd9rx0/B/auPEFvAzd0ejk
         pInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=oE01F0SF2I0CJYZNXztVGMTSrHuG1clp4AQ85RY2cJ8=;
        b=VxhSKibuztL714DbRHZ3+zWTfPDEDgxz0gj/VRqoYrUZGTCypi/PHo7hHI3gbgqOpS
         aqh1+1YwxC+kmsETB9jJ9hHu1fzb8C6LmPc8WtFUgjdc5tOoW0qfaS3VaihVGrzAMF93
         kSKMhG22/87fPQg4obEQPWfWG7Zuk0r/mwOpt6lr6jA1Umh50AfF9GyQ5DHncuRTjNfy
         v2X7YCW+nqx/ekOblbvdxkR1Cb7i6jrg6TbBbCpNbAl0nIEnyTjBvsrqlzU+RO+oslin
         /LP/voP5MSw57l4J9V/0C9/7to6vru8nMC0G7BTAMimTi1ONhY5k3RTx99c0J7kJYwEx
         h8Ow==
X-Gm-Message-State: AOAM531ryYfO83JR120ZPbzy8ztAWvjk7rb4nFIrma5B3/XskiDSuCL2
        vC02wsoypa7G4c8NjHWjT7k=
X-Google-Smtp-Source: ABdhPJwoVxUjY2KahpW1sf3KQyY/0z8SltB8hE4mRZgWh2ZQksT9iQFLrnd34iSIV8zbzNtAhQWs2Q==
X-Received: by 2002:a17:90a:e7c7:: with SMTP id kb7mr6282781pjb.43.1627703001289;
        Fri, 30 Jul 2021 20:43:21 -0700 (PDT)
Received: from [10.106.0.42] ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id b7sm3855288pfl.195.2021.07.30.20.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 20:43:20 -0700 (PDT)
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] bfq-iosched: possible null-pointer dereference in
 __bfq_insert_request()
Message-ID: <37e54bb8-25db-6f93-4b54-7a10f1eb49c4@gmail.com>
Date:   Sat, 31 Jul 2021 11:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Our static analysis tool finds a possible null-pointer dereference in 
bfq-iosched.c in Linux 5.14.0-rc3:

The variable bfqq is checked in:
5920:    waiting = bfqq && bfq_bfqq_wait_request(bfqq);

This indicates that bfqq can be NULL.
But the address of its field fifo, which is an illegal pointer, is 
dereferenced in the function list_add_tail():
5925:    list_add_tail(&rq->queuelist, &bfqq->fifo);

The pointer bfqq is also dereferenced in the function bfq_rq_enqueued() 
which is called at line 5927.
Some dereference operations are:
5826:    bfqq->meta_pending++;
5828:    bfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);

I am not quite sure whether this possible null-pointer dereference is 
real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
