Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7AC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B0F619BD
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhCWQXj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhCWQXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:23:37 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD25C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t6so18687784ilp.11
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rWh3AKi5SFPZYfzTilgKq/RJwaJMU4SjT7+h6/AuhnI=;
        b=WGtYCALbmPj3DX9JRJyoxXSZACk/il6nthYFGpEHryoq58Ih91nCA5mA4oViGDLmP6
         5cr3PyMALQT4sZKcYkJtInrtdDEY0vUOS9b6Pqk2KUUov47fzc2aA05wYWPektI1STWM
         KJLgJEtmNrFJu/BOzAKT0yPfKVhkt3tj7oE1uG4xYinbkUko0yeweeVobEkuW8blVEWS
         eTuZ04ThCZCe2puzBxMTGDz3FFw2cFZca6IKEoq8YycSoZrHDy6sOaSYd63aaLe9tEVq
         pcTD0p24+UkvCJQPdohsXJMh+nVSVzHsAGkyDs5NrAHe5x/9z/k42Qw5l0cmBqBwPwjl
         xfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWh3AKi5SFPZYfzTilgKq/RJwaJMU4SjT7+h6/AuhnI=;
        b=oL8w4sT83USjVqLdpxseoh31oiwW5E0UzIKns1WZaKLrdgExPINqH/IPacI0C9qu6s
         8Nwykdkz8Lwjwrzk4LYBHIgMGt/JQFmWwZI6iEk0cBUEbTvge5uKtb4Yfdpv7Roq7Y/c
         IEcKfWal5dpHCsSxtUTrGvZhwhOmAkfkjrcuBEAb7UQb+2yZN/Gb2p6bGWpS063RdpRM
         lo1UfmFj463ZxDkKIkCEZmhDyXKxM5Tc0LmjLUVZ1AgYXYu+S931T8uhmyuhPIB46Xas
         VECwjHL4hwpKrEaTnGTMbXcZY0QXDkRlvQT+kfqDKo3WV/7KNLZVucoccBxVTPE2puy5
         6Pww==
X-Gm-Message-State: AOAM531cirxklndMlTmZZppZtxZNGg7a60Qe0ZJw8I/MD2m91TssUUh7
        sgaFAnfksJMvC9iJmESY0D5/nA==
X-Google-Smtp-Source: ABdhPJwouPug3WEYGZOba12nsSNtkNanniEIp80Dp4dSxD6i3FNNVXc6j63VH4CZUlecYnMGaTAC9A==
X-Received: by 2002:a92:7d0d:: with SMTP id y13mr5652853ilc.269.1616516617058;
        Tue, 23 Mar 2021 09:23:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h15sm9729695ils.73.2021.03.23.09.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:23:36 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
Date:   Tue, 23 Mar 2021 10:23:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323000436.qm5rkiplwt5x5ttk@offworld>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
> Hi,
> 
> On Mon, 09 Nov 2020, Michal Simek wrote:
> 
>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>> systems. The driver is not regularly tested and very likely not working for
>> quite a long time that's why remove it.
> 
> Is there a reason this patch was never merged? can the driver be
> removed? I ran into this as a potential tasklet user that can be
> replaced/removed.

I'd be happy to merge it for 5.13.

-- 
Jens Axboe

