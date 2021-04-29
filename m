Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA8C433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7F461409
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhD2O3C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhD2O3C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 10:29:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAA1C06138B
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 07:28:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id p15so18550008iln.3
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTfQagdApWUfM/U2Rf47/ooIfsCgh5fL/vBRwfCGb5c=;
        b=GuACGPIllxVpNV1LkvEA7tAZBOHJ3wwuQqwRDoJctoqxa9xo62wAf8e9xcvhHqzwsk
         v6e3BzeH23m5fVktw1Ld3GfLQC0dy2BAaieMXJ9M594W0AFzBKr1eWD/EdVW5On+GQCN
         JvX4qnWiaAdL3CzTGYzGHpQv7PDAe4bxnViQoE8o91qBrFQY1py3rBT75ORdKLClEiTk
         +fqKdzP9zKXCxmXEaRHOG/xd0qS8uUYSIzTZnWHpvy/fSEzEHZNWQugRns+kxcmNZ3ZL
         Op3bwy61Z8UMFu3Dtj1MJMIhgKTCiT2CVlHL/0LLS76xEJtYkKEyQrOop820cF4NRgYX
         qblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTfQagdApWUfM/U2Rf47/ooIfsCgh5fL/vBRwfCGb5c=;
        b=Q2U2byK9yRNdykOqQGnGw1tZlT3rhi/u77DlWnFG37+UiTemtaxR7b1YxM9tg3reLD
         C5wcLMZgL50vv0lUgsm5hL+vu9Zkee/3IaRb1FzQX5ybDfEWJLV60WqotvbBcdD7JCcA
         iVHGQxCl7gj/i68KRQK1ea0z+KPyaofx5LHdCPclGqGj7B8PeMrid5jwh9GJd4lQn2EL
         od+chUQUd+Jf3qCe8DY1Di73BdJ0EO3PHzoaNtjJ8KVA9esaGJwD5Y1brwlr+MJbs13V
         8jxvjT2szCmAPMytammEvmyvPTJ7hTciPINcy0E4vKhrFmgqY6nv3q9no/wSH+DRa/P/
         Hz+w==
X-Gm-Message-State: AOAM530X7jb0LroEZoQZtRc9T4U9Tc51KEOi3IH63lxWB44WUXHOJEX8
        UeL/oKErB/cvqDZKdgk3VU3Xog==
X-Google-Smtp-Source: ABdhPJyVY/WeR4Ahw4RqbJyT+RSCXBBMn3KAasK0vAiaZ384bUzlX0mh/dZnM1aGhzASzLGXtARSPA==
X-Received: by 2002:a92:b74a:: with SMTP id c10mr25591ilm.72.1619706495286;
        Thu, 29 Apr 2021 07:28:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s17sm994611ilq.26.2021.04.29.07.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:28:14 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rtrs: fix uninitialized symbol 'cnt'
To:     Gioh Kim <gi-oh.kim@ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@nvidia.com,
        leonro@nvidia.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210429092741.266533-1-gi-oh.kim@ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59957d8a-cf37-f3ef-1abb-0713075ccc67@kernel.dk>
Date:   Thu, 29 Apr 2021 08:28:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429092741.266533-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 3:27 AM, Gioh Kim wrote:
> rtrs_clt_rdma_cq_direct returns an ninitialized value in cnt
> if there is no session. This patch makes rtrs_clt_rdma_cq_direct
> returns a negative value for block layer not to try again.

Applied, thanks.

-- 
Jens Axboe

