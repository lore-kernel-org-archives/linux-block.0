Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E4AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 15:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiC2P0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiC2P0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 11:26:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC027169
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:24:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt26so30884412lfb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7p35TWvl6IRR76g48gZ/FV3yHCrma4H2n4XIVQjHGbU=;
        b=rc7cqRTm/2czxCTles9/xCK5rpH8y9OSfuqPHW8xmLuVPgNpeGsjgQ7dqeXGBNg+cv
         nYFWQYGUKYM5ai2wr/2RzDbRLITVEYSqdutPb7uihwgAKjUArY2ntWDcIDSOMJDZ8xRO
         11A+qEOflqtV8TQpSEDb2WbRad+IZLGa+UNci4sAj6MSIJdR/fSVvlmVLZNtA4G4zvcu
         k8FeX4AQMnMFXccQXUyLRMRK4FAWO0q8LxmoHNJXdVh7vusRccFoD/66Y0llJGM+E/Jx
         lY2QmNCGZkcphOwyUydg3srZZfz+KygQlBwCO/C3Q23XZhIFTTOvKJTGO6RCJdg3nbAr
         9uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7p35TWvl6IRR76g48gZ/FV3yHCrma4H2n4XIVQjHGbU=;
        b=P5XSApKZHNqYEapXCVHcUpPsS4L8E/GZFyP4Yd5kVcDfC1fWZ9Hls2Ll3kDxhTD8Ug
         dN4p9RnjqcbzuTLZ4TTwPPy9CaiXMVATbwa8Lcsz6Ekxu7dl0kWjCIr/HaIcD3QLO8DF
         RBG7/1GD3jbEfYl7Q3+esEwQcWUxvBC7DMU9igdBZUu0KcpnyIxKiHeepeHWj1+5KQ4u
         22k3TXWt4dJnF0ID64wAZXeIrUW3opl5GESIdxghnDGGjS+Vf6YjJFpvdMJ79TbMt8gn
         hNSfiJnAyYuKt+9O8HfGfQUR3dVO2j5PUDMZA9ABYzlZpJEwG7eJrRy6oT2LqQi9BHZV
         C0Vw==
X-Gm-Message-State: AOAM5335sgJa4S9HrQhv0FYFmV2wgSveZWKhb7JDX77ydsx2CuxVpLtK
        l50a2WJlLLNizxuVqrjpy6HEQg==
X-Google-Smtp-Source: ABdhPJxrgrgQ8/lRgdnygDMTeGxvGw9V2TWV8TndcAF6ht0JArKuArXclzzTgpLQB5WvXqaVSaNUrg==
X-Received: by 2002:a05:6512:39c1:b0:448:3d37:2cf0 with SMTP id k1-20020a05651239c100b004483d372cf0mr3128325lfu.273.1648567458347;
        Tue, 29 Mar 2022 08:24:18 -0700 (PDT)
Received: from [192.168.0.120] ([2.92.192.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a2ea408000000b00247e5087157sm2037603ljn.101.2022.03.29.08.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:24:18 -0700 (PDT)
Message-ID: <241b972d-5f78-6282-4f67-131a2566d479@openvz.org>
Date:   Tue, 29 Mar 2022 18:24:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [dm-devel] [PATCH 3/4] dm-qcow2: Introduce driver to create block
 devices over QCOW2 files
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <164846619932.251310.3668540533992131988.stgit@pro>
 <164846631540.251310.2398727490395218229.stgit@pro>
 <YkMK1cmWyEJGoMB+@infradead.org>
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
In-Reply-To: <YkMK1cmWyEJGoMB+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.03.2022 16:34, Christoph Hellwig wrote:
> On Mon, Mar 28, 2022 at 02:18:35PM +0300, Kirill Tkhai wrote:
>> The driver is request based, since this allows to use blk-mq
>> merging of request. Driver splits requests itself, and every
>> request (i.e., qio) after splitting fits a single cluster.
>> (In some cases it is worth to create bigger splits, and this
>> is a subject of further optimizations).
> 
> Nak, please don't do that.  If you want finer grained processing use
> a bio based driver, not a request based one.  This is just getting us
> into tons of problems.

Could you explain what you mean? Why shouldn't I use generic bio merging
code, but implementing my own merging? Which problems you point?

Generic blk-mq is well tested and lots of people work on its performance.
It's not obvious reason I should better implement own realization.

