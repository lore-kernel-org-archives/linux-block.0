Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E13C2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF91207BC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rDzBmDSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEMCVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgEMCVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 22:21:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14987C061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:21:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so10300840pjd.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uQx7jsiEoL+4pTsFLx0JIAQjXn+Xi7pKRn+FFonx4D4=;
        b=rDzBmDSOY6S6dcjX9uHeOo7f8BGfMNUwmLdQ8IJYvd2IusKnq1GIViVgisxpVParfE
         XIrI4hle7lKVMH4iKQJd6wJ5zYLM2RITNk6mB3Wu1RDN6oZQnxaw2gNgIHLl9xEtvAE5
         6qvu8bJUUL8bp/JyklkSkitcueAmLIhrPEY1OPhb4hWflrc4xwqwwO5M4jZrDUQXrhpH
         clK6Brch18AKBiJ2BTgMUJrQXMcUumd96s7PZjybnzHxMEBnELRbfpJX/QCfaBPNCXrd
         lEbxt3I9l6LAxj6yXZBu2TCW2D23TE80sIC8EXamMfi+u2pw4ShbHXF1z6Cy/1y1nu35
         8tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQx7jsiEoL+4pTsFLx0JIAQjXn+Xi7pKRn+FFonx4D4=;
        b=jH1Mnmyq2wjI7IL5EptnylpvKCRDVEuGcf47ZIJVta0M1RSvtyp1pqCxwy5sDH97xI
         5uE/WC4yeffZisyJleefEm6S+asISu7Cw7G9jJKVcsWLfHoBh4FCH+8HK9O1q2ePLGOE
         lrll303Bi38HJtivEp+ELmWuIWac+6ifS71tQOJ1pPqB6HtUEDTLgQjz3dJiqbGhJhZv
         4h5cEmiUceC4GiUSKMXcgSpJf5XtRNl04GSBoFCevCfFeJWGhe5oRd1gWyUaeVi5H8UH
         2mwWKph2yYg1lYLjlxQDHYnvMp7EZWydE+LARmWPrvxl61zERlBvI0CBK+BIt1iIfl24
         AraA==
X-Gm-Message-State: AGi0Pub8rvJjWxkioCKZe31xcwHojd2Qx07PsLkMo/6FHRoT528mHpZz
        qTBpqr0ob+aSdXvhUANeSAjcyndpM5w=
X-Google-Smtp-Source: APiQypJymAErgzRRhleZIsp6z5KEqf2zwrSpBCaveWCHD5WrV1R17sx7t8m7sIaXDa+MEF6wSw7iyA==
X-Received: by 2002:a17:90b:80b:: with SMTP id bk11mr21995579pjb.204.1589336461086;
        Tue, 12 May 2020 19:21:01 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id h9sm12912941pfo.129.2020.05.12.19.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:21:00 -0700 (PDT)
Subject: Re: [PATCH] block: reset mapping if failed to update hardware queue
 count
To:     bvanassche@acm.org, tom.leiming@gmail.com,
        linux-block@vger.kernel.org
References: <20200513004345.GA28465@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <585b0389-aa83-59b8-a155-f23621155bcd@kernel.dk>
Date:   Tue, 12 May 2020 20:20:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513004345.GA28465@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/20 6:44 PM, Weiping Zhang wrote:
> When we increase hardware queue count, blk_mq_update_queue_map will
> reset the mapping between cpu and hardware queue base on the hardware
> queue count(set->nr_hw_queues). The mapping cannot be reset if it
> encounters error in blk_mq_realloc_hw_ctxs, but the fallback flow will
> continue using it, then blk_mq_map_swqueue will touch a invalid memory,
> because the mapping points to a wrong hctx.
> 
> blktest block/030:
> 
> null_blk: module loaded
> Increasing nr_hw_queues to 8 fails, fallback to 1
> ==================================================================
> BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2f2/0x830
> Read of size 8 at addr 0000000000000128 by task nproc/8541
> 
> CPU: 5 PID: 8541 Comm: nproc Not tainted 5.7.0-rc4-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> Call Trace:
> dump_stack+0xa5/0xe6
> __kasan_report.cold+0x65/0xbb
> kasan_report+0x45/0x60
> check_memory_region+0x15e/0x1c0
> __kasan_check_read+0x15/0x20
> blk_mq_map_swqueue+0x2f2/0x830
> __blk_mq_update_nr_hw_queues+0x3df/0x690
> blk_mq_update_nr_hw_queues+0x32/0x50
> nullb_device_submit_queues_store+0xde/0x160 [null_blk]
> configfs_write_file+0x1c4/0x250 [configfs]
> __vfs_write+0x4c/0x90
> vfs_write+0x14b/0x2d0
> ksys_write+0xdd/0x180
> __x64_sys_write+0x47/0x50
> do_syscall_64+0x6f/0x310
> entry_SYSCALL_64_after_hwframe+0x49/0xb3

Applied, thanks. Please do run blktests on your series in the future.

-- 
Jens Axboe

