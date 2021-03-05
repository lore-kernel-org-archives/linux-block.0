Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BEC43381
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DB8650A3
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCES17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCES1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 13:27:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4216C061574
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 10:27:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k2so3013066ioh.5
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=URvi90fjReX66GGxg6Cc/WcyhDQVeYyWsL++jmjfP4w=;
        b=WEcDFIAY3501+eCSpuhzyzBep81t7Z9AAUlxXimo7Aj5Z5MbkoPNCt5g0sUEOHU6Hd
         yqIdAYxqfkEU3KDkjUjVAYOc1+/Ncw198mvgLsIwQDHD6ii43q/bPHpT4wOsn8sLY+di
         IvXMg1hk3Q7LWAwLPeYG9mVaNmrK7QQf2VDuFyU2AEO9hu2bTrw9/xCkKb+RiI41hP36
         /16mlEeJvW35yXQJDrHUXoxYQL5BgVCkwyinR7XOLlfoUsidgJ2AWIpz64LHF/35KTFk
         71qxnCYG/tNsCBuGsj7ByY9p3H38hIVgFDtiof7bivJo2RGBHmOiSAtIv8yt+7ihjRMh
         8kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URvi90fjReX66GGxg6Cc/WcyhDQVeYyWsL++jmjfP4w=;
        b=XYP/JF+tBYpnV50sT393Prnffjw74l0UhMBSUTTBGaKVQqFy3vUecsi4MelUhsPMQN
         S98hstlyRUI8FIIzBTL+g0TurjdO6ctEcn5y7Bi378eYo1jaCqm7JhrE7IttEy2twI9C
         sGTN6UHuwFVR090bL4SiyWvzT/4r29elFoo9oZq3tpc0ylYCHlSQ634fRT9CUGiM/SXk
         rpNhH+rKTDS2BMfnGYgKmACeK+OGvrrpUYRqB/JeZ1mV4Rvn5VbY+xdVKKBicLiWnHlu
         zNIW5Wq5yRbc9oV2WtoJwfbhUhBCNq8PFMN4LGTFlXSQGMgvL2Ra2ncIU0CvJFOZRKEk
         /s3A==
X-Gm-Message-State: AOAM530xrRG5TxX2+BRSmPH/puNwi5OhfKJrwJ5GDfJynnSWhr65BSS+
        zLNxzKQdU80t4fWS2TAbIPA6qg==
X-Google-Smtp-Source: ABdhPJwqjG7Eq8kF3HmSR3Fy2ObJJoErkj1f5tNBTd9wUKtd5rUPdCoxhJ/05fFUXlAn0FSoCLxdjQ==
X-Received: by 2002:a02:8545:: with SMTP id g63mr11315827jai.79.1614968865235;
        Fri, 05 Mar 2021 10:27:45 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s16sm1630643ioe.44.2021.03.05.10.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:27:44 -0800 (PST)
Subject: Re: [PATCH v2] block: Try to handle busy underlying device on discard
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        stable@vger.kernel.org
References: <20210222094809.21775-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53689a67-7591-0ad8-3e7d-dca9a626cd99@kernel.dk>
Date:   Fri, 5 Mar 2021 11:27:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222094809.21775-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 2:48 AM, Jan Kara wrote:
> Commit 384d87ef2c95 ("block: Do not discard buffers under a mounted
> filesystem") made paths issuing discard or zeroout requests to the
> underlying device try to grab block device in exclusive mode. If that
> failed we returned EBUSY to userspace. This however caused unexpected
> fallout in userspace where e.g. FUSE filesystems issue discard requests
> from userspace daemons although the device is open exclusively by the
> kernel. Also shrinking of logical volume by LVM issues discard requests
> to a device which may be claimed exclusively because there's another LV
> on the same PV. So to avoid these userspace regressions, fall back to
> invalidate_inode_pages2_range() instead of returning EBUSY to userspace
> and return EBUSY only of that call fails as well (meaning that there's
> indeed someone using the particular device range we are trying to
> discard).

This missed -rc2, but I'll queue it up for -rc3.

-- 
Jens Axboe

