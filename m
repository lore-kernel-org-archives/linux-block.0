Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D1C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8B12086B
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lT3YZPeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8B12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeKSNVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:21:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36831 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSNVk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 08:21:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so7274450pfc.3
        for <linux-block@vger.kernel.org>; Sun, 18 Nov 2018 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MntAUUWdNLXNytWXJiDinmcWZyIUrtuck+ug81Ol6YY=;
        b=lT3YZPeTeBG+L45gFUE5KCFhDlnOVoTTcS7oiVR/3Wcy6GAKuPbqrHDoKmqJVjDViL
         X2rd19OLSobmxERkXYmKpZ6Nd/aDwzQs+iT/Bxi4Oc8uczTFpdtIZrLM7qw4H7l5TZ8N
         G+IUTJK/q3YoW1o+AEddJa3YdXYXAZ16Q5Xmms0mdxFvHNKFNtYNSzPVuhCSJ/HklpKm
         DIeS4Npj1k5iM2dEizLv5FeDslERjleWHlG63rRb+P6FzzNeOSBE+fur+fq3MQmwfJ/P
         k8ZbDoidBPRsM7rGEP1e7mrOQCSbQvWGlEDX6qE7LjEjB56WCYkF634RDgpoeGRt7g4X
         WiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MntAUUWdNLXNytWXJiDinmcWZyIUrtuck+ug81Ol6YY=;
        b=ioBTpZ5QhWaImS/9o5HH1Tps12QpXOnpt5bTmagV/q3wslbPoXe4AGQMlKgb8Ixa7c
         yRriN1q7HiotycrOwHoR5Drf99APJZCfw88i1MFVux6TTJbGYp1bSfilFBf76pph8Yku
         vF3Jy9n1zwLcwgt2UQcReTUekQQmqWI2pA2oq2f+2U/cfZbvsD5X4Ix1JXJdVKkALr1/
         pzglyOrj4eJEwnI700MOOBIdqVhH76FXvLh4+vP6dXcfkmcRIUs+tFl2A+BJ2mTkvJ7K
         2Nuzeh6CrsylKLLtqFIg/XigqdURFvyC95cJxSeHZNF+wBWHCk4JPet1ELAPTNI2wjNK
         WtJA==
X-Gm-Message-State: AGRZ1gKjcz0urmudWlX/Go2PS8IAOMnCHXV8aqrqFhfJrnTvY2v6iDPw
        qySrECWTP3GS7f5nJ7xEGSat1A==
X-Google-Smtp-Source: AJdET5dOQFrt4BvZ3zIdZnymNJy2OTbtgWC8/YUDDMjiestfeLMMIk2dBf72ehmJjIbJs/pdiMijDg==
X-Received: by 2002:a65:4142:: with SMTP id x2mr16849792pgp.356.1542596370565;
        Sun, 18 Nov 2018 18:59:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b2sm48093416pfm.3.2018.11.18.18.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 18:59:29 -0800 (PST)
Subject: Re: [PATCH 3/5] aio: add iocb->ki_blk_qc field
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-4-axboe@kernel.dk> <20181119015921.GQ6311@dastard>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <031c304e-1b15-6a4a-b286-2d044f4c7faf@kernel.dk>
Date:   Sun, 18 Nov 2018 19:59:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119015921.GQ6311@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/18 6:59 PM, Dave Chinner wrote:
> On Sat, Nov 17, 2018 at 04:53:15PM -0700, Jens Axboe wrote:
>> Add the field and have the blockdev direct_IO() helpers set it.
>> This is in preparation for being able to poll for iocb completion.
> 
> What purpose does this field serve?

It's for later lookup to find the queue to poll on.

> And why add it to just blockdev direct_IO and not the other direct
> IO paths, too?

Only block devices support polling.

-- 
Jens Axboe

