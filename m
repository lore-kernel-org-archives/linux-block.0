Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB01C6FA83
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIHXeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIHXdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 19:33:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D461153B0
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 16:30:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d82so5831889pfd.10
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VI8ZKF30b6+ShoHnZl6AawsI5Hio7XEfpfHuGj/El6I=;
        b=aH/XTM65GYFxqa2vQcTB3vkorMCojpg4i7HfZuWsv1vi1UFCZCtCygFkcKwPMOzq2/
         DEzBBOjjhOilgFtWADg4Z9l6f822p2HWu/k4vbdrcVCKyvRdjWHuAUaLoTEFOr2XAk3d
         HzXMzlinEJYWN9aRz7l04GpaMlQinxQSUV2+7CkQlTZJZeqTRL6sUZnSSU5rlCBbnFz5
         fK32BbmwcjaY6UMwFyaQAcJNlg4me1LwTAyeERDOxEX2CjuZ77JapfvpBypGPQnwts9V
         tcPn3sRhE572hWFLaef4sRDHjd724Tx+Tdi+cPPm5vZTwsJOWB4+jlWwGNZXY9XGi4a5
         DEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VI8ZKF30b6+ShoHnZl6AawsI5Hio7XEfpfHuGj/El6I=;
        b=bZl+TKkwqdg+R2d8OKa8tBZYYHa/o42NXVMHs9r4K1pQVXXvYLzwjGVV9AX5g5FzqO
         2+TLMpnWbDq/xYW546gmYhGH+Q1v9oduyiTixMvNiK+RDdhkcRV52CYtGE8L1q0mS+su
         WfeNfzpEU37zVBsIeCtchI9gFZwr9hfExluAJdmybiU86b+gSY2fWoXfXbu2pFv8zzES
         7B2agrskCF/LtQy+1dSZ4dXNOLrZgsIRIEVBtXaEfB1gcAMYuP9anhQgxmXnNPT9qL0c
         ACOhll9Uw+7zrUqyM1qewREHWFkaY86IEEi4p8jh88heOZ1m7waBeLFg7WU4Lvt6qxtO
         IlAw==
X-Gm-Message-State: ACgBeo0TzUmF3455BIP2fVjYbc+AbxpdTL/fCfl6/PPTduVoN2+9VB05
        3y4uQrmnavR0kz3gRK8XCo0TiTFW6JQTNw==
X-Google-Smtp-Source: AA6agR4S3QbmzdzqyzoNutj5PC8QeiQiUtkjxw2wOLzsxgD6zDcROe3w+iC+K8xI9hw0ghA+dyN6QA==
X-Received: by 2002:a63:b59:0:b0:434:2374:6d12 with SMTP id a25-20020a630b59000000b0043423746d12mr9846216pgl.311.1662679685862;
        Thu, 08 Sep 2022 16:28:05 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gi7-20020a17090b110700b001f50c1f896esm124806pjb.5.2022.09.08.16.28.04
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:28:04 -0700 (PDT)
Message-ID: <cf3a0c34-9969-27e2-5fb7-5b5263e0af1d@kernel.dk>
Date:   Thu, 8 Sep 2022 17:28:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: add missing request flags to debugfs code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We're missing TIMED_OUT and RESV. Particularly the former is handy
for debugging, let's get them added.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8559cea7f300..dee789f2f98f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -283,7 +283,9 @@ static const char *const rqf_name[] = {
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(MQ_POLL_SLEPT),
+	RQF_NAME(TIMED_OUT),
 	RQF_NAME(ELV),
+	RQF_NAME(RESV),
 };
 #undef RQF_NAME
 
-- 
Jens Axboe
