Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F41C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146A461104
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhHERuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhHERuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:50:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC855C061765
        for <linux-block@vger.kernel.org>; Thu,  5 Aug 2021 10:49:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bh26so6878677oib.10
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrz/c1Nrd+geJVnvm9c3w/g/qAKZTO4maWX/t7dL8Dc=;
        b=qPcKn8pPtCKRF+9MnIxby+qwMNbWeXgltvG46ncJnzg2PF5oEgUc+COsRsDMMy7Oh5
         SkDNsUb1Y3KvdO3Rst4ac2paOpEtjRMUG9pyRjVoRsHGlI8SjgfwNyzPZlw3Ol9/d7H3
         lvonllyHO4hOtxxYXAndnU29mZSKa4rHtkCWmwsbQbcbQaGoLuQM5AQR2DvtRYlplkGN
         QHLkx88eUY082P0SNcAyvfBBvaN6JZ0+RgaRQ0T64Ge4mtFA3GgY48b1ZgRqgzTYUWnB
         jW2bGJ96+cpy21E1bUBeybBxfVzJv0Yyo63CbYj7aAf2PjWqphRuSDl4Y8keINLA5cw7
         Uueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrz/c1Nrd+geJVnvm9c3w/g/qAKZTO4maWX/t7dL8Dc=;
        b=EG5xfaANlu5GEOCR0Mcv2GNpCh2XaiPB0DRaXEsAuHzA/asW968cZenSHXs4+fVfMo
         J5XaUKW2CVK87d/LP70+q3BWCz8IZ+7MAcENU9G529SGHzguQAOmoWqUuH+xdHZuZkGO
         3JExpzQeGwxBWWMQfT7bzv7EYm/AtixS0nh3D+Czl1KMaDG44m1xnjyykZ38z67dc/lt
         boGedzExGSEMRVbhKMvOkEyF8ypUlqZU0PGBZK8ewTlF/j9Qych7m4yUzjzIKEZgEwcN
         ormACgSCm+z1jKXfpog7nYvMyr2SbdWsxx9gxArJTourCzjbgU8gT1y+eD5HgcxzBiio
         JtNg==
X-Gm-Message-State: AOAM531y3MRuRSWoenMiDSHoor4AE4/VocK6VdNOw6ArhDmN6zAX+xZt
        gc1Wr6dKdZC+jQxnmzF9+M4okw==
X-Google-Smtp-Source: ABdhPJxDDayPojSwCyUlnkXIsiyv/8KmEAbPCKwpHTfhPzKjZgM53XFKe3bC8FJbqPa6nRMRFir5ig==
X-Received: by 2002:a54:470c:: with SMTP id k12mr5577712oik.126.1628185788192;
        Thu, 05 Aug 2021 10:49:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l19sm705865ooe.20.2021.08.05.10.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:49:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Change the default loop driver I/O scheduler
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210805174200.3250718-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d34ad5c9-bbbb-5c64-919d-e8dc23d1d0e8@kernel.dk>
Date:   Thu, 5 Aug 2021 11:49:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805174200.3250718-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/21 11:41 AM, Bart Van Assche wrote:
> Hi Jens,
> 
> The two patches in this patch series change the default I/O scheduler of
> request queues created by the loop driver from 'mq-deadline' into 'none'.
> Please consider these two patches for inclusion in the Linux kernel.

Applied for 5.15, thanks.

-- 
Jens Axboe

