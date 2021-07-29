Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CAC4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205A060720
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhG2PBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhG2PBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 11:01:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC962C061765
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 08:01:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q3so7393810wrx.0
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4O1I87U2stEkz/YUjYSiQ1/9SiHiehqPp46NQ2rxgg=;
        b=LecaHDd9irY5hHx18BSCSN/6hB08ltRDILoxBgcTJgeG7f+CIMqUlZlwxwkgJO+bLn
         B1IeyFDwnLn4eCmMF2O22YRRqgB+9jlRVjJVxdlTCFz+kMt5b9ztuOL6ob73CuUQu1/h
         srXJI90rWpxmnF1eZfJ4ZdPxkicjbwzZKOGJm75z/sAtqZ1ooh8IQWE0Q/mgCFSQ0izA
         TJALoM1lGfBHAqrbvMlJasCqURVf0PdeTUwkkpUt/zNwjcq4LsjEwfoIcSXeAFW+C3SN
         JSZFWrSUMv2usyIKPktUJ0OSBEpeDCaFIeCCR741A2uTnABUbq3UqN6jjRWjLqv6YSLp
         sg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4O1I87U2stEkz/YUjYSiQ1/9SiHiehqPp46NQ2rxgg=;
        b=BqatE2xFnPy4CvyUetm0oA+xFLEWQ4pdfV5aLsxHqMigwRZ2P5Jvpajc5MkJSCmNW5
         +XB4ojM8/jmT1AX7pDhNl/seoxhKJ2qsnSUrjXLWlbUJd1Sx715rS64Pisl1iB6PQoqn
         oMfJLSFL8qquunU152fhqchx8ledPX7SQ7YNxhaVW718Bt7zh6Vpp0q96QpryzhheVcs
         10uguZTbat0WYi7lyl56kYFQHcqyIX2yHG/h4ib/Jm5S2CdYRVy85iY0uAffDSnSn2mW
         kX/t5eADqlb3MUOW/PfD5FDTsUUBKq09wkP9Gce3CwTCTcvW0m2ZqQ1Mgv6JysHQwdut
         wdyQ==
X-Gm-Message-State: AOAM530PbsijQEx7A9F+LHEX8ZMkIVusFBMiyfrOeBuKCHA760qlo+1/
        /fSZGKGixMQr5u1LhZccRXUMhzund7Y=
X-Google-Smtp-Source: ABdhPJxE8iS/k3YsL8C6WjITTXbMpLzLrNKRoRz3wfn+er3aI1WsiwbtBXf8HXoDfLKku0i+q22GHQ==
X-Received: by 2002:adf:ed45:: with SMTP id u5mr5369561wro.203.1627570899385;
        Thu, 29 Jul 2021 08:01:39 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id t1sm3567140wma.28.2021.07.29.08.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 08:01:38 -0700 (PDT)
Subject: Re: [dm-devel] use regular gendisk registration in device mapper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de> <YQAxyjrGJpl7UkNG@redhat.com>
 <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
 <20210728070655.GA5086@lst.de>
 <9e668239-78cc-55ad-8998-b7e39f573c34@gmail.com>
 <20210728112430.GA22101@lst.de>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <b51ac16f-bede-15df-ac8c-b219e06f9060@gmail.com>
Date:   Thu, 29 Jul 2021 17:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728112430.GA22101@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/07/2021 13:24, Christoph Hellwig wrote:
> On Wed, Jul 28, 2021 at 10:37:41AM +0200, Milan Broz wrote:
>> very specific hw attributes. So you have one emulated device compiled-in?
> 
> Yes.
> 
>> Or there is another way how to configure scsi_debug if compiled-in? (we use module parameters, I think it is
>> the same was how util-linux testsute works with scsi_debug).
> 
> Can can add hosts using the add_host sysfs file.  I thought that was the
> way to go generally, never thought of reloading the module just to
> add/delete hosts.

Heh, I just thought the opposite -that using kernel parameters is the way how to use it :-)

> 
>> (BTW could you send me output of the failed test run? I run it over Linus' tree and ti works so it is perhaps another
>> assumption that should be fixed.)
> 
> Output with everything from the README installed (a lot less failures now):

We cannot run some tests without scsi_debug as module, so I at least added detection for compiled-in scsi_debug
and some module error noise removal. (There is still a lot of operations tested without this.)

For the kernel dependencies:
For cryptsetup project and testsuite is good to have also enabled userspace crypto API interface (CONFIG_CRYPTO_USER)
and keyring (CONFIG_KEYS) but we should be able to run without it.
(The rest is specific crypto algs used in test images, but these are skipped if not available.)

Thanks,
Milan
