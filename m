Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D3C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C19B20792
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bVKdU4m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFKPKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgFKPKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 11:10:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06539C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 08:10:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so2340923pjb.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/X/+kpACXvRRmwOF9itPa9xFOnhajqf8ulGsiMVdvTI=;
        b=bVKdU4m2RGJLj431IBJ9IrPrP4xrYzmUzo+VGCPj46tATsUxaOXCLcneqJS3gCWab2
         2d/lwDRCMtmHGgAgjjyhcXPd5RIEfKaAy8eKQ2vKy7GYqyF2t//cEmcYH6mxuxtWgZF9
         FUpzBwj23sECcBpqaHv6axyix+Z/MF9ed6C3U+zVPPEe0HF+AAmipWl4QIgZeZOFJQCK
         x5twinPxcJ/DjX0WMyWOnW4Kz+HQlBJB38zHRtpG/P7DoFoE/GOB83F7GDvVWKMr8Bcp
         iZcVxrFuZ/rXU3xNQ+vmT7cTtv/Uv+td11sSteiiQY8b3kuk880ERIZe2kPmFgBtuBDC
         hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/X/+kpACXvRRmwOF9itPa9xFOnhajqf8ulGsiMVdvTI=;
        b=AGM8jQHUOghC1vBRLl9HJEh638W/CGi6z3y6cliWd8JMYiw60pPJofbjBddX2vYxjK
         0PUDz91iPK4+c4pm+Q3MbnyxFQkfCMQ0+P3AAEuROy1VxmnW6qnulACYagjLuytv9Xlg
         XcH0vn0k+whkLpc+sAUxe96bAFTnTIyFszSfA47bPqodk3q5kzpFN3CW8srhXNVSaGNX
         npjGo5qw/8YgeHw9sDQPgQGmwwpnZNtmV/0rEKKKyx4xh12c/LhIScUI0osOd9zeOGwS
         dMQltFhKncwJNkYmm3D3fwfkDXBjHrxICkMJVZBZfcqL8jZdDO7UA0CXl81rqXJS/4R3
         WjSw==
X-Gm-Message-State: AOAM5303nbIovm9aJhgBE4cKDuNNl2P1LfhcynSAjtNUj6j0m8ANCGim
        rvxtIJzCPAlnHUWpaDc8C7JMIX+dSfbXdA==
X-Google-Smtp-Source: ABdhPJzRUlqMtsFRqGQ3yDymzVrbGrdzUxNGTf8zE2fVHizskDD6pQ9+BGMk1fcRsBvLUhILsMMo9w==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr3357374plb.330.1591888234845;
        Thu, 11 Jun 2020 08:10:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x4sm3517799pfx.87.2020.06.11.08.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:10:34 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200611062257.GA11119@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc90f508-5c46-b69c-cb64-aa7383899cb0@kernel.dk>
Date:   Thu, 11 Jun 2020 09:10:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611062257.GA11119@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/20 12:22 AM, Christoph Hellwig wrote:
> The following changes since commit abfbb29297c27e3f101f348dc9e467b0fe70f919:
> 
>   Merge tag 'rproc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2020-06-08 13:01:08 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Applied manually, it's way ahead of my block-5.8 branch.

-- 
Jens Axboe

