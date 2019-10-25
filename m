Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F27CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A3921E6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="st9Tyicw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJYUZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:25:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45398 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfJYUZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:25:49 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so3824611iot.12
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWlX0Fem2kpGy9gEKeAraGn+PeNBOB4tCP0K20nK+rM=;
        b=st9TyicwUYNBUrPw/AKthdco114fqflwKJDzdgA09bwkPZRVco4/SGO6THATNGNZzH
         nu8zMNJjQRfdGYtyWrOD6K+XRK8ajGd5bI97yIa80+8oJVqFMIq3B4Mp2CXiBfQFjNau
         s2om6raLdgeCHOKJePr7ixR4DdzgOoQlXd0Wh0oBznpUOLuFq99I7HwZulJH01EtwJ4Q
         ZZbjwXpPvyOw6DX2Oy2cGvl1uQtey3mR3X1UDLX8ij3FWgK0rd++pc7MqsfpzJitup3B
         hzhgkUhTTy4df0ABVDzBejiCKZMM4ta72mCveqKyn4/ZLSOauTacReFTWvzEPOqmvKS2
         MVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWlX0Fem2kpGy9gEKeAraGn+PeNBOB4tCP0K20nK+rM=;
        b=bQWNSbbXgqS5xQBpEp65dSwkvYHSFUoyJ6HzolcKRaeBinrpfvYK2aqHpqBk3E2sL9
         nyytdG8IHGNkhl7l5UcPK46KYPIWQHqThRaLtG6QvlzWiDgCz637IPQsyv/t8vakEa/P
         y0r237LP0OR07IO2kS/hnztZpBdrwLGa7X3G+AKFOp9eM3Yz+c0oTEQxs8Z5ZEQyiQc8
         J3HLP1nYGZIcWS3MeIhbKyiqIJn9/wYi1y6NLQ/Z9AOZu0szUZUqBLmf6uwx7LrvWMQN
         dc3icumUMkRnDNkll9mqKeD4cgMXDVaIZirzOwyhYo+yl5Vhig/etCTzRRgDdYLt3k4P
         iIKw==
X-Gm-Message-State: APjAAAUjKTv3msEuefBjZcjpRnd2KFae+F9ckXLLfcs/iXCHMPgooFxO
        XM/T6/SkglWewjK7dLVbZFHl/FUf58r6ZQ==
X-Google-Smtp-Source: APXvYqyVONCpnmmloHEF0tgYQk+k7LBxx/KFv6wd7BOqZfAaPb6YYXdKC1F8U/UapyjlbUaiIjpZIw==
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr5683934jah.82.1572035147280;
        Fri, 25 Oct 2019 13:25:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g8sm450618ilc.60.2019.10.25.13.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:25:46 -0700 (PDT)
Subject: Re: [bug report] null_blk: return fixed zoned reads > write pointer
To:     Dan Carpenter <dan.carpenter@oracle.com>, ajay.joshi@wdc.com
Cc:     linux-block@vger.kernel.org
References: <20191023130623.GA3196@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <658eaf70-beaf-240c-199a-e54a22d7095d@kernel.dk>
Date:   Fri, 25 Oct 2019 14:25:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023130623.GA3196@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/19 7:06 AM, Dan Carpenter wrote:
> Hello Ajay Joshi,
> 
> The patch dd85b4922de1: "null_blk: return fixed zoned reads > write
> pointer" from Oct 17, 2019, leads to the following static checker
> warning:
> 
> 	drivers/block/null_blk_zoned.c:91 null_zone_valid_read_len()
> 	warn: uncapped user index 'dev->zones[null_zone_no(dev, sector)]'
> 
> drivers/block/null_blk_zoned.c
>      87  size_t null_zone_valid_read_len(struct nullb *nullb,
>      88                                  sector_t sector, unsigned int len)
>      89  {
>      90          struct nullb_device *dev = nullb->dev;
>      91          struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>      92          unsigned int nr_sectors = len >> SECTOR_SHIFT;
>      93
>      94          /* Read must be below the write pointer position */
>      95          if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>      96              sector + nr_sectors <= zone->wp)
>      97                  return len;
>      98
>      99          if (sector > zone->wp)
>                      ^^^^^^^^^^^^^^^^^
> 
> Smatch complains about "sector" being from the untrusted all the time
> and I kind of just ignore it these days.  But here it looks like we're
> checking "sector" after we already used it so that seems very suspicious.
> It feels like "sector > zone->wp" should come at the very start of the
> function.
> 
>     100                  return 0;
>     101
>     102          return (zone->wp - sector) << SECTOR_SHIFT;
>     103  }
> 

Ajay, please take a look at this and send in a patch if appropriate.

-- 
Jens Axboe

