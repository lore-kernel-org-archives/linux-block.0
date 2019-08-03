Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05839C31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F12087C
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 05:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=csquare-ca.20150623.gappssmtp.com header.i=@csquare-ca.20150623.gappssmtp.com header.b="SgyYIeat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfHCFBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 01:01:40 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43902 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHCFBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Aug 2019 01:01:40 -0400
Received: by mail-io1-f54.google.com with SMTP id k20so3505669ios.10
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csquare-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=/vk/77LSDoOzoE1ULKx1uk+L67ix7QMx5QSiEUP86do=;
        b=SgyYIeatgQLyy3cF4iGKgPhKHYZKVidyUYUEvSO6R6SAA+CI31RqCoLeBJq6V/hHir
         LIdYGJFHExkRd9ciS0bNNyh/D7pa6Oe3Lvipv0vq6h4TNKQeSjn5bWoQHO8wi1iBu3uL
         z2ZD67MIDuFWoOTk0TUbti/5cgTVfMA5cJcUE692a+FqaeeK6ZH5ON2ZXMkUZtQeAv6c
         OJBUnwB2/itVaeSjaJfsCDXFDYbeysT2jF/mBa5m7Ibq1SkMhHvzvm/LXDnLVqBUG+LH
         kRvqVfSA0x/hzcYXhSS8l1siEHzMfz5YGSVeqSOocpKP9j8FBQ1PYd5osMGaEmq2Cv6B
         xdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/vk/77LSDoOzoE1ULKx1uk+L67ix7QMx5QSiEUP86do=;
        b=EZ4xDc1/d8McQ7wOU/f/MsXXRElsLyq5Bb11w4NOBeTcCT2RyppzgF/tCS2x5UBuXv
         URqCz3lw7EF3QceC7wX6BgOnjglv2MUpISNCp0NjhyhQE5T+a2zPJMmYGdNZa8tLKgVe
         K4Q/8U8v4Fng+Fr9sinopHPEiKmDR5AxaGGyL7P2MaFfg2AqfvSd8+9aFLkJZPXrejfZ
         l4sGgi8ONdLTmEfKuGE8cbBwTGQ0KG9wvU2eU/LZR9a+5+ldm55Uo3yOtuGDc8feHVNI
         Nhnxxy4mUpYwQwzym8rI/IahP3nkQYh7E5lju+slwk9gndadrgg1tgBBn9a3Ftlxf87A
         pbhQ==
X-Gm-Message-State: APjAAAWVqbOYKBGsgo5pwRgpt29XZigDwDopUZDw8HPRDgVZyQskti8n
        95RDGsDWz1nCES4Tt9YZcAiUmZq2GaCYN4+mYYbJtios
X-Google-Smtp-Source: APXvYqyTWPhaI0/tFkENa12WEGl3Jwbecm83cHbvt/2xahLMVSl2Orzbn16UafknCDMMcv6em579/WYKsXxEmIdcIK8=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr2979784iot.243.1564808499618;
 Fri, 02 Aug 2019 22:01:39 -0700 (PDT)
MIME-Version: 1.0
From:   John Sully <john@csquare.ca>
Date:   Sat, 3 Aug 2019 01:01:28 -0400
Message-ID: <CACVf4-7Y5w_AXXruXV37ng_9ZbRY=4TMoq91UYGBRaEAcnS+LQ@mail.gmail.com>
Subject: Invalidating Caches When a Block Device Changes
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I'm writing a block device driver for a device who's data might change
without the kernel performing any specific writes.  I'm looking for a
way to inform any upstream caches that the data it holds is no longer
valid and must be discarded.

I've found APIs for flushing caches *to* the block device, but none
that makes sense to call within the context of the block device driver
itself when it has learned the underlying device itself has changed.

Can anyone point me to the proper APIs?
