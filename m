Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45744C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1495D20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiOkm+6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfDQNm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:42:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46013 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbfDQNm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 09:42:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so12119880pfi.12
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvzzQsU14gNTRXfeTva2wkdpmNfG4sv2ks1xVHlARjw=;
        b=CiOkm+6pGax7EX2pw4Mm+GseVAazK6g6Ex2R4+wOcFhADdQaFqFiM+wV0y8kHE3+RV
         eQxjPWOoJmRvDvhLUG169K74AyKGW//NvooBjJA67bsKok/3HKcSV9ugXEsrUgDbUvSk
         nJ4yBWSooVwqjdHyC8YCFfe0QOzDrn2FJLrrOSD7foLa26LfNGqy6u5aT1sRt/kubZ5Q
         3Dfs/KyGCDmdtfwuO+lhQ7tWBj9fYFFL2ySYU4PqJFii63w9RyqlBojpS24MlpW4iAIc
         Jb3UREPts/MU6Iz7b7ZxdF7uRqQAw6nX7cVD2zNjRCMEiAsYS0gjH+KNM2h50KHYTezi
         F8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvzzQsU14gNTRXfeTva2wkdpmNfG4sv2ks1xVHlARjw=;
        b=XjqYd4s0+xmDU4rbbi5zpOt8hQWU+l/2sjIi8vRlVlaFjNR9uPZ1YXB51WYo5HBGZo
         fNsnWngzU2YsZgeOhi5duuPPlV0/va6PKeG2Ms19I4zqt+24WoN561w9MmEJgAbFpCtQ
         YbF7DZE+bpH2X8MtZRM2PQHwrCwOEpZbK0ijQk2XQrIMxl9Ry1u0me7qO0zel2vFfEgz
         Pt4DXnP/fCXGLN2TYojcu6RqEWrLf4/ztFNZMicB+nleuTnXSr11qGgmPMKTPa/8SquM
         ggiLg73Oc6ODHvgwUqV1njN4oT9vcRVjTjlTdWO6P3585strvqxOkgoX007RVSctCM1T
         8n6w==
X-Gm-Message-State: APjAAAVyyjRTDk0PjpJ1orNL0pzoilaFo6m8S003EOMaz5FfH7sXIjFr
        ybN+MmTj2phw0kQ6M9x0OEM64NZr
X-Google-Smtp-Source: APXvYqy+x7QB3uCjQk7kdR7OB0nnjIWc8wrVjfZ/rrbmYQ9P3FpmQqwvciLQWawarFRnCAIAi4Yl2A==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr89127151pfa.134.1555508576501;
        Wed, 17 Apr 2019 06:42:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1sm28314978pgq.15.2019.04.17.06.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 06:42:55 -0700 (PDT)
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de> <20190415210731.GA32723@roeck-us.net>
 <20190416063356.GA25763@lst.de> <20190416170847.GA5531@roeck-us.net>
 <20190416171011.GA4611@lst.de> <20190416175108.GA9550@roeck-us.net>
 <20190417052723.GA23019@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2cdb91a5-e605-2630-848d-cf970e69aaf2@roeck-us.net>
Date:   Wed, 17 Apr 2019 06:42:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417052723.GA23019@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 10:27 PM, Christoph Hellwig wrote:
> Now that I've fixed the sparc32 iommu code in another thread:  can
> you send me your rootfs and qemu arm command line for the failing
> one?  I have a hard time parsing your buildbot output.
> 
Example command line:

qemu-system-arm -M vexpress-a9 -kernel arch/arm/boot/zImage -no-reboot \
	-snapshot -m 128 \
	-drive file=rootfs-armv5.ext2,format=raw,if=sd \
	--append 'panic=-1  root=/dev/mmcblk0 rootwait console=ttyAMA0,115200' \
	-dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
	-nographic -monitor null -serial stdio

Root file system is available from
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv5.ext2.gz
Configuration is multi_v7_defconfig; I confirmed that this configuration is sufficient
to see the failure.

Guenter




