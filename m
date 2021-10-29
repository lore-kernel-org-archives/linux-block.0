Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC99CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677960295
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2M6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJ2M6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 08:58:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC9C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:55:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x9so2888275ilu.6
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=nlxv7m6ePO7jaxpIUwFy/AHNnpBEbKx9hHILRtHA9No=;
        b=TsI+RiEGuODQfPi5b+aRvrDpGxXwTC1wlVX0SE7CYwu9YhdyjPxPWSaMjWV4XyqDbS
         4HBjt29+WvOgBqhdEuAONAITj6iaeUmc46zNoA7DD2jWBOP1DiJctUnXfRCO3vuiQ+m0
         vkFZyUVow7QJJCMk0URTTMjKACVcyF7SN8HAA0Es+lKcqZTCUhRwTyQd7/VaQ6dw3NkM
         HQqTo0KrYayb6T38c/s1YuTsBqUaA5dsMkPEFQkHxi+OsB3uR86YdGACz/Fs5aGIYdZn
         5q0EQjPNHD989uUV7YeIDx4loXLgjDSG6BCnjAivJD/SyBipLlHDN+S7/r5NVUPKvRH6
         846A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=nlxv7m6ePO7jaxpIUwFy/AHNnpBEbKx9hHILRtHA9No=;
        b=2YmbonJCWeg73EpIDTOrPcEdcpMKMR++8LG1R4bAS375B4xP7Dk/LJPCglZ0d7hVe3
         pglQfFWuNv/5zkNJtEdCUMwopocrHdt8pVBn++kAmIHYnYmvCxKoQZhRd7oMTZuIbvS+
         irA4tf+cpxLoalEl3Megk9gL2lLaiiXMEikoOaJdk28RgEyxiH7NLTTDZBwsOkls2tNH
         S7mSNT4mQPiRlavP8Mh4GhrAFLTKEHZb3Afvzvowu4hkuMIO6GYIbezUAwXXTMeSQToz
         jCfhInrx9cLL3ALCK+VH98Hse3tXZaZPITWBwUOANnAJsPFqf5Rd0Cey2CSQQvtYdh2n
         +tIQ==
X-Gm-Message-State: AOAM533N890wkLJrh6Hvncs840X5gjUXcOktE/4p0eVdYhcpGe3RyHaU
        bbWfAa4aiSqBL8vOEVEoaEcgVFTFa/yVsg==
X-Google-Smtp-Source: ABdhPJwWWEm1mQNex4NH5QX7o+upWqvVu4UYoKPagTro1D6pF90omAKPtDjPxNj/W6DWHNAutHsuEA==
X-Received: by 2002:a05:6e02:1c08:: with SMTP id l8mr7241822ilh.203.1635512145431;
        Fri, 29 Oct 2021 05:55:45 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x13sm2993370ile.9.2021.10.29.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:55:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>
In-Reply-To: <20211029103926.845635-1-shinichiro.kawasaki@wdc.com>
References: <20211029103926.845635-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH for-next] null_blk: Fix handling of submit_queues and poll_queues attributes
Message-Id: <163551214334.85702.3735215502568945036.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:55:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 29 Oct 2021 19:39:26 +0900, Shin'ichiro Kawasaki wrote:
> Commit 0a593fbbc245 ("null_blk: poll queue support") introduced the poll
> queue feature to null_blk. After this change, null_blk device has both
> submit queues and poll queues, and null_map_queues() callback maps the
> both queues for corresponding hardware contexts. The commit also added
> the device configuration attribute 'poll_queues' in same manner as the
> existing attribute 'submit_queues'. These attributes allow to modify the
> numbers of queues. However, when the new values are stored to these
> attributes, the values are just handled only for the corresponding
> queue. When number of submit_queue is updated, number of poll_queue is
> not counted, or vice versa.  This caused inconsistent number of queues
> and queue mapping and resulted in null-ptr-dereference. This failure was
> observed in blktests block/029 and block/030.
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix handling of submit_queues and poll_queues attributes
      commit: 15dfc662ef31a20b59097d59b0792b06770255fa

Best regards,
-- 
Jens Axboe


