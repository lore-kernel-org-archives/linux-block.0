Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB193C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915B120870
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="mYQorKfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDSsm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:48:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40267 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgCDSsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 13:48:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id m2so2697516qka.7
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gaiPqDNxbGjPvULcXVentH2r0KxuB6YZ5QjsMBCeHec=;
        b=mYQorKfWcmDjXtRuYROKlRZpSkDVPpQBNo5QcfOAqIMq6EBk2ZMjEnfys92dBcDr/g
         j9+19Z8mBniWXU9Opl5/9fF42M50sq3jQjrRAoDNvc4/9iImQe/qG3Z0wEYtaDMJgpBD
         Y+PbGCyuiELp7lf4TyUga6lc2iWbtB6WajEcH6iPgGuEr7RPH66llE6ZtamsM4gzmqVL
         ERk6EujU4NEFgbob5rebVMoYBt0S33Yu/D4vRXzBTNgdk82sytG7ofEJXasmLpyLV5WY
         6jZKsbsslCeFR3QsiYh0SmhUoxPWMpHMLydNa47e5+cO6H3utog4xptQZsR737Gv6D6G
         LY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gaiPqDNxbGjPvULcXVentH2r0KxuB6YZ5QjsMBCeHec=;
        b=SOM2bAnH1dbU0i7ox6ag3qAa2s6OSq33oa8xe+uID0EyH0DMbB8kpkcNfHnzRpQETz
         jWb9C3k28ISPqAuKoBgoMkI2nNXDxOC/rCavVyF3SuMtnUyLEwtisUxShh+JAl3XSMC3
         STfXxMR9W9PO8eC2tJ83zgRzkizO4dsObM5hmXrn5mHybdCeI3bRlFa/B5VLbjTQAwY7
         gGyVWjK+np8b0vZBSue3DpD/smKjD9FRnKDxam32H8kXbvDEJk1np/AjK7VBnVTXIqgA
         erJhz/duJ+LKnnpvrqL/kfTtyUwUleuv5uQ6XVhej3MUwVzAn/7n7GD6WHYkL1unPUW5
         wAwQ==
X-Gm-Message-State: ANhLgQ02N+PZBShtq1inT07U/RnE644c03z2ooO65fcprTMdA3rpBmwX
        q9QIIEQvLR3m2y43MkP/gYnOaA==
X-Google-Smtp-Source: ADFU+vsI5evWFOKkqNQUBS2xdCXb3Ty9BF9CjXGr19/96KNNE11UK2M6OYOr7n87JSPQC4u+HzE4pQ==
X-Received: by 2002:a05:620a:141a:: with SMTP id d26mr4336143qkj.312.1583347719821;
        Wed, 04 Mar 2020 10:48:39 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x203sm795338qkb.44.2020.03.04.10.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:48:39 -0800 (PST)
Subject: Re: [PATCH 2/2] nbd: requeue command if the soecket is changed
To:     Hou Pu <houpu.main@gmail.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-3-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0f3dd5e9-a2e2-3b05-7ad8-292a481e3006@toxicpanda.com>
Date:   Wed, 4 Mar 2020 13:48:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228064030.16780-3-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 1:40 AM, Hou Pu wrote:
> In commit 2da22da5734 (nbd: fix zero cmd timeout handling v2),
> it is allowed to reset timer when it fires if tag_set.timeout
> is set to zero. If the server is shutdown and a new socket
> is reconfigured, the request should be requeued to be processed by
> new server instead of waiting for response from the old one.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

