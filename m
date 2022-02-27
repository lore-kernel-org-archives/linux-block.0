Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C325C433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Feb 2022 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiB0VxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiB0VxT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 16:53:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C958E3DDF6
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:52:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so8698989pjb.3
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=KELxwpE6zsT2Sd3VaKEod57TJwPwVugZyJqtCDvL28E=;
        b=xTG8nK5H6qwycXEKjmelhk9G1F46HO/f0zI426KHXciCpZEghM6+Lw38sThzSOhqic
         9UJxPh/V/cgNsVH6BrEuu658Mj62JZmCgdZUQd3XFt9sn1RWdyvijVMFF7A4uVFyc9el
         V03MNJNvP12XZcOP1Y/KK2+qimtrsrw1pnwQA4nfO5AltiOB+CjsZFqMQKHlSiEW5DPS
         FPTtmNB8x/yEK3uzDN/wg7zTFZ5dlZo738hSOyr74Jk5OTxdoIqP0ZC2gFZi0sTyh2rg
         VAHI6JlE8wD9XujjzMK8jX8QhjFT+a+quJEdwnAaG//iQ2/DpfOk2ktk6FajcfjyMA9z
         mdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=KELxwpE6zsT2Sd3VaKEod57TJwPwVugZyJqtCDvL28E=;
        b=8Ot/M/La5QAK/EOoM4kKJ+GctfzcyJ8KJPVL1H2WfC9RtlbqwL4ItP48j/clocbeYU
         ZV8dRtM6dpEVnU0+JKI+c4VYgjqdYzBcnYNry8SZK8dVrMV5X1iUrxZg/x4yoHrU8005
         SyVgY0++5Euyl2N4cGdeTeSrenYueO61O74bO+YV9kH8C00+ELsdEYp+gFyxwhOuPA98
         3PUThj5U02wEqinWVpKb7rUJmNn2Aj+7kiha8rAzPzQPcelyI3Umcbr7yUYGS8SpwDek
         jBBfL8SM2I3SJ/K0ZLznirw0RpcT2jH1lNlhkxmRmA+89Mmn/Wn/kYAZUmJ6hoN1HJ2W
         pKoQ==
X-Gm-Message-State: AOAM532hgsNyvyngHRv3bR1i+QbwtKhf0vw0WpNzpAENSNtW3VeR4ZEi
        GkG9wi5oE7N2zkmgi0/D8jhikgv7PhyZOQ==
X-Google-Smtp-Source: ABdhPJyINlHZicR+tKM59zWkHp5XFpvt6CfTxWUnjh8T8J9AnNvQMNiAURBFRwYfW6tVlPU6dV8QLg==
X-Received: by 2002:a17:90a:8e85:b0:1bc:429b:513d with SMTP id f5-20020a17090a8e8500b001bc429b513dmr13616893pjo.11.1645998760999;
        Sun, 27 Feb 2022 13:52:40 -0800 (PST)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a16-20020a056a000c9000b004f0f8babedfsm10597368pfv.29.2022.02.27.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:52:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nian Yanchuan <yanchuan@nfschina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220227170124.GA14658@localhost.localdomain>
References: <20220227170124.GA14658@localhost.localdomain>
Subject: Re: [PATCH] block: remove redundant semicolon
Message-Id: <164599876007.130939.6014751551631014564.b4-ty@kernel.dk>
Date:   Sun, 27 Feb 2022 14:52:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 28 Feb 2022 01:01:24 +0800, Nian Yanchuan wrote:
> Remove redundant semicolon from block/bdev.c
> 
> 

Applied, thanks!

[1/1] block: remove redundant semicolon
      commit: 483546c11d702fd6f74c8c3f8123b7672def10b2

Best regards,
-- 
Jens Axboe


