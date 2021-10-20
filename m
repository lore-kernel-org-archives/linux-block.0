Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE50C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368C5610E6
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTOXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTOXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:23:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE9C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:21:34 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so6266739ote.8
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vsbrFJfS+jP1Jg/HuA7LaV/hjtXfHzWdpDcH8c5NrJY=;
        b=bFIvbA/fXdaWkA2KtNOtw4/WvmZbq07UDN1KIT2PbNde/vqMfnkM6RgwbPChN3IS2s
         l3NldQliO86DwdiUR8zI6G3BxANldzBmgStYXEd3LNb2d4akUJezpo+rPlxpiUp+SGkH
         lA71FRoKFRxhKdwh0cb86r9oNnUnDuY7l30cz6MN1dt4d0dypKZeQOBOrFMgv+M1VPSN
         5demsadrBc9yOdTpiEKi5rAVLtiHBeJUCnCxBcektYc/PAp0DeAyI7raDtkAf4PhqOu0
         MLA4nDcUVBaENEXQJqTE1pqbD/ZgT/boe7q/SjIOs5YKD7DgCgdPPpn8pzVygRAiRzD0
         kaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsbrFJfS+jP1Jg/HuA7LaV/hjtXfHzWdpDcH8c5NrJY=;
        b=HdJp8ILFqrVYJUHmlTEH6TI3wN9FoIK7ShEVnLtTKech4Zi2Qf7Z89qf0IjE+aXvN7
         iwTLeuNo9CB+14rbofAcHxblkEkwRDfEmIsig50eVFHfc2GgD9XMcNpMO/GeAKHFx7os
         lhxPGkX1NmSY766C4SvYSXnDg7rbvn6c9APclGtMKq7ZpbWlowoRV5PvkHa6HdLmCE7S
         gqKpH63eZDoCF+ZwzgMMl5yJE7AxYvmYKUxAocmBVVvBPyEhnLJx8qO82cp6h8CUPLMm
         QA95bZTw1F/XTuBDwhuf21Aup5lctS99FiA+dum8KQXV8Q/pt2VYPbTw5+OGmphB4CAJ
         prAQ==
X-Gm-Message-State: AOAM532QLLZ5eEp1skZzWKo9KAC0Dbzhx9NjKtsjOtc+qBdtyn6RasPs
        9VZqjOqoVPoegos4woUQkNxz94XkOyim8g==
X-Google-Smtp-Source: ABdhPJxbSlVMZmMau/C07hcFSAObqgwDfxt5rf7mm74pw1XPd9ltlsFG46DUmul/MNtTl4MKThdRJA==
X-Received: by 2002:a9d:3e17:: with SMTP id a23mr164176otd.46.1634739693420;
        Wed, 20 Oct 2021 07:21:33 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v13sm474731oto.65.2021.10.20.07.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:21:33 -0700 (PDT)
Subject: Re: [bug report] kernel BUG at block/blk-mq.c:1042!
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs80zAUc2grnCZ015-2Rvd-=gXRfB_dFKy=RTm+wRo09HQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b2ac8f7-495e-abeb-80de-3d72af2ac7e0@kernel.dk>
Date:   Wed, 20 Oct 2021 08:21:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs80zAUc2grnCZ015-2Rvd-=gXRfB_dFKy=RTm+wRo09HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 8:29 PM, Yi Zhang wrote:
> Hello
> 
> Below issue was triggered with blktests srp/ tests during CKI run on 
> linux-block/for-next, seems it was introduced from [2], and still can
> be reproduced with [1]
> 
> [1] 4ff840e57c84 Merge branch 'for-5.16/drivers' into for-next [2] 
> 59d62b58f120 Merge branch 'for-5.16/block' into for-next

Can you see if this helps? I don't think that check is valid anymore,
there are plenty of cases where queuelist may not be valid just yet,
but it doesn't mean that it's an issue for requeue. The check is
meant to catch someone doing requeue when the request is still
inserted.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b05a8f9bb33..a71aeed7b987 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1053,7 +1053,6 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	BUG_ON(!list_empty(&rq->queuelist));
 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);

-- 
Jens Axboe

