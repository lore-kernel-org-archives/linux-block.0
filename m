Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44879C2BA19
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F5420659
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 22:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tCJj69p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgDEWjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Apr 2020 18:39:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39228 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDEWjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Apr 2020 18:39:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id k18so5152482pll.6
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2020 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OdEDPg1uj6czYj2ENMVOETWmVb6mWwN1SQGCKZ+dHjw=;
        b=tCJj69p0Y8rc548xIsTRZe8souY3WW1gDWL9CafReLDnGC+X0pNRuQDlY8G4KUeyb3
         kNdmaTv+mczdzPQQvIQeFv/sQipISwukUI/SJWD6JeEEBmwSLCyRilviqJvy25wR8LKY
         zyBWmfDbcQxKQ/yUvYYU7k025Zu469HDZcQMt2616HmJ/PXxDzPsFU0NHYO6OAkPRDff
         PfZ8QfbZ0ma5oDQX4ckjW0xZ3v+/P1KuCneRVH8ujJPojCRxdeFlbaOkuFsUuwsVrvDy
         II7/sMjj0R3RWLMB/rr7MViLD1QludTVXCUuDyQwm2L4rKXbxkErHtl5wk0bxf117E41
         sOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdEDPg1uj6czYj2ENMVOETWmVb6mWwN1SQGCKZ+dHjw=;
        b=VGOyAgfOXBrPtuauaBpwxcwHQe8/4+hRaS26WHfwS3+03SVf2hyVJWRrTj/m5+7Cbz
         XkPHOWoCwytBPmW3e2hs43aacOVHa/GpsMk4GpQCQj27xZ0tBYTQ39H+CMwBu82TgFEl
         7VPiZPGIu650vEWtinJsUC0pGhUdLIC9z65C76gLi1JYgBSywZNFTIkq6HJECJPLqIZQ
         TxYLunCBoyixsVUOtUjMbqAm3SiFYqvfamQbCPxksP7j/XkceeXUWFrjn8C/hHqLBA2b
         +hqHYNi8yJ5C43l+/6h+dZgZxDQ5uSuM1mMlUP9XtAFBl2Yk3GR8L6DuYpkypiEknWXN
         ltMw==
X-Gm-Message-State: AGi0PuZqhIRUdzE6re8SVei7JaI7WcpRxfA2s/HEN1npHkHhrDdjc5gm
        ssfC/qQ7lOXQrsw7gsTuRrn5aWn4pf0A6Q==
X-Google-Smtp-Source: APiQypL7ds5t0I80ORFe0Ng4w1OGRNRKW7aGKFzj+e2L7xY96gpJwTjLPT1lBQhkNin7qXPXGy3JOA==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr17307665plo.336.1586126369347;
        Sun, 05 Apr 2020 15:39:29 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:5d19:ea24:5c10:884d? ([2605:e000:100e:8c61:5d19:ea24:5c10:884d])
        by smtp.gmail.com with ESMTPSA id o29sm10292773pfp.208.2020.04.05.15.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 15:39:28 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e6=2e0-?=
 =?UTF-8?Q?83eb78c=2ecki_=28block=29?=
To:     Bart Van Assche <bvanassche@acm.org>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
References: <cki.30CC7B67BD.D92JFO5H7A@redhat.com>
 <0a957017-9d26-b3d5-4751-66c971b7c253@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <722d886b-fbeb-b90e-54ff-05f7fbbedae1@kernel.dk>
Date:   Sun, 5 Apr 2020 15:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0a957017-9d26-b3d5-4751-66c971b7c253@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/4/20 9:07 PM, Bart Van Assche wrote:
> On 2020-04-03 13:04, CKI Project wrote:
>> All kernel binaries, config files, and logs are available for download here:
>>
>>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/04/03/518551
> 
> From the build log:
> 
> ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> 
> So why has this report been sent to the linux-block mailing list? Does
> the build bot perhaps need to become smarter?

Still working out the kinks here, I did notify them about that on Friday
that we're not interested in build errors that aren't specific to the
block tree.

-- 
Jens Axboe

