Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6CEC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08E761380
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhDFP24 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhDFP24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:28:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EDC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:28:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b17so6966306pgh.7
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tF6CUcXpDbuAErZj+N46Yk25H9mtpHvG+8qfiMxKbKU=;
        b=Bn2+6Kr/JILCfY9KCOAIzAHAOAGagzdl2B5myfm9+iNCnlqdBNKLt0Utw/vwFi2BOw
         +Y/3JeiL3hPpByyQ6U+n158Az5HijEuoMx1kM/9D6tLX4IheCNv3ecUZuGqvqZYwZV4/
         kOZawMX9OBQ3uj5m6tYiGG21KkIa4IKXFUuUzn+91NMLOtRW76pwvGGdqo+OiCYL8Lrb
         VW37guDHBJBPpUYMqr9wl5IRGh4AHr7UTLAmD26OPUiYQhXAqkPkydC98zEKISO7wgnH
         M8JBKFao74fizTutzYEHHQwbBMbGNlLglmLRkG7aANcbDOGcS8G3Q8Sz3DbfZsBl9pZy
         enBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tF6CUcXpDbuAErZj+N46Yk25H9mtpHvG+8qfiMxKbKU=;
        b=Dr+ZTOkx863TB5iYKdJyMC6Av2T5LugLnKrqKLUpmR3J9/svUOE9f1TKAN7ygoSrUg
         bAlHYt6uCRAEIYDpUaOr9My1QAxwBCE3lXrrzmb7RWZ0x+iAy1h0w6D/fTjEd/0LKgeS
         KeGRVMn1rgoI+e1YBkn7woa3zXwqa+yNdcQiMiFfNUJpSLWcJXZ7m2TVLuyPPoLYYHNr
         fLX+AeQk2l9cD9q4NRDgPX6ht4pPZWPs66asULeJ4l8g6SDQJJyut6QonTvuF/kDGyw0
         3ClVDo7LB72mqlgzzHrbXKfuqEXPZmjbzl5uubOSIaeVOa8btTnmKzigO69/SoeKT9Pg
         Akug==
X-Gm-Message-State: AOAM533ITspTifASjNiD7BDTmo2hYtr589g7dUYUXoDz4F+b6kfsb5Ew
        /xdmfvQ8dQ7jUaZzF3nHcfeRlw==
X-Google-Smtp-Source: ABdhPJx2qHg/FttuBAn2osLaKJ1OJTMxTAM4fMtZXL0k+4IEXtlKOhbPcpdi1h48369ylF8Q/VFQAw==
X-Received: by 2002:a63:e63:: with SMTP id 35mr27016911pgo.27.1617722927995;
        Tue, 06 Apr 2021 08:28:47 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h7sm19254868pfo.45.2021.04.06.08.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:28:47 -0700 (PDT)
Subject: Re: start removing block bounce buffering support v3
To:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210331073001.46776-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11664576-758d-7e8e-bf95-ff9c82cab927@kernel.dk>
Date:   Tue, 6 Apr 2021 09:28:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331073001.46776-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/21 1:29 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series starts to clean up and remove the impact of the legacy old
> block layer bounce buffering code.
> 
> First it removes support for ISA bouncing.  This was used by three SCSI
> drivers.  One of them actually had an active user and developer 5 years
> ago so I've converted it to use a local bounce buffer - Ondrej, can you
> test the coversion?  The next one has been known broken for years, and
> the third one looks like it has no users for the ISA support so they
> are just dropped.
> 
> It then removes support for dealing with bounce buffering highmem pages
> for passthrough requests as we can just use the copy instead of the map
> path for them.  This will reduce efficiency for such setups on highmem
> systems (e.g. usb-storage attached DVD drives), but then again that is
> what you get for using a driver not using modern interfaces on a 32-bit
> highmem system.  It does allow to streamline the common path pretty nicely.

Applied, thanks.

-- 
Jens Axboe

