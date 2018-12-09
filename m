Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED27C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94B20672
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AohJUZXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD94B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLIUjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:39:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45241 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLIUjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 15:39:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3964918pgc.12
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjS3v3ci/ePQ9H13yauXMKNL2w4htIugzJpTDQXbABs=;
        b=AohJUZXIH6GIUaOFeCSwC/viWBRG9fVKgm+udCuuze2gcFBG+/7PK4k2hteEoktfzO
         Fy0Xd5dChQpOZoj7ryFpAJmF2DBuHLfO9vT6Q5goQWtUubkGLf2azobgiVHEIALglgSL
         NAIPtwA0SfDe+aLhFxhcpGfiuVfMz/As87/AIdHS3yz2b4jF5h/nlOQS1IrMrhSwrHSM
         pi194sYHGwigUev2FZwO/1Vne+F4h4H+f0QcWbiZsRqvYVbPsBDJIHc11CWk5bSLk9Ls
         /ICPqupvWXWaYxpf7eeDW/gZHYLgJK8aJEmO5NpnEEPf9AI4+ZURgHn8VbR7fmGFFiGY
         BX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjS3v3ci/ePQ9H13yauXMKNL2w4htIugzJpTDQXbABs=;
        b=BIySGO/x5kbu+x6y+bczKILcHEhdcRPsZXZxiPgARFZ189VrHAt2PP+gpChSIXUnyd
         kHoQybyz6BMUC5ERlLCCjn1ewOxj8kufPEaeVW9Lo4W+ffVg3W8qqIUJBuSRpT1ypnBT
         ySp4vLmzR5/C+bzRuolURHtsI1x0y4LN7H/Zq/bd59MArGCL9TCiVGXxZjVMWJtON8GD
         wA+YLOIyJx6yJOQopXy5HcuReVcLiB6dc30J86D7X6zcn4JsbRpmrOv/v/S0kvSBrSLK
         8xK8q/jDGz8QqaFsY9Z0bvBSzn2pWHt4ltytwApRMJ1QjSefOZ0ucUR1DMQRJjdobjf4
         fq4A==
X-Gm-Message-State: AA+aEWb9ksscgzQUFehNJb1J5VKEr+bxVq9ZFpp9bFNc4B0Lw3tgr0rk
        3u+NabXWdvktb0gJO6W6z/MPeA==
X-Google-Smtp-Source: AFSGD/XlngrLwOYFXHq/Jam+WsMnbBjWhOA11ocF1Dtwe26IH4qGDHFANd34AamBB7MBtgLafNTKXA==
X-Received: by 2002:a63:f444:: with SMTP id p4mr8554698pgk.124.1544387988603;
        Sun, 09 Dec 2018 12:39:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i21sm10232390pgm.17.2018.12.09.12.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:39:47 -0800 (PST)
Subject: Re: [PATCH v2] sbitmap: silence bogus lockdep IRQ warning
To:     Guenter Roeck <linux@roeck-us.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <d4dca36f-d694-0dae-7e30-87c0490497b1@kernel.dk>
 <5d116e30-7a8d-aff5-68ca-9c3705d6f82e@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fe4e245-6d95-22d7-8338-d98be22e82e7@kernel.dk>
Date:   Sun, 9 Dec 2018 13:39:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5d116e30-7a8d-aff5-68ca-9c3705d6f82e@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 1:35 PM, Guenter Roeck wrote:
> I can't say anything about the correctness of this patch, but I no longer
> see any warnings.
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing!

In terms of correctness, it does the right thing, just always makes it
an IRQ lock for lockdep. See analysis above. This is better than
disabling lockdep, since we'll still trigger other violations (like
ordering).

-- 
Jens Axboe

