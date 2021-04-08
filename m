Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE9C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF607610F8
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhDHQZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhDHQY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:24:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B46C061762
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 09:24:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so3473584pji.5
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9qVeCK4vS6vpZSzxYALrDHb+JmD6zco2ydcMgklB9rg=;
        b=wNp+cuWAbmf8tZP6jrJbqvDhJuh/FUfrnYS2kMItEnzQ2TQU1RcIcRaePIlrhLWrsI
         Tj3vBPNwrrUVGbuQZeg77q1LhEoMbU0MSL3qRxQG31vn9jbm+dkR1uVbijNhMcD2cnl+
         E5FV99t8zy2wMDGNQjJyhnudM435VSeK+8hm0wHBDREUImk6w3fZ+QdCLHEUOW5dV7Eh
         QZiS60pPxxwJp9lF8wh90B/TXlUxGdjGXBEAPaHIjsDTLrPQn8eDY/DmAbS6KvMFm2k7
         HKG8UkhPhkJFO8aLyd1jG9D/kDJbOgNiCR0NHQjZbTnBbhlfszS6VckC7Wr3x0xpRXsA
         r9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qVeCK4vS6vpZSzxYALrDHb+JmD6zco2ydcMgklB9rg=;
        b=XqRhdTjqckTc4sWPHGLjmo+7ryL6cIH6CEYXZyBxGtfcB7+JRRq6+Aga91qOQ8HtvR
         8Mv/OcTPUkzxKAKDRqaUltvfBanBmHmAKiAhJm1lIIErOmhalk8Vw4UeWd3A2mA9fm+/
         jGOLhDBFZJJayUxz3GNxi53FSCVGXyjClueWqdxIN4tr1XotybCM1HvjF1xyhofNLy7n
         gWtrKWJwAdxk70NbqX3/V086EnyAAyxP8bmTWsySIF+WIdEU1+i+mGn2nM1KAfiVoFzq
         eeDTZS8PiJkEfTz81ZgHjzuzrYQn7UxaxtFpy3+FlEaz1kT9KS5C2s9yPUjl/8c0sJMK
         28aQ==
X-Gm-Message-State: AOAM532L0YYjPZ+lLBFC291xqFBawauOf79jXuyrYQdDOIDwtJrk9E1A
        BrKYADI5Gof4Vj0uu3xCQCzQuA==
X-Google-Smtp-Source: ABdhPJz+1lWdnJ8vpxYUdzLO/CmMzDE28rZDhEp3J+v+oMy62Y+cZQfIXzEP597lMYyyoCVPmZHQIA==
X-Received: by 2002:a17:90a:f3c5:: with SMTP id ha5mr9471466pjb.54.1617899087246;
        Thu, 08 Apr 2021 09:24:47 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v135sm25742226pgb.82.2021.04.08.09.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:24:46 -0700 (PDT)
Subject: Re: partition iteration simplifications
To:     Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210406062303.811835-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30ca9cf8-b15f-d50a-288f-a43eed1cb20a@kernel.dk>
Date:   Thu, 8 Apr 2021 10:24:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 12:22 AM, Christoph Hellwig wrote:
> Hi all,
> 
> with the switch to an xarray for storing the partitions of a gendisk we
> can now use the xarray iterators for iterating over the partitions and don't
> really need the disk_part_iter_* scheme.  Also clean up the teardown of
> partitions where I think we have a (very unlikely to hit) race currently.

Applied, thanks.

-- 
Jens Axboe

