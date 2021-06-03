Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D7C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 17:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401A660FDB
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 17:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFCRsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFCRsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 13:48:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D57C061756
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 10:46:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a6so7288984ioe.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qpFtT5B6GLJGoBY5auVIaf9nOYgUihdN+2llOJLAB4=;
        b=0y7LYR0lSvOSDrvvIxwMMy/ldBnglje76K/eONh5IohdgR3RZijBy7/A1WnqiQ8ko/
         OAAKDMPLy60sHDePjJE299jmh0ylFGs0U94Wb6HsWDhfLwWOevTrNe4+Nv7ANtdlVYwu
         2T7foo3+T/HvgMsky2tIiDBMXYbsYrumbVPdRSqt1Xy4upseJsu/8s1civB2BuQMjrc6
         27vwcgMDfkzlRj6xsOQmX11dqY6t3duLrqIifTzA/pgLblndXFcFdffUU5RBjOqTPTap
         9n2YiTmmdwQWkLBOHeF1dL/W60/DmSpXMTgcEl4P07j9V8DVn8qeU91p22LlE2DAe/2s
         vt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qpFtT5B6GLJGoBY5auVIaf9nOYgUihdN+2llOJLAB4=;
        b=AZVBb7A69tcnjKZs756l0LVomtz7FUR/KtHFKc8v3Mb4czkVYyYLRP8s4dCKtCBU+l
         gvfCJDcOmrXEnvuZTlUVQkmGB+Ym/qxw11syBzM1vs4tajIN8F3Tw0+83pIuH37a0a6R
         1qroCCGgJcb8r7w0gzP/P4tBimbSTuWJnqZBwZsFxp1lqzLAuzTACLSUkpCyx7afY9Va
         GWouaTx1eZ2mvvYuSsD5qCyLkdE8XOCNJsDAGfAC197jF/L4Q4+BsyeNVvgeS3g1bqYI
         7omtuIpMDl6kkcB/w/jzaYbmKSrrWZvYLQmwhSsgFu3WyFZoJALZkcSWE0voiQZ/scMj
         4w8w==
X-Gm-Message-State: AOAM531TCZm9U4ogu+gb/BJHher0P+/ggCS/GpByEietaxAOSbGfXOku
        BjAAgyD7+3XRkNCllqiXHN4gNq2Fn9AQkUSQ
X-Google-Smtp-Source: ABdhPJxFsxPty1Kc/6oQGUVZmZB2wDpcHWrj1rXqQyzfnvYIGtUsv3kpfwMEaob+VqqLqXyHYI837Q==
X-Received: by 2002:a02:2a0b:: with SMTP id w11mr211672jaw.22.1622742412616;
        Thu, 03 Jun 2021 10:46:52 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p81sm2062261iod.0.2021.06.03.10.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:46:52 -0700 (PDT)
Subject: Re: [PATCH v5 00/11] dm: Improve zoned block device support
To:     Mike Snitzer <snitzer@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <DM6PR04MB708146E418BF65FC2F7847E3E73E9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YLfO168QXfAWJ9dn@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a972018e-781b-c0f8-d18a-168c3d1fe963@kernel.dk>
Date:   Thu, 3 Jun 2021 11:46:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLfO168QXfAWJ9dn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/21 12:32 PM, Mike Snitzer wrote:
> On Tue, Jun 01 2021 at  6:57P -0400,
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> 
>> On 2021/05/26 6:25, Damien Le Moal wrote:
>>> This series improve device mapper support for zoned block devices and
>>> of targets exposing a zoned device.
>>
>> Mike, Jens,
>>
>> Any feedback regarding this series ?
>>
>>>
>>> The first patch improve support for user requests to reset all zones of
>>> the target device. With the fix, such operation behave similarly to
>>> physical block devices implementation based on the single zone reset
>>> command with the ALL bit set.
>>>
>>> The following 2 patches are preparatory block layer patches.
>>>
>>> Patch 4 and 5 are 2 small fixes to DM core zoned block device support.
>>>
>>> Patch 6 reorganizes DM core code, moving conditionally defined zoned
>>> block device code into the new dm-zone.c file. This avoids sprinkly DM
>>> with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.
>>>
>>> Patch 7 improves DM zone report helper functions for target drivers.
>>>
>>> Patch 8 fixes a potential problem with BIO requeue on zoned target.
>>>
>>> Finally, patch 9 to 11 implement zone append emulation using regular
>>> writes for target drivers that cannot natively support this BIO type.
>>> The only target currently needing this emulation is dm-crypt. With this
>>> change, a zoned dm-crypt device behaves exactly like a regular zoned
>>> block device, correctly executing user zone append BIOs.
>>>
>>> This series passes the following tests:
>>> 1) zonefs tests on top of dm-crypt with a zoned nullblk device
>>> 2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD
>>> 3) btrfs fstests on top of dm-crypt with zoned nullblk devices.
>>>
>>> Comments are as always welcome.
> 
> I've picked up DM patches 4-8 because they didn't depend on the first
> 3 block patches.
> 
> But I'm fine with picking up 1-3 if Jens provides his Acked-by.
> And then I can pickup the remaining DM patches 9-11.

I'm fine with 1-3, you can add my Acked-by to those.

-- 
Jens Axboe

