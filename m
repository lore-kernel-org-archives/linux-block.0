Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD5C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 20:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhLNUth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLNUtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 15:49:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D395C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 12:49:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k26so18814705pfp.10
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=81Eu+4hNmNyLkFVxFqpLmunbwN48igqxU9UopdqlQoU=;
        b=iWp3HSDlUPt2H5YTvyEumVj31LZA61mHfqGzTcn7NggaB0L/bIDGG1CY/QaxpTfytD
         wuzy+YsChz/xICh0EbmTxtmeGEigS96eKo4n3V1Bef8CmoPaeD9jclHVqJqERqE8e5CA
         N2lm8NxQ3PJBSiBaoFMq9Gi0zb5QfMVwKrMHOzfmwsY1dJ72pTwG4dphIWyfWhK+9rr8
         9AlqwwoJluMTe5IDn3JgRYULNEj8NQ4OSyZxLSWhASojpQVn5MQqJpngIhTVS2OM0tb5
         Q0NwMCHbtqdiawcrjnjK82VdebTaxVS/8dGbfs0Gsz5BrCBu6ILdEG5JzijgMO5DX8TX
         ziIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=81Eu+4hNmNyLkFVxFqpLmunbwN48igqxU9UopdqlQoU=;
        b=dhHPbVnoKoZXz5sRMTDO4FTda5ECcjDZYxxOBVkLtJvxUJ0xCuzYmAcjRaHVvTJrgu
         1NDunzJ8UGmNVC5ETIQkkpJZWriPnhbk8RkOh7ggWIPiTXT8v9MepNUDauVS5d91B589
         5lvZJnpPDP+He0UvS5gZXPfcrfca+UD6pGMNMZfqLze+zo6v2KuEF+DvZ1CBYxf1kPGA
         ++1aYH16lq0zw5Dk5Uy5N9y4AyybHeYO+ulK8aRzwN/U/XmzkOwUGUE1VLEWQeN9/zlk
         IWVz2SQkCcRjbG+jqc83sJTkr8FvlX/hFqdDyraRkFyCsdmN/mVvZQhKLPFuRr/vs33s
         tIBw==
X-Gm-Message-State: AOAM5306kT2mSVRrsIrilcwKzmajBrR2lgrRA8iCyYEEsNhR7zG4SljV
        gO1vDVo3dUdvsOq18joM1aaLDg==
X-Google-Smtp-Source: ABdhPJwlxextMALk23yTNDQf8f+M95Njc2M+PUVT5hKHStV4zM26oNpCHQKB+slY57WoBGoEqAelgg==
X-Received: by 2002:a63:a18:: with SMTP id 24mr5316000pgk.100.1639514975956;
        Tue, 14 Dec 2021 12:49:35 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e8::1780? ([2620:10d:c090:400::5:f59d])
        by smtp.gmail.com with ESMTPSA id y126sm656958pfy.40.2021.12.14.12.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 12:49:35 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: reduce kblockd_mod_delayed_work_on() CPU
 consumption
Message-ID: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
Date:   Tue, 14 Dec 2021 13:49:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dexuan reports that he's seeing spikes of very heavy CPU utilization when
running 24 disks and using the 'none' scheduler. This happens off the
sched restart path, because SCSI requires the queue to be restarted async,
and hence we're hammering on mod_delayed_work_on() to ensure that the work
item gets run appropriately.

Avoid hammering on the timer and just use queue_work_on() if no delay
has been specified.

Reported-and-tested-by: Dexuan Cui <decui@microsoft.com>
Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 1378d084c770..c1833f95cb97 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1484,6 +1484,8 @@ EXPORT_SYMBOL(kblockd_schedule_work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 				unsigned long delay)
 {
+	if (!delay)
+		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
 	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);

-- 
Jens Axboe

