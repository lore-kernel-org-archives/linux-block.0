Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F3C4346E
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E934F20897
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="MBlPipWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgI2JZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgI2JZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 05:25:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BFC0613D0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 02:25:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so13923464ejr.13
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Eo+z2/XPX9KqvAntC0eg29WykmGoGJYNJE8Hmye2bYI=;
        b=MBlPipWPxjPPHW1M71myTFPsbocczwAG2AB9WC6x9p4BhG4Kh4w7mmvoiUQ9664nmu
         GWAxoISBrizY7bBXj7NkjKeuTf3gf4c+ENy0nTO6AyuwraoFhqAIfetMbMX0U27MEHqz
         BoX666NdU+M9Tr63H9y1Bn5e3TD2li30OpJe2wHnCfHcDXL/jSVpq4bRclBsyIs0Gr/0
         jQqkSVEdJE/9JMmcvu14mZEdhG/1sFdnO7Cz8BiQmBv7R5y6JCfqAtWT8bvADjwxMsgM
         iYyVpTYAFmpnl/acvSGzAqwzVHQwjnQMRYEutmqEhXZw6JijJC4bZMctEnxZEYZkekBO
         elWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Eo+z2/XPX9KqvAntC0eg29WykmGoGJYNJE8Hmye2bYI=;
        b=YIIc3VO+ClSYHAedFAagcfO9msdbYrBmT3VLGKD6c7rzqaOJTmvcnKF0b3tdRaisYj
         M30a9xk4kyp+95fapZZMVEBLPtmSLMqPRzXxnyVW8HWtEeIim/I6blw4n8KE70rPgw4s
         yYGJX9O2VR7A3O3uA0qGItyXYP1CLx9AQr9YeU+9ylKMxSr1EYeSViz0/mzbN+s7TLk1
         f18XTn9j0c+tcsav0NjhKhgTYzodWWybGU/TP2p07GqwXv1Yt8wF0SbnpOy9/Xgve8ZN
         WgRNW4ynrZhQuv92kUATlVLRLmh7IcsYujj5JW7NqjrL2wQUrHAGesjvLSBmbsAAm/jI
         Lflg==
X-Gm-Message-State: AOAM530sWalUZsgKL1R/ZZGiJdnp1WaJfKLNlImSfZojMX0+OEeGicEH
        aTTsnncGa1SaKNWRawPR51iSIsRfpRvkdw==
X-Google-Smtp-Source: ABdhPJwmUOq2dOapktMQ+kiOOey6ddV1sydIapnSqsDovRws4juNOXlmT+6CNJQT4sFSTE55bP9aaQ==
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr3009634ejk.141.1601371511314;
        Tue, 29 Sep 2020 02:25:11 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id q3sm5524721edt.1.2020.09.29.02.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 02:25:10 -0700 (PDT)
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
 <20200907081824.GA260080@localhost.localdomain>
 <20200917075647.GA20845@flawful.org>
 <SN4PR0401MB359871B467B7F5FDB3115ADE9B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d562372a-eeec-a0e8-cfff-9301cf0a8fb4@lightnvm.io>
Date:   Tue, 29 Sep 2020 11:25:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359871B467B7F5FDB3115ADE9B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/09/2020 09.46, Johannes Thumshirn wrote:
> On 17/09/2020 09:57, Niklas Cassel wrote:
>> On Mon, Sep 07, 2020 at 08:18:26AM +0000, Niklas Cassel wrote:
>>> On Fri, Aug 28, 2020 at 12:54:00PM +0200, Niklas Cassel wrote:
>>>> Add support for user space to set a max open zone and a max active zone
>>>> limit via configfs. By default, the default values are 0 == no limit.
>>>>
>>>> Call the block layer API functions used for exposing the configured
>>>> limits to sysfs.
>>>>
>>>> Add accounting in null_blk_zoned so that these new limits are respected.
>>>> Performing an operation that would exceed these limits results in a
>>>> standard I/O error.
>>>>
>>>> A max open zone limit exists in the ZBC standard.
>>>> While null_blk_zoned is used to test the Zoned Block Device model in
>>>> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
>>>> mostly follows ZBC.
>>>>
>>>> Therefore, implement the manage open zone resources function from ZBC,
>>>> but additionally add support for max active zones.
>>>> This enables user space not only to test against a device with an open
>>>> zone limit, but also to test against a device with an active zone limit.
>>>>
>>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>>> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>> ---
>>>> Changes since v2:
>>>> -Picked up Damien's Reviewed-by tag.
>>>> -Fixed a typo in the commit message.
>>>> -Renamed null_manage_zone_resources() to null_has_zone_resources().
>>>>
>>>>   drivers/block/null_blk.h       |   5 +
>>>>   drivers/block/null_blk_main.c  |  16 +-
>>>>   drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------
>>>>   3 files changed, 282 insertions(+), 58 deletions(-)
>>> Hello Jens,
>>>
>>> A gentle ping on this.
>>>
>>> As far as I can tell, there are no outstanding review comments.
>>
>> Hello Jens,
>>
>> Pinging you from another address, in case my corporate email is getting
>> stuck in your spam filter.
>>
>> Kind regards,
>> Niklas
>>
>
> Jens,
>
> Any chance we can get this queued up for 5.10? This is really helpful for e.g.
> the zonefs test suite or xfstests when btrfs HMZONED support lands.
>
> Thanks,
> 	Johannes

Thanks, Niklas.

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

