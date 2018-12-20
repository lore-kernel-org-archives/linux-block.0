Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DAFC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C16217D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cQ8sGEn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeLTRJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:09:10 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45579 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbeLTRJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:09:09 -0500
Received: by mail-io1-f68.google.com with SMTP id p7so1269501iog.12
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D9hkcSs8HBWMT6SdNmeVV6DfX2QMrp0TLHn/Cojxr74=;
        b=cQ8sGEn/bHwlaecNHICGNxDX506XzUA6VR9443rARLipbmL8IDKwuFiRzyLjfSfmxT
         YHD6aXdb1pv5p4JM8lgsMonlVTpO5AD7H/vxKGGNiSKhOEhdyR08ViYYzwBxD7g82hK5
         7aObW51srrUTypjyCmlIa1OctmTkEOU3L3F/BAGxxoWIDRK/hT6xLXZaWxF/iz7tgm7n
         Xvj5v5qxN9LuCWPkjVwEgwoGNNGSZUl/itt6tMt0vsnaccBC7tH9rm8qbUkxI53jSz0t
         PeQGAIhCl9yeNlQNcFHxfwOompyc+wFiZIBOL/t3OzetrEM7l0vTzl51tTf6vTxAhBno
         2EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9hkcSs8HBWMT6SdNmeVV6DfX2QMrp0TLHn/Cojxr74=;
        b=q9L67Q0QX9jAvmOeiJIsc5HIfIBDonqVYMjUCokP5tjyR0OX3Xm9SpV6aUCcVLoK0J
         p0t1wVTCbXhGUSDppQsCg74Bcddn1UimcSreUwtEgByWg4SHNKb60ZcmfrmlRd0WpRT2
         rjtlbvXlk7Sf9Ele0HXgv9E/8FY0HmLcdsmARJcjNUOIpMpAx3LxtagoWVtsVmeibVXB
         rBwvgrIfVgR71BEbORS71wVw9t2KJa0y2d/W0+lZrU+GibmAyZzH1L1tn6Q0GCPvHpGR
         r8R72iDGFrpZ8qbe7S49aXuOxB4bl5zBnXRQEYpsDbpF6pWGRKqssBSM+7umGGKCJXSO
         gt7Q==
X-Gm-Message-State: AA+aEWb1IHwlNkvPNCByFQNbiSKz7dq/hpg+P0iFZcm5rxomflO3u3i5
        8x0xujSzqIRJh6LefYM7l4yB14rUj5g0rQ==
X-Google-Smtp-Source: AFSGD/WOi8nyH4vEYvXHKwudORIzqh2gKPrVil+P9Jbv88Xko+m2JcVmX+acqScGHHEA1gbse0QUhg==
X-Received: by 2002:a6b:ea05:: with SMTP id m5mr19219696ioc.97.1545325749117;
        Thu, 20 Dec 2018 09:09:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b25sm5040568itd.37.2018.12.20.09.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:09:08 -0800 (PST)
Subject: Re: [PATCH] bsg: deprecate BIDI support in bsg
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181219143934.3910-1-hch@lst.de>
 <c1bffb86-9b3d-d8c2-98a3-480364f21346@kernel.dk>
 <20181220071254.GB9895@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9d89b97-9f9d-b586-ff89-61bafaecd5cc@kernel.dk>
Date:   Thu, 20 Dec 2018 10:09:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220071254.GB9895@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 12:12 AM, Christoph Hellwig wrote:
> On Wed, Dec 19, 2018 at 04:23:14PM -0700, Jens Axboe wrote:
>> On 12/19/18 7:39 AM, Christoph Hellwig wrote:
>>> Besides the OSD command set that never got traction, the only SCSI
>>> command using bidirectional buffers is XDWRITEREAD in the 10 and 32
>>> byte variants, which is extremely esoteric.  It probably doesn't make
>>> sense to keep the support code around just for that, so start
>>> deprecating the support.
>>
>> Acked-by: Jens Axboe <axboe@kernel.dk>
> 
> You are the bsg maintainer, so I expected you to pick it up :)

OK - did you to amend the commit message to reflect the death of
XDWRITEREAD as well?

-- 
Jens Axboe

