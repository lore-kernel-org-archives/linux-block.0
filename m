Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD3C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03DA603E7
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbhIFRkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhIFRj7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 13:39:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65733C061575
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 10:38:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so407098pjt.0
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sQHkWdbNwQL+km/anEAO4GkAw1yDfLqfvOkzncIGzQs=;
        b=hkZiYTI7ITLho6KNgNMXS3Fojm3uLGt2wMEGeP/KT/1WA9ObXGUmNfae9U7na0E/FN
         pgFNLPgsmgMsBHwn/CrJrUHyEahtdPY0Dqb6Taw/JA2Or6xMfDyf/Q4quQch6i5a6T0f
         z8G1o755xM1YG5ooQd8blQN2vfEiV3P2Kh/a6fdhBDh9brcsyKKSJRL1JtEsjTgCTfbo
         NZ9zzc3RNYRT2g/y8So3niUUGgrTFHh7tFi0vu+8XmdFPMgWhX+PpIum0ODEGf1wJkIp
         8l9RczsPGbkvSi0EpTuyOjPVcBPm1KLbMUg5ReYFqiYRGsVNdISgi2pAf5IDMf0Q0zuT
         QbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQHkWdbNwQL+km/anEAO4GkAw1yDfLqfvOkzncIGzQs=;
        b=S85hNKx9pT31pCSw2vOymuIUX5/4/MDWfOEIyBkE+DMeAKApnieed9ixTnxt/AqFBc
         hoX4QWsOYCnY5HCski1xujzI0TRTDQzHGnzYM5xSA2k+1NigCK2T8P2nt/iZgaEAD/i+
         8Ei0QfYL8on2sAVj19xi0Qgxrc0JUKMY+dxvJu6a7jvKXSCFGkxQOrN5dPC9rES5hAKH
         nhEv8lD1LL90jMncEAgERSlL6Kf5ZwqXDWpRiPYl6ekmU99yPY3B1PHSV42QoiBSthlm
         3BfbuqtrW07jNJdc3u34yA3XECJimtY6bKZvTjIjuoENPh4ARZInyvViY3snqyDNLFvG
         Ub+A==
X-Gm-Message-State: AOAM530yf09rInKGkMaIUk1sO5BgMW8r8IOuaCiraYz7CCgFcMZsfghs
        hPQblNZMF3P8VBg0c+d2mdPl9w==
X-Google-Smtp-Source: ABdhPJxuIE2RpHMVps8Sa+gF25x2LZ3amjCLjaUwGyvy6FRnJ8jf0971TypSPxvLWdevF0Bx6gmEcQ==
X-Received: by 2002:a17:90b:2212:: with SMTP id kw18mr230767pjb.59.1630949933839;
        Mon, 06 Sep 2021 10:38:53 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id n15sm8579420pff.149.2021.09.06.10.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:38:53 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] block: Add independent access ranges support
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210906015810.732799-1-damien.lemoal@wdc.com>
 <20210906015810.732799-2-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a253efe-d924-a8a8-10ac-c2787ce34cb7@kernel.dk>
Date:   Mon, 6 Sep 2021 11:38:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210906015810.732799-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/21 7:58 PM, Damien Le Moal wrote:
> struct blk_independent_access_ranges contains kobjects (struct kobject)
> to expose to the user through sysfs the set of independent access ranges
> supported by a device. When the device is initialized, sysfs
> registration of the ranges information is done from blk_register_queue()
> using the block layer internal function disk_register_iaranges(). If a
> driver calls disk_set_iaranges() for a registered queue, e.g. when a
> device is revalidated, disk_set_iaranges() will execute
> disk_register_iaranges() to update the sysfs attribute files.

I really detest the iaranges "name", it's horribly illegible. If you
want to stick with the ia thing, then disk_register_ia_ranges() would be
a lot better (though still horrible, imho, just less so).

Same goes for blk-iaranges, we really need to come up with something
more descriptive here.

-- 
Jens Axboe

