Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35919C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 13:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354650AbiBNNrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354615AbiBNNrI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 08:47:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A326BCBF
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 05:47:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z16so7400659pfh.3
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MQyTnQdQjSUY0e78Gh+oLNwswoy3Hv5PSlLyjvXSo7Q=;
        b=Tf6gDPf342I3F2XOXojPByk3D5E4j8aFY1XRUMtHjN6AAaPkrlBwqUXryN6fse6iQA
         2RsKLuE+OVmx1jGJAUDhVZzO6i8Osanb5ggdCN2HKX3LRQC/Tt3bD+cTnxXao9AG/jrw
         P1rD3WX6M9zdfIIaXC8Va24TN/NledeQlGmTNj/4SpRp8JdkodKXgisPDU44Eof4W/NO
         gCyOeoT/HcVNy/Ak2bLK1C7PxnYhSTlOjMr4qhVlNwvTKP0IFOtyGkYyiVSKyM8OvwxE
         S2wDG49boxBlI3Y/sH1jy0R/xwVsF5UwExXTywkoi2oA+bts8/ArT70dAY7xn09XKNyC
         8Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQyTnQdQjSUY0e78Gh+oLNwswoy3Hv5PSlLyjvXSo7Q=;
        b=48hGfwmcJV+XX5/+xYgqDJ6NZSw+SiZqrzIcVUh/E7Y8ZZ/vFIwpo5nJbf/C9Lse/p
         3pI6c72M+LfgzmlgMI/BelkpJIXcpaK6Mui9TAEjRrmIGk8RcdQIdBe060RGhBOhADs5
         B4GLcuNxCfi3F0g8ES0jbGqoqUPNxf6EXvhLiHx9FXlPRKe0ByXJpxh8o7QrZFOAcZVf
         yq45LM2WupvFozN/L9QPm03uptJNC2f/wBt3iM+Rc+t/RTvI1x1mtyQ3Ak9iMHznJL7j
         z6mHq2cWE3RAm4cPF4pQQ58Abr4aYij9Gz+lW6grC31vHkJc1ioXPGZ2uy3oQDC6T1Fp
         PfoA==
X-Gm-Message-State: AOAM53398nmHau9uhfRviaHRu6o4Hne/JPoi8BTBPTpdZs9qokyKOC+k
        hLZnPzxZo+4qYrk2SaNA/H9Opn7yEK0YkA==
X-Google-Smtp-Source: ABdhPJzbRYhSFBJrtCWaNzNYUGN8AOr2nQpS0Oz8VoypHgHSgTlq4TbRAXgYRS5WXnQi6MHP/goPVA==
X-Received: by 2002:a62:7ed1:: with SMTP id z200mr2267090pfc.76.1644846419742;
        Mon, 14 Feb 2022 05:46:59 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l8sm2952852pgt.77.2022.02.14.05.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 05:46:59 -0800 (PST)
Subject: Re: [PATCH 0/8] loop: cleanup and few improvements
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
References: <20220214100119.6795-1-kch@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <448dd873-daed-25a8-4996-755b64805cc6@kernel.dk>
Date:   Mon, 14 Feb 2022 06:46:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220214100119.6795-1-kch@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/22 3:01 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This has few improvment and cleanups such as using sysfs_emit() for the
> sysfs dev attributes and removing variables that are only used once and
> a cleanup with fixing declaration.
> 
> Below is the test log where 10 loop devices created, each device is
> linked to it's own file in ./loopX, formatted with xfs and mounted on
> /mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
> partscan, and dio attr from sysfs using cat command, then it runs fio
> verify job on it.
> 
> In summary write-verify fio job seems to work fine :-
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3495: Mon Feb 14 00:43:19 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3960: Mon Feb 14 00:45:17 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4321: Mon Feb 14 00:47:15 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4369: Mon Feb 14 00:49:20 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4443: Mon Feb 14 00:51:25 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4536: Mon Feb 14 00:53:25 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4770: Mon Feb 14 00:55:24 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4933: Mon Feb 14 00:57:31 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=5008: Mon Feb 14 00:59:35 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=5048: Mon Feb 14 01:01:58 2022
> 
> Below is detailed test log.
> 
> Chaitanya Kulkarni (8):
>   loop: use sysfs_emit() in the sysfs offset show
>   loop: use sysfs_emit() in the sysfs sizelimit show
>   loop: use sysfs_emit() in the sysfs autoclear show
>   loop: use sysfs_emit() in the sysfs partscan show
>   loop: use sysfs_emit() in the sysfs dio show
>   loop: remove extra variable in lo_fallocate()
>   loop: remove extra variable in lo_req_flush
>   loop: allow user to set the queue depth

Please collapse patches 1..5.

-- 
Jens Axboe

