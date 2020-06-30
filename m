Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D8C433E1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2E62067D
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vIyCu074"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgF3TAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3TAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 15:00:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A29C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x11so8831193plo.7
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRcKUYv8vLMl07E2wdlABymQJFgrXbgTcbsQgAon5/Y=;
        b=vIyCu074YMPyf2Ko3ofarVXk/Wxbl62AqwQ2UDR5UU8SRPqmxHf+1uFctP73i4xGPC
         UM553wn8Jn7Gk7IP4wsYjza2xy5UHJ9ppYcm6xqsmpPYSzMvX5MI3I9jcHzI8qh1ENRr
         RQh3zxcGI9lITyz/c6TlyJ62hLloJACxieH2CO9YJPxUfEnERzIVnVpoyyuLnqABUzc2
         09OWpgauhVKk5aAcaly00m/Rujet839tXO72Wfoe8CtvLgFmE0jZ9v+vLMptv6Gm2sa1
         BKCOPatyl/v4JwP7ZO5xvW2g1d755NzL78E+wbW3nNQFmF0bvWSogT/g28bJP0wQ5err
         DAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRcKUYv8vLMl07E2wdlABymQJFgrXbgTcbsQgAon5/Y=;
        b=ZeVk+ZpwSIaUNjcaS20l0lhRRKtH4IJuVZsysKUC2ezQ3LDDwZBQrbbSubXRBgK8kL
         p1y4dH+HfjYoqr4WsZYxsZ8YKifygeYZWk+H6LfQ7Bc5neSE4JFrmbZH5o5wPNkuiSfC
         qKbiyyf3nSbNqWLFMfwX5uW8E/cQhLn+Gv54KAsYURMjB6vkDwKnZn+cpurZKwPU/hK5
         GlLUVS7jNzko3JMRIoZ1pOanLkr+efFKUXk36PwK3edpAS8PLvsmrOP2bYSLjidKIfsb
         vEqpmWPmBztFmZEiIOzBQEZyyoVT63pHtBxJhf8RE5cPcZXN+hg89ysZ38As7BwIaUNB
         uI4g==
X-Gm-Message-State: AOAM530G0cxyVKC8cznWcGQMEgjzip6EC5EUT5amIyIedGLoF5NpItPG
        sBDyzqxWOhDYp/dYSDkqdq8mfQ==
X-Google-Smtp-Source: ABdhPJzsjTFT0KHYgvipUVj/IOy0DkeFygIVTw7V0JqjKb+vc9JixphbA5csC5gy8bdDgwbaF2EcvA==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr23711760pjb.110.1593543623094;
        Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id u188sm929814pfu.26.2020.06.30.12.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 12:00:22 -0700 (PDT)
Subject: Re: [PATCH][next] blk-cgroup: clean up indentation
To:     Colin King <colin.king@canonical.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200630155441.518850-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a75d74f9-88a6-7bfd-d0e2-b4f05c8aa7b7@kernel.dk>
Date:   Tue, 30 Jun 2020 13:00:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630155441.518850-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 9:54 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that is indented one level too deeply, fix it
> by removing a tab.

Applied, thanks.

-- 
Jens Axboe

