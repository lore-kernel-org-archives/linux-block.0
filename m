Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB33C5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AD2063F
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="neCh9IFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGCBco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:32:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38660 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfGCBcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 21:32:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id 9so264103ple.5
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZLRZX+RONwb2eRUl7r9hydyKH3F+PBiS+tpvLQ0Hmao=;
        b=neCh9IFAmo31SuxfCsQA23K+wZBWzYv/E5zqx5twbFpRb2mIps3lUBN8UDzbAh31gt
         Ju796BiKDC9ann3eDY9vmLuuP2IBgQ64NWPuWIVTMZFtLN7mZh36omsqZ/ceuwuZM+nb
         9PxMZ0VYjYwyl6NxBDd7dxFPkiRroDOQhziCGD6LYcG453SP8uOwoxH+y4ZsJm9gu6XD
         ceC0Ziy4xhSDjNNNvMU2Mc/KD1xGtCfYpNx0CPM3Z+pYFV2RBbgARAZqUItu9ukW3pGG
         e5pzPo37DDkZPDRGwtgYgIhc4W3D0srBVj/EHJw7/Sg/iFaBAUnmUSBY6VB8e6f1sSaw
         OESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLRZX+RONwb2eRUl7r9hydyKH3F+PBiS+tpvLQ0Hmao=;
        b=e9W/KkPm6WPqWT3DGraP84It/R20jHYLvOJhajvAWEo1RiBZ06Nb8pU377swvDz7hW
         bPB0mf6RAx29nnim6hukvexfGBHfYwP5PZBFG1ImeaEfA508oVakK9zlTqOn9+P4DqnG
         /yfpaRjOPby6AZidfvICycyhPPb4tQtN2FJ2jTFChV9Hdqvvv98uMK6RclayJI6yIDuB
         Z+uVdepp6/r/IQ7t0ifzm+9iBlZMembjyp4gy23x0HepoxAmHoUhjYcuLyA2WSw0GcLv
         81PWqesLziTVVS7l1cPEVykVexHA91QhFbiBCyDjp4ic6qREKv0lc+HhYhPV5LFvkcfL
         4tQw==
X-Gm-Message-State: APjAAAVBNgg5YkORaumgltBDaXSNHS7JvwPMgwD1jol8lZF9wavsi/vR
        lPvYHBebtJGwEXFNhaBbpDCs78XSH1BmhQ==
X-Google-Smtp-Source: APXvYqxOQRbpmyu6wMUqqAf+08VF/cTyFAl07N3J7SWRD+e3BbfTodwv/OOJSXw/mLpArPye+RZtHg==
X-Received: by 2002:a17:902:1102:: with SMTP id d2mr38586266pla.149.1562117562858;
        Tue, 02 Jul 2019 18:32:42 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q63sm345291pfb.81.2019.07.02.18.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:32:42 -0700 (PDT)
Subject: Re: remove bi_phys_segments and related cleanups
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
 <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
 <20190702133406.GC15874@lst.de>
 <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk>
 <20190702182934.GA20763@lst.de>
 <ef4a5fb5-9d79-75e1-1231-fdfc14f91835@kernel.dk>
 <20190703000055.GA28981@lst.de>
 <a01c861b-8c5c-0f6d-4ca8-00e97bcecbd9@kernel.dk>
Message-ID: <cdc56c4e-37ad-812c-076b-cb2c7eb0c01a@kernel.dk>
Date:   Tue, 2 Jul 2019 19:32:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a01c861b-8c5c-0f6d-4ca8-00e97bcecbd9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 7:10 PM, Jens Axboe wrote:
> On 7/2/19 6:00 PM, Christoph Hellwig wrote:
>> On Tue, Jul 02, 2019 at 12:37:59PM -0600, Jens Axboe wrote:
>>>> I couldn't get that to boot in my test systems even with mainline,
>>>> but that seems to be do to systemd waiting for some crap not supported
>>>> in the config.
>>>>
>>>> But with my usual test config I've just completed a test run with
>>>> KASAN enabled on a VWC=1 driver with no issues, so this keeps puzzling
>>>> me.
>>>
>>> Let me know what you want me to try. I can't reproduce it in qemu, but
>>> it's 100% on my laptop. My qemu drives also have VWC=1, so it's not
>>> (just) that.
>>
>> I seriously have no idea unfortunately.  It works fine for me both
>> on qemu and on a real WD SN720 drive on my laptop.  Just for curiosity
>> you could try to pad the bio structure and see if bloating it to the
>> old size makes any difference.
> 
> No change with the padding, put it in the same place. Still insta crash
> before I get to login prompt, or right after I login and run sync.
> 
>> The other things that comes to mind is that when Johannes removed
>> BIO_SEG_VALID there also were some unexplainable side effects,
>> I'll look into seeing if there was any similarity.
> 
> Do you have a link?
> 
> I'll try and poke a bit here.

The issue is a discard request, 4kb, with a bio but no bi_io_vec.
The sync is a red herring, apart from the fact that it triggers
the ext4 discards.

I'm guessing, when you tried to reproduce, that you didn't have discard
enabled?

-- 
Jens Axboe

