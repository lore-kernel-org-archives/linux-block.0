Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF0C2D0B1
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAE220674
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R3YSkdAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBDOTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:19:48 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35351 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgBDOTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 09:19:47 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so16024888ild.2
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2020 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4NlxEaC0CdDvRmfmIJOSEJmWKwzQJ80B9aXkZjJVyL8=;
        b=R3YSkdACMblNudrIIr49OI3al1MMBN9pmhJpPWyJwaetdve9dKaEu4pAHACB4+u2DF
         8Re7w8S0G+/W+SkBaa9pXdjLEJgZqKWQ8s9eCl/DKXsZWeLk9hHmOdPgOxqLuTCXvXyk
         yJRQaS5WB/Irw4AlkCK5j79caBjeqEiCu6e+ltXtI1P2/VvDKBPrk5jI5npLthe2pl+a
         nTQKvvmGHkeckVgcdRdGQPIKUsViJqgnocZDU+l36nuGwDK226cjTK9FOJu3VhK1iTvc
         k7xzCvUqwAdTduymjTDHAuc7mlfsxytXEsCZRHITH6bb+AxexBTsa7Ee6DRQnwyM7ls5
         MJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NlxEaC0CdDvRmfmIJOSEJmWKwzQJ80B9aXkZjJVyL8=;
        b=WBRHQQImNe66VvVlnP3RWiPAnxGeKOQbwRz4/bJ7TPuZ/caQVCtAuxuqY762z8kYDB
         dBfo4U3v8HmyC2G/aBep5OdLEQ2mrxL2liMxFAzCC0zwlM/s+NX0NN0Ux4kp+9XmH9sy
         8OUm4VONfK3HptyE1Ug0WA2BiygHG4apzjg8BH/blPPvXtphLdCzj4AXUylLCT0ouO8q
         5c9fXdR3Q82jVqfFBXFmbgEHinj/fM2USD9ZJaCU+o43BGIQPKrPiV1eH0aBt8QhRUyB
         9PHbD1oBA1EjoHb+FYutdKlLNu4TwPehFn+w+w0HOsSq7tebD/8ZqYvOyuOGU1iWP3AF
         BKWw==
X-Gm-Message-State: APjAAAWZMdxrai63t5HbKY1UBWPxm0xKn8xcLg/KUQOEg7opZ+9bhNRR
        9QetAOHE5HScKCXjcpyPXaXUag==
X-Google-Smtp-Source: APXvYqyxorWrGAGoWeM+23k80onJrm+gVqtgsoo6CxIXcvEAH60ecFJYPhSM/N/ICQ4LGxIScoIUBA==
X-Received: by 2002:a92:2904:: with SMTP id l4mr28325026ilg.166.1580825987128;
        Tue, 04 Feb 2020 06:19:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d17sm8838522ild.11.2020.02.04.06.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 06:19:46 -0800 (PST)
Subject: Re: [PATCH V6] brd: check and limit max_part par
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>, Guiyao <guiyao@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <b643ad2e-33d7-0f0f-38a1-0ef06ccd3d3f@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <14b08288-7f0d-1033-302d-41549bfa5b67@kernel.dk>
Date:   Tue, 4 Feb 2020 07:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b643ad2e-33d7-0f0f-38a1-0ef06ccd3d3f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/20 4:30 AM, Zhiqiang Liu wrote:
> In brd_init func, rd_nr num of brd_device are firstly allocated
> and add in brd_devices, then brd_devices are traversed to add each
> brd_device by calling add_disk func. When allocating brd_device,
> the disk->first_minor is set to i * max_part, if rd_nr * max_part
> is larger than MINORMASK, two different brd_device may have the same
> devt, then only one of them can be successfully added.
> when rmmod brd.ko, it will cause oops when calling brd_exit.
> 
> Follow those steps:
>   # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
>   # rmmod brd
> then, the oops will appear.
> 
> Oops log:
> [  726.613722] Call trace:
> [  726.614175]  kernfs_find_ns+0x24/0x130
> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
> [  726.615749]  sysfs_remove_group+0x38/0xb0
> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
> [  726.617320]  blk_unregister_queue+0x98/0x100
> [  726.618105]  del_gendisk+0x144/0x2b8
> [  726.618759]  brd_exit+0x68/0x560 [brd]
> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
> [  726.620384]  el0_svc_common+0x78/0x130
> [  726.621057]  el0_svc_handler+0x38/0x78
> [  726.621738]  el0_svc+0x8/0xc
> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
> 
> Here, we add brd_check_and_reset_par func to check and limit max_part par.

Applied, thanks.

-- 
Jens Axboe

