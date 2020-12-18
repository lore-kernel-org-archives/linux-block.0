Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47380C4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2523B23AC6
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgLRPDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgLRPDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 10:03:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA317C0617A7
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:03:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q4so1535816plr.7
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=44Dz7UODKtxucgIU/z0kgpq5D9ykfiTluk1i5GOLaTA=;
        b=ioj0D8FS0RItvOwIo1SdCkZSKFnIv7CUPYVBsFYAYQOeEHpnQ5532g0arCpf8VXfPM
         KZZ6bX8fT/BlfTyZ5l8Usg1xDttwXQt9y2sGucbt+Y0PEuJc25QY2rHPNMc3l0vpa4Gg
         wEuYNsfm90CQKPUZuENWYnQ/f6H1Bas8/tBxJiXuKnudDkvmoB/BPOWIATLyvbHubVq5
         AnwgnNsuHzBhZ3GT6Gk+j4GvSCVGhc1QZq7BwpQ+kMM3Sbp4VrGhKVAvrSmw/mfBAyiM
         iAJm9bAxpBXN792Ntex7D5fkM7aDd1tqFGpvHjN6OX2E4p7PS7Qy7HipTSI19FN7Pnxs
         +Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=44Dz7UODKtxucgIU/z0kgpq5D9ykfiTluk1i5GOLaTA=;
        b=TqDy1aBUQixlAmf5Q3zrxp9dusfZ4Aho8Unou3aRHKOqX10e9oGS5dBiuK9Pw4K01b
         8OCK754lJr3xuXlEjge0OH0zJ6ofJ2B/2g8FV7gIgi6hYpdqq4faz54LMRUExj+EeScn
         MOSAvgNH4MyATdiKqfyhCGqYf8G6o14esjFxLV0jO2w8LuNOdYI3Saw8Z6dlOwPTxtMw
         /nA8tPMpJGmNKWuBZ5dWIg28FhpekOyHsO9x43Qm6t7XD0kCTLuAVAlkAMEgiN8RhAOt
         3F7iOOYDUZbm3+kGeRTqHM3/Wt+2q+o3G+IAJBQ55Wc9kG9ROwN0BWodklUYny68/xDu
         ca2g==
X-Gm-Message-State: AOAM533ir2d5pv0Gav7dXBojMQMGzsvoUii0I6BallSvlrhIL9Jjk7AQ
        OepPYVx88A+PRtbTnQmletd8if64P2AEEg==
X-Google-Smtp-Source: ABdhPJzakMBae9YxPyetoyx09lLXa4HqE0Q6BwpTGImP8ImvcD+YwyJXtN5pB9xq9xGxChNBaYGTkA==
X-Received: by 2002:a17:90a:348f:: with SMTP id p15mr4725822pjb.125.1608303780165;
        Fri, 18 Dec 2020 07:03:00 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d4sm7776167pjz.28.2020.12.18.07.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:02:59 -0800 (PST)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: "blk-mq: Use llist_head for blk_cpu_done" causing warnings
Message-ID: <1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk>
Date:   Fri, 18 Dec 2020 08:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sebastian,

I'm running into these when that last patch is applied:

NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #10!!!

on at least my kvm test bed on the laptop. I'm going to revert this
series for now.

-- 
Jens Axboe

