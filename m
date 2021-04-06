Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640DC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8138D6139C
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbhDFPaz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbhDFPaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:30:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44342C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:30:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so3223296pga.1
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hGwJDVxaOZw/rA7m2eTDQSxQQORKcDebEzAg7BkGlAg=;
        b=XCzFiXpYGOn+PLSMuzD+WoayLErpGB7YD6V8IcLGacD/dhaiVxpc4FVgBKnGs1ydnL
         pLmvLTK7r/wKPR2YeYybzJPl/c51rFdsvzPHFWFMrnxYWwqFlZjlRiMkue401No/RrtT
         o1lbzmEVlxWb3mgxn/I9y5NbafBvgntIx2XXIJn/hQnJSz3VtmmW3B/lNB4zMiw2V5JV
         Svq+nQT+S8504STonMy8q1ws/kJQI9nOGz8scTyhsyE7QcpKJVRzCGVVdgQHX6hE5vr7
         U5EZY+J1UQyCXK3l/9yhmq4DvsBjB+sdmINmOMUqUehv3DoaSyIwpe3qNxdtaNxsRoRR
         w6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hGwJDVxaOZw/rA7m2eTDQSxQQORKcDebEzAg7BkGlAg=;
        b=BKiZ0xfavmRoV5zL7ZFB/l3SGr+krl9D7HG7tFW+o9sZI1puuFMZMeqBjjqzIbVgss
         PmnvKjVgF8WRcRTfKth4w7pxqqLXr++ouTbDFHPRBy7Km+I+EDhL5AGOEkm1UfPzniGu
         aWdPBrnaXddJE/taLYlXmwEX+3N+gtGh2vdEvfz5iZroEoS7s8pX7sOlxt2EtAs4riyV
         ZQS1xwQ053lf0Ms/DNSERHGEcNTiZl+5yvPT82EJZtDtWfJqk87LQkhTOucibpI+1h5p
         pqG1XTyF+U+FRG51QzSDEV+PRhX/XR/PzY4iw/HR8ZW02t4Zn7hj8HmYQw+Vt6W8cCJW
         D26w==
X-Gm-Message-State: AOAM530bTpXJPLMC5bV+da+Bf0EZA4LXOcXg0X1BuQN6IjcoJpe3bX/7
        d2uI7JXYhzdos0azj10Vv74qFBnw9NT83g==
X-Google-Smtp-Source: ABdhPJxH/bQgDSa7nGgjtThh2zCW38I1O9fmJCXikr6FDOXnYVfVUZhBfPlRuh6nmOSFfGNV/SI+FQ==
X-Received: by 2002:a62:18ca:0:b029:1f8:86c9:2330 with SMTP id 193-20020a6218ca0000b02901f886c92330mr28444175pfy.15.1617723046612;
        Tue, 06 Apr 2021 08:30:46 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id k21sm19065378pfi.28.2021.04.06.08.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:30:46 -0700 (PDT)
Subject: Re: [PATCH] swim: don't call blk_queue_bounce_limit
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210406061725.811389-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bff5dbc5-d895-ead9-f468-75b56bab5579@kernel.dk>
Date:   Tue, 6 Apr 2021 09:30:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406061725.811389-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 12:17 AM, Christoph Hellwig wrote:
> m68k doesn't support highmem, so don't bother enabling the block layer
> bounce buffer code.  Just for safety throw in a depend on !HIGHMEM.
> 

Applied, thanks.
-- 
Jens Axboe

