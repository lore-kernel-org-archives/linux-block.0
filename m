Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D1C6379F
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBPDZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPDZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:25:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92D11B
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so4944572pjd.1
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkIy+PD9i/Mhfprd/Udsg2LOk07qpz0tloczw1AVH+k=;
        b=sHrGTQHi458a4x4W2l57nULY+gXzylffkmirkZ00lK/CEn4sD9ZcJ5pFoONf7JeAKj
         w4etxAWFyiJoNzikFAmGWDyyNO6wnCIaWi7ugtDzSnBCAxr/u0rpHcN/mBwKwUO+ZO6C
         Y7Q7vV1CNWM1UxQ2WVVC9U/J+T407d2n3De5X2JQ7ELch0FPJ2h1JvQ2gTl94gV/FAUb
         PHPITJEVgbH6DyvWGE+BPvyq7ns8z/VaJiRly5f6mfw7PS1q0ZQC5rIA0wa47CUdYQ0k
         cnTfj4GmBa6vRmKermBwE75f1u08+HCAmVBTYGPnL9dVopKyK+qjk6XLWyZM3EDXxE4W
         Po6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkIy+PD9i/Mhfprd/Udsg2LOk07qpz0tloczw1AVH+k=;
        b=nbirpnJk/cFGUtRwcl0XCWyt0QfEu+2PmuxLWAh8uQHeZWlIWvZlUPvGJBhIf1X1k4
         F3XvYbAWzVqurrP7yUJsrDkGjJEFqzmvPAwtDmSjsuBLQiIx4IoQbBOXs5i48+VcuAay
         aqAaP2Mr/q3MWYp3At7Hf5X9rDbzodpYimsrDzGVfGiyhkpKp0IPQKXVX6EjLSm5ZJDa
         8yEVkwxXps5b0VYtcwsLLVUu/Tt8JehfnSrzltxiVwAjRJk3TU978qJZr4fqxnUBnK/G
         +KSWRWt9SCL9ljID5RWSDRYMSizoyK88beRosZ8Tyiu8oprZW70WcLOvHbAxX2WsQ6gF
         HLAQ==
X-Gm-Message-State: AO0yUKWigSH9hOHiiOWnmtBWoCtEVwfb/LDTR5eWVZh44t/86tNLAGIB
        JYIs16u/wIgcew6AJCuCyNrLIA==
X-Google-Smtp-Source: AK7set9J2TLiuEZRwITaTwfJ1e9POck3pKzDKucWlGmrsXZlwofcN6gxjsMtYBuAGJELZ8rBuAARlA==
X-Received: by 2002:a05:6a21:33a3:b0:bf:f68:9b1a with SMTP id yy35-20020a056a2133a300b000bf0f689b1amr4996660pzb.1.1676517922491;
        Wed, 15 Feb 2023 19:25:22 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id dw24-20020a17090b095800b00233df90227fsm2192615pjb.18.2023.02.15.19.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 19:25:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>
In-Reply-To: <20230209125527.667004-1-ming.lei@redhat.com>
References: <20230209125527.667004-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: sync mixed merged request's failfast with 1st
 bio's
Message-Id: <167651792171.207091.3077979859216146323.b4-ty@kernel.dk>
Date:   Wed, 15 Feb 2023 20:25:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 09 Feb 2023 20:55:27 +0800, Ming Lei wrote:
> We support mixed merge for requests/bios with different fastfail
> settings. When request fails, each time we only handle the portion
> with same failfast setting, then bios with failfast can be failed
> immediately, and bios without failfast can be retried.
> 
> The idea is pretty good, but the current implementation has several
> defects:
> 
> [...]

Applied, thanks!

[1/1] block: sync mixed merged request's failfast with 1st bio's
      commit: 3481d9424950159b1dbd366a14acab79f1440bbf

Best regards,
-- 
Jens Axboe



