Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF64C433E0
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A568A238EC
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 15:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhAHPUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHPUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 10:20:14 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5FBC061380
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 07:19:34 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d9so10101099iob.6
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KwAKpjuTRQjD2W8PHLf+qTr766IBNvmBAEHG/aZKYXU=;
        b=lVTZHMy4zD/ToP7nAMspl/gbuDj5rCphyXMFPBUBi1LJvBiFy59zhyIpLM55QP6ZlG
         TuffFnSe8ruZ5fv4ogjroqD29ggY+JTml8tJgr2exM0JiCC3xj2WmMOmoNmWtYdYf/bt
         m+iGEZRQdcj7mC3enJt40UQ4u9LM+jsCEgeT6tBS/1Bx3GCPjLGNQVKbdUdhvfwBIcos
         s+VIa9eTSFkG2ZF9hzoggH78icRD8knqirmg8C+qrbXao7qRs09zMw5EpUKj7eAGrnPD
         NpNQBIq56o+7gZtgV7rTSfwW/RJDy/DSH1RAn6IkAFAcAZFV8W5gM1D0GnMqupcaJMfk
         O2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwAKpjuTRQjD2W8PHLf+qTr766IBNvmBAEHG/aZKYXU=;
        b=PVRhwpbq5PS7nFieaA5qZcYdPxDEyvgOjTY9MGRETvrZk3AoYt/XauB/bK67lmIl8p
         bbKdGzoWH1hcZ/QCjHBJQL17MnfLcbFOD8DP8n493K5SQ730MDART+X7HDRYUGSqJClI
         ZpJ4OocGTdxs/t9WhlNz8mWXi9kPH6JH3NkcjU6siZRSbWRhoeikfFhq5sNGGU1HPb3V
         LTfM7iq/S2fysYVTQiEFqh3NiUNBo3YsdSQRO42gLuv7652y2/rWTJYqN9C+g7tTpuBk
         TJXg9yBAyCgb1RDJMsITF/7Yu0mQblNkKlm6NqRHj8sP0bPQvOvXBq8i+VCKEm9HWzma
         r7FQ==
X-Gm-Message-State: AOAM5315TPotMUFALAYc8glMZGyAx4aSfbmc6QwBFc/F0bSY1DtqV6Dd
        xHyWuO7cMMEz0H/T3BAKx0iGKQ==
X-Google-Smtp-Source: ABdhPJwyWJ0Fw+dIW4lupntZP+cmiyi0gzhTw5/DtZHN1mVhao1YDekb/0W1HOa4XgVPZKetaNW3sQ==
X-Received: by 2002:a6b:8ec9:: with SMTP id q192mr5923705iod.28.1610119173536;
        Fri, 08 Jan 2021 07:19:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p25sm5760956ioj.21.2021.01.08.07.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:19:32 -0800 (PST)
Subject: Re: [PATCH for-rc 0/5] some bugfix for rnbd
To:     Jack Wang <jinpu.wang@cloud.ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5f95d21-042f-1aec-14f4-09ad86474096@kernel.dk>
Date:   Fri, 8 Jan 2021 08:19:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/21 7:36 AM, Jack Wang wrote:
> Hi Jens,
> 
> Please consider to inlcude follow bugfix for rc:
> - fix one compile error reported by ltp (me)
> - fix UAF for sg table (guoqing)
> - fix UAF in rnbd_srv_sess_dev_force_close (me)
> - fix module unload race with close callback. (me)
> - credit for Swapnil's contribution (swapnil).

Applied, thanks.


-- 
Jens Axboe

