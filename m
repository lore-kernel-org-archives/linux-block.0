Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E7CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442120DD4
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Y4ie8kxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFZKCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZKCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 06:02:44 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6022C08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:02:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so207480edb.13
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/dCW4v8WLTt9ErWAm/mwA0WZI03Ih/ZKlSgwSD72N4=;
        b=Y4ie8kxw0NUY26G2pWnnE8ZmchVi0do4H7HZegWCb20g6pCB2kfjo3h2cdXWbOOlSC
         qWDt2MLXbBb6lE30qGkMm/TaQq0NtZGSdDf9h/J5ovXv/o4saQ6/X8bjbKuBaE1CNZm2
         20+KIl0swwqz6mRyZN9ZtHZbIXKyLJyfSZrXozRQlciT/eGisPadjiPTOACDDJG7NdVa
         31vKIhqzFeyWfPStqycEu0Kd7vwTvqKAw69JyAENl8gIQ2e83PjeFm9GBiSf65jgxWip
         Ky/ckLU3xh9hIz2/weBQwKKFPQaEXIcD2IY539v5QWxjRmYZfEzFNeuX4f+PaaPtkul5
         w0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/dCW4v8WLTt9ErWAm/mwA0WZI03Ih/ZKlSgwSD72N4=;
        b=HpsnK0nUhQRQZ7W632vLaJ7MUBa3HzL8qUAD45/Y86OzGL3QzBStflQMzmMY0J7jcM
         xsLvQnMv9bVWxpH/h06+YTkqBF+ugroLj639nPddW0hLTgz2861QTrz/nbT8x6UaPyi5
         KFuFoJi03EbHF0KUxf8uBweLke3x60/E9nSn9C4I+TiDsvHKxO0LY8M4wIKPCnO1iRHm
         7Ck5BYY4dJGLmUpIdbavB1OkQMX4ZwsUNbIUElQF6zizRFeuTgmmTksFgDsWRw4trcqr
         zUMXFiSIlu01F0uNh/hutE4cmhtT6jDm8+YCiNFnM/Z5+FOFdRXhtV3h9SjptpeMN2P5
         4Wyw==
X-Gm-Message-State: AOAM531CRa/+3jfcD0wM2Lj4SUcR9MKqjZtGdnlmbbpSAh8eNVO8bK+V
        WxCO5fwrZGXPJ4lwoqgxe4pIDA==
X-Google-Smtp-Source: ABdhPJzG40h4fZUL5OHcBXwwcE+6pgHzz7gBUjtOz+GMdQlSfGd0xv1012exLZQA5gMOhTEtuYGweQ==
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr2614934edx.334.1593165762376;
        Fri, 26 Jun 2020 03:02:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id f1sm20329336edn.66.2020.06.26.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 03:02:41 -0700 (PDT)
Date:   Fri, 26 Jun 2020 12:02:41 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626100241.5dtagphfyxwybodl@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091113.GB26616@lst.de>
 <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091758.GA27903@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626091758.GA27903@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 11:17, hch@lst.de wrote:
>On Fri, Jun 26, 2020 at 09:15:14AM +0000, Damien Le Moal wrote:
>> On 2020/06/26 18:11, hch@lst.de wrote:
>> > On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:
>> >> As long as you keep ZNS namespace report itself as being "host-managed" like
>> >> ZBC/ZAC disks, we need the consistency and common interface. If you break that,
>> >> the meaning of the zoned model queue attribute disappears and an application or
>> >> in-kernel user cannot rely on this model anymore to know how the drive will behave.
>> >
>> > We just need a way to expose to applications that new feature are
>> > supported.  Just like we did with zone capacity support.  That is why
>> > we added the feature flags to uapi zone structure.
>> >
>> >> Think of a file system, or any other in-kernel user. If they have to change
>> >> their code based on the device type (NVMe vs SCSI), then the zoned block device
>> >> interface is broken. Right now, that is not the case, everything works equally
>> >> well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
>> >> do not define. But that is still consistent with the host-managed model since
>> >> conventional zones are optional.
>> >
>> > That is why we have the feature flag.  That user should not know the
>> > underlying transport or spec.  But it can reliably discover "this thing
>> > support zone capacity" or "this thing supports offline zones" or even
>> > nasty thing like "this zone can time out when open" which are much
>> > harder to deal with.
>> >
>> >> For this particular patch, there is currently no in-kernel user, and it is not
>> >> clear how this will be useful to applications. At least please clarify this. And
>> >
>> > The main user is the ioctl.  And if you think about how offline zones are
>> > (suppose to) be used driving this from management tools in userspace
>> > actually totally make sense.  Unlike for example open/close all which
>> > just don't make sense as primitives to start with.
>>
>> OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the current
>> zone management plumbing well, I think. So the patch can be significantly
>> simplified (no need for the new zone management op function with flags).
>
>Yes, I'm all for reusing the existing plumbing and style as much as
>possible.

OK. Will use the current path on V2.

Thanks!
Javier
