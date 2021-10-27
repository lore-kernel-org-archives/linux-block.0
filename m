Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC8960EB4
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhJ0Coa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237667AbhJ0Coa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 22:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635302525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zG4wOwNju0vbwzgcCbmJ62s9mn3CKYEpgz+8LI3TwWk=;
        b=eGaeZVxkpWWVYgrq2530lM5ATBda5UyBiiuO4wQw+IFu4tBRGt0DxfuEtYq5zn+3ZpwxUj
        lnlhd3ijsaZWPESJ1grCYHUbzXJ4VwqDsoKLWyB6KMYuz9P1r3n0vqWG5bh3mDuO4g711J
        GoFv1eAVZ2KUXJD8rLauX+M5gdZ0Z94=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-90EwijK5PWKsurbdkzsV7g-1; Tue, 26 Oct 2021 22:42:03 -0400
X-MC-Unique: 90EwijK5PWKsurbdkzsV7g-1
Received: by mail-pf1-f198.google.com with SMTP id w13-20020a62dd0d000000b0047bce3ae63bso774359pff.2
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 19:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zG4wOwNju0vbwzgcCbmJ62s9mn3CKYEpgz+8LI3TwWk=;
        b=l8RYrZJjbfruyLRGyPjnYjOmD9nH0ELRp34a7ARwvInANzKkd3CoRzsWWANGKMunId
         VP/SGufDvdSRdzjJ+twv6IWBEg60AAfq5mcLiKxFryCEHjjQiozguXvqPnsk0lPjJcaj
         FfvPb5Wpa3TzWiilBLm5kfyt8gk5XisrHB27Dzu4b1zlwZY9EAw2Ckhe04F8hKjJEI05
         WdWOT9FizXOk8rWMoaBxcbpMsS7kwXbYpJ9RlMi6OYmyPrnPuVuLc7eH1t16wxTW00s+
         2wl/jy/OzFVSVsR2HFbY3HsdnJkO7t0qniv8M/S5qWyyyR+hcr2XQ3RLYqZNIySY0iiy
         FxSw==
X-Gm-Message-State: AOAM533s/yKBJ4UHrHx3hmAyWH4sebDnqCa/ePzsIkA4YiPbVvAihT2H
        c4zBLD5EGS5PDNreBd+eQ9sFgdOnR8KMQUyc/URBrTEpMYlDt1FrU1fCCWnbzak/imXX5HVv9LB
        niB1MavzavpZiTcJTmJ+v4SQ=
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr2843357pjb.24.1635302522764;
        Tue, 26 Oct 2021 19:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7/5OU3lvyXYztvEXb/ExmtHdCQzdKN/vMBrgbJMaHdW2excTPY8LP3gMdhwF+AdVbp7nbAA==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr2843329pjb.24.1635302522512;
        Tue, 26 Oct 2021 19:42:02 -0700 (PDT)
Received: from [10.72.12.93] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mi11sm2170281pjb.5.2021.10.26.19.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 19:42:01 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] nbd: reset the queue/io_timeout to default on
 disconnect
To:     pkalever@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, axboe@kernel.dk, idryomov@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
References: <20210806142914.70556-1-pkalever@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <c46ab94d-4e09-f74d-3d05-789cb47c1057@redhat.com>
Date:   Wed, 27 Oct 2021 10:41:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210806142914.70556-1-pkalever@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/6/21 10:29 PM, pkalever@redhat.com wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
>
> Hi,
>
> This series has changes to reset the queue/io_timeout for nbd devices and
> a cleanup patch.
>
> Thank you!
>
> Prasanna Kumar Kalever (2):
>    block: cleanup: define default command timeout and use it
>    nbd: reset the queue/io_timeout to default on disconnect
>
>   block/blk-mq.c         | 2 +-
>   drivers/block/nbd.c    | 9 +++++++--
>   include/linux/blkdev.h | 2 ++
>   3 files changed, 10 insertions(+), 3 deletions(-)
>
This series LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

