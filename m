Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA8CA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1FC20679
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z4QNmvIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390659AbfJXDlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:41:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390576AbfJXDlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 23:41:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so2679697pgo.0
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zwHGAGSuSHidG9tIwCEU1uoNu5Fa29oag25M6q1oS4o=;
        b=z4QNmvIxM8deAwXsqiRRKIwCsgsi6CeuScWhfRDFR+Tr2iapBdN5B+cEGNFP1CsLaa
         e6ivTuOhEIz5633m8Quwj47+4pIvI6WmGXeIuJJidMCVw/qQ8t/6aJ7aSft8nWe2hUyY
         JJ5APWRHqlHk9/nGlneMYTj0tCdY+k89tsI9RRH2tUEb9pZoFG74/zjZ/Yyj5GQH2gx8
         MacTfAP+20MJUC7SBALQi5WvLVzvo8+fUIM/zifONixImdqKI59ip6UDtQaCOlkzEyds
         4YqH0t7CIqzpo/G9VY8W2JIOZtmV8m6l8019sZZV1KeOHr8sHP60UDDjQgtldjnxNLhj
         VljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zwHGAGSuSHidG9tIwCEU1uoNu5Fa29oag25M6q1oS4o=;
        b=p5raFGtbsCKo6CPyN3wpryqSWvQhqIIT/jpDSWNtT5gVOWwOYl32/XfrAdYoi785Rj
         2rEcJcYRVttl8S624N9s3N1sD/2GhKNIzbHcbKA+9ArIWo9j0hWEBX1+4qJsDTaR86Cg
         M2p4rhqDvts9S+DosTodzJ/on2llj0TsyZfe8Mj/ALNclAmsNBnrP9741ABQipl1My51
         qrZILRl/dn6LNVOMMmjKiMw498bNaCtIQ9bgLNSv1sXdEKir9+zsI+VQGZ0M9rES7cxG
         dQTDd6UIzd69dn+H/w24ewZldnuxruH9CttbpbDt5hOvopIuATR57kmBi0qXUz8ublDq
         UkPg==
X-Gm-Message-State: APjAAAWE6zakSPEBgVSq6CESOhEKf1S9WIi5xgdOofP1hu+r0qAPv9SE
        aNpcbKN1tVq0V8mLTxY/4YWXPjytNvg66g==
X-Google-Smtp-Source: APXvYqxm37nk22XJrjNXb77yzg7YTWelPCCHRdbgLNK7Gk2Dfn9QgDAUnowzRZUQnAtg1fWeO1P7sA==
X-Received: by 2002:a17:90a:9b85:: with SMTP id g5mr1728643pjp.95.1571888496528;
        Wed, 23 Oct 2019 20:41:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a6sm6314170pfn.99.2019.10.23.20.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:41:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring : correct timeout req sequence when waiting
 timeout
To:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-block@vger.kernel.org
Cc:     yangerkun@huawei.com
References: <20191023071009.13891-1-yi.zhang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed1f6549-00d0-1376-5d55-370e0fc0262a@kernel.dk>
Date:   Wed, 23 Oct 2019 21:41:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023071009.13891-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/19 1:10 AM, zhangyi (F) wrote:
> The sequence number of reqs on the timeout_list before the timeout req
> should be adjusted in io_timeout_fn(), because the current timeout req
> will consumes a slot in the cq_ring and cq_tail pointer will be
> increased, otherwise other timeout reqs may return in advance without
> waiting for enough wait_nr.

Thanks, applied both patches. Will run them through some extra testing
tomorrow, but looks good so far.

-- 
Jens Axboe

