Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9976C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92762184C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IBCkp4gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfC2OuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:50:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55616 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfC2OuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:50:05 -0400
Received: by mail-it1-f193.google.com with SMTP id z126so4082871itd.5
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4hFJxnC8iRWqjo0qKrPX4btOJ2zxCVRoqW+aDEDQVc=;
        b=IBCkp4gQAeRH4y1HGYXJinTTyIuieTNP5lcDgAuFwk1wq3AvxmgD46ivekZ89q9+9p
         kvAjNEUI1I8c9hASCy0fX0yaPPEvblc6WrYSPLTT+UaRMezuJ7FUrNx1I4LSiW/OqTDA
         V6vAGKiFVWUgAXoMmSBfFgcXTGoYqLYnm6Ih4BYRFSTjFGXjZ7ABzfo6X681WFdFdgU+
         M2+0/+CGtrS8uKRYbb0oJ0WkY7Ah5/FsrZ/iO5r7elWZAkmdXe1ADfoKJilSBegZe7Vv
         xmZy9m1B9OoRvKuvQI0XnzxxZh8QdNlwDC3hVYQVdL4AiihREqm6UgRnMB+/BG3WY335
         xs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4hFJxnC8iRWqjo0qKrPX4btOJ2zxCVRoqW+aDEDQVc=;
        b=H42AP7Bnlhy2yUdNRXGuhCWGAvxQiCQqOVtNiQT3wIqFNlghYg6pMqTPV7XJVlrC6U
         pV4kX20JsvLGwrI9IAzYzElxUmYHBmbUZZtKF5wSOLXcTdb+YLcfZ9yavnBx5m0ns0mu
         Vf5tZlgDnyeAHWpGxVMrzsW4qR0bGY8LjfENjQkY143dmACVxKwPwuc1S0ZZwqgd/wyG
         yMD+/9KoJUabXF8gMljZoTOz9SMJW7H+sbIzSLEZmyXPP4oC/UdMSaZlAtPduljkuzBn
         vSrY+cvII8X2iwRRweQ5g4zFmX0hmP+2JmBN9a0NlKHY7UZfOk6ZGd9WWnANUB2SA37A
         yXKA==
X-Gm-Message-State: APjAAAUYvrumwFXAM+y2w+GRfttLrZwCvAwswZQn/Lfo5xj/OTmhvjKe
        fCEbN3i4CCXuruq1h5Hm9qsMPg==
X-Google-Smtp-Source: APXvYqw1TIc95eQ5v2h1ew5imgN3OCGaWCfG0B6K1scASf3X+ESIiCTL3iMjTdW4o96gqr9JogtINg==
X-Received: by 2002:a24:3201:: with SMTP id j1mr5182494ita.107.1553871005198;
        Fri, 29 Mar 2019 07:50:05 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v187sm3479122ita.0.2019.03.29.07.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:50:04 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        adilger@dilger.ca, tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
 <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk> <yq1bm1trb4y.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk>
Date:   Fri, 29 Mar 2019 08:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1bm1trb4y.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:46 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> I didn't miss that, but it fixes nothing. That will unify the 40 bytes
>> with 8 bytes, we're still growing the bio by a LOT. And we can't even
>> nicely hide this behind some ifdef, sine distros enable everything and
>> hence we're solving nothing by doing that.
> 
> We'll just need to handle it exactly like the integrity stuff. We only
> allocate the extra bits when the underlying device indicates that it's
> required and desired.

The integrity stuff still has that nasty pointer in there. It'd be nice
to get rid of that as well, and hide it all in a parent container of the
bio.

-- 
Jens Axboe

