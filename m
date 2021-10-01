Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E791C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B00061AF8
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355316AbhJATf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJATf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 15:35:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD1C061775
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 12:34:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23so7263740pji.0
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ro8iOwfopNiXVIntVOBdNVbsFsfISEozcMLqc1AhTz8=;
        b=PleXJeqNow371PmypOEyNQWu02xPu6HO2KS1KwBVvxHQd0Pvb0t6WQz7UB5e+JXI2g
         qDVsw3k4YR0bMHnIIUQme/FiF7fPqwxaRC8IY9w8s7cC8Oyk44ZcuW6S1v8AVJ6uxKDx
         x2yzGU2ouUD7NdRH4THACd2k7SSUFoaFvmj1XZBWZJ0k61UgbqbnQOWv3tzgbb6w4NJO
         BW0b2E+o1w6XOzsZK3E121VnwpV+2sqAZYnNJ2Rg61R1zHeiRvbLRh3GaYI5XGI3mrln
         6gqE2rlBA3My2etPuc8HXCxefoqPdCSEUx+9bXh2J9Aykaz81IUTt/uIgomu429lfn3+
         K/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ro8iOwfopNiXVIntVOBdNVbsFsfISEozcMLqc1AhTz8=;
        b=RrAp410K7KX2FvGsBaXaOI9zwtZwt4UNX/uOpP5cw/pgIGIXqOTVznbeNfVgoQifbv
         8ZXJwucHHPD0QiX/u/FvnefLP2lQc2pGegzdxWjpyzoTuaVFQK0iXhOaFVSrARKuLEen
         aSDHzkYoyuG/VF0WjWcAn4iPiAkikpI7uutNasfVVkFwBLzBdS3kdCsCv5PaSUgO5CUR
         tLWL0RmK5okX1E+Nqac8biV0hZvxi0nCS7H7X/k+j6HDM4Q4OZr9etvMTIpDc618wNi1
         t9Q1/763SVsK3e9I3AzzM74uZyEP4RcI0knh4ecjnYNbwa8WkDGgmWlz8ml2Hp/mM0NO
         swqQ==
X-Gm-Message-State: AOAM531rNZgtHPUQjpdVKcWRw79UDitGDJloDfciQPHVUkI5VDzYJIgw
        TIG7fIgiA2HBpeRoenvyQQCexA==
X-Google-Smtp-Source: ABdhPJwvmFV/6aaZ1fuPOyLCI4asHxlJmusDca5epowSQQq45pxYz9o5aUkpJYLJmBqwFNk3HT+DbA==
X-Received: by 2002:a17:902:c409:b0:13c:a5e1:cafc with SMTP id k9-20020a170902c40900b0013ca5e1cafcmr10985061plk.52.1633116851555;
        Fri, 01 Oct 2021 12:34:11 -0700 (PDT)
Received: from ?IPv6:2600:380:4a74:fb92:622f:875a:688c:3102? ([2600:380:4a74:fb92:622f:875a:688c:3102])
        by smtp.gmail.com with ESMTPSA id 26sm7996404pgx.72.2021.10.01.12.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:34:11 -0700 (PDT)
Subject: Re: [PATCH] pcd: fix error codes in pcd_init_unit()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211001122623.GA2283@kili>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dca58d05-67f0-c8e0-5619-42fff4224f50@kernel.dk>
Date:   Fri, 1 Oct 2021 13:34:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211001122623.GA2283@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/21 6:26 AM, Dan Carpenter wrote:
> Return -ENODEV on these error paths instead of returning success.

Applied, thanks.

-- 
Jens Axboe

