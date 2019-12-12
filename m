Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B2BC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A63205C9
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1jJNlB/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfLLPRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:17:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41125 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfLLPRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:17:45 -0500
Received: by mail-il1-f193.google.com with SMTP id z90so2320393ilc.8
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eomPDhGlMkJa5hw3SQ+p2cD6ocrcZ+qwzGvgSybIfF8=;
        b=1jJNlB/qae3h4JgDt0Y1SB0vy7eormUawj6HVkWTr65WDefAU5u/FrkwRsajrRIyqd
         PPDomMVapKmGshnA/M6jzftaLfeNEQQEwvjVULCS8qqqq2DcgDmcHA4T+sza8JGU3MbT
         I4pYW8iy8HJt+5ySxolimSHNdFTwguypU+5RLDwSww/k3uA34IoGCzwHxzAc0PDMu9rW
         gdHiupPvY8SKPJoDA7zDwHgMTmuQ/tporqWmoMh/HYRpY0dYyFfjUAMG/aWUVEcLmqML
         z36CE77atWeGRtnlkg1pH8xKMh6iKN4JMQCT9cCGrDCQtNhtFr9RPSeVKBK1XtW+EWTh
         Pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eomPDhGlMkJa5hw3SQ+p2cD6ocrcZ+qwzGvgSybIfF8=;
        b=LIQq6eW/i75QFnjMbaib6EPQEymlX8eJEwzS9RsDv67S4khQgAN1rfdI8s2YJ0vkEa
         YTMTX+7SutOjpOEpX/yEMpbR1l/cmqM1i+zjr0Uxz8Mp4IFs7eYDe/Bay5bhEJnoqldz
         tdmhwKbQ6IpuLIENLhw0t+TVgc8ha+Mf3u42Kb4MpghJuLNudnjYkubZk99Jb6R4sGNi
         rP6dUsyD11wMmBBsxobmcywiQi0okdeK9359X/Ije04thyIO5dsLWcoMZzyzre7mgUbK
         /K37PB/x3/twLZLq7evp0S645ZqqlnJSSdWY3RlIxCV/+OCWHrNpvRB8AHI2PaczELbF
         YENw==
X-Gm-Message-State: APjAAAUz8Mk74V5y0+Bi7jz6p7HVMYR7UfjsxgCJcTbUm8tDWG89FOX/
        XfxFr29p02jvHBfticrYSbdLKA==
X-Google-Smtp-Source: APXvYqztPbope+PAr+dOEEI1P5hXeWFYdrfFlD+f89jbYQG+6Th/TE7e1VyRTiwlCiNSqrQJAcZ/vg==
X-Received: by 2002:a92:884e:: with SMTP id h75mr8730645ild.199.1576163864702;
        Thu, 12 Dec 2019 07:17:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm1302166iov.45.2019.12.12.07.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:17:43 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: remove blkcg_drain_queue
To:     jgq516@gmail.com, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0cb5895c-aa35-b65a-83bf-81f5444e562f@kernel.dk>
Date:   Thu, 12 Dec 2019 08:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 7:08 AM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Since blk_drain_queue had already been removed, so this function
> is not needed anymore.

You should remove it from include/linux/blk-cgroup.h as well.

-- 
Jens Axboe

