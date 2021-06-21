Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A09C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA95261164
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFUQK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUQKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 12:10:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E4C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:08:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p66so16426293iod.8
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OlCOy+HeD0rN5WnuF7UNheKbb+x7CdKtiEN/ib6DAGc=;
        b=nk/K/v736t7tgQbi4fKvxJbk69XoezM/RDnzm+woo4Ihgmkv0V/PNn/KrFIqnPROak
         0VwfmLpvr7/PxlHjVd6mpXPzRCRPxeA8ufUipVzpLSMTars4mkxbZ7r4N/INfFkM+K+L
         9Y7xynd0caPsPqnpShmz0JUHhjs8CX+ct7qCFUIONcTVSOoB9NuX9SiXgloSLOXtMUWt
         vvWXcpTj1YoSv4CJbYYA3xmArILUSDF/XmdOPH8tT4WNGJuLxICl8hhJK+I3XlrgiQJh
         SUEE+T3gFTtvZbYPN7mjUpS6vQ/PS+FMyakgnmlEy0innk9frwyu6KwsvCJUa1+So3+6
         NMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlCOy+HeD0rN5WnuF7UNheKbb+x7CdKtiEN/ib6DAGc=;
        b=QMctlm+w024+LF8oDXiknKBsn4oESYjzEZku9dWVwRqND1vZzGqUL9A/OisG6Lbzwa
         0iY/9KlpltuZQZr8NcSCqgka1kQMm4gLOgxh+8/AQIFj1cFuQUxQdTCz92gAnDYwtnRm
         Xgldbt5EtOExURDlofa3RPPqCgd66p4N509nEp4c862Rr1bmpko64pZX6s7jn9/ZDLD7
         wsH1WkbX7FdAbp9X6NKNBbtus9iiji19j3qMep0hcJ2qDGqjTqOvoGdKvYwA7lVVW9EG
         91l/eR2i8Wr6Qczp6JcJgguVGHLrAvgXC4HiQRlRD/iljv0KXTm0iFFGJZsRZbZbaHx7
         xGvA==
X-Gm-Message-State: AOAM5326VEj3f8BbqOCDrciD5KFoq2BAQKHSLvk5zt5hjR1cnFyJLvZL
        xcD804OqoqRBNFTk9mikasszLeo3dbeQ7Q==
X-Google-Smtp-Source: ABdhPJw7GMOu2YIDQVXr+m45vazP/BWgabqyV4P6eXHb7lrtN748i81jWxSafG4j/1BdyvLR9BWL9A==
X-Received: by 2002:a02:a817:: with SMTP id f23mr7422871jaj.101.1624291690445;
        Mon, 21 Jun 2021 09:08:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e14sm6317948ile.2.2021.06.21.09.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:08:09 -0700 (PDT)
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com
References: <20210619140948.98712-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02db63cb-9cd0-4068-00db-dc37314faea7@kernel.dk>
Date:   Mon, 21 Jun 2021 10:08:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/21 8:09 AM, Paolo Valente wrote:
> Hi Jens,
> this series contains an already proposed patch by Luca, plus six new
> patches. The goals of these patches are summarized in the subject of
> this cover letter. I'm including Luca's patch here, because it enabled
> the actual use of stable merge, and, as such, triggered an otherwise
> silent bug. This series contains also the fix for that bug ("block,
> bfq: avoid delayed merge of async queues"), tested by Holger [1].

Applied, thanks.

-- 
Jens Axboe

