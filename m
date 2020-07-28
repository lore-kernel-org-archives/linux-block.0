Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B622C43458
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760832078E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sFeRSbxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgG1Ph4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgG1Ph4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 11:37:56 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164AC061794
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:37:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so13167408ilc.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aT/4Vd1KT6gFUEyaURRCi9T5w1JgYeHkaL9/rT+SjdM=;
        b=sFeRSbxrDGk1FX1/85Qv7FXIlsc76+QGGUWMfOjXNSfVVvdM3ACfzQHLbqezRd6BOd
         njlEWUrAROEV1+gX5qSdf3MHM7jPnoqMwXb5cEFM2nLDHTljMst2sjQQXNFby+ZwqAhk
         R5cd4wY1rm3RkLoJTOBDPpBXH7c6O6e7xifxbWYSZm3wPeo3vw+qCfOtEbfezD9F8svX
         1Yc25TTk0P+oDj7KTqcj48j3GE2pQDex9QiHSCKk1S1XMJStDKHTqzf/m1s7vEB4GtCh
         zZDwug/yEN0AG/yuDhhY0es8K3VDnFqkIK+L99us7hibyLuSGo/TdKSPjLUigjTH/6OJ
         YaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aT/4Vd1KT6gFUEyaURRCi9T5w1JgYeHkaL9/rT+SjdM=;
        b=LikbncSYHU9BELWGn5V1N6xoDxdoIGP+5Nq8ZrAAtdJyf9rr9lpKkjLqKPnQqkPnx9
         QuBIcY8Pcc1tZNUjetNqfad/hDMzSpMdO71QAsMkQEiH5+PyFIez3QOJIBW8DXaTCMZC
         /SAFf0Hl++O6AvLKhbyUGcykmqmHVL8OIRXY+kM5q1z8vjuOR6a7OAuRKPj34gAB/978
         dfR7+Fn+YZmHZIfOcGrvMWI0LFoSpvua9eyLXMI+KhxSD+PkZIZBxyXW90YyFUVfmFLG
         61SpvuUtWppHLPWWVpImXHkrZSSiKi0fz24JpP8tjJW/D+hP1R37dMDZF79M0EYqbufs
         X2CA==
X-Gm-Message-State: AOAM533vZgxgy1VpSM0mo0SBfyazn+sXm1UiJRMKbyZBG79J7GKWBXiM
        V4ytzYPNvexRN9qwyCYdL625Xg==
X-Google-Smtp-Source: ABdhPJwqrM+TwYM3A0LLl4/nqG8Pt+LJGaycrasyS6nUKhqtbIBby3yzfVH1Ro6mIWoOXWDdYhVouw==
X-Received: by 2002:a92:5e1d:: with SMTP id s29mr14577822ilb.245.1595950675515;
        Tue, 28 Jul 2020 08:37:55 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r3sm4772269iov.22.2020.07.28.08.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:37:55 -0700 (PDT)
Subject: Re: [PATCH] block: Use non _rcu version of list functions for
 tag_set_list
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200728132951.29459-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67e31df0-b86c-6a2e-d9da-3e8a7114e42e@kernel.dk>
Date:   Tue, 28 Jul 2020 09:37:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728132951.29459-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/20 7:29 AM, Daniel Wagner wrote:
> tag_set_list is only accessed under the tag_set_lock lock. There is
> no need for using the _rcu list functions.
> 
> The _rcu list function were introduced to allow read access to the
> tag_set_list protected under RCU, see 705cda97ee3a ("blk-mq: Make it
> safe to use RCU to iterate over blk_mq_tag_set.tag_list") and
> 05b79413946d ("Revert "blk-mq: don't handle TAG_SHARED in restart"").
> Those changes got reverted later but the cleanup commit missed a
> couple of places to undo the changes.

Applied, thanks.

-- 
Jens Axboe

