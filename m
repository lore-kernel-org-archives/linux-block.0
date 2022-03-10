Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56680C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 04:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiCJEHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCJEHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 23:07:33 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790212CC25
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 20:06:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e6so3687111pgn.2
        for <linux-block@vger.kernel.org>; Wed, 09 Mar 2022 20:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4d3sdtg+pC+efPptigqIpK+EMPNrP/21aNp3aHZHfI=;
        b=7Ep3Gli9urH0fc/yDHJKXSe/+eljSRIaVMth+Y0rdC2BJh9++wXpkvgHlDkqvm0Ee1
         VP0Iwp5EvicUohWhuszfOmeeBRa0uz/3dXKhyvXqhEgdfu/okxSTv82eZ1+sIBv3xv61
         xgleg58Oia5J/DlvEKnXs+WprOxMb2y5DzN700PD7tZYa9XtQgjY1jGXY+KgAgsJGJl5
         mcK3BqR8Q5DDafbh31AJUt/wq5W17/jizWqHylQHRZQhct5P3O1PTB/LS12fYa4a/vMa
         8GuAqCzAy7V8avFvtyf7E03f80CBsjoaqO045Jh2XYvocRxPIa22Zjq+a4w92BmdhUbM
         1qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4d3sdtg+pC+efPptigqIpK+EMPNrP/21aNp3aHZHfI=;
        b=R9fscqLEDMhQ0HtifGaiFAFqe+c4eN/3ROuho0NH66T96I2l55TxZ6/uMzRWzr/rRv
         sjovUvt+mhaWEwapfMn/RBUnMpmjYbsutCkmC0DwJNSdp8Eik7VUBVWKuXAEFPi1qw/h
         mx9Zmx7HuA4Qi+ziPsJzVonqP0cSmSZ8c5cp0Z4XlDq/6Ya3hH4jbSpH5+u31mjfFH22
         dpagZaJGyskoyVtR68k2TozllUfdAuHGiIZLCn7H1ehVVEa+xfKhrhaAwJ2Tv+ao5+bz
         H671P5Jf+JH7QqKlkvYdoXnmnZPkwXlB/G3xm8zfmCo5n+iQjbQPYX0kip8e4go87gSK
         56kg==
X-Gm-Message-State: AOAM531KHJ1tu1Xitjti2l+pVrWstByFAFXEpQv+S2gYc41hTsupefsr
        kPqq9WYX+4LPZO4EWVfmNg2bKA==
X-Google-Smtp-Source: ABdhPJyE0JVdHttDZ4avXV2jMFMqd/QgecH2nRf4iP9Tk6UbPqRGEjVQtOlX1AcMCBOfnEYiwQxioA==
X-Received: by 2002:a62:1881:0:b0:4e0:1b4c:36f8 with SMTP id 123-20020a621881000000b004e01b4c36f8mr3117227pfy.26.1646885192218;
        Wed, 09 Mar 2022 20:06:32 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a0002c500b004f6dbd217c9sm4686550pft.108.2022.03.09.20.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 20:06:31 -0800 (PST)
Message-ID: <240bcfdf-a04f-069b-7574-a8a300d1d8f5@kernel.dk>
Date:   Wed, 9 Mar 2022 21:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/2] dm: support bio polling
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220307185303.71201-1-snitzer@redhat.com>
 <20220307185303.71201-3-snitzer@redhat.com>
 <eac88ad5-3274-389b-9d18-9b6aa16fcb98@kernel.dk> <Yif/Or0s1rV87a5R@T590>
 <d4657e24-4cc7-7372-bafe-d6c9c8005c6b@kernel.dk> <Yil3wXO83U3zj5vj@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yil3wXO83U3zj5vj@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/22 9:00 PM, Ming Lei wrote:
> Looks improvement on 4k is small, is it caused by pcie bw limit?
> What is the IOPS when running the same t/io_uring on single optane
> directly?

Yes, see what you responded to higher up:

"which ends up being bw limited for me, because the devices aren't
linked gen4".

Some of them are, but the adapters are a bit janky and we often end up
with gen3 links and hence limited to ~3.2GB/sec per drive. But with the
bw limits even on gen4, you're roughly at about 1.5M IOPS per drive at
that point, so would expect lower percentage wise gains for 4k with
polling.

-- 
Jens Axboe

