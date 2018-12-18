Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB09C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FC02184C
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ilwynBUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLRWhz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:37:55 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:40871 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeLRWhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 17:37:55 -0500
Received: by mail-it1-f173.google.com with SMTP id h193so6575939ita.5
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DeQsi/7r3Kub0FvVofORziEOojenBzEiXb8EYHacHFo=;
        b=ilwynBUnh9uVgzHp739oJp7y8ocVZOsF6frGE0pkKT/Z+4+VYN+efzw/MeMjUS+rzg
         h/XmbduvJRGj6cJglTC2wT51u+SAS1eMYAE/dA2/c/Ca/fiYFoJTaPBdDyQWc9mwbtUr
         0kisqZu7KcB4CLevCYqBABYXll51TnrNUyNXVqMBB4TsxVUYPfOT710XyIXQk4F5aOtl
         FrB3kEjTs5hr9Tb5zANHBKCDRKAnu6sGXa0nXzhpHeJ1cQSo4LnqOuHy/YXI23CBs1Yk
         1I2DIMQWXQRdA3JvMjUwoWPsjqkK42cG2EgqVn0wf2mWxSzVi6uNu5JuoidKuut8nsKA
         TZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DeQsi/7r3Kub0FvVofORziEOojenBzEiXb8EYHacHFo=;
        b=MzLh+TZW3uc7vPdd0HKS5C/sFwjD413RaD6PmMH1RiM0Icoitd0p6hJ8JIJ0nf7AJU
         zYH2qARxiA2vd9Y2ybs0FyXgQVtntFnolzSTfX2zBsdibC3f+3ZMiFe9k41kLLZsUnYz
         9+HoLPVhcChcnWXYOeXKt4uwxB+UNtEaKAJYm9+BtRP2B+69KxQo/jEcKagKGwJqengU
         mJIXCR4DoN7Hyh6dtHOwkCr0eXkkUdik+1JImGET84kJI2PDriLZ/ec4pWJFDRxfbFgj
         KESqcsz9woPB19XZN5RNqddVM7CX/KLuwPdCj5OZnWkYmPaDF/VOjsa1TVna1HTythuc
         ITlQ==
X-Gm-Message-State: AA+aEWYMR4/O55mnomOc6XWcqelU0RCy8wPG5qmDpbDXcwxQeczFYPKd
        Gxr+QT650XucWhvhtRvAHVr29D3vqWWY2g==
X-Google-Smtp-Source: AFSGD/XQhcXLpafkorg2LD3EaxoH2p6uR7O+R+WujzvMQ3K0c2KxfVEFyCQVbrt3UstNmMTIT3LT8w==
X-Received: by 2002:a02:708e:: with SMTP id f136mr16374125jac.118.1545172674020;
        Tue, 18 Dec 2018 14:37:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b192sm2118575itb.12.2018.12.18.14.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 14:37:53 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single block fix for 4.20-final
Message-ID: <4a76a25a-eac8-c76f-0b0f-e327c56ff44e@kernel.dk>
Date:   Tue, 18 Dec 2018 15:37:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single fix here, correcting an ioctl direction for the zoned ioctls.
Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181218


----------------------------------------------------------------
Dmitry V. Levin (1):
      uapi: linux/blkzoned.h: fix BLKGETZONESZ and BLKGETNRZONES definitions

 include/uapi/linux/blkzoned.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Jens Axboe

