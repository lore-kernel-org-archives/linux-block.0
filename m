Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAD6C54E94
	for <linux-block@archiver.kernel.org>; Wed, 25 Jan 2023 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjAYUF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Jan 2023 15:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjAYUF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2023 15:05:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A038B75
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2023 12:05:57 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so14181984pgh.4
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2023 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz5FPIej+ZL768VxxTSO7JAtZIOpIDuLVahyOsFvYOE=;
        b=YvmdbXWa2RyfT2BuTdrlXMD1nWcHOo3bjDsk1hQNTk/wxdBr99dm6XbB44zX3qn4Ic
         sYMMqOqrbR85BKMxGn+ANBDoUM2uq7R/fjvqI/hqGq6ysflVIo0x+AxXIV4UAay/T6jc
         iKtsK8/r7lZslh82kBzqMDURAPdrfhXeGOgupLX7Rtzar8u6bnag+kePrh/1nLstpyLS
         e0OdzcMpyLSWpj6lm8hmK1DbIlFIKzTLgqyWAEQOVDoBX3wKwIGO3SguuEouDElAyeME
         b5Z6SsN/PHAfN97WV14OsPof03CKYf3rsBDtTnv8doui9qWK/kM9VWlDfPV97jGCP8yq
         BvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz5FPIej+ZL768VxxTSO7JAtZIOpIDuLVahyOsFvYOE=;
        b=iltCQy2I5BGDrVLoxEGeDrYYHWs190wAN9YqIeZSG0MiTBZhR1+ikqpn39g9+kM927
         iyOYq2Tfsni1jJH4HUsuOqo7YAsplEdnYqh/JUrhuSgvEhpOSlF3Lb+4uq55VUcw7BcC
         7NRX/r/Yqi8G4ncH1WRW9mp9GGopxh0Ur2B9Vavg0gLS+Qwa5185JaAbvHqkdjyLEbo5
         OfDtbEpEcwkGC1cez4WwfZ5fBhnWaiyaZSHQZ5GBLnwL/gk6sUMbSg+u3u0h8DgNMpCj
         rFe8ikoqDygkn6S36GE1rG7eu0+zog7QO+joZ40lHU4izkWFMG6aXqwKchcXzGvcg79q
         sUaw==
X-Gm-Message-State: AFqh2kpCQSlLcvU+mrRyq3UBfMXB794jZ1fm2Fr5AgtTYMRSAlMKQRlG
        o+KwyWzydxQ/omc2PDVOuHAwaA==
X-Google-Smtp-Source: AMrXdXu2pe2WV5ZQocz65zMgFywX9p/VuWbt0vbkgMyZUMk+FOjUNzPzhBlyp0hgDY8ORB4w2rwSDw==
X-Received: by 2002:a05:6a00:189a:b0:58d:e33b:d588 with SMTP id x26-20020a056a00189a00b0058de33bd588mr6889259pfh.2.1674677156998;
        Wed, 25 Jan 2023 12:05:56 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b0058e12bbb560sm4175535pfo.15.2023.01.25.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 12:05:56 -0800 (PST)
Message-ID: <d949dbc2-a0cf-c581-c5ca-ddefc592a0a5@kernel.dk>
Date:   Wed, 25 Jan 2023 13:05:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: kernel oops when rmmod'ing ublk_drv w/ missing UBLK_CMD_START_DEV
Content-Language: en-US
To:     "Harris, James R" <james.r.harris@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <78E62777-98A7-4D19-9608-D8A3412D9800@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <78E62777-98A7-4D19-9608-D8A3412D9800@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 12:50?PM, Harris, James R wrote:
> Hi,
> 
> I can reliably hit a kernel oops with ublk_drv using the following abnormal sequence of events (repro .c file at end of this e-mail):
> 
> 1) modprobe ublk_drv
> 2) run test app which basically does:
>   a) submit UBLK_CMD_ADD_DEV
>   b) submit UBLK_CMD_SET_PARAMS
>   c) wait for completions
>   d) do *not* submit UBLK_CMD_START_DEV
>   e) exit
> 3) rmmod ublk_drv
> 
> Reproduces on 6.2-rc5, 6.1.5 and 6.1.

Something like this may do it, but I'll let Ming sort out the details
on what's the most appropriate fix.


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 17b677b5d3b2..dacc13e2a476 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1149,11 +1149,17 @@ static void ublk_unquiesce_dev(struct ublk_device *ub)
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+/*
+ * Returns if the device was live or not
+ */
+static bool ublk_stop_dev(struct ublk_device *ub)
 {
+	bool was_live = false;
+
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
+	was_live = true;
 	if (ublk_can_use_recovery(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
@@ -1168,6 +1174,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ublk_cancel_dev(ub);
 	mutex_unlock(&ub->mutex);
 	cancel_delayed_work_sync(&ub->monitor_work);
+	return was_live;
 }
 
 /* device can only be started after all IOs are ready */
@@ -1470,7 +1477,8 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 
 static void ublk_remove(struct ublk_device *ub)
 {
-	ublk_stop_dev(ub);
+	if (!ublk_stop_dev(ub))
+		return;
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
@@ -1771,7 +1779,8 @@ static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
 	if (!ub)
 		return -EINVAL;
 
-	ublk_stop_dev(ub);
+	if (!ublk_stop_dev(ub))
+		return -EINVAL;
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 

-- 
Jens Axboe

