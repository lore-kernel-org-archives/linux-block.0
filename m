Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC12C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5A564F53
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSMlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCSMla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 08:41:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C49C06174A
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 05:41:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q5so5810675pfh.10
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w0ZdVyANdr56S6dEpKoAB7XUWp8JxF+HTfgSoDwJ4L8=;
        b=amOvbcp2TUnXsfdboUSaCAK4AZ6DR+WkrKflVSmVnI6sYUkUw/l3nhiEEK/QL+TgN5
         q52JfZxcqHv2TV+Ez7IYIXKSO/3WQY2E/YilLo1J598SGBB6CE2mESV73ihvfSDHTfv6
         LqbxDjU6mOqCEMcHnxucftBEJGICQUxOrMLzs56hcUEeqL9DpojnwUlLrcMsoE7J1cpO
         RHku4Fol3sTWORgNOFMZoEGdchjGP4EaoHMlEVCitqibB5m6gTWtxP8Al2ETdmQK5aaZ
         o5Nyuq3g9y1Wbx1KgUataYMVv0qfhiFiW+48z9622b6JzmuGoC3GGWaIEmx3HcyhTdda
         HltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0ZdVyANdr56S6dEpKoAB7XUWp8JxF+HTfgSoDwJ4L8=;
        b=ITnJpriK1vTruWBmYuQbjIJb1hQgD4pOQmpWmnIKWt53FFtrhYgFjGbEeGmpRX+Oab
         Qhkt9iHuFw3shc4PTijL47g6wy5Mui30efLgmOPylcYnw2Znrt6yioXwfecjPT5trYrF
         /qQeou9L/yXwSjj1TvGLhT8eeQBGIchHmThFNcdIr1TgUy5PJ378k/4CC06IFTJckhtF
         0pgwaGK2n58lZbxcwLZvBVbEcPUQP+6sAM8+wAOzJ/w/yD0kgJtpTdW3xwzA0DjqZWd/
         eBaDb70vff+6BJVowFPQ2Rr4pHPtucy5H7qiorVxmudrkJyyZrcIq9Z/uUfxTi5f707u
         085g==
X-Gm-Message-State: AOAM531uHNzWTLD3McuuI/+4rxn/2AYSnbcQlF0INy5AG/JQkV991DdX
        s1wcGhjtVradh+oSRnVZBUmIrA==
X-Google-Smtp-Source: ABdhPJyHL+YkVkYDx5KBjTg47GdKiJEL7Ww3FNf3BBSpPxNBuU6T4GK5er6jHfIy+PvhhT9/jS8ivw==
X-Received: by 2002:a65:5bc6:: with SMTP id o6mr10956190pgr.127.1616157689633;
        Fri, 19 Mar 2021 05:41:29 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 143sm5722651pfx.144.2021.03.19.05.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 05:41:29 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YFRPRP/WLS/5FCSc@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91e2de6d-b6a7-b3a4-8997-b43d58076017@kernel.dk>
Date:   Fri, 19 Mar 2021 06:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFRPRP/WLS/5FCSc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 1:14 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.12-20210319

Pulled, thanks.

-- 
Jens Axboe

