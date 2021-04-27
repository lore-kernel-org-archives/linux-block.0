Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCAC433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F31461073
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhD0Cra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:47:30 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35340 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0Cr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 22:47:29 -0400
Received: by mail-pf1-f169.google.com with SMTP id c19so4451543pfv.2
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 19:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ICTo5cvEPnFYD0QqDzZhMvRJGvfvL8K5WWAJzsojEAM=;
        b=E2C4dhgxG3T/5XKCGagFb3WTyV3jAG1p7IVWuKhjKWlA964ZLGu707uqpg3t0t+4SI
         nMVl8J+awp2yCEPgJx8po0ErMe13n6QRdLCk7CnhnrXGAMIsMUvcWgjFYlVhpspau4ln
         MuVWIc1EdzrFFa4EO3avuZaV9T6CdUKiZxz3AOTNlt2FRcmTLeFGyJyJ17zWkI98isyE
         WLnOcUbg0+n+7zPLBF1835X2ix9NZiRNsASIVzgsLtx/CneNCVpyX12AVfqrTIvQTbpC
         wBpxabsxhxKSP7uTY5AnO4dIKsTWQFJCvxV3A5g3trv9k9qOE9sNGOTkSeRsgaOOunME
         XEUw==
X-Gm-Message-State: AOAM531ncwQ2oI9Zc8VL8OrQY0eQvsnwLm5RNMZ8q10HievI85Fd42K/
        xzRpB//GaIgaUl7gRqzojG4=
X-Google-Smtp-Source: ABdhPJznHAQx3tIFZfuoRsEKUt525Ia0Lv0/okmw8SMSfWquZhhe74RNIMpqNQKtoVlrz/1qF9BFTg==
X-Received: by 2002:a65:6496:: with SMTP id e22mr20002030pgv.46.1619491607244;
        Mon, 26 Apr 2021 19:46:47 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j7sm856517pfd.129.2021.04.26.19.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 19:46:46 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, yi.zhang@redhat.com
References: <34286266-1c03-35bc-94e8-08bd0ac3400a@acm.org>
 <CGME20210427004655epcas1p15cc4b2be6312c4762272474908607722@epcas1p1.samsung.com>
 <20210427002857.8038-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <68e4c8f1-1dc6-7dac-289c-5a7595af8d15@acm.org>
Date:   Mon, 26 Apr 2021 19:46:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427002857.8038-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 5:28 PM, Changheun Lee wrote:
> __device_add_disk() do not call bio_max_size(). I just imagined bio
> operation on disk without request queue. Disk can be added without queue via
> device_add_disk_no_queue_reg(). It might be my miss-understood about it.
> I didn't check bio operation is possible on disk without request queue yet. 

Inside __device_add_disk() I found the following:

	WARN_ON_ONCE(!blk_get_queue(disk->queue));

I'm not sure how that could work without initializing disk->queue first?

Thanks,

Bart.
