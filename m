Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57022C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3068F20663
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfFXTqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:46:38 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46655 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXTqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:46:38 -0400
Received: by mail-pf1-f178.google.com with SMTP id 81so8088017pfy.13;
        Mon, 24 Jun 2019 12:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifvZwjPwDnekn88v2jZcVDzNwUQkndcGRvqJLqxCMJM=;
        b=RigsEIJMVqY+eXhbrmD9uR0vJzcCxw9/2BctBV23xULkOFJKn+GxMxYiT6M70AA1Di
         xf5Ee7cAP1OGsDWyTdW8FOpyI5wiNAXWX66qR3Jlis+wS5PiMErLUPzin9Gz90k7r05j
         Z4BAt44l9UPEo9LLr7TxI1F4n8/IwpdJiJUmzuX2FhW8UzO2pRlcMrEw0QzN+XFX/8of
         3NL8kCPZWsl3HmPPUUw+BJX8LHfjTOmtbyzC7gf8+0ox8nHL0b2IEy0PzRP6t9EOzx/T
         uaLnPCMzx3pH59PgyphkyxUNs2+bZWgtrUg/onvjDlgvoGxjUu6vjqQp/dZjHfY7wmpv
         0ecQ==
X-Gm-Message-State: APjAAAXxoGqFXqmeRTyzjMwiuvdrWyHI3rb+G4Uqd/eMXrGLsJ0eXYPa
        D0ips/STKox+8xfkpodOwlk=
X-Google-Smtp-Source: APXvYqyXexiRyLBKCch3RWNo/gEJaD46Zv3bDfNy7281rA63x0CF2GMKqklJcpXfrfIGHJ+S0upenA==
X-Received: by 2002:a17:90a:2648:: with SMTP id l66mr26400820pje.65.1561405597532;
        Mon, 24 Jun 2019 12:46:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r15sm17932733pfc.162.2019.06.24.12.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:46:36 -0700 (PDT)
Subject: Re: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>, axboe@fb.com,
        hch@lst.de, damien.lemoal@wdc.com, chaitanya.kulkarni@wdc.com,
        dmitry.fomichev@wdc.com, ajay.joshi@wdc.com,
        aravind.ramesh@wdc.com, martin.petersen@oracle.com,
        James.Bottomley@HansenPartnership.com, agk@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-4-mb@lightnvm.io>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
Date:   Mon, 24 Jun 2019 12:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621130711.21986-4-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 6:07 AM, Matias Bjørling wrote:
> + * @op: Operation to be performed

This description could be more clear.

Thanks,

Bart.
