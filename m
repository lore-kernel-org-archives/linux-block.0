Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C7AC10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56667206E7
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lYsAIgpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCLN7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:59:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46114 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgCLN7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:59:05 -0400
Received: by mail-io1-f68.google.com with SMTP id v3so5725671iom.13
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zTlRjOseOyMl3jA93cw2svqgh39qVO6h8t5eEoRUrVo=;
        b=lYsAIgpbcxx8SyvblMkx/gqzdjPUpxHVZp0Dozn1TdX7jJ8RQPhY2EwwwEdBEyHa8d
         Y2gf31DfsSkF7s3R223GoIa2un+DhsqKFjRvsa/WQ+9TOrg5E6+addic6Cun63qFANKl
         iWoAtz9SVjo/ElFiLWNu2BBeLEjBqFxD2wKjXiVJNM6OSmg8z4YyFtvwLih298dgQ9J5
         hMEtwF85V61rzlO/ek+yM/ca//+W7WHyMEFYm75krEDSKIdSG9WUYFLZjSX1m1vP6Lem
         h9pom7Dm0Zpc99cwOv6MnGhQqjfOgqal+zocU2kX70zR+3lY5APB5+mrD77vj8pCzXQm
         MQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zTlRjOseOyMl3jA93cw2svqgh39qVO6h8t5eEoRUrVo=;
        b=DJaSczyvUNi+xCNiI3aYj9VlzV/6Kcm7I+iByK9IbTjxiSAj+UftJC6tA2HbjaGsW9
         /dRkTHN2Z5GEz00b67IUiG9bvMWDLaAq7d39uhzg792Iimh6bzTKDz19Yeb4EXxskCG7
         7FbfKWvqi3/7aq7FcwSnZ2BaWZcFWKtKkLCUQZplvITuvJnXCZAG0eBM20XLR9bRV6+Z
         v1pCTTH/AiGHE5XUc0OXbierQAe0fhOCLcAdvPfBA1EGhnTSVBpKvf0jNqyfimazQPaC
         34KxZ5MNhjaUa6G+PK+sxUhOUMIHwnrm08YwsgrMS1zM6zz5VlUH0K+fUgVc2qskLQ2m
         UEkA==
X-Gm-Message-State: ANhLgQ03/Bhb6mlpyEiUDG12QPvyXG1OhPMn/Uhdxk1Ocu12cdlGmdmh
        s9QDNSLG/y8lhelRvZY8dH4r5w==
X-Google-Smtp-Source: ADFU+vtPZYlapRmWvw2pq53TpFm31JI0b2TqwVD7oq2luQRkfS8WUZ+EDaoteFpLJanNoCHbIZDoLg==
X-Received: by 2002:a5d:8cd3:: with SMTP id k19mr8072733iot.123.1584021543117;
        Thu, 12 Mar 2020 06:59:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o76sm3746593ili.18.2020.03.12.06.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:59:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] nbd: requeue request if only one connection is
 configured
To:     Hou Pu <houpu.main@gmail.com>, josef@toxicpanda.com,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b407f0d1-f07c-4d6b-9657-bb296557ff50@kernel.dk>
Date:   Thu, 12 Mar 2020 07:59:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228064030.16780-1-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/20 11:40 PM, Hou Pu wrote:
> Hello,
> 
> NBD server could be upgraded if we have multiple connections.
> But if we have only one connection, after we take down NBD server,
> all inflight IO could finally timeout and return error. These
> patches fix this using current reconfiguration framework.
> 
> I noticed that Mike has following patchset
> 
> nbd: local daemon restart support
> https://lore.kernel.org/linux-block/5DD41C49.3080209@redhat.com/
> 
> It add another netlink interface (NBD_ATTR_SWAP_SOCKETS) and requeue
> request immediately after recongirure/swap socket. It do not need to
> wait for timeout to fire and requeue in timeout handler, which seems more
> like an improvement. Let fix this in current framework first.
> 
> Changes compared to v2:
> Fix comments in nbd_read_stat() to be aligned with the code change
> suggested by Mike Christie.

Applied for 5.7.

-- 
Jens Axboe

