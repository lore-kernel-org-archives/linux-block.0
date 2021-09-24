Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1EC433FE
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A836103D
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346351AbhIXNcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbhIXNc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 09:32:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5BC0604C1
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 06:15:52 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i13so10307810ilm.4
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IQN9DP0M41u2cr727GWUuFS+FbSRmoFH5BT+NmKfBVo=;
        b=0ivsGxgqYM7TnLQGtxH5qjhcLwDtPTSjzgb2gzXSWk5YWRAAcXfHTkWOxIEQr6O14a
         dN1S2DmKdLHolCiP1kXzaa7YX7kJlbua1dmFUX+izljooBJAYVciEi8bJ9hofKKbD/wd
         KYVPWc1o0/IzHFXSppiWGYJS2fEpSvYm+h3PkrWxQU1PtLUV22mPXJFu3EXUODsdlfmc
         1oGcQ57nCDgpeWP1G58dAN1cmRXCNqvURVMr5fy431FhE9jneFQJClpd9a40rqJRHS/7
         uiiX8woixAXBalNgUdUhltv8q12oQrIdRLAcTDCpUEtvgiSL3dm6RYWFOwVWHHygJ1U1
         GSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IQN9DP0M41u2cr727GWUuFS+FbSRmoFH5BT+NmKfBVo=;
        b=yHAfrIfufidANFEkov0Fz7X25stu60kEvUKXp2VZCD4ewDL496ZkxqGe6iH9SFJHNB
         fT+6qZXJxNbBz+UWYuz95IgKcbVFycX/t0yw9OIQ2ndjDgAum2Ao2Y0VeQa4BEPi5cP/
         AS6hocFPrS/mll0Vn2TAYxdKErFWw7UI7OyehfcvO0f3+7nIKUhPi2C1ymDjxtRjJ+8I
         VbUQuexxZSy72ecPzwoyRxLEIyHB4kkqz4ODeKrxZvEc9ucgGq0bUA21uUzm/v0a34J6
         7yyilNxKB1S196KAlUcsSiNj0KVve9XQrUGkhzSxttR259Lm4QUn9FT3qlBFO7aOPM7i
         QKkw==
X-Gm-Message-State: AOAM533XW3aokLuANWnYume/PeXCnnhThcNGXAdBDgDbVBErahYitso2
        ISWjFqhhPD+J1r/TT76lv8TXfw==
X-Google-Smtp-Source: ABdhPJy/y4iAfP7x2vzAcTTt2bxFyqaDRkQ2Oj4i3wDUnG7kGhD5OtkI+slaMY38uFkKaMJQKYiO0g==
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr6298407ilu.53.1632489351553;
        Fri, 24 Sep 2021 06:15:51 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r3sm4177181ilc.56.2021.09.24.06.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:15:51 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YU1yBgH+CqJu9h5u@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc838154-552d-56fc-37dc-393910b34f50@kernel.dk>
Date:   Fri, 24 Sep 2021 07:15:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YU1yBgH+CqJu9h5u@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/21 12:36 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-24

Pulled, thanks.

-- 
Jens Axboe

