Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B624C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718F21934
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 16:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yrqMbocV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfBMQZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:25:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41370 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfBMQZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 11:25:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so5194422otk.8
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hBD/Jo8/wLvcfqtc29UV6KYddakyQ/RdI5PpCOitMGw=;
        b=yrqMbocVzXqDEYUTqzAJ3dM6/bFXeXoow3ZqY2dNdJqycQFMxqpuOZ9dP2PUlhHCvL
         2DX8zcmBRYD8z94fgtpK/xy/FzDN7dr1/q7lCz3n4gig40GnLS2/D6ol311HwCg26d2Y
         LiHoUiEEM+cg9/9ydcQotNLqf/GhUU2qBlpN+6S0TbwLrTqrPPgVH33ATVVnZMGIo7Ai
         OM5iFkPn9s0LvWWO1OJhFkkXH1XkrDZ1fpxcyIGPHYYiTbMkCHNO8nDcRlBNrOMd9f86
         x8I2uCJCCtQmTNxU/HWclwtfK3r7LYbeHQRpDCuoKb2cLxwmDf2H3kfM7U6z82g8MN/4
         +5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hBD/Jo8/wLvcfqtc29UV6KYddakyQ/RdI5PpCOitMGw=;
        b=sZ5qFv3iFD/CFC1kRE1JlgdL+vmhT5eQChHtBT+NdaDIWhFDkfnjzSHCJ6qJDoxvtx
         Yxe2Jr/goLfsRWROGjKr/UrvHisXzcaBOXtUEO/WvR39tDPaZYI6U1EVFBdQFHZ5/RzC
         Htcv5P+X2g+1l7EZf/qO2aqiZhNrfl7SfSpDdpDGf+1kKSJ8kbpQ/XmIvR7SuxYXRoHF
         r5iFS3u+DtP9KTv8zWFbiAoI6yWaJXn5VUgVdjdgdzgnhfbQWbt22VVDv8h015g9M6pl
         kAc5gm3yhRqg6OjYV9e0dTwFUgxsRbPy+BnujWyLDcvrs521Ium3AbEaU+lkM313W9ZV
         3KYA==
X-Gm-Message-State: AHQUAua2/fzmPVUSQxA/pfmlFTwvK5A74v1kU2UkSZyNUfHmGr5yjl5/
        YQ90ZxMObHoLYSv0DmEs9TmNTg==
X-Google-Smtp-Source: AHgI3IbK1eKY1TxpP/SCgoawfnyBTe2w4VmMf3SQ+TQObDIYJjcN9xXpsWsHAGhGTqgH7kZ4XlkQ1Q==
X-Received: by 2002:a24:14cc:: with SMTP id 195mr686674itg.47.1550074693660;
        Wed, 13 Feb 2019 08:18:13 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w13sm3688270itb.10.2019.02.13.08.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 08:18:12 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/9] block: add rd_hint to bio and request
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-3-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2aceac4-7626-0aa9-ec15-eeca50aac442@kernel.dk>
Date:   Wed, 13 Feb 2019 09:18:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213095044.29628-3-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/19 2:50 AM, Bob Liu wrote:
> rd_hint is a bitmap for stacked layer support(see patch 4/9),
> set a bit to 1 means already read from the corresponding mirror device.
> 
> rd_hint will be set properly recording read i/o went to which real device
> during end_bio().
> If the upper layer want to retry other mirrors, just preserve the returned
> bi_rd_hint and resubmit bio.
> 
> The upper layer e.g fs can set bitmap_zero(rd_hint) if don't care about alt
> mirror device retry feature which is also the default setting.

You just made the bio 16 bytes bigger on my build, which is an increase
of 12.5% and spills it into a third cacheline. That's not going to work
at all. At least look at where you are placing this thing. That goes
for the request as well, you can just toss members in there at random.

Also, why is BLKDEV_MAX_MIRRORS in types.h? That makes very little sense.

Look into options of carrying this elsewhere, or (at the very least)
making it dependent on whoever needs it. This is NOT a negligible
amount of wasted space.

-- 
Jens Axboe

