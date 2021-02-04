Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179FC433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36AD64F59
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 10:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhBDKTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:19:40 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:39604 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhBDKTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 05:19:38 -0500
Received: by mail-lj1-f171.google.com with SMTP id u4so2729390ljh.6;
        Thu, 04 Feb 2021 02:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6PJk8jj6u5YYiX4RfcCuOWdN6inRNJOHZHQGYwd68F4=;
        b=avLa1W8r8i/xzeUQ0GlWThP0Luh4eF6kJlcJKqoogn1UYVw7QfALvM59vADwQZjrEi
         ASR2ta8Q4kaL6M/tFo41Qz7rUPnuyDp79FTFY0XFYVt5tY0e9z1pZMRyWCzW3ne+vh5g
         I2oat1TivOuXHPCxqcMs0t7fHgtwYW2Z8sjrF/3MVQJuePT3SkjgjbueYBZ6tnwP5KWY
         A2me5c87iyJosE446e6ob6W/iO8omSEjk7DkHyAlJZI9e2diCmabh5zi5yNBK1x2DVkc
         kSW793bp6L6FHTK93T5O611h7VGl2vRaX1QX6TP14qJxoHPjOGUgKJ61nqzO+Rs5EGkc
         6O9Q==
X-Gm-Message-State: AOAM531ZLRbc4TowN++eNiVfWIWT+UxPMhfBScpJ2rFsi2atDPEYzDxn
        5xgpPPgr7nDpL1v7wZ1FTfo=
X-Google-Smtp-Source: ABdhPJzLZVbw5JWeNzby7nfcLF7Aq2+pAcojqo/aekD4oxM/8MScItSWMi+LIdaSFX8KTr5Pgcv7nQ==
X-Received: by 2002:a2e:860f:: with SMTP id a15mr4386593lji.411.1612433936544;
        Thu, 04 Feb 2021 02:18:56 -0800 (PST)
Received: from [10.68.32.65] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id w18sm604117ljm.11.2021.02.04.02.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:18:55 -0800 (PST)
Reply-To: efremov@linux.com
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>,
        Kurt Garloff <kurt@garloff.de>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
 <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
 <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
 <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
 <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
 <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm>
 <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
 <nycvar.YFH.7.76.2102041024000.28696@cbobk.fhfr.pm>
From:   Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
Message-ID: <20d3e926-2037-8af2-5451-dd79c0794dae@linux.com>
Date:   Thu, 4 Feb 2021 13:18:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2102041024000.28696@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/4/21 12:24 PM, Jiri Kosina wrote:
> On Tue, 26 Jan 2021, Denis Efremov wrote:
> 
>> Applied. I'll send it to Jens soon with a couple of cleanup patches.
>>
>> https://github.com/evdenis/linux-floppy/commit/e32f6163c47efbdbad06258560aa00d1c7e5b699
> 
> Denis,
> 
> I don't see this fix in Jens' tree yet. Is there any problem with the 
> patch?

Hi, sorry for the delay. I've just send the pull request to Jens.
I tested the patch and stressed the driver with syzkaller.
Everything look good with the patch to me. Thanks!

Denis
