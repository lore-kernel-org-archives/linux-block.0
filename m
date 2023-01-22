Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A270C25B4E
	for <linux-block@archiver.kernel.org>; Sun, 22 Jan 2023 20:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAVUtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Jan 2023 15:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAVUtE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jan 2023 15:49:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5A1C309
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 12:49:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p24so9618007plw.11
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WJZMQA7v4Th1qcxlhjbVBkGKPGVYQAd/RZT7qOQl8U=;
        b=kt0tafUOm0RxWZP0+BbaOKGRYiP89lUi7mOxliO2REmvNBNgn9fWT/DAzXu7XM80pa
         rPM2c1goiHbQvBrorvYNcJrw4hH5ecLv9x5JD3v3ge5Q7xOmfjLweHJfYaeMxVKZB2De
         mO5XMZz42JyiZZPhCDrr3U2JXm0lhDXDjXqETAxBrjxTMNUQieZldZbCnW1k8I1nnB/V
         CIdwKKY9zbKcppBWDB7ZuScmHMuhVjtGvPNuCbDluI7dU/71myIXe/9ncMi4g4D3ufbr
         quI/wu9Iezx4w6+VeE5QV60qhFYxrPDYtlH925ztGlqdwqW7MCjWE+isA3HWV6r4qc2H
         qItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WJZMQA7v4Th1qcxlhjbVBkGKPGVYQAd/RZT7qOQl8U=;
        b=34oHnPtDeTJB0Sb4WA0mP4+58ZknNncbcbiMrmd/6IG2K59avpCo4HKvKRhAW9ATP3
         T/czOXLQ49AuxFMDvDmscJA+5h058fZUfASjMDYAK75evuhe2DmvFUWl+AHF4Atrt5gU
         BTgAG+2r6KtjBR9+T8O6VjQgVHtqOhsEG9fWX5t2iQW9EBWImpKHZ+QT7O2u3nEUdn95
         9woCeUcu5lOx7giNc/hHpAwMF45Y45PqtDqZUa8ot4xDhB40Pumlb5oNF7YiMb7yO9pL
         ulWv2zVdVp8++/So3gtUmTqoU/NXNt8s8NWHFW/FsRy5Lb15kQL1pq3ZyW21vYz2B6Pa
         leBg==
X-Gm-Message-State: AFqh2kqhfzpn+EyOeR5fqVgpJz791zvGx0htIiUNsdtx1ugfn22me1xy
        mJV+zMct0OGsm3jICsEajQq7GQ==
X-Google-Smtp-Source: AMrXdXvyQSV+qYXNvJm+cGGxO2TAXRsOirLpHAx65emFQK0O6KYlUqfGqEx6JIp+BtRNcviWHOKlbQ==
X-Received: by 2002:a05:6a20:429e:b0:b5:f664:b4bc with SMTP id o30-20020a056a20429e00b000b5f664b4bcmr7108121pzj.2.1674420542819;
        Sun, 22 Jan 2023 12:49:02 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b00581816425f3sm29636220pfc.112.2023.01.22.12.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 12:49:02 -0800 (PST)
Message-ID: <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
Date:   Sun, 22 Jan 2023 13:49:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
To:     Tom Rix <trix@redhat.com>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230122154901.505142-1-trix@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230122154901.505142-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/23 8:49 AM, Tom Rix wrote:
> clang static analysis reports
> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>   is a garbage value [core.UndefinedBinaryOperatorResult]
>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         ~~~~~~~~~ ^

Has this one been compiled? I'm guessing not tested...

In any case, this code is going away hopefully shortly, so let's not
bother with changes like this.

-- 
Jens Axboe


