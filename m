Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7213C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFD321721
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D+A6hQDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfFMQ3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33880 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbfFMIfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:35:23 -0400
Received: by mail-yb1-f196.google.com with SMTP id x32so7512376ybh.1
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPqoaHNDR3sZCgHnG0+QvBRj7hSSAwLDpGCasb6iY6c=;
        b=D+A6hQDVvHdY6EGiGZWWAElDBlP0ebInQgsiKbs6FqIIqUX/wdYr/19y7ks9/8gGKc
         eSeYBktBP9VKjPdGG9GyG/7/g6RdQtrmPXb2/hkRGyem1AACuMR8gDFY/xxrRC0vM8H5
         JnYMKZbWLCNlNRjh78CNmo61/8mNqbttMXgvvaKSI2FIwmuzxIe3uFoQIXXW9VZaTCrY
         g3fHJFoBnToS4pORunSextxuLOjjQqHY0ZnxI8x3/VaYFFCcCJznAVzc0y0+0ylJ0QnS
         qZeYOlG15eCAkY6Eap+PesOCmvoWPXGg6wBnX15Tr9VO/AoxO61pXWeZMJ+CuA/4puBd
         2UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPqoaHNDR3sZCgHnG0+QvBRj7hSSAwLDpGCasb6iY6c=;
        b=ezZKTRfYJaPVyqVuOhVbvExqLWpdL2BvTIUtSKaZp+cwhkB/W9rT+BJqoUBZkCotah
         nIyXpxpK4PQGVNPgRpOKUOfXKAXFPlR20nOd58e+7nH0A8PwWMNBtNPDsQ/NE69JZ+/a
         sR3+cgjqFkd6SkuP3qY7vD+NNkGCeWLdxW7SfaBQPHX20VQ+t2r5OsxJsgyCIbJMOkOS
         YYkJNX6PYXINb3drb9Hd6qn1SGZLME+GuUA4uNvEAOQsSd0qdLegzO1Yz8mr3bCd2pQ2
         EqmKAQFqShCYzb9CV3Tq5fecWji8PFWpKKwnveVPaw3opVHoZKeLuV34avQWnXn/5dfS
         QqlA==
X-Gm-Message-State: APjAAAXPRIuV20g1aNTFfSMpwGWBbnuWabPrf16HvAbIiE696LWAzXiR
        1F8Zr366H5eyoitbpFIUwOKx6FnC5KSRkQ==
X-Google-Smtp-Source: APXvYqy3D/obrwzFiQ17ObNknUGRRWjvyfoc6Ug2/bcUDKbkhrj61spDqTCyZNjFsJ0Hl6lALEa9zg==
X-Received: by 2002:a5b:9d0:: with SMTP id y16mr24818633ybq.520.1560414921963;
        Thu, 13 Jun 2019 01:35:21 -0700 (PDT)
Received: from ?IPv6:2600:380:9e2c:9b66:893e:4845:326b:1174? ([2600:380:9e2c:9b66:893e:4845:326b:1174])
        by smtp.gmail.com with ESMTPSA id a187sm624084ywh.21.2019.06.13.01.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:35:21 -0700 (PDT)
Subject: Re: [PATCH] block: force select mq-deadline for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Matias Bjorling <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190604072340.12224-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90c1cc58-0069-ce47-9850-4426dfa160a3@kernel.dk>
Date:   Thu, 13 Jun 2019 02:35:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604072340.12224-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/4/19 1:23 AM, Damien Le Moal wrote:
> In most use cases of zoned block devices (aka SMR disks), the
> mq-deadline scheduler is mandatory as it implements sequential write
> command processing guarantees with zone write locking. So make sure that
> this scheduler is always enabled if CONFIG_BLK_DEV_ZONED is selected.

Applied, thanks.

-- 
Jens Axboe

