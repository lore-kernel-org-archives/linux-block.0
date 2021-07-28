Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50970C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3828C60FC0
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhG1Ihq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhG1Ihp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 04:37:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88044C061757
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 01:37:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m19so887566wms.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1L2Jchg5OdnAOILbniN0YQs16Gjlig7fJyJCi+ceF0=;
        b=slIDqxr9tZF1ghtwdCP2dadIaZSajmfMRp32wytrsrBngMSJAekeqieJuplB844Hm0
         zL17g6cUv/tUOUtpiUMhZjrTghxTvuqYHip1N4hbaFcaFN5VxdRG/+mmW5BCG6fkyUGU
         FdlqwAEcidBmczln7ulpep2aEng7jZd+vpyVxrQ/mqTVk4Lyxmk0N4+GTkkUiF+TIzWY
         u/jP585y22NmxESq+2UsJgPxjdYwGZBbrRhsug7FOm/AhSdFx4meahCD/9Tuymm1a7zx
         Q23GtdWq3wKNU2w7JsEEHXG3YEL3aX5RaM4l4y9EweNNiK5vMjxLJ39MQEBv7/QSSy66
         H5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1L2Jchg5OdnAOILbniN0YQs16Gjlig7fJyJCi+ceF0=;
        b=eh/B00k0IgzSPJdD0IngI5rzSvYJe5hUlsFou75YJ1ejeOwRf9XDYwqLtm/XN3s/qK
         vZ5oVuGIFz64FFnrnpRuxVI0e5m3cjTZFkMRRU0p/38LDqiPskX+jq/m6Rus/null8cW
         lWweRTdi1qITOZ/orcGNQ9Puy+L1tLiWZADPOBrV2wieJYX5ec8wnkPPFP3Zc+xDOf6g
         py2pR8CV9FotomICepI9g8XI/gtzEurIIpts4JXkP124NGK3yIIyBPnqFq82LGHRfPck
         QqGhSD29D8egDfVdTGd1Qbjr+kJErFIpY6S3gayRN1HcNMJ/5uc5QMolZZwJSwBMmD3e
         Iv7A==
X-Gm-Message-State: AOAM532SH8MW1ozcSDto50DHWaSKW1I9QO6AZ5KUFSVJ+7mX9cnXh0Ac
        Qxg1DGUaeojdtlIhEPJBOl2aNo2DLGw=
X-Google-Smtp-Source: ABdhPJzAA5mCJ7kdYgSW/P7puft4HReSjV75uDDD8Jty59N9zXYfieg1muOkeW/1Jok3hSGNcwimwA==
X-Received: by 2002:a1c:a510:: with SMTP id o16mr8127946wme.162.1627461463178;
        Wed, 28 Jul 2021 01:37:43 -0700 (PDT)
Received: from [172.22.36.87] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id h8sm4845588wmb.35.2021.07.28.01.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 01:37:42 -0700 (PDT)
Subject: Re: [dm-devel] use regular gendisk registration in device mapper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de> <YQAxyjrGJpl7UkNG@redhat.com>
 <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
 <20210728070655.GA5086@lst.de>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <9e668239-78cc-55ad-8998-b7e39f573c34@gmail.com>
Date:   Wed, 28 Jul 2021 10:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728070655.GA5086@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/07/2021 09:06, Christoph Hellwig wrote:
> On Tue, Jul 27, 2021 at 10:38:16PM +0200, Milan Broz wrote:
>> BTW it would be also nice to run cryptsetup testsuite as root - we do a lot
>> of DM operations there (and we depend on sysfs on some places).
> 
> It already doesn't seem very happy in current mainline for me:
> 
> =======================
> 13 of 17 tests failed
> (12 tests were not run)
> =======================
> 
> but this series doesn't seem to change anything.
> 
> A lot of the not run tests seem to be due to broken assumptions
> that some code must be modular.  E.g. my kernel has scsi_debug built
> in, but it complains like this:
> 
> modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could not open moddep file '/lib/module'
> modprobe: FATAL: Module scsi_debug not found in directory /lib/modules/5.14.0-rc3+

Hi,

there should not be many assumptions, but yes, we depend on modular scsi_debug in some tests because we simulate
very specific hw attributes. So you have one emulated device compiled-in?

Or there is another way how to configure scsi_debug if compiled-in? (we use module parameters, I think it is
the same was how util-linux testsute works with scsi_debug).

Anyway, this is a bug, tests should be skipped (the same way if scsi_debug is not available).

I forgot to say - there is a list of packages that should be installed for make check mentioned
in README.md - I guess this was the reason some other tests were skipped.

(BTW could you send me output of the failed test run? I run it over Linus' tree and ti works so it is perhaps another
assumption that should be fixed.)

Thanks,
Milan
