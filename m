Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BBC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 10:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiCNKuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCNKuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 06:50:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28CB30F49
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 03:49:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt27so33004991ejb.0
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5v+MbMpFwg12ZX2fkGk7jqjd92RrZHcnEuh9hvS+YHI=;
        b=dZ8KDEoSKuDC9blyTD9k4H0c1K4dMSqu+QpOBBRWjMxP4Rpt4fdnjF7ebkvyeUl+8M
         ekRE0TP43x9TzYVgrWobsnR8jTXAfL3xMdGCx8uu+VDGtfXIwHKIzeiCm6Gd2TsH0Y1V
         9rSDwAgcFQlPflwVi7xekZhZsFkE8WXgbeymcEARdnSksRP5uee88/YGTb3F1h4097r1
         xtdxtMmzAhc7jLqqkjBtGY7+SIMrPdRntgjTfdDxbph/wK3nh3zHJ4Zk4nX5DVsxSujV
         JfRJosLqrIJR1XwqOoiCj5HwAY1AVKs55LcByxjGE6yYYRPZkzP6P0CjmGydgaCsLuKi
         3Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5v+MbMpFwg12ZX2fkGk7jqjd92RrZHcnEuh9hvS+YHI=;
        b=1nipPmELaF7OT2i8yIpxA2vBBF4w7ekWkESANlu0IJTCDTIMjGYI5dwZSRswYAJ2zk
         xZKAVpcrB6W8TvENHgDES+xDKTZtT9Su3q3pJ/2gZ9BJOtbPMxb/X5Ego7kTxjmq6dWk
         +JJLHD0p2v6F/cWr5J9aL6CJiEq4Qo0F2AcPtDeRg3R66rtQjd4TpB0m0GArfGvrxs8D
         Us6gjngiA0P3B+eJGLty03F4945QNHCvxoTFlm+w3SN45f0QHQQKVb3ai5jOfjZc7xl7
         ZrSYW81EsEZo5vKdYKyGnA/ngeHQpG11Bpk7TkGLYnZ6+oGijXVvfvLcUxKtEqPty2u8
         8xvQ==
X-Gm-Message-State: AOAM532lCbmGHo8mrqFrDhdm7AAf2zLQuFPrSFqSi9Jv6qRsnhoOQ5WE
        5ggdZrw5eS2fP/RLVovl42949g==
X-Google-Smtp-Source: ABdhPJwUB7QvmU2/DQ4a1BV7hvOsqGzdgORi48giRQu8+k6H2+I+u0SCcfcXrBNmoQAUv9JH+vVwyA==
X-Received: by 2002:a17:906:8585:b0:6db:2c85:2bc8 with SMTP id v5-20020a170906858500b006db2c852bc8mr17716374ejx.747.1647254980245;
        Mon, 14 Mar 2022 03:49:40 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402254900b00416b0ec98b5sm6434619edb.45.2022.03.14.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 03:49:39 -0700 (PDT)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Mon, 14 Mar 2022 11:49:38 +0100
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
References: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14.03.2022 16:45, Damien Le Moal wrote:
>On 3/14/22 16:35, Christoph Hellwig wrote:
>> On Sat, Mar 12, 2022 at 04:58:08PM +0900, Damien Le Moal wrote:
>>> The reason for the power of 2 requirement is 2 fold:
>>> 1) At the time we added zone support for SMR, chunk_sectors had to be a
>>> power of 2 number of sectors.
>>> 2) SMR users did request power of 2 zone sizes and that all zones have
>>> the same size as that simplified software design. There was even a
>>> de-facto agreement that 256MB zone size is a good compromise between
>>> usability and overhead of zone reclaim/GC. But that particular number is
>>> for HDD due to their performance characteristics.
>>
>> Also for NVMe we initially went down the road to try to support
>> non power of two sizes.  But there was another major early host that
>> really wanted the power of two zone sizes to support hardware based
>> hosts that can cheaply do shifts but not divisions.  The variable
>> zone capacity feature (something that Linux does not currently support)
>> is a feature requested by NVMe members on the host and device side
>> also can only be supported with the the zone size / zone capacity split.
>>
>>> The other solution would be adding a dm-unhole target to remap sectors
>>> to remove the holes from the device address space. Such target would be
>>> easy to write, but in my opinion, this would still not change the fact
>>> that applications still have to deal with error recovery and active/open
>>> zone resources. So they still have to be zone aware and operate per zone.
>>
>> I don't think we even need a new target for it.  I think you can do
>> this with a table using multiple dm-linear sections already if you
>> want.
>
>Nope, this is currently not possible: DM requires the target zone size
>to be the same as the underlying device zone size. So that would not work.
>
>>
>>> My answer to your last question ("Are we sure?") is thus: No. I am not
>>> sure this is a good idea. But as always, I would be happy to be proven
>>> wrong. So far, I have not seen any argument doing that.
>>
>> Agreed. Supporting non-power of two sizes in the block layer is fairly
>> easy as shown by some of the patches seens in this series.  Supporting
>> them properly in the whole ecosystem is not trivial and will create a
>> long-term burden.  We could do that, but we'd rather have a really good
>> reason for it, and right now I don't see that.

I think that Bo's use-case is an example of a major upstream Linux host
that is struggling with unmmapped LBAs. Can we focus on this use-case
and the parts that we are missing to support Bytedance?

If you agree to this, I believe we can add support for ZoneFS pretty
easily. We also have a POC in btrfs that we will follow on. For the time
being, F2FS would fail at mkfs time if zone size is not a PO2.

What do you think?
