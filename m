Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF999C33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF8820748
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WJBVY3nC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgAPEnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:43:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53677 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgAPEnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 23:43:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so937745pjc.3
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 20:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQOS9ykL8kDiDpFhWlW2cOv2Kzb1Z6JcIaDHRAWaufU=;
        b=WJBVY3nCN+GyBuVTM1QYsofvrmOXGph08lGYpnvCuF2D+M88uj4+OP5MKiGtBRHxg9
         HnvnMWYkPTmEv9Zv0ZDGmoM/SYHgPKaXX+gCDOAZGgUpJN2hl+IWVg4XBB/6WIj/Ey+s
         blEroMTCohOFOgfzEKNsF/JU6KuO5uuCZqCuwk9TM52gMHxbliPeAp2cKms8qDud3P8t
         05kd2GQJDrS7+u2Tv2MLusQ66jq7O93NiB+DgkRZViSZ8Et5GFVYGJSvJ7eG6hr4pLjb
         ji+fzx59BogME+3RZ3TV7uk2BdDJ1jpUqdVIhJ8dauAG9RyONSzQoU9idTKuKH7sdeJA
         ntGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQOS9ykL8kDiDpFhWlW2cOv2Kzb1Z6JcIaDHRAWaufU=;
        b=UUhk0O8KlIwfaF0LoddMykT524K7iSmk/FhLNUNCLtCHXSCKmoSkaeFmeHxcMeORGD
         +2Rsg29PIObojywwymkoEDSXsVLI6sJRKzfRP2c+LQHx8Otb19Xoui8uwxdq+/LO27oL
         G3yPQxShz2fiMftauTaCC0ASU64uBm9zJ4/8icuSiI+C4FfJgmVKxidHVlGABJnAyd4M
         ciMCxF6NmhAwV32UIEh/esAOOJPW93/Mf/QYCuW9n3nPbQryFW/tkpuvi/v2Mb7NXby6
         uUaouapj18Y9NouffUpHFYV7Mj1zsuldoRGmo/FsqFA9Jp29tWkPlS9X+u0Sal+X4o6n
         XX8Q==
X-Gm-Message-State: APjAAAWWjdFMiWkOxy5LaUcjzBJSgHdgzib1FRfNSP2WsHQtsKx28bd1
        dmsuNxIk+IiXNWpU3bf2mm4cghGdiNM=
X-Google-Smtp-Source: APXvYqzOne459gI8+ok09JE1JN36m1QzqwT/j4wr0q9YgDvHpfW1mqNP0LmmW1pvFG8+z+uaV60IZg==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr22136266plo.195.1579149822350;
        Wed, 15 Jan 2020 20:43:42 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z30sm22451520pff.131.2020.01.15.20.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 20:43:41 -0800 (PST)
Subject: Re: [PATCH] block: fix an integer overflow in logical block size
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Mike Snitzer <msnitzer@redhat.com>
References: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c013af2b-d5b9-06d9-e617-db882cde4a37@kernel.dk>
Date:   Wed, 15 Jan 2020 21:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/20 6:35 AM, Mikulas Patocka wrote:
> Logical block size has type unsigned short. That means that it can be at
> most 32768. However, there are architectures that can run with 64k pages
> (for example arm64) and on these architectures, it may be possible to
> create block devices with 64k block size.
> 
> For exmaple (run this on an architecture with 64k pages):
> # modprobe brd rd_size=1048576
> # dmsetup create cache --table "0 `blockdev --getsize /dev/ram0` writecache s /dev/ram0 /dev/ram1 65536 0"
> # mkfs.ext4 -b 65536 /dev/mapper/cache
> # mount -t ext4 /dev/mapper/cache /mnt/test
> 
> Mount will fail with this error because it tries to read the superblock using 2-sector
> access:
>   device-mapper: writecache: I/O is not aligned, sector 2, size 1024, block size 65536
>   EXT4-fs (dm-0): unable to read superblock
> 
> This patch changes the logical block size from unsigned short to unsigned
> int to avoid the overflow.

Thanks, applied.

-- 
Jens Axboe

