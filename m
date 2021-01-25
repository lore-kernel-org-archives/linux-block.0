Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B2C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABBE2087D
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhAYBVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhAYBUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 20:20:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB94C061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:20:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b17so56911plz.6
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDCH8ssNvRh56D4K9BgC9iGmoQjBN/dPHMN5SJwmyYM=;
        b=AmEGBigeVqRqfuQsYXNce465V0cqwySPRdMKlDNNWGXL/qFq28BBfpOWJu7OoH31UI
         cvThXAc4uNYMfQ2fbmg931kPRmk67kpjeNnsj6m6dVleaPyszad48wnAUVsZl8V1CmRh
         t9Q4Tf+cnrGF4OmQ+bx8r5PdSNjKk3eVfu8jGXFq4Jco6wwNPzMz94hwhiTHrDVAnfPt
         8WevLcjjPtUHDFxcMK/cjeV1z3tDDUDikAvftyrTPCG9CHoFEruRzPLaaq4lzrSrsgNA
         w0K+ccAJ64KMCOXuCUP0wvAwtEylZ/fypl5Iv6D+w3s2S7kLAUNkSHTyHP+PQt7vuOj+
         GW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDCH8ssNvRh56D4K9BgC9iGmoQjBN/dPHMN5SJwmyYM=;
        b=neeBly06V/+3EHGWRJtktr4pszDhyrOmh80Ghv2YKKf7+chnjRtyvQQMA6Yn0Gnyi8
         qUCuYQyHEoLZyHUaEg+Li5gR2TV7ZCWUASYbcI20Q1m/YSFz9a+iFrd0K8aS7SVFSPKU
         EQrTiXfBYeHGdJ8CwtNaobfXftGgwVLxkgqe7oK9vFAVt0D+Jrqp9DQJWMhw/BtFWZKC
         xa76hI1TT86JTFFWN2Vy05FP+wtYVDONo7vevNfPZMhVKpjxy/VtWQn5GNuILoPNIo+c
         OQ8Rzxiig53XwtMRUrOva67lxi5I3s0Zn84PlPIH26BS64vniqwfH982AcNty0wc6V6D
         nzvA==
X-Gm-Message-State: AOAM5324/H7sHC++x9JFbuoS4+ybNNVVfQtw24YahAVESTkYRq4UQyT7
        0ekAuJtQRQSleIAMrcz/PNL9Hw==
X-Google-Smtp-Source: ABdhPJzqbYXgncDR2lnPCLJ+J0lzKzqnrGnBt5/XyieRAjPImZgsybsBWCQnwUTLGTVyJHow5krSmw==
X-Received: by 2002:a17:902:a512:b029:db:cf4c:336b with SMTP id s18-20020a170902a512b02900dbcf4c336bmr9248141plq.17.1611537613966;
        Sun, 24 Jan 2021 17:20:13 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i132sm7875777pfe.10.2021.01.24.17.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:20:13 -0800 (PST)
Subject: Re: [PATCH 0/2 v3] blk-mq: Improve performance of non-mq IO
 schedulers with multiple HW queues
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20210111164717.21937-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7afa35b2-cf35-a149-d325-3ad2ae8d8935@kernel.dk>
Date:   Sun, 24 Jan 2021 18:20:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111164717.21937-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 9:47 AM, Jan Kara wrote:
> Hello!
> 
> This patch series aims to fix a regression we've noticed on our test grid when
> support for multiple HW queues in megaraid_sas driver was added during the 5.10
> cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
> for cpuhotplug). The commit was reverted in the end for other reasons but I
> believe the fundamental problem still exists for any other similar setup. The
> problem manifests when the storage card supports multiple hardware queues
> however storage behind it is slow (single rotating disk in our case) and so
> using IO scheduler such as BFQ is desirable. See the second patch for details.

Applied, thanks.

-- 
Jens Axboe

