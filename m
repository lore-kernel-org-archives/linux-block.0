Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA2C31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F138F20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="USwEzZa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfFMPxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:40 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44894 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbfFMI7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:59:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id l79so214200ywe.11
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yix4cwozT+jczHu1xP60tXczHRRxoNdAVfibY0mb7XQ=;
        b=USwEzZa7kdgRRBAgVoUG4Mn/z0skjfSIkvXgLv7sumTg99QxHOsc8HxY9MY1cXPGPV
         XktRpIYFVhMnzT7cMSAy1fe8pO+L1nG+tXGE+qMtXNOR/Kwpb3eqo8gNNPYmIYL9ecqN
         yNTjnsa1B0Uyvc7EuEG0XfDWxIo/92+2C9bjpNrcbLqbrk2ImAE75s7CgC1MRBMWUZIh
         sSlsBfXi8IQEZnbEaSabDoiIZY0xqXf486hkZcZGN2vOGnLc1BNSVWeIePHKky0EuFS/
         LcoBBYq3LvJxDAP72Cs22Fp06WqQhowgkL+CYAQM9EtVBdagAwLCM/xrWmA+tg6NZT58
         LVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yix4cwozT+jczHu1xP60tXczHRRxoNdAVfibY0mb7XQ=;
        b=EQ8a5ytuIm6Vx4firZokRKTwiKVaIk8OGBpHBXegUSYmkNKNLpcnuHldFsBsu43z7r
         jiS6MNwjwDJyVSQxeTt5/4CMFrmhc3MpVeyrKLh+Z9DTuaXmf9Ss2IpHMOkc288gQDze
         SDGt5C/BtWrT6SofrE3HWQFtJ/wUADt5yG8z9g3VNmhPBUTuX+x61bIxz5vcOWDvTnla
         XcQKA/x0PwuypJcCDjgQ0GO0DhTUEwhoWgjtP3FmHW6xpgLEySbBG40hqTWGubbWkZKy
         isXXl2Bx++/vCn+f190qwZwzfiF3TquJM87U9abpdvs0eoEwQIilh5koTesWY51xw7Y0
         6Lxw==
X-Gm-Message-State: APjAAAXUKYgPkFTATgGvE5VSDPpaI+ZMEV6656RNdGUuwRr+7s9RDrzi
        7p06lfT8dOl3IYJZ4+TMnZZZAmXUgK4bjQ4q
X-Google-Smtp-Source: APXvYqxhCHbtbpafVd8sFhaN8Qp403W5oGeM9dhphP8ruJg8dU7hCZTiTBVC036ErtaHpZnhWwtDpA==
X-Received: by 2002:a0d:d910:: with SMTP id b16mr3515205ywe.150.1560416342903;
        Thu, 13 Jun 2019 01:59:02 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id v70sm594527ywc.78.2019.06.13.01.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:59:01 -0700 (PDT)
Subject: Re: [PATCH] null_blk: remove duplicate check for report zone
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a98a8e6-830f-37ac-d52a-684fcfc9378b@kernel.dk>
Date:   Thu, 13 Jun 2019 02:58:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/19 4:10 PM, Chaitanya Kulkarni wrote:
> This patch removes the check in the null_blk_zoned for report zone
> command, where it checks for the dev-,>zoned before executing the report
> zone.
> 
> The null_zone_report() function is a block_device operation callback
> which is initialized in the null_blk_main.c and gets called as a part
> of blkdev for report zone IOCTL (BLKREPORTZONE).
> 
> blkdev_ioctl()
> blkdev_report_zones_ioctl()
>          blkdev_report_zones()
>                  blk_report_zones()
>                          disk->fops->report_zones()
>                                  nullb_zone_report();
> 
> The null_zone_report() will never get executed on the non-zoned block
> device, in the non zoned block device blk_queue_is_zoned() will always
> be false which is first check the blkdev_report_zones_ioctl()
> before actual low level driver report zone callback is executed.
> 
> Here is the detailed scenario:-
> 
> 1. modprobe null_blk
> null_init
> null_alloc_dev
>          dev->zoned = 0
> null_add_dev
>          dev->zoned == 0
>                  so we don't set the q->limits.zoned = BLK_ZONED_HR
> 
> 2. blkzone report /dev/nullb0
> 
> blkdev_ioctl()
> blkdev_report_zones_ioctl()
>          blk_queue_is_zoned()
>                  blk_queue_is_zoned
>                          q->limits.zoned == 0
>                          return false
>          if (!blk_queue_is_zoned(q)) <--- true
>                  return -ENOTTY;

Applied, thanks.

-- 
Jens Axboe

