Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB8B61052
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhJUPQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhJUPQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 11:16:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6FC0432C4
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 08:13:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso869524otv.0
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHnVkHqSj5BwwhHAlhv7wAcGZEnrphj2uouVF5jVP/s=;
        b=sOlAv4ipGzcArxwkp54XTdEqr+Rdy+Mw+N+tfFcUGHGrbCHrTP8Vzo1qFMPI2SmQRz
         nLurM1odMHo5Z2MR1Y+fIj8BsOvd06PasMR5EqAqUNsdep6waT+zC7fLWCOqkVYq0XWM
         OPTu/XceL/pBNEAsnpA22mEqL6iCc1gTTT5W0n2IxEdWozT550zc/aE+GARkODcn6R19
         2dVtgtR3w94a+hRxBZme0NFkpp1jV2oIdbGnM3IRPpqCUBJKPQh0AF9OBlcT77ORXwXg
         EqE30aOPGZ83XnohR0xca/AFKY6J77XytcXNow4qd6e9d6tUm53pPcgg1jiSYb1U09dm
         Xh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHnVkHqSj5BwwhHAlhv7wAcGZEnrphj2uouVF5jVP/s=;
        b=H3WSKH05SF4ts6i0gKZw3KlU8/l8lbaRkLMJ000SQe+QKmHD35xBxn6A/RtPTbrsSR
         DqvllgJyx6wBEzvm7KKCO9F6Wgor8ReznWHto4TInVF79YWh1ycc/0Tixi82xVq0QugO
         hfTiF1gSyAb1WQtMU4zRDRjE0zTZRnkEmOV+f6KtfXj22aVCm3txAbtSn2GiWzHHCzf+
         9BaON02oje9xLzOdrGSOYyt7ivpJy9XkSAOsd/k91i6Nklj0gmMU5ZSAVwzwd8tXQXhv
         HUgQ7ONFdoeu9Lz/+oaEf6mWfro5beAVZ5Aov8PniJa+MY7kL67TqbB2uicNrTjYzgKd
         u/EA==
X-Gm-Message-State: AOAM531jxYJkPMHpoB60xkP1M6WeIrDnTFeaWoZFVrvRY+CxcvchSOOC
        dYk/YwDAUSH1r7rdZcqk4lpuk951Ps4k86hN
X-Google-Smtp-Source: ABdhPJwKEJu+DEJtf3r2oj6Zo2hVUWDcklyzGD5PtpycXduYR7gV+IodmAmMDKxiPX8lPlYypO2JqA==
X-Received: by 2002:a9d:3e03:: with SMTP id a3mr5267633otd.39.1634829211627;
        Thu, 21 Oct 2021 08:13:31 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id v13sm1143141otn.41.2021.10.21.08.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:13:31 -0700 (PDT)
Subject: Re: please revert the UFS HPB support
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20211021144210.GA28195@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84fac5a3-135a-2ac8-5929-a1031a311cb7@kernel.dk>
Date:   Thu, 21 Oct 2021 09:13:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211021144210.GA28195@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 8:42 AM, Christoph Hellwig wrote:
> Hi Martin,
> 
> I just noticed the UFS HPB support landed in 5.15, and just as
> before it is completely broken by allocating another request on
> the same device and then reinserting it in the queue.  It is bad
> enough that we have to live with blk_insert_cloned_request for
> dm-mpath, but this is too big of an API abuse to make it into
> a release.  We need to drop this code ASAP, and I can prepare
> a patch for that.

That sounds awful, do you have a link to the offending commit(s)?

-- 
Jens Axboe

