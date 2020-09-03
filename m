Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF841C10DAA
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B427D20767
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YWusSryR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgICVXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgICVXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:23:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF3C061244
        for <linux-block@vger.kernel.org>; Thu,  3 Sep 2020 14:23:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3141721pgl.2
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7aPf35sf/rS+GXTAQsshOPRXPlwTg6mH4xINQljk/gs=;
        b=YWusSryRB8OcSkITbDHW/EnL1O/mD9bEqM8DYvjXJbHtrcFb8EHan+0f1sXoNXbb8i
         VpnHm2/J9Ngzg9ND5BGc/oXr6jtgVLu1VP3mBDHkl1ptmzNiwTJW9y2OVFk9fpaANOp3
         aJSUvD9m7EfQDpgyqKBqjsR0i2J5j97MiE6NXIO3GDDBDoM46Er41HUkJxui+v2KjPZV
         y6Qyu85ZJd702JPAxSVSNNyG9bOM7VvKq/H7feko+WrI6I25Q6Iqd11dUxU9mKwV4qRt
         jb1ReKZH5H6o9L5VdNLoDB7U7GS0P7G7D+E3jSAH0DQCabwewZfSixE4hSH6JxsY1zOw
         AO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7aPf35sf/rS+GXTAQsshOPRXPlwTg6mH4xINQljk/gs=;
        b=RwDd4QDCWQpvz/MicehBZ7kas0ATv5Izq4aqh9EBaDv3SI5/iobp6tzvZboKl9KcXY
         IlsbMCAzrZ1EaBAQEYh1jD+DV6+Rr+WaKgp7Z1Q0cg05KwdrlAYunq0g1LAwFiCsvWea
         z1rZ2j0mANlqqiqCUP2S/tE8Q8J+vymjFKFf0tVZxWzWXUXHPpPf03eqyDJWvGzPwDXS
         f0HNAttIqZMK/HDMwlfvAzoAVaSkhpg+3LFghO3MDkLkn247QfhS0X66qhEdJKynuymB
         lNtC/9+Fh8T0ARPtlLp+xHirb3j5W7O61CVbWZUd3rdA1IWaXsipgIY7K0a3lFXDFv1U
         7RlA==
X-Gm-Message-State: AOAM531jzRSKVJwY3Jk545g8iSfjc8aIEI0odQ1gTWKUhzObTSyxwx1u
        6/BYZxdaRsHN5VzlXuC1/2AEeeVe2Oct6kL8
X-Google-Smtp-Source: ABdhPJym9rvtUQKTClz+mGu97nT6oHUMgtaUIZjPoGBmcrUgQSrxVqyJs/60gErYsCPJ4ijihoDT1w==
X-Received: by 2002:aa7:8ecf:: with SMTP id b15mr5674464pfr.236.1599168222424;
        Thu, 03 Sep 2020 14:23:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::1063? ([2620:10d:c090:400::5:c6f0])
        by smtp.gmail.com with ESMTPSA id u63sm4188113pfu.34.2020.09.03.14.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 14:23:41 -0700 (PDT)
Subject: Re: [PATCH v8 00/18] blk-mq/scsi: Provide hostwide shared tags for
 SCSI HBAs
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, don.brace@microsemi.com,
        kashyap.desai@broadcom.com, ming.lei@redhat.com,
        bvanassche@acm.org, dgilbert@interlog.com,
        paolo.valente@linaro.org, hare@suse.de, hch@lst.de
Cc:     sumit.saxena@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, megaraidlinux.pdl@broadcom.com,
        chenxiang66@hisilicon.com, luojiaxing@huawei.com
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df6a3bd3-a89e-5f2f-ece1-a12ada02b521@kernel.dk>
Date:   Thu, 3 Sep 2020 15:23:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/20 9:20 AM, John Garry wrote:
> Hi all,
> 
> Here is v8 of the patchset.
> 
> In this version of the series, we keep the shared sbitmap for driver tags,
> and introduce changes to fix up the tag budgeting across request queues.
> We also have a change to count requests per-hctx for when an elevator is
> enabled, as an optimisation. I also dropped the debugfs changes - more on
> that below.
> 
> Some performance figures:
> 
> Using 12x SAS SSDs on hisi_sas v3 hw. mq-deadline results are included,
> but it is not always an appropriate scheduler to use.
> 
> Tag depth 		4000 (default)			260**
> 
> Baseline (v5.9-rc1):
> none sched:		2094K IOPS			513K
> mq-deadline sched:	2145K IOPS			1336K
> 
> Final, host_tagset=0 in LLDD *, ***:
> none sched:		2120K IOPS			550K
> mq-deadline sched:	2121K IOPS			1309K
> 
> Final ***:
> none sched:		2132K IOPS			1185			
> mq-deadline sched:	2145K IOPS			2097	
> 
> * this is relevant as this is the performance in supporting but not
>   enabling the feature
> ** depth=260 is relevant as some point where we are regularly waiting for
>    tags to be available. Figures were are a bit unstable here.
> *** Included "[PATCH V4] scsi: core: only re-run queue in
>     scsi_end_request() if device queue is busy"
> 
> A copy of the patches can be found here:
> https://github.com/hisilicon/kernel-dev/tree/private-topic-blk-mq-shared-tags-v8
> 
> The hpsa patch depends on:
> https://lore.kernel.org/linux-scsi/20200430131904.5847-1-hare@suse.de/
> 
> And the smartpqi patch is not to be accepted.
> 
> Comments (and testing) welcome, thanks!

I applied 1-11, leaving the SCSI core bits and drivers to Martin. I can
also carry them, just let me know.

-- 
Jens Axboe

