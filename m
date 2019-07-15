Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D142C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19C42083D
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q6lMckc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfGON4l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:56:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39593 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfGON4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 09:56:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so7754115pgi.6
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLzeUCwDhnmuubSlWE5FO7mBsjlDcwQfEShESjt4gOs=;
        b=Q6lMckc8q2DfHZlKNZFC+04jZYCL8S7FTEVVJdIw8FN8Flnk2CRO+1gCEtKq4x5RX8
         4dhrUXpfFqWkcaB12tLph24n7C979QTTjwd4KXvH+xbbU5TT3V55wpisjAVAKFJhHxTB
         b3uzR2S3pjplm1b+NDkkHoVI+rfB4oVUIrHTgm0WRCcbT6xXsUpI9jcWCoQGDhvxeFaG
         XNtioRTi+Al0KCexrGdOCc7A0RJNtCKjXkMmxRRibBBepN7Uk2a0/4WQohhllHr+k9X8
         Lq1BDC+E7c8HX+/bUJXteZipG+LzKZblPlrIGGzHhu693WgBYI7yZ167264iHqRjqLNh
         OhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLzeUCwDhnmuubSlWE5FO7mBsjlDcwQfEShESjt4gOs=;
        b=L4xzPs/A/dCEO0HZLctniPngNHasZIxoZeAgeHvEHMC0+trM+XbYEmQQMmhhOhweMo
         guFBx9Rc1EEKELZia5fRYzbvQR2dkIPmipDztfdkR6hUFxo7zisAOlIjfMayV8Un5Ql2
         aplYxQ93fIxhPbmIHBlVU99sYtXC/RpEt2dAeiw6R614BHk0iZse9WEYhSMXrOlsyt7O
         MmkmJzbriJiJHKQcpED3+O9YELvvQj13t/jBrbNQEmEiV5xYZrdE0wykVW359Advzddt
         j/XEogS65rjyVOXoa+Hr2tAYrukW6QjAI+2pdFHXc+Sn3hpkTnjy8dy20vlkK4LLTozc
         dj5A==
X-Gm-Message-State: APjAAAW8ZPR6zEoqvZQiyIIK/66sdYBOVAPdYX7/u+KfE1pxdBkAMfcL
        h5iRxZOOTXMAe6C2bVTtrnPwb6nqS0o=
X-Google-Smtp-Source: APXvYqwNrHHw1hezwwKINEtoW5yfwUfjNr/40OQ5D2r8pl14YPty5LRH60B/WheNajbGOauTh1hiMA==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr29775864pjc.63.1563198999458;
        Mon, 15 Jul 2019 06:56:39 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v10sm17464861pfe.163.2019.07.15.06.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:56:38 -0700 (PDT)
Subject: Re: [block:for-linus 20/23] include/linux/kernel.h:62:48: warning:
 'zone_blocks' may be used uninitialized in this function
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <201907131730.Br9OqtbO%lkp@intel.com>
 <BYAPR04MB5816C2EFC9D3C9FEF6DCCD2CE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <279546ac-9089-d5fc-f26c-9e46db269623@kernel.dk>
Date:   Mon, 15 Jul 2019 07:56:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816C2EFC9D3C9FEF6DCCD2CE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 11:43 PM, Damien Le Moal wrote:
> On 2019/07/13 18:10, kbuild test robot wrote:
>> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus
>> head:   787c79d6393fc028887cc1b6066915f0b094e92f
>> commit: b091ac616846a1da75b1f2566b41255ce7f0e0a6 [20/23] sd_zbc: Fix report zones buffer allocation
>> config: c6x-allyesconfig (attached as .config)
>> compiler: c6x-elf-gcc (GCC) 7.4.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout b091ac616846a1da75b1f2566b41255ce7f0e0a6
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.4.0 make.cross ARCH=c6x
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from include/asm-generic/bug.h:18:0,
>>                      from arch/c6x/include/asm/bug.h:12,
>>                      from include/linux/bug.h:5,
>>                      from include/linux/thread_info.h:12,
>>                      from include/asm-generic/current.h:5,
>>                      from ./arch/c6x/include/generated/asm/current.h:1,
>>                      from include/linux/sched.h:12,
>>                      from include/linux/blkdev.h:5,
>>                      from drivers//scsi/sd_zbc.c:11:
>>     drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':
>>>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>      #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>>                                                     ^
>>     drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here
>>       u32 zone_blocks;
>>           ^~~~~~~~~~~
> [...]
> 
> Jens,
> 
> This warning does not show up on x86_64 native build with gcc 9.1.
> I just sent a patch to remove the warning, but I do not have a c6x cross
> compilation environment available so the patch was checked only on x86.

Is it a false positive, or is it legit?

-- 
Jens Axboe

