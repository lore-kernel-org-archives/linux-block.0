Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B4C43217
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 01:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbhKYBuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbhKYBsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 20:48:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BFC07E5C7
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 16:56:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v23so5459430iom.12
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 16:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQECEZaOSnuAkiPU2V5NI9wzqYl9rSxziHehNSDY9mc=;
        b=yEj/CgFCl/hr7Oo3i9m5Nq1jZp8DDu5fJZn9grSTIdtkREa9BgrmMdMoxW7Hk9w/Rc
         4RSM6Ui1OmasykZGf3GtxV+dvcW7MOBJ6E5EgQpZ1Aq9n7pNRrRnz2v0LcCrhTqj6jcs
         +tetlBrOZb0QPcTsvZGx8HRaGIzbm1pTvGMym5EdjReNaHQz+eluzHtkLsnGNv/Mjjlz
         pXCuS+S2f7gm8dXB+TjZnZtVlxV8L1Eljkt4Wwdf2qLnTFjQHh/AwAZo7+vcmOiR49g3
         lNaAtKzbQIFdxFnLWPt3ZElqk3LTjgc0qB4a9DwG3BYAFBnSPpVs4BkOzf90NrKorDtk
         +8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQECEZaOSnuAkiPU2V5NI9wzqYl9rSxziHehNSDY9mc=;
        b=Yi8AnwxyvfQJWWiesYQC2NOVpQdOY35Y6qdfnYATyZKgq6NrMu0s0Bsg9b4ddJ+nVf
         C/W10I3Nh5rbeMgvbbG+ErkgG1CobEQRqj/gGomkJuHE9h281zK9A/cYL0/crdJfD2qz
         swPbHOXmCALULNqmOt2qHiBKjtxUa9yQB6ay7Gcplahhs6U58fHvDE8J30KV0fe9FTXQ
         41uu8I/cz1tIJvWv1D6vRuHu+PJy9kIBqMJvxxIXillBd/NWPQwARQ6VvL9EGn3GP6OA
         ED6klUGVXORWKJrVxPP1qW+dLPLGTJbAScD1kv6p6h+jrSFKlG97LjAPYMKjYkcGSoq9
         lfqg==
X-Gm-Message-State: AOAM532dlpCP6za0z70wMu0CAO+ER6fFTOVxm6H75u7DcfoXJTJ/+U7z
        PfnjdqYaIV+zIT7QUzthKKQAdA==
X-Google-Smtp-Source: ABdhPJwWVqRdKf3NBnTqyTGlkAHlIY6XUp+YcgmQT7OkghhTzfdemlFqdTBdXPGbLVqoNQM0fCzxnw==
X-Received: by 2002:a05:6602:19a:: with SMTP id m26mr19954552ioo.162.1637801808369;
        Wed, 24 Nov 2021 16:56:48 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v23sm778469ioj.4.2021.11.24.16.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 16:56:47 -0800 (PST)
Subject: Re: [PATCH] block: fix parameter not described warning
To:     davidcomponentone@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <3ece7228314e89177d022cd514215d8c76485fb8.1637735436.git.yang.guang5@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0145c2a3-4648-ef7b-6f7f-d15a95231327@kernel.dk>
Date:   Wed, 24 Nov 2021 17:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3ece7228314e89177d022cd514215d8c76485fb8.1637735436.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/21 5:54 PM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The build warning:
> block/blk-core.c:968: warning: Function parameter or member 'iob'
> not described in 'bio_poll'.

Can you add a Fixes tag as well?

-- 
Jens Axboe

