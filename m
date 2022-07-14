Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiGNCyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 22:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiGNCyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 22:54:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FE22B39
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 19:54:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so335492pgb.4
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UMayq6NnSa82+UEkfGFktrBm4nbNiRMSgFSEFqPlza8=;
        b=5asTxkUbxGoxHZ6SVN7afAB0c3QHNviUdFllLH4zGQMwO83Q7WvO0Tj21HIlCSeZDD
         gQc2EBqQPA3NT0v8xYChrvEGnR+Ukoo5uJSg7usT0T7OK7ZJo+fGEO28tAu0e0ClcdUu
         8LfUC4na0wb1Gq+Tciqe/nz+wahpCgBr+XUooxlhuPPxq2WtUMrFO45gHjFcAbl8FSrG
         GS62d4VVk5afufE9SofvVNuXRCScLipAwXtvQA2/LE4ykUDppNax/1BHmZ9QtVxOUAG2
         wy26VbM9OecJMp8u1WmonQVLj9WrnI7jfZsdLuTAczlh5BVBhYjhnOYZnoYDdHIFULqX
         ETtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMayq6NnSa82+UEkfGFktrBm4nbNiRMSgFSEFqPlza8=;
        b=quDO6gWqpwU4DHREMgYh/evrFQz+QmSKdJdZ+ASBqifrbe2mq8AUmFN22OoA9oW4J7
         Quoaeys2UKq0kNo5OEmiviC0qZrr6loIN7dDXHnUROTc3JSv4KRCPorjteiKoFn4vTXh
         n3GK0Hvlynawxwe2kDXpzAZzG/+5Xo1sSiDVyfG/2PIPoaeFP6Ko0KWtX6ezU6sDOWbn
         t0vq+PLQnAAoJX0T9Jv4bAMDLUr2NZ+XoHHOemAPB2aXuQiJRgQKLi25tmMtIfABwqv0
         qdMTssUh8sc3r43kNLM5eRvTB2WUvpdYbLqW3vB2WTMuUYix9UwyBNGwiRbAkoaMPmBj
         3piA==
X-Gm-Message-State: AJIora95Lf9jq6TK9LV+GEmx5ajt1nmEhmKQS4P6C4SqrIcWH8D1s9R1
        EFAOKhZGu626NBBg2CttluPDXNDPSaw56Q==
X-Google-Smtp-Source: AGRyM1uX8kH9/LuMvvYpQMygjFfjC/uuLEIWGU0otE8d+VyqY+fhe3uvt0+eT1hRUxjCDZgBQc2xhQ==
X-Received: by 2002:a05:6a00:2445:b0:528:5a5b:67d3 with SMTP id d5-20020a056a00244500b005285a5b67d3mr6108536pfj.32.1657767254520;
        Wed, 13 Jul 2022 19:54:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aaf8500b001ef8c81959dsm213985pjq.16.2022.07.13.19.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 19:54:13 -0700 (PDT)
Message-ID: <94289486-a7fa-1801-3c67-717e0392f374@kernel.dk>
Date:   Wed, 13 Jul 2022 20:54:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V5 0/2] ublk: add io_uring based userspace block driver
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220713140711.97356-1-ming.lei@redhat.com>
 <6e5d590b-448d-ea75-f29d-877a2cd6413b@kernel.dk> <Ys9g9RhZX5uwa9Ib@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ys9g9RhZX5uwa9Ib@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/22 6:19 PM, Ming Lei wrote:
> On Wed, Jul 13, 2022 at 02:25:25PM -0600, Jens Axboe wrote:
>> On 7/13/22 8:07 AM, Ming Lei wrote:
>>> Hello Guys,
>>>
>>> ublk driver is one kernel driver for implementing generic userspace block
>>> device/driver, which delivers io request from ublk block device(/dev/ublkbN) into
>>> ublk server[1] which is the userspace part of ublk for communicating
>>> with ublk driver and handling specific io logic by its target module.
>>
>> Ming, is this ready to get merged in an experimental state?
> 
> Hi Jens,
> 
> Yeah, I think so.
> 
> IO path can survive in xfstests(-g auto), and control path works
> well in ublksrv builtin hotplug & 'kill -9' daemon test.
> 
> The UAPI data size should be good, but definition may change per
> future requirement change, so I think it is ready to go as
> experimental.

OK let's give it a go then. I tried it out and it seems to work for me,
even if the shutdown-while-busy is something I'd to look into a bit
more.

BTW, did notice a typo on the github page:

2) dependency
- liburing with IORING_SETUP_SQE128 support

- linux kernel 5.9(IORING_SETUP_SQE128 support)

that should be 5.19, typo.

-- 
Jens Axboe

