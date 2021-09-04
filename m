Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE99C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 04:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E100A61057
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 04:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhIDEP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Sep 2021 00:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhIDEP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Sep 2021 00:15:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA9C061575
        for <linux-block@vger.kernel.org>; Fri,  3 Sep 2021 21:14:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so983026pgf.5
        for <linux-block@vger.kernel.org>; Fri, 03 Sep 2021 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UcWvFhD5MwoDOY9PK4UK1BXsroFoPK/symV/Mv/nYak=;
        b=jo/iov4YMXoolTUq5oPel3fZyNKHfn6f5Y+AIfX6NcvOa1M26TpPb0Bh3qsOr8mxsS
         UYPr72NJiTj3kVO+bKXhbhzj3kVmgpdNBSTN0SxM1v+NAoeeKG7ffqNgGVqGkr+QxadX
         JbdvaV6ZTbNV9d2OyIydb6OnEZKxT7xCQKpNa4PQU8F0yPRXOoZUE6vGfnLk3dWsAQa1
         3pbcHuXTMfs/DfZGXZulXy54NsbF7pB+aPJ18TNwLUJcLlNQXh4lUXO/FzkUZHGdwfp6
         iGnZNi4rm2EDWCYvN2AgZ78gVbJR18QIEXpMuoujflk6tjY55HFg0ffLcyhshW/bERE8
         /xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UcWvFhD5MwoDOY9PK4UK1BXsroFoPK/symV/Mv/nYak=;
        b=swWLJihUXIU7iP9hQP4eJUxfPRb+bAcubF0RvP1wdlU7MRHHW6ubOtjufHfLw0t3/v
         tSXZnyIyuJcwD00hC9sVK/eRbtYemJFPnKi8saQUly0hMsHb466AUpBS6hLl/gnat4FY
         uELMWW+CEPWs9p0XYZ0eQLK1GDW27MaZ2+jU/f7QRNmWwhlXHv7Cg3+KLX2p5D/5NmC5
         1G13OFd/B6Cd0UHBwFPUIjqDgQ6+O6F4qwab2/qcxhDbmsMB3eXT+XjcMSMrwvu0DOUK
         b+pUbidXe3tO9EIHucR0Bl4daUWJjVb3/sZ4SL8lLeLPuTrswQcwhhE3z4cEqhhicaiY
         rT0w==
X-Gm-Message-State: AOAM530gEhrqnU2erSPcHWkUXMRdSHvNtmlDRYp8pG2yD7npHnkHiu8o
        kulo4vD5AQQO6SgfAwVTe8qRE0pECfK1SQ==
X-Google-Smtp-Source: ABdhPJw0BwcU6L5s0iWqnrPjqUKsSN3rK4/PCGHgeE0xpxGbPuvkKdOUwwFScJg+urdS8+VWqTT/mg==
X-Received: by 2002:a63:7211:: with SMTP id n17mr2023331pgc.456.1630728865216;
        Fri, 03 Sep 2021 21:14:25 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p4sm869536pgc.15.2021.09.03.21.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 21:14:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Luis Chamberlain <mcgrof@kernel.org>, hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ae5f0d7-66f3-83f3-8692-389587369a5d@kernel.dk>
Date:   Fri, 3 Sep 2021 22:14:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/21 8:49 PM, Tetsuo Handa wrote:
> By the way, Jens, will you pick up
> https://lkml.kernel.org/r/adb1e792-fc0e-ee81-7ea0-0906fc36419d@i-love.sakura.ne.jp
> before these "add error handling" changes?

Yes, that one is 5.15 material, the rest of the error handling changes
are not. Hence the ordering follows naturally from that.

-- 
Jens Axboe

