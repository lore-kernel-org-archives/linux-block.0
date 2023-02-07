Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC161C636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 14:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBGOX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 09:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBGOXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 09:23:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ABA1420F
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 06:23:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so15804268plo.1
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP4KJ+sUVy984XavI9TlLdBqFbJPagaCXgo+4pa+BK0=;
        b=dOzq7fmhkX0C94KaiqP3PAxTwWZeiv0eDwIEB9yzreSN75EPMu9zZdWxvT4siUoRk/
         jLyf+gWgipAEvrh5KV9dBzDcg6o2BiMHSb1vs3S3kX1LszcohTbKPNdhCH/tXhiXqWT1
         4Hq748sI/E4vpWz/2VI6E6X7yAm2V+HDawN6woX8bAMvb0AOj1CLsAGnLA7Z6SoFFBRl
         J5QMh5L+kfm9kVMmbZG9zDCed82YtXY1A88oS2r6u2jniV12hGnzd2DxpXn943O+MC03
         zrdL+dPHoNzzS4zg7QVM1QdCwfgkatXP8+NFdukB1/lQZAztG3sk9S98Iozlv8wEXWVL
         DP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP4KJ+sUVy984XavI9TlLdBqFbJPagaCXgo+4pa+BK0=;
        b=F9XjOHAWQpqEVettIuC6GC51FY+hJUjsXVdP18zMcsQjHxWVFAh97oJ6ALjBaUU3WY
         09ol9SQ9R5I9UVB41Otn6h0NrOJfQV0uwy78xxYe1RBXN7/CXcC1Ud79xcGTmtUjcCdq
         Nnc+NnArgB7au4El0j985orCBDVKmWrI05XhN5shJioEdkjkznR21il7xohWiitFADkf
         GHJTQjxjUSZUPJM/J66H8XjCQO6STChSApybWJOWxTjUigREWWEIIcgIjRmrv24MvCBd
         szrPr83/NdQqbS11WNu4DzHledLYTEvUfov/VErMF7JIORn64hcqCE6VURd4pHKayDUe
         B98A==
X-Gm-Message-State: AO0yUKVBTQFI2CUpjEKzFsGq0m6uHVC0c4gJjVRPhno0AkMcu/+E4xL+
        Tp51x05H7rGn9r+9JIegYg/UZ2suflP2lP/A
X-Google-Smtp-Source: AK7set/LK2NJA8P7Ldh16A3GC7dgJXnpinpBlMVgFhhnYWxbKN2ji0deVq9tc0pA87XfR9cSIuMhrQ==
X-Received: by 2002:a05:6a20:690c:b0:be:9fff:48e3 with SMTP id q12-20020a056a20690c00b000be9fff48e3mr4174015pzj.5.1675779828395;
        Tue, 07 Feb 2023 06:23:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b004f06ccd76bcsm8047588pgp.70.2023.02.07.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:23:47 -0800 (PST)
Message-ID: <115b0b15-98de-3615-064e-3de15b40895a@kernel.dk>
Date:   Tue, 7 Feb 2023 07:23:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme updates for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y+Hsk7eOObSafEkz@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+Hsk7eOObSafEkz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/23 11:15 PM, Christoph Hellwig wrote:
> The following changes since commit 2d97930d74b12467fd5f48d8560e48c1cf5edcb1:
> 
>   block: Remove mm.h from bvec.h (2023-01-31 09:21:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-07
> 
> for you to fetch changes up to baff6491448b487e920faaa117e432989cbafa89:
> 
>   nvme: mask CSE effects for security receive (2023-02-01 16:10:10 +0100)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.3
> 
>  - small improvements to the logging functionality (Amit Engel)
>  - authentication cleanups (Hannes Reinecke)
>  - cleanup and optimize the DMA mapping cod in the PCIe driver
>    (Keith Busch)
>  - work around the command effects for Format NVM (Keith Busch)
>  - misc cleanups (Keith Busch, Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe


