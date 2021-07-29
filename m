Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE7C4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20E961050
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 07:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhG2HuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhG2HuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 03:50:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECFCC061757
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 00:50:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3361717wmb.5
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udUb3L8Bif4FLui4619O9MaK2lof2JoopjmyT+I1elI=;
        b=ddptn6MUxFG613WrhKyY4b1X9yZ9jH1j87VFcgsdVE7ozweMh8vRcnsqoaZTub5563
         QXFxef6MhA+Jn6c60BHQDf7Od/+UHtOh6Ve9WoSN8U4QCeHt0+vDLEPNZ/DCALqJxuDK
         1M1Pt7LRdLP+NYR5PCJn8FlhCODrUKAKUfUVdZs3oPDCO1lJKtZWtxAxvBRlcfB0iWkR
         KPKKWDUOonlaTRvHqyN4QYoP37WHDCeMHIZudJR/5UbXaVM6BSiGZEKwhAufiYCP7HlD
         mNY/Y4T3QRadjVMCwYMYdyXm0laYdlSYd+PFldAqCUqa4MPejxdSx0DJ7BvkNmEL/2YA
         r2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udUb3L8Bif4FLui4619O9MaK2lof2JoopjmyT+I1elI=;
        b=MsytXDnHCDqSPvX5vYSlVviRfMmJBdGVuyrfHFchI4SFC9GHvEXIFnZvKidkaEORto
         66A04+xRRQcTVAfHhjaauKWTJpmaE2Y2gcCx/J3NPnZPwfz+eDio//leI3AR4cnnGD6A
         nJUj9rNfCrKW3+PzaM3RRBoJULG1Z1Wkmz/M5RACP9R+9+eWeUvs5iTRRYC8rNmHN1Zf
         PNSxiSIax20Mf23lI703FNaQqhgx9S9thjTMXm2aR+Ak9xlE2oJvmliP+XtbxWfhFTVq
         t7CRV7RCiiiHoNwVMXGlndYfdQSkwUaOJObO77Ed/W2UBwFzDnU2974PmFvsSLcT+LAj
         Rh0g==
X-Gm-Message-State: AOAM53119pP9uvc5fOO2E7n5uozZJAuoN45FB8mA/5RgQnVpzqTU7sgo
        BSv9LjQ4gpX2o4f0mBPjw6M=
X-Google-Smtp-Source: ABdhPJyaIq8e9VQSmaYYwVo045uqXv5SeZPkxkRxeuEE9SyU02Zo9KPSdAZRKPt9b4eoJTXU1npvmQ==
X-Received: by 2002:a05:600c:4f86:: with SMTP id n6mr7183657wmq.60.1627545003895;
        Thu, 29 Jul 2021 00:50:03 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id l41sm2533846wmp.23.2021.07.29.00.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 00:50:03 -0700 (PDT)
Subject: Re: use regular gendisk registration in device mapper
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de> <YQAxyjrGJpl7UkNG@redhat.com>
 <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
 <YQGDLIbefYvSHJqi@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <96450487-a95e-85f2-3721-181125825bab@gmail.com>
Date:   Thu, 29 Jul 2021 09:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQGDLIbefYvSHJqi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/07/2021 18:17, Mike Snitzer wrote:
> On Tue, Jul 27 2021 at  4:38P -0400,
...
 
> Once I installed all deps, I got all but one passing with Christoph's changes:
> 
> Block_size: 512, Data_size: 256000B, FEC_roots: 9, Corrupted_bytes: 4 [no-superblock][one_device_test]Usage: lt-veritysetup [-?Vv] [-?|--help] [--usage] [-V|--version]
>         [--cancel-deferred] [--check-at-most-once] [--data-block-size=bytes]
>         [--data-blocks=blocks] [--debug] [--deferred] [--fec-device=path]
>         [--fec-offset=bytes] [--fec-roots=bytes] [--format=number]
>         [-h|--hash string] [--hash-block-size=bytes] [--hash-offset=bytes]
>         [--ignore-corruption] [--ignore-zero-blocks] [--no-superblock]
>         [--panic-on-corruption] [--restart-on-corruption]
>         [--root-hash-file=STRING] [--root-hash-signature=STRING]
>         [-s|--salt hex string] [--uuid=STRING] [-v|--verbose]
>         [OPTION...] <action> <action-specific>
> -s=e48da609055204e89ae53b655ca2216dd983cf3cb829f34f63a297d106d53e2d: unknown option
> [N/A, test skipped]
> FEC repair failed
> FAILED backtrace:
> 500 ./verity-compat-test
> FAIL: verity-compat-test
> 
> Seems like a test bug.

This is a bug in RHEL7 libpopt where -s=XXX is invalid syntax (works in recent distros), fixed in testsuite just by using the long option.
(Released RHEL7 kernel does not support verity FEC so it never hits this code without recompiling own kernel.)

Thanks for the report!

Milan
