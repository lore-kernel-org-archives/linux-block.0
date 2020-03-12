Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D26C1975A
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 15:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F9D2067C
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 15:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kZQRdNYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgCLPLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:11:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32897 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgCLPLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 11:11:10 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so5819047ilg.0
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vi1YcPYinpCw9NCfPURmixLhnM73y9pgNUdCXW6R9p4=;
        b=kZQRdNYAsWnl8IyJvlvkNpgce4+2DM2wX0nBNAk8g4cxWJbmWupDryRn0QfzwX+kpt
         H3yMrg2v0W5ydDA2n5DaspXbLHTxkFFZ/eFP+5qz74SQlJHv40+gMmBIzwGxW6Jjs3bH
         7GK4jxyhtjBf0jWZDCatO/7TTnExEQYtcZftkszUXeGWdqstenvQTtmidYjznu6VcPXz
         L2sSqtT3hfkupc6z/61Oke5WhDT/kViVNoz2dBVwWnqiiABrlDL5VxmBqrhlE1Bdck+5
         gq9ZWwV5xZy3XyhGebXe68SedgWOuzKIErcB+2dwPslAvtcqlaRMPkE/n7uHCyTArj5H
         ZvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vi1YcPYinpCw9NCfPURmixLhnM73y9pgNUdCXW6R9p4=;
        b=PwxLJuVwfQmU1y4stXgbq1h9UKSQ6iIvdzdQ7X29mFdnLw3r74s34u9CrrhxHEJ1Gv
         HCKUKlSWlgjheTMuMi6XJSwz2Zg/Np0ZwtGXOerNXNRQwoMVUGLvoz47XliEWwxVDsFn
         j4f03LyRgBQEnMmoqWAyfC1M8jtVMSXFeBgDG7PChfIlQPtYYtCiq/+/m+cOPDOsCFX3
         bjn+hQfZ39sc6fqlC93FjfZ5zFVRtzPBg0YF0mfxHtcLP7QlCBXBbTXEPxJb7HfVWdXk
         I4n4pcu36qP4upGfynbJpBZflWfRHhqvQR02sdLUmYpA35VImnf5A6GjnPxCox6s+ZZB
         J6Xg==
X-Gm-Message-State: ANhLgQ2e2ewqyJRpVU8rkJXEzW35XKfC0MGlSaIPaQ1MVTDXrx6Y3jld
        fB+Zu4LoFdVX2RunfvwCj/zFM4xDHBTO5w==
X-Google-Smtp-Source: ADFU+vu6HyhFYZ+kLdSZovpcY7BCWUenY5kOaD/JiMYJH5/gRO2yeEAVJ/itO2TOjXh7pN3XGUf26Q==
X-Received: by 2002:a92:3d49:: with SMTP id k70mr6870019ila.122.1584025868458;
        Thu, 12 Mar 2020 08:11:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f16sm19812258ilq.16.2020.03.12.08.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:11:07 -0700 (PDT)
Subject: Re: [PATCH] block, zoned: fix integer overflow with BLKRESETZONE et
 al
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-block@vger.kernel.org, hare@suse.de
References: <20200212174027.GA3535@avx2>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36d297fe-5cf9-b438-ef9a-da7e1668da7b@kernel.dk>
Date:   Thu, 12 Mar 2020 09:11:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212174027.GA3535@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/20 10:40 AM, Alexey Dobriyan wrote:
> Check for overflow in addition before checking for end-of-block-device.
> 
> Steps to reproduce:
> 
> 	#define _GNU_SOURCE 1
> 	#include <sys/ioctl.h>
> 	#include <sys/types.h>
> 	#include <sys/stat.h>
> 	#include <fcntl.h>
> 
> 	typedef unsigned long long __u64;
> 
> 	struct blk_zone_range {
> 	        __u64 sector;
> 	        __u64 nr_sectors;
> 	};
> 
> 	#define BLKRESETZONE    _IOW(0x12, 131, struct blk_zone_range)
> 
> 	int main(void)
> 	{
> 	        int fd = open("/dev/nullb0", O_RDWR|O_DIRECT);
> 	        struct blk_zone_range zr = {4096, 0xfffffffffffff000ULL};
> 	        ioctl(fd, BLKRESETZONE, &zr);
> 	        return 0;
> 	}
> 
> BUG: KASAN: null-ptr-deref in submit_bio_wait+0x74/0xe0
> Write of size 8 at addr 0000000000000040 by task a.out/1590
> 
> CPU: 8 PID: 1590 Comm: a.out Not tainted 5.6.0-rc1-00019-g359c92c02bfa #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
> Call Trace:
>  dump_stack+0x76/0xa0
>  __kasan_report.cold+0x5/0x3e
>  kasan_report+0xe/0x20
>  submit_bio_wait+0x74/0xe0
>  blkdev_zone_mgmt+0x26f/0x2a0
>  blkdev_zone_mgmt_ioctl+0x14b/0x1b0
>  blkdev_ioctl+0xb28/0xe60
>  block_ioctl+0x69/0x80
>  ksys_ioctl+0x3af/0xa50

Applied, thanks.

-- 
Jens Axboe

