Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DEC433E6
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A7964D9F
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhA1Oen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhA1Oef (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:34:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB842C061574
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:33:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w18so4088075pfu.9
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=s/8G0pIfrzxemzeiVD4GkxI82+AzGvnsibV4H6ZREvhKAErR0KW0yF6f6G5MIp+ODk
         ABEm1aKAvUVJgyz+u6grfty+wsKgHlPEw11ngoZfP6Xemg19u5GNEPM6fah1KAQB7Sp8
         oXAPsFAqF0AWwrNEV7DNiL/RuDSPjd/SkiPhVdCOXPAq+cdWlAuvZo1m+CoqvVT5fFkE
         +mxqzgsqUuuzNWeUp+7zOWKQCn5MzMa/cB6yN6H8uCRA+ZbZJy/6AD2aBZO36uz/PT8z
         ja08dRmsk+qBPTSyDcOEuhxrz0M3eWb2dBdwGHM6HE/P84WBdVfjsW8BlI+NQU3rraut
         Z93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UJyCYyHELMaW+UVSUKIODWe8UUnEGgoP936EHMWBTE=;
        b=F4KHtqmjn3Un9eBrsjakMHNEZtnneyH2+z3jVUg7jLz4KcchCMJDYVa+h6/DwDj9KB
         Fm9wjcbE4Wek4HLc2kiTgvSioYZciLzqGQZ/791AxboVrD+nhZwC3zfOaNh/G1V4gd81
         swzPQEnCMl4sWPKZzkUds0mkzNaQ2heGXuNhhr/+fsDipzaR7GJIhXw5rj8zru0HxbaL
         eSBjDq1MmbxIhpxaYQte16UZd6kGgxB4njhVbKSSzkbWtdcKbiCAdSJvIKrjLPx2M6Zy
         6LEehw6GX5z+vDx4Rl9Xbgbo4CmCE1XTcvMqnnL47gokW0nQveyck5+7K4B9DbF8Gcyn
         nD5A==
X-Gm-Message-State: AOAM533POgu5zlKUeALO6kS7MDYLrlwCf3yGgB3XWQMl7u/eZAUWZCcD
        4BgNlUtSPOW7PGldRkEEPLnB6w==
X-Google-Smtp-Source: ABdhPJxF6U0Qzrc8Am006a3Fus+0a0hD/R4ejx1kyG1ZkdEuhQ/QEtJnyhwAAJwDlgcfuFPqTdCl1g==
X-Received: by 2002:a62:ee09:0:b029:1c0:ba8c:fcea with SMTP id e9-20020a62ee090000b02901c0ba8cfceamr15832892pfi.7.1611844434516;
        Thu, 28 Jan 2021 06:33:54 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 130sm6178975pfb.92.2021.01.28.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:33:53 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Remove obsolete macro
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd20b274-2fdc-7046-6571-d11e0a8cf0c4@kernel.dk>
Date:   Thu, 28 Jan 2021 07:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/21 12:18 AM, Baolin Wang wrote:
> Remove the obsolete 'MAX_KEY_LEN' macro.

Applied, thanks.

-- 
Jens Axboe

