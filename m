Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E205BC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A517C64F69
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhCDU2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhCDU1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 15:27:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA01C061574
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 12:26:54 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z13so31214242iox.8
        for <linux-block@vger.kernel.org>; Thu, 04 Mar 2021 12:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFKn59CF1p2RXs/QYRNWRDnrQj3ENHOQmiAUNdwvt/8=;
        b=goAo/R7+UfioF8QKCapnUVAbDiE1D8ybcizf6fF+H1/dhyQJpR0Okh8peBp/uDi4g1
         /voaLbInCz3O/pxD9/cRPCP89mF7NQWHaesOZmw2xDeS9s6dr3k6OqAjvzkGMomAiV5D
         NHDdeNx/+o+lE7o5jSFKn2JwGZDv+JD95EL6V81iS5haFMGqE/oenUDESPXp+r2KJtO2
         WjeUswIzSEpLuqghJo2VGi7K9I3quUOhaQ3Yw8dXwjegLR6wDjD01Tm2/ZPJJXCWscan
         PE53HBYGkprlI7zmUUOtSlAnsHIuF+Ke5J6aFFbpnRFKMIy31m/yavKUaaoLKHyAgHA3
         gbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFKn59CF1p2RXs/QYRNWRDnrQj3ENHOQmiAUNdwvt/8=;
        b=QhGM4PnMKUbivW1/FXPfn20ce793fqyuBlsObfuaDwhhRaPpMZ/6aznPggOWvp+RI2
         tx4KihQ/f5oi/XxdJ7eX5NEuHKzQmW7zC/caFdqiGGSwGv/HNFBm8l26jwF69/y5rO2H
         WJ0/FkuGBkUgiAcamwlrr36uuGpM/IHJH+0iew/MfdU6lBHclyaXLZ0/2rfNOgFho6fu
         BGDYrlVOEd5FbrG/JDUIYnrKvMTyk0q5LhIM7PNo8wpRyDKQ2ZtXak8Dsx4z7MRWwxTi
         ow5t6c4Kqo+sorolKXl8YEVSpF4zglXLpdxA74Uz+PIrhbjb++pyN3UzYoLo0YJ7BzRk
         pPLA==
X-Gm-Message-State: AOAM531ULX38JZ77R+blWesjxGjMoBg6fmNmhvv4j4YobowGhsSwkVT1
        MqDG2MIPgradS9+ZAZiZVcAtnA==
X-Google-Smtp-Source: ABdhPJzHHwzOOuPqOOtNNPiTepGm3D6zLTMpZsCvsY80ZOdfAhQ1CplzfOYFKkFrYo1ne9Ip/jXGnQ==
X-Received: by 2002:a05:6602:2191:: with SMTP id b17mr5080325iob.114.1614889613494;
        Thu, 04 Mar 2021 12:26:53 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l14sm254530ilc.33.2021.03.04.12.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 12:26:53 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YEEf/hvMMuqpp63T@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55b373ce-304e-f79a-6904-dc1c1205a9b2@kernel.dk>
Date:   Thu, 4 Mar 2021 13:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEEf/hvMMuqpp63T@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/21 10:59 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-04

Pulled, thanks.

-- 
Jens Axboe

