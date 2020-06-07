Return-Path: <SRS0=x+nQ=7U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41432C433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Jun 2020 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148632067B
	for <linux-block@archiver.kernel.org>; Sun,  7 Jun 2020 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xcEShDoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFGO5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGO5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Jun 2020 10:57:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3FFC08C5C3
        for <linux-block@vger.kernel.org>; Sun,  7 Jun 2020 07:57:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so2459678plo.12
        for <linux-block@vger.kernel.org>; Sun, 07 Jun 2020 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OrPIMIyi5BhhyDJr5YGAX/Ehw8/mYxY1q09wl16B21M=;
        b=xcEShDoGcjXZaqQfnG2qZ6Er3xpWL/4Gf4RATaU3qiZW5ngaxc8X+8FrThZ9cu/FbC
         UfpAsJAyl4a3tp3p/Rhzast6Qu3pHAXxMpMV7srbFyrFjwImB/FETVpI/OM7Yd8Xc1Sr
         GMwe3pYdOdKdFtHEFW3Aun9L5u3LpYZe5Moqym+DMUQjoSW63pG89tQWm0RnG2HxrsJD
         SAz7R+EFea6cFxElI/tbMk7RVcb065psS/xltundqurze+VV/6dWglthdmEUHf3JTXXM
         UXZF7W9hJeoFVPqvrJVqFB/I81InUbI3lqmqdRuUWAAjV2LfYewXbnUdTmy/ebURJxYX
         0b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrPIMIyi5BhhyDJr5YGAX/Ehw8/mYxY1q09wl16B21M=;
        b=i7poSp1x63kJgXn4sqbMxSwV9jlughyPpFahLgBFQJ+85IFaX6tTcEYBSuexJJiqMD
         cmC8nARq92OE+D8LIt+uftlzDd5ZlAV3LJi6pRO3BbRcF55pftWcw3ME+YgagYBm4aGp
         lW0tnVCezrFr89KabYVsmfaaSIDb+nahv/92kSJHD7fAtkD0SLh3IwCRUphfwSjfHi3u
         bd+yf/QLS0meHZW/SExGudM63ROkq9tJR3MNK2FTmwHwNR2idMniw5R3lKGquuE6JPFN
         7fIJXd6Evc0Nkkc7SDom/nyAFLlnfNw0J2Mygpt/zrJFRNvwvsKzw1kNZdZYSs44bxdH
         bHuQ==
X-Gm-Message-State: AOAM530wIc0UhYMaVTB2qyHvgxyiAI8WTO5VEE6YG/OBef9nZR3uZRgl
        BjOBao2Ba8Ri7FHjyNgJ45/8SSeOwHby4g==
X-Google-Smtp-Source: ABdhPJxaLYMQsPLrGMdpDs9WOqAhUxxDgBc0wThCoi+nYAZ9p08tHkuUPRAs84ksAHrFKnp1GW6UeA==
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr17885584plr.58.1591541855238;
        Sun, 07 Jun 2020 07:57:35 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j15sm13089579pjj.12.2020.06.07.07.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 07:57:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: fix handling cpu hotplug
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20200605114410.2416726-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7652e408-9c70-b0fc-9595-0ce12fbe53bf@kernel.dk>
Date:   Sun, 7 Jun 2020 08:57:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605114410.2416726-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/20 5:44 AM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch avoids to fail driver tag allocation because of inactive
> hctx, so hang risk can be killed during cpu hotplug.
> 
> The 2nd patch fixes blk_mq_all_tag_iter so that we can drain all
> requests before one hctx becomes inactive.
> 
> Both fixes bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are
> offline").
> 
> John has verified that the two can fix his request timeout issue during
> cpu hotplug.

Thanks, applied.

-- 
Jens Axboe

