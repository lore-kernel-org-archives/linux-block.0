Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76364C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B761053
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhKCTx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 15:53:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422CC061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 12:51:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso5073159otv.3
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NJJAeDm4lR1IWKcIMGCLF7hWryTWgPdMsq23gVu9Cq0=;
        b=a0iv53G+xtTHjl1tDVzn88oq8txZMYG236nrlgNNS6N3ON8ai+0mpzqWA4oD+ycMvn
         WJoi/JwCqkvYOTh9gGNCTF7DpHF4wMkmQKY00Aih2JMHVm1zG5uoiBqiBvNx9frymbgf
         +UHuOwa+5qBxJhgLPXcteBoeteTBEuNBqcQGuceEMiClXlY01NNQ4M6PzI/ai+wve3xa
         kLVZqS/1azV7cM4W3jTWrqyxj/XST5pPzTubgbunO9K/gzcszPIVS6xovZXLtkYHxard
         5u8LYfjOWu6Jf90CFZfGXbwU/TlX1eIVJqBg3iTVkaAPs7WpCfomHwEoabZtK8qP7FkV
         VVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NJJAeDm4lR1IWKcIMGCLF7hWryTWgPdMsq23gVu9Cq0=;
        b=irvXNRZNiAxIe9vTOFDblBMMdxIE1wv9dsvntHBeaVg4Pddw78xMLLKIWbz2rQ1D27
         XUXOu6kC1SmlpFHTtTI4sCREx51KuOjfopFQCJPs/zN9N/GSBAKSXCz1GszavGAVmvgM
         z4zfRpQsds0Or9R81BRVCghx+jHt+JM+ffDbuhblWP/9+ZUMjY4Oa/wKBLDHCPbbzznb
         W+kEtHW0q3TfzZPzhO3VSVo4cLy19GhmqCG/2qQ39qeKCsbYrlGR54ZxBcarH01FnFme
         QPFcY6kqVSr5gLKhbH8IGhR3oG2UEfKMPnaKytL34JPaIA9Zws8hqVTpKZ8u9ruEg78U
         PCZQ==
X-Gm-Message-State: AOAM532NuU0tn3VxPDzG7sHTWq49K0iYTpXvhC6gbaBy7CEgvLQYPtoV
        i4GVJmVLMGq87actJ9ajpM1P8g==
X-Google-Smtp-Source: ABdhPJzcKlpre9/j2IsmH4aztOpZzvDezOCIwQtQ2/AAWog41tJiOytcDRobGi+bzwssn8NjNXC9LA==
X-Received: by 2002:a9d:38f:: with SMTP id f15mr9407501otf.166.1635969079276;
        Wed, 03 Nov 2021 12:51:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q5sm830639otg.1.2021.11.03.12.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 12:51:18 -0700 (PDT)
Subject: Re: [nvme] f9c499bbbf: nvme nvme0: Identify Controller failed (16641)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-block@vger.kernel.org,
        hch@lst.de
References: <20211103141454.GA30634@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
Date:   Wed, 3 Nov 2021 13:51:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103141454.GA30634@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/21 8:14 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: f9c499bbbf603389abad60d1931c16b2f96dee06 ("[PATCH 1/2] nvme: move command clear into the various setup helpers")
> url: https://github.com/0day-ci/linux/commits/Jens-Axboe/nvme-move-command-clear-into-the-various-setup-helpers/20211018-214956
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 519d81956ee277b4419c723adfb154603c2565ba
> patch link: https://lore.kernel.org/linux-block/20211018124934.235658-2-axboe@kernel.dk
> 
> in testcase: will-it-scale
> version: will-it-scale-x86_64-a34a85c-1_20211029
> with following parameters:
> 
> 	nr_task: 50%
> 	mode: process
> 	test: readseek1
> 	cpufreq_governor: performance
> 	ucode: 0x700001e
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> 
> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   38.907274][  T868] nvme nvme0: pci function 0000:24:00.0
> [   38.924627][ T1103] scsi host0: ahci
> 0m.
> [   38.948010][  T773] nvme nvme0: Identify Controller failed (16641)
> [   38.951220][ T1103] scsi host1: ahci
> [   38.954193][  T773] nvme nvme0: Removing after probe failure status: -5

This is odd, looks like it's saying invalid opcode. Looking at the probe
path, it's pretty standard and the command passed in is cleared already.
So not quite sure why the patch would make a difference here. I'll
poke at it.

-- 
Jens Axboe

