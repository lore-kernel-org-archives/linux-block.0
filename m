Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D3C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E46054F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhHMPpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHMPpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 11:45:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA0C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:45:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dt3so3571830qvb.6
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9++UQjluYFHNVHpmQPx1jgqFcnRfQdNLC3YQP9GS7Q=;
        b=pKtoEC6bxELQk/aJyT64Up3tnNBPYcWkLLIvJ7A1sujHclj2FFZpimAIv/QzdlAR+l
         g21eYJ8Bg+7IflnlejX8/YVlYXsJil24EiN4v+5WCVxuUhogCZkdpw4At4zMS+3aKxBn
         uzffAW+HYXtCKI0KIwbDJDK89xd3yQqSttYtWGSVTrPBo1iaAguLhnv0wlmM7aYJlQkq
         FI/l6dFCKPyThFrGTstVPDPTl8TJ8TK/e0JrxqEdrcZ+4u2tvl7BQQ/PI4mD7wkbKFOq
         dmE8D2shm2kcuiDvD7LgHdmKBq/6Z5rPd6RFPEp0wscI/7cgCItEZSDraOfJbzyilIYg
         e//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9++UQjluYFHNVHpmQPx1jgqFcnRfQdNLC3YQP9GS7Q=;
        b=bfS2j1Hu+P0yMvfpkAmwZpoaIhVFdvTKpnMd38fG6GgOYqu0ZkrJMiVEPbWUYOK/9R
         SWReGwt1qqJA+8AVNECzW6cChaaqQ9bmfP3LHJ930yiPfvgZnSuDaLk/plSQ5X6p3lQr
         BEf9D/a5twhJdyCARyRDxXUbqN39zuAZf31sBW57VG8phx59ddNfFiJJTrAcKy/T3OHj
         bpWP60lM/TzeogLijCpIZ5JqvfPqFgPzsEN5BBWRDwi646XKxZKtcsv5VtgM0QPRDlTF
         KCh5tJ/JWaz7vf1zPTtJGwMRLvcbUNzmnGonqT9/DpqeaWDVOSd+szqPe2JVGAcXx3rs
         AExQ==
X-Gm-Message-State: AOAM532hFFOJ/sKL39SKzKS+SSue7ZSqcZQ2C62w0vHJYAkQo0o5hYEN
        nzxLeu+yPlzNz9LuFSu0h4T0Jw==
X-Google-Smtp-Source: ABdhPJx9RQY6Th0CkE5I3ByN04Wqooir3FdeHuj6MJzRj/u0jEm2CJDN2VDhOSanExV4MT47kFMfBQ==
X-Received: by 2002:a05:6214:e62:: with SMTP id jz2mr3280396qvb.21.1628869506897;
        Fri, 13 Aug 2021 08:45:06 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f17sm1065682qkm.107.2021.08.13.08.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 08:45:06 -0700 (PDT)
Subject: Re: [PATCH RESEND] nbd: Aovid double completion of a request
To:     Xie Yongji <xieyongji@bytedance.com>, axboe@kernel.dk
Cc:     jiangyadong@bytedance.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20210813151330.96-1-xieyongji@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <10f5ac3e-4420-2635-1edc-7beca28e9619@toxicpanda.com>
Date:   Fri, 13 Aug 2021 11:45:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813151330.96-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/21 11:13 AM, Xie Yongji wrote:
> There is a race between iterating over requests in
> nbd_clear_que() and completing requests in recv_work(),
> which can lead to double completion of a request.
> 
> To fix it, flush the recv worker before iterating over
> the requests and don't abort the completed request
> while iterating.
> 
> Fixes: 96d97e17828f ("nbd: clear_sock on netlink disconnect")
> Reported-by: Jiang Yadong <jiangyadong@bytedance.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Thanks for resending this, my email client messed up.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Josef
