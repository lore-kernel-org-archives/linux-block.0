Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A1C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752F5613B0
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhETOBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbhETOBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 10:01:19 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFAC06175F
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 06:59:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p8so16614552iol.11
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qKk0ovYZWZ1WB30d/5Z89uobg2VgkbYeJ+U/Jwm6GtE=;
        b=TXItptErrmAeljUDOSVkc5s87ljCMb1Y5ZsCdpk2xKiKccYbgzflZegTRgS9K1GCuH
         JLzWRU2zpIGS0IJ93rRUYF5YASsnuP0eoaqqFTXJPqpM2+yJG1e5doqJLbhOFmdyom2S
         KtQ4W0VbOgJcZEZH8EIqYoAd/ly1i204QdwX9zljKoVZPiHVkMe432Va0X+TN8coUHWL
         OERGhxnA2GssOWG6whr44rJ0HGpiR0YCQJbzLm/P5JjjxockhdX1kM2emeXWGD/uMI3d
         zIG74l3UuZDTLtoJBWs3P0eQiRXhy2di0YOzwfLgNrvdYqa7wmEE7VOGlx8+7rGheOYN
         +BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qKk0ovYZWZ1WB30d/5Z89uobg2VgkbYeJ+U/Jwm6GtE=;
        b=GlAkqcPv10pk6K0JPJ5GWTBb4nDJZc1ycVMquMX7r3x7dD+oO7QpNM48JSBvaW53tq
         ZMaihrJNJXOXtyp/Wu1Rp+1H1qjfTK5zTy+n6GFB89FiyTlDUpBi49bLDBI7KP2jGBR+
         3zf4ezwkNIKKD9zkBkwx1/EGWzJ99vs276IuOtQwhZ4NHKBZ5ZxAYcdOHydZop0QZQr2
         tJjgNuwyuhO0eqXbMOzPaX0OSwHXFDor9e+b7hgcJfTfuTdWXG17Xw7NrXm6HTQzbAFe
         SlAcbvDc++b20Q3H20H8Nz/D3FcPcBBE1/kfgpzBmtdvWXIQozIewAJTYl2owhfAM+XX
         cOuw==
X-Gm-Message-State: AOAM533+JDeFuu+nu56vTY3SkyWGxCFryxG8TUEDITKoLQJO+lkvbAKx
        IEqOpb8LyGt4WrjoNblzvYRJpdLOd2tj8g==
X-Google-Smtp-Source: ABdhPJwDlkGa7ST7JZNIZm8Zj77wASU0YvhoHrfYj8EDf/47c+8FUfAW0NsPuOZDQLLlPz5YT2kkkw==
X-Received: by 2002:a6b:dc13:: with SMTP id s19mr5944378ioc.14.1621519196953;
        Thu, 20 May 2021 06:59:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b8sm2913147ilj.39.2021.05.20.06.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:59:56 -0700 (PDT)
Subject: Re: fix a race between del_gendisk and BLKRRPART v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20210514131842.1600568-1-hch@lst.de>
 <20210520081446.GA30422@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecbe15a2-7447-a55b-f8fd-d40ffb1ce39b@kernel.dk>
Date:   Thu, 20 May 2021 07:59:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210520081446.GA30422@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 2:14 AM, Christoph Hellwig wrote:
> Jens,
> 
> can you take a look at these?

Looks good to me, applied.

-- 
Jens Axboe

