Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA12C433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F87F6144C
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhENPBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhENPBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:01:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23BC06174A
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:00:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id t11so3066735iol.9
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SRvINRU3OzuZNAe9Ef6oULKflYLeLaPtMTkYFRUGVqQ=;
        b=tUxYYEzUFKI9XPrTRLgn66cx0/yoWJk1UgOocjdG4ZxbB89+yYgdvtbKVNP6KX7RMO
         y5nJfoV4PwNFh9vbHS7jC/RQ/Dy9dBMHhzjUx3kPcl0UDYS0vdK+8CIfynCYdMp9QKkb
         /K/FyZZtrKDGIBUO5qcxq7xWPkWyCX+JX3H+bDYscwCTOvGMjY35DkgUp6z3jSvIG72g
         ptU/XOAOnWcyAZ0lxG+L/BGl6IOUVrCFZDaw53a7ocV1aHtmqY5qDYHDDYUh+m4H2Aum
         az0eD5kUkIvshONMWTkB7H73RMpcb6oBMhEzujIUi/b/oFWsgDzfQ1gYgkxdEyV2L1q7
         dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SRvINRU3OzuZNAe9Ef6oULKflYLeLaPtMTkYFRUGVqQ=;
        b=Vy0rFwc5T056kM+bpI2qeHQHU1eWImzUPkKDx7GvMA4N25b6MKLFnIup048T/aDOPZ
         eMPMHvk/zJeHDkbO778Tpz1QrXZqNGQ96I8tC/6NOLamdzEcoV4r/KPtGV2OIFKWr36i
         jQe8TxWTbXCAqAr0GoXqInGcznPYIsflvGkPCcIZ6Fh8LTzM4GvPIhdm4T1T3uQ1tkZF
         1FcyVtSKi0bFVUSFTe/26+bCOTs9TsTBgAn/04jaeMSIEXMBsV41ffWAwXtJeM/+5duO
         kS6GVXf+0tk827KYjCfMghx8kt9kdStFMKNQtmb/6StAMQtP0sjekdgwok3mRqtqSdO9
         qQeQ==
X-Gm-Message-State: AOAM532pb++egdcRooZ4E/28FtyiEGiym6yOWXKS9lGuch0K6NCY4dAb
        kFAaRe6Gx5EXZxKfdvG+UYMdkA==
X-Google-Smtp-Source: ABdhPJyxhLHMALHHR3OZSwTmVyytsYZRX3lvjsJf9BdfF0IejbEu+KZL/E4OYh6wFp3uA+ghGmA+tg==
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr21278361ioj.109.1621004418659;
        Fri, 14 May 2021 08:00:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h11sm1603067iob.21.2021.05.14.08.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:00:18 -0700 (PDT)
Subject: Re: [PATCH v2] block/partitions/efi.c: Fix the efi_partition()
 kernel-doc header
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@math.psu.edu>
References: <20210513171708.8391-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04e22776-7ea9-83f7-cc2f-36717447adc0@kernel.dk>
Date:   Fri, 14 May 2021 09:00:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513171708.8391-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 11:17 AM, Bart Van Assche wrote:
> Fix the following kernel-doc warning:
> 
> block/partitions/efi.c:685: warning: wrong kernel-doc identifier on line:
>  * efi_partition(struct parsed_partitions *state)

Applied, thanks.

-- 
Jens Axboe

