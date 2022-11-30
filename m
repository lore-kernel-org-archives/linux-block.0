Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C47C4321E
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 22:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiK3Wwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiK3Wwp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 17:52:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93EC1B1F6
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 14:52:43 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q1so39401pgl.11
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcDS9MqlzY9dwBBZ/FN4VCSf99L/TAy6gl0f+4+Jcqw=;
        b=xtuRZMafRUKS1VuIlFVCxs9bmAEGBQWvv4PNrcCOndpuA6bj0xK9nJRlt6PDoQpZXV
         22R7uxY8vXuBwbV+xoh9velDiRyoguMbuNIcEiGEMEh0G7Fq7LDwGCTeOcV5KX9Gmx7Z
         MwMi58K6XzXeCKojcp5eJpckUAbdBCTa+JE+r8up4KFVN6gzqozTEILkHLWwnGW2iFnX
         pcQquRODQu67+oWVSSKUguR9hqubh5+Ja4omxZZKtS1zUPVBcYGqxnICcrrq5UWHpCyu
         o0myZDB4UjRoEeaCvaXtZkxGljsB0IO0ayWn5Qe0D7qQjppz/c+RG9oidPFj9D7bfI2r
         cMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcDS9MqlzY9dwBBZ/FN4VCSf99L/TAy6gl0f+4+Jcqw=;
        b=C4OE2t0NXO/Yr9JlTl0lVgkpkraJA+aPr07GXm0YYOccIZ7dAOQUCK60YdoPlinWxN
         /fMCSbvFUafrklkRZz7i3Am/ttO37XLnk4wprOwGzntemC2UEB7LiqhaZaJ8auBuyIke
         eqmdoqg+ooWSXhYpiMZc5KM4tERLnxq8RWzqDTzR2NunN9UvSb2kAwHu2yjFffROPdky
         hJYMVVZc1gZqMrNKarSvhYMtUq+X2tEAYu6D1A2ucd3Vi/VWmZI3vsp1jhTwHejI4RIJ
         vjoeS2pWMVKos5+9ShbCpB5/GPGkIT/mSoKXIP47/U2amJle37l7sHU13Coomi2jv3de
         b9Mg==
X-Gm-Message-State: ANoB5plQnFFpECZTd4PLIn/io4moWv3z+ghrK0vC3G95zZkyq8cvH7kg
        Hq5aDz8CBaCmfsbHfwf6HkY6L2nO2X6gdnIG
X-Google-Smtp-Source: AA0mqf4MVqKO5wjrvcsI8NeOZ4udOWTEE5y5azU7F8W2HQCK70FSuLYZAPJ8HgHLQRnv4CHcwT2VDw==
X-Received: by 2002:a63:5c0f:0:b0:470:8e8a:8e11 with SMTP id q15-20020a635c0f000000b004708e8a8e11mr38266253pgb.490.1669848763299;
        Wed, 30 Nov 2022 14:52:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0018912c37c8fsm2001951pln.129.2022.11.30.14.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 14:52:42 -0800 (PST)
Message-ID: <0afd657e-ccce-5cbb-dd26-c2c07e2f59d8@kernel.dk>
Date:   Wed, 30 Nov 2022 15:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
References: <20221130175653.24299-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221130175653.24299-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/22 10:56 AM, Jan Kara wrote:
> Since commit 10c70d95c0f2 ("block: remove the bd_openers checks in
> blk_drop_partitions") we allow rereading of partition table although
> there are users of the block device. This has an undesirable consequence
> that e.g. if sda and sdb are assembled to a RAID1 device md0 with
> partitions, BLKRRPART ioctl on sda will rescan partition table and
> create sda1 device. This partition device under a raid device confuses
> some programs (such as libstorage-ng used for initial partitioning for
> distribution installation) leading to failures.
> 
> Fix the problem refusing to rescan partitions if there is another user
> that has the block device exclusively open.

This looks nice and clean to me. Was pondering whether to queue this up
for 6.1, but it's old enough that I think we should just funnel it through
6.2 and mark it stable.

-- 
Jens Axboe


