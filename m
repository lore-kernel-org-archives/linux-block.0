Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB98C4332F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1695E611C0
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhI0XPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbhI0XPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 19:15:48 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC13C06176C
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 16:14:10 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y15so58026ilu.12
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zp4nvftGOWeD1s99FCNFjdYMml7KoKUo9QCBqD0w6uw=;
        b=dN9t+G3CN5xOB80VLU9lbSpzF02CNiXrEqBBXd87+/jkX0g9h9GglyqpPpCbREI27p
         wadLrQjKoPgBATdzVeoyrVNLF3GtTk4DOwuBimT7rVapTsj8Zdhv1sKpNA2BPzRaQhVN
         jts7UT6RtmTkPkMyVInFt/KUchC9I2xOWy3t4xS0Bg6REj+KmCA24D0rgNlenznIqXWH
         UPs9qTLUqSuVdnKz/bKrfQ7Htmq3bd4fLaWenQBN4kkzAd71swl8OVV7ET0VFkwynJUd
         7KjL8EtxkK76zsqhglKXyCoql+ajqJPrsexs61eJxhxo0u3Dw4sfgx6dl/vF3Gt4tz04
         JcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zp4nvftGOWeD1s99FCNFjdYMml7KoKUo9QCBqD0w6uw=;
        b=bJCUBXG54caW65vrLG+2IshuD9llg3SVadVTHFs5m9Ybsank5xczO+ZCG4xPSBF7q8
         pkOxxGpoVu7n1Hv+tBvffPW7geNHblZUHuEuIgNVQ9GPhVBpiyQhDRH/Aw27oHbm0PD+
         i6GjunueN2TFVk7jTK5DbLcZza2eT9BF4XblSSP0ba+42Q4pW8LUOisHlp5rad6HxlUw
         5JvgJTluphU9SZe+JGmnDZ37GAkwHnIc19aeFkvjaT2G7kcSa7BIPFmWS07K+3a2A84r
         ReHsjInLQR1G1KOqDAzbPstMRdg0qIwifYN+NEXjUcuPczrVYAEJJx7NMT/VwUhRlWDC
         DP8Q==
X-Gm-Message-State: AOAM533O7gy1dMX+fE5OzJxl1ZlZx5hjOVpqCF3FI+FnSHd9PIic1lfE
        yunJHM2t3PRWCi7Pf97DN2+yTg==
X-Google-Smtp-Source: ABdhPJyhweJCjRid6ogP9g4aUKXpEV9/JuAu4JG9Q+FngZAwBhpDLwLHFAgtgqarsNakZPQ/6MXARQ==
X-Received: by 2002:a05:6e02:1521:: with SMTP id i1mr2027451ilu.22.1632784449385;
        Mon, 27 Sep 2021 16:14:09 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j14sm7096226ilu.74.2021.09.27.16.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 16:14:08 -0700 (PDT)
Subject: Re: untangle the block headers v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20210920123328.1399408-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8db0dc92-c12d-26ee-2f2a-b80f320eedf8@kernel.dk>
Date:   Mon, 27 Sep 2021 17:14:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 6:33 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series untangles the worst of the block header maze.  It removes
> various includes from blkdev.h and genhd.h, and also ensures the
> writeback code doesn't pull in blkdev.h leading to huge rebuilds
> whenever they change.  Finally it moves various bits out of blkdev.h
> which shouldn't be in the general block layer header.
> 
> It has surived various randomconfig builds from me and the buildbot,
> but I suspect there are a few more conditionally missing headers
> that will emerge later for more oscure configs, so it would be great
> to get this merged early.

Applied, thanks.

-- 
Jens Axboe

