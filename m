Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF41C433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhLNOxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhLNOxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 09:53:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420CC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 06:53:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p65so24582690iof.3
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Q9uN+rlxBTJsrQVRj6do9tilx7EaOxNT54UxbaqD8Ws=;
        b=sJNyvjHwq4GxzrOD3ScRCXAdiLDOO+p19x7pqCwpMdGPTtm5JVRrT/Nxzg3cOmzXEa
         fgMiCoSQeyjhYTjaXUiph5bImJgsHaTsiFvwxsqRyQzU3fAhWg911uiT9qG5L6SHs0WF
         deu4IU1LF0WndsYCiV3GkB6t4pFqF5KKpARnJ27zQXIcdq3sImfYZwsMmvrSHp0QJnt2
         pld1DxdG9dkPErxVStf8NBo130EvYFugx6rovuNtiB6MsRah0S58JUt6+G4OGEwbVPmU
         u8q0kGMKkfW7UD/fle1B1yF/pDhm0TKtOdvM7w78dBBRHkutXk5qi+HfsYr+IFCvMSTP
         W5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Q9uN+rlxBTJsrQVRj6do9tilx7EaOxNT54UxbaqD8Ws=;
        b=v6gjSSzE7gCbl7IsAe7FGJQeF6j3uAUsJ1jngY3TUvSudBplc5kMQgtdFe027BCRfv
         HGNsKgWsczenawexttOv/VCJ0zmpOLcZlB5r7qMvFRoxtVa6vzOYR7sTg8BbNZ3ncBgD
         fYlIXhVpNmLHQvoNTxMyORqSN6E239UpHxmXXn/0FnuVVhEFHvJTn6M82LnhKY67nXol
         nYgrBAmGp+Eb/yQqTUfMRkSiK/BLX9gv3o/+Tkz5VobV+HaHPU2cQ4Kmsg4zPnq7k2uh
         wu8y5TYEBu8hDSPgLvZTJ8GLg9nodRCtKQaM38a5ZzLjiS55tUmjQHWn8+wDgCeJni5p
         2O4g==
X-Gm-Message-State: AOAM533OVk67ifc2uV3SY2qya8tr28xJ65AVTDh+s8No3zczscXdyMML
        NV0IP+bqv43HhShI0EmoDJUrkw==
X-Google-Smtp-Source: ABdhPJx04W3tv3wZKNP1dSwXzeuONhD8AcYikMfiKtx2RgxkMVxjchO81ZKVuPkjZwbiTDGHDuwohA==
X-Received: by 2002:a05:6638:14cd:: with SMTP id l13mr3189120jak.364.1639493627769;
        Tue, 14 Dec 2021 06:53:47 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u4sm24921ilv.66.2021.12.14.06.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 06:53:47 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: reduce kblockd_mod_delayed_work_on() CPU consumption
Message-ID: <bc529a3e-31d5-c266-8633-91095b346b19@kernel.dk>
Date:   Tue, 14 Dec 2021 07:53:46 -0700
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
flush path, because SCSI requires the queue to be restarted async, and
hence we're hammering on mod_delayed_work_on() to ensure that the work
item gets run appropriately.

What we care about here is that the queue is run, and we don't need to
repeatedly re-arm the timer associated with the delayed work item. If we
check if the work item is pending upfront, then we don't really need to do
anything else. This is safe as theh work pending bit is cleared before a
work item is started.

The only potential caveat here is if we have callers with wildly different
timeouts specified. That's generally not the case, so don't think we need
to care for that case.

Reported-by: Dexuan Cui <decui@microsoft.com>
Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 1378d084c770..4584fe709c15 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1484,7 +1484,16 @@ EXPORT_SYMBOL(kblockd_schedule_work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 				unsigned long delay)
 {
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	/*
+	 * Avoid hammering on work addition, if the work item is already
+	 * pending. This is safe the work pending state is cleared before
+	 * the work item is started, so if we see it set, then we know that
+	 * whatever was previously queued on the block side will get run by
+	 * an existing pending work item.
+	 */
+	if (!work_pending(&dwork->work))
+		return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	return true;
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
-- 
Jens Axboe

