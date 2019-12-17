Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0CC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B0124655
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ln434Cl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLQQmi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:42:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41666 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLQQmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:42:37 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so11744482ioo.8
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85tJwjfPsvm0o1CtqUKLxcZhYUO7faTPrBd2G2sD4nI=;
        b=Ln434Cl87LG0Fhc5QQ+fjnUtO5EBQMmZiQA99NPbXKIHMXwk/CPV+7eXQR+spZiR05
         7NZSGPylcPDhe+hrtQph4Tcz0HA/+Ps3tu/nv5ff6mp21dQy/mT2GfSpvy2N/T6TD1n8
         y7F97PxPMZbr+l/VcpvRiEZuGi6A7oz61Hv1tz6+m5uZtiCdhpmrDGf1JSiEfNX9q2XT
         ePkiPEVerc7ksamxDVA0yRuJogydPUe7WKUtflNHHlZ358RLNEeBBDLR/nh8su474x//
         /ViR/BWI7rg1ZfJ8neJTkrDj2ChUBd4naTOK7WEH37/hFINrV+PS56fZ3tN2QekQzt53
         1Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85tJwjfPsvm0o1CtqUKLxcZhYUO7faTPrBd2G2sD4nI=;
        b=KyzSbyfQMPtKR8RZB9CPJmOuqJe8el0j4wxSmD9BlX8wkWvU2YU53ptAjqx7lULM+s
         oyUUtgYXQwbwyLwWQ2CD7NrsM/S31LOjiKtwxJwGwBaI+J8we6Rm+oE/5EFrG0P+233M
         iIcy0hWZc8BLTI6Aif42awpuytxg5vtgAGD20MmnGydWJGkLIvxOAp9pADBRQ/V2ODAA
         bZ4UmM7v4aMK/eQ/g3MpucF+n+Db7w2CiEGXxryepsV7BDmBZlbJPxQm3bzgyqlFBoP7
         ln7rzm3xXgHy6fp24dllDlSFSX56XGTLi7pZzzY0XDANGrWDOpPpWTmJMZait8TeGOhj
         zvqw==
X-Gm-Message-State: APjAAAXW1OSMkus6z1brfhm3veIZOk84uB/tbDEhvnOCMSpYb36g7Q43
        MjZr5J5v6FX/BszVnB20Hm2M6Q==
X-Google-Smtp-Source: APXvYqyYO5RxUVG/bXRqYescBr8YitSiwk6ahy0P0Apkt/Qsr+xKR6Zn0kyBe2qQk4SjmxlWjKkIeQ==
X-Received: by 2002:a5d:9d4a:: with SMTP id k10mr4619158iok.134.1576600957011;
        Tue, 17 Dec 2019 08:42:37 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y75sm6925426ill.87.2019.12.17.08.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:42:36 -0800 (PST)
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
 <1d0bf482-8786-00b7-310d-4de38607786d@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb1112f5-01e7-4c6b-361c-213a919d9529@kernel.dk>
Date:   Tue, 17 Dec 2019 09:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1d0bf482-8786-00b7-310d-4de38607786d@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 8:16 AM, Guoqing Jiang wrote:
> 
> On 12/17/19 3:39 PM, Jens Axboe wrote:
>> If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
>> pages for the buffered reads. These pages will never be inserted into
>> the page cache, and they are simply droped when we have done the copy at
>> the end of IO.
>>
>> If pages in the read range are already in the page cache, then use those
>> for just copying the data instead of starting IO on private pages.
>>
>> A previous solution used the page cache even for non-cached ranges, but
>> the cost of doing so was too high. Removing nodes at the end is
>> expensive, even with LRU bypass. On top of that, repeatedly
>> instantiating new xarray nodes is very costly, as it needs to memset 576
>> bytes of data, and freeing said nodes involve an RCU call per node as
>> well. All that adds up, making uncached somewhat slower than O_DIRECT.
>>
>> With the current*solition*, we're basically at O_DIRECT levels of
> 
> Maybe it is 'solution' here.

Indeed, fixed up, thanks.

-- 
Jens Axboe

