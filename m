Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA7EC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D45E2086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 13:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tpEcxR9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D45E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeLLNtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:49:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42455 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 08:49:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so8635081plp.9
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KrF+haHfKOc2sIySyLQdDJ/U8+IBvgihuPVZ7lGTD0M=;
        b=tpEcxR9KJ+BCGZmnb8uxJ+Rnx4Mi1zypBNnni4CzGeIZ4VrrzdWbcOVfXYujuDFeJ+
         kVpiNfPMVnHsUl+ow4yJpFZoHvJQKEpW2Hi78674wxl4bzKRBctLtTk+G856MXzOWjm2
         cAC91P+5V+77SGHn1e+QIJ1nf4STcD1Jj31eN1i5zefbfMr57CFD92Wp9AjmdVZ0GVAN
         G+MzOE13QifAwDpQHkEs2Q+EixO3aXt21t9ad6v6SqxjmGQLYxvSthUX16CyJUhV9gq8
         yA/HRJeLFp1SZgmXGkd3vLckNJd5lnLFxiyTkN9vOZR76bHmopWaeeSvjyJl8Sk8COCt
         Zaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KrF+haHfKOc2sIySyLQdDJ/U8+IBvgihuPVZ7lGTD0M=;
        b=m9UyOO7cw+GsazFmq4DygE3RxvhHXT5xUnOFIQ6nd9GGNsL+e2h7SZPob+3AMFN6T5
         rHi0jt0qTt2E/vBhXZIp3if7PzqwhI1MxCKXcnS14SOSRoGbS5Tb158Ak9snVR057BnS
         V836KmeelNrWjVJIcQvsyhieKwwuOJMzKffdk4kwLLYPfA3g07KHPdcV/2WdcdFo4r78
         /cu5hVvnCMeWLRcYjXS87zoi2TBR5vvsjdnhmxpY0OQlxIzrZkDYVSNloFyofsuuXbEo
         8KOYnJEsseG4X7bYsEmzpjvtzgUTffi5GIcr0gojwrPjkecF8jpBmhljhiHSGbALOLUR
         1/2g==
X-Gm-Message-State: AA+aEWbAZTQAYWHe1J5RC01Nt+6rqWPGWn7QsO4AjsEXE3Ht7sYnMWVI
        gwVTN6f8UpIOcCOBO69zT3910A==
X-Google-Smtp-Source: AFSGD/V0nOrr5PBVdx28jgKbPEGfThEKtjKfg0Uzm5T2xTOqQKYqqPidVjmAlUdFhrq38iK1cDijhA==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr20113435plo.27.1544622590933;
        Wed, 12 Dec 2018 05:49:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p67sm34166222pfi.85.2018.12.12.05.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 05:49:49 -0800 (PST)
Subject: Re: [PATCH] block: deactivate blk_stat timer in wbt_disable_default()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20181212114434.13435-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eaba9bf6-c372-0396-13fb-6888062e91f6@kernel.dk>
Date:   Wed, 12 Dec 2018 06:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212114434.13435-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/18 4:44 AM, Ming Lei wrote:
> rwb_enabled() can't be changed when there is any inflight IO.
> 
> wbt_disable_default() may set rwb->wb_normal as zero, however the
> blk_stat timer may still be pending, and the timer function will update
> wrb->wb_normal again.
> 
> This patch introduces blk_stat_deactivate() and applies it in
> wbt_disable_default(), then the following IO hang triggered when running
> parted & switching io scheduler can be fixed:
> 
> [  369.937806] INFO: task parted:3645 blocked for more than 120 seconds.
> [  369.938941]       Not tainted 4.20.0-rc6-00284-g906c801e5248 #498
> [  369.939797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.940768] parted          D    0  3645   3239 0x00000000
> [  369.941500] Call Trace:
> [  369.941874]  ? __schedule+0x6d9/0x74c
> [  369.942392]  ? wbt_done+0x5e/0x5e
> [  369.942864]  ? wbt_cleanup_cb+0x16/0x16
> [  369.943404]  ? wbt_done+0x5e/0x5e
> [  369.943874]  schedule+0x67/0x78
> [  369.944298]  io_schedule+0x12/0x33
> [  369.944771]  rq_qos_wait+0xb5/0x119
> [  369.945193]  ? karma_partition+0x1c2/0x1c2
> [  369.945691]  ? wbt_cleanup_cb+0x16/0x16
> [  369.946151]  wbt_wait+0x85/0xb6
> [  369.946540]  __rq_qos_throttle+0x23/0x2f
> [  369.947014]  blk_mq_make_request+0xe6/0x40a
> [  369.947518]  generic_make_request+0x192/0x2fe
> [  369.948042]  ? submit_bio+0x103/0x11f
> [  369.948486]  ? __radix_tree_lookup+0x35/0xb5
> [  369.949011]  submit_bio+0x103/0x11f
> [  369.949436]  ? blkg_lookup_slowpath+0x25/0x44
> [  369.949962]  submit_bio_wait+0x53/0x7f
> [  369.950469]  blkdev_issue_flush+0x8a/0xae
> [  369.951032]  blkdev_fsync+0x2f/0x3a
> [  369.951502]  do_fsync+0x2e/0x47
> [  369.951887]  __x64_sys_fsync+0x10/0x13
> [  369.952374]  do_syscall_64+0x89/0x149
> [  369.952819]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  369.953492] RIP: 0033:0x7f95a1e729d4
> [  369.953996] Code: Bad RIP value.
> [  369.954456] RSP: 002b:00007ffdb570dd48 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
> [  369.955506] RAX: ffffffffffffffda RBX: 000055c2139c6be0 RCX: 00007f95a1e729d4
> [  369.956389] RDX: 0000000000000001 RSI: 0000000000001261 RDI: 0000000000000004
> [  369.957325] RBP: 0000000000000002 R08: 0000000000000000 R09: 000055c2139c6ce0
> [  369.958199] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c2139c0380
> [  369.959143] R13: 0000000000000004 R14: 0000000000000100 R15: 0000000000000008

Thanks Ming, good catch. Applied.

-- 
Jens Axboe

