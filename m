Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCEC433EF
	for <linux-block@archiver.kernel.org>; Sun,  7 Nov 2021 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD69461284
	for <linux-block@archiver.kernel.org>; Sun,  7 Nov 2021 21:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhKGVWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Nov 2021 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhKGVWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Nov 2021 16:22:48 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C01C061714
        for <linux-block@vger.kernel.org>; Sun,  7 Nov 2021 13:20:05 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c3so3396516iob.6
        for <linux-block@vger.kernel.org>; Sun, 07 Nov 2021 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOxRSAEdOrXagFyqm1lOCp1sO7zqGLiMqKw0bXeJJWw=;
        b=Uqwvy1WfIUYdFgdp0V3DIiFt3IRdc+TcvOHSTfQ6XLL6SyxbOEN2Hrz2woauXeIieD
         h/PvpnxWuVQDz8HZXCbBsnhxAjvI8P8K7gnLRzQ/sjJW14y3Gj7LWLEhfa4NngvQlYp1
         I6sDHoEgVl6Y1Lac6Pt1ABMy2PI7wkq4R6XC9MxfOUJCA9x81CCltvlGLPScCyt+AH+K
         Z7YfbLUArGGQSWNOJi1AMnHB6GZfP9LM9Z6IWzl+PJb4wAiGHKDSPH4Ay2+THAlixsBj
         r3sM5l/7lP5CFXpzkcxjgEhzEFYscPq6qBrfmKdKXWvhWPDXgqgSDKMVl39n5x25Ve96
         Ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOxRSAEdOrXagFyqm1lOCp1sO7zqGLiMqKw0bXeJJWw=;
        b=vz98K0GB3JVer+qmtStoOv1J9BlH2MW3nH3R+zO24Bps0Mr/k9GIJvv4QMDX1br84k
         +0Vs4jP/Ymi04Z7r5+p/0t8jHXD+Vhi6Xc2oRCxVKWKU3tPSbSlGfzWu5rSw2skHFcfJ
         +SWPae6xe6UIdI+ZlLajDGCmb60PJsNY15TfU5ePUTYrd9lT1kJvaO6LoOHMgipIVwAw
         UgN6hSaEvhd1UasfvXEll7QO4QTCgSC7+y3pdYMQnI2LnRjEdxcoDqxxKiw1vypdHVfC
         dVRn36zC/v8K1y81G70Y5/LfrtqCbtYCrYIL3Nu+zo7uE6l/YNxu71ffq/8o0L6D8ae2
         c98Q==
X-Gm-Message-State: AOAM531NMvPAQV1FxGhVME+UyosRM9lvdMCTWLy/OFATu2Tsz1Fuzpk/
        5Rl/b0JxoVyvHBgkFtaMqbs94w==
X-Google-Smtp-Source: ABdhPJxM16nhV8xoydrnwWRXtjuHki9c6awqX1ZziMpc6LmtrmsPGonV89lpv8rnJEQjNGgLEoEloA==
X-Received: by 2002:a05:6638:1382:: with SMTP id w2mr14845378jad.50.1636320004782;
        Sun, 07 Nov 2021 13:20:04 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g13sm7983553ilc.54.2021.11.07.13.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 13:20:04 -0800 (PST)
Subject: Re: [PATCH 0/4] block: fix concurrent quiesce
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <364680b4-defa-a559-f7bf-53adcbec957f@kernel.dk>
Date:   Sun, 7 Nov 2021 14:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103034305.3691555-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 9:43 PM, Ming Lei wrote:
> Hi Jens,
> 
> Convert SCSI into balanced quiesce and unquiesce by using atomic
> variable as suggested by James, meantime fix previous nvme conversion by
> adding one new API because we have to wait until the started quiesce is
> done.
> 
> 
> Ming Lei (4):
>   blk-mq: add one API for waiting until quiesce is done
>   scsi: avoid to quiesce sdev->request_queue two times
>   scsi: make sure that request queue queiesce and unquiesce balanced
>   nvme: wait until quiesce is done
> 
>  block/blk-mq.c             | 28 +++++++++++++------
>  drivers/nvme/host/core.c   |  4 +++
>  drivers/scsi/scsi_lib.c    | 55 +++++++++++++++++++++++---------------
>  include/linux/blk-mq.h     |  1 +
>  include/scsi/scsi_device.h |  1 +
>  5 files changed, 59 insertions(+), 30 deletions(-)

James/Martin, are you find with the SCSI side? Would make queueing this
up easier...

-- 
Jens Axboe

