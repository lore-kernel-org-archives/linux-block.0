Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE59C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 23:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiBQXtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:49:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiBQXtX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 18:49:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F23789B9
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 15:48:56 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l9so5836460plg.0
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/w15czlRzN+lDuA+qHytIYAHyMQESX84Et1z7TZM9SQ=;
        b=E0PL/GDBGGWqp32hQEn6OZ5Dc731PaV3f7dp0lN4AfdiPVYh5r1W+7ISlA4UPmtRFO
         baPlmc5sbbCzcXzScl6kfE0AlWDQC3uaLF4wXlPTyVsCWXkyktW9gsGrrwqK6C4f8fKW
         c0SAw7P9oK8WVsLo/6TRx5/CsKQo6A7kVwoFosZr4+5ZUxvCi5SNG834krc6CaFBQ/uq
         cO+vjRsEBUiEaOqq1YUHwCHZecCGHPGy7JreaZxYQ+BfuYee0kLOCkEiD2xS+eOwGcs3
         JLwb1PfJf2uLepOdlzXZUtDRphvsCti97lZ+BkHlg6VNnZ6Brihkn3T2kwviC3E/YeBN
         p0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/w15czlRzN+lDuA+qHytIYAHyMQESX84Et1z7TZM9SQ=;
        b=0YEp9Z21QTe2kh2RlXdU8xYN1CvsZujq/vFmXshJFM1Ze4eNJ8V0nCtMjSvZ1jhqBw
         4KIPXYBOdF5Qo8q8giok/LoF33OSTANGPt12oXZKAEWZm3/SYuY97jmgPStI9dvKJxKN
         LntoRJWcD/5wmpoNqls/0u5y7PU8k6ZecRVv7YPZt2/V56sgEHRa6i9/fK9pM86EuVMy
         MST7+Vjsux2DiBhbGyE6S9DSrSOOKfmELTmWEJsjxRJCc4Oqp414x0UgqDU/BoG23vG8
         TCXrMNJKNZTP9SD8vaj4sI06xpIMBzAPX0X4m5QeIQL5GUS8QbS7LbClfEYzt08zySay
         JWUA==
X-Gm-Message-State: AOAM532IPAotSF1kC1ZZH2D+YfytChgBFNLmaRPGZEJ/2JVh0w5dAyDm
        3f8IxgmXl6KuFf7HQYSAGTvPqg==
X-Google-Smtp-Source: ABdhPJys5s2voOmnNrN1vZmThsDqlgMwJ363O3uIV/aFGPGvykYNrWOU3hS0uYHs0xS3tKUR4o6/8g==
X-Received: by 2002:a17:90a:b017:b0:1b9:485b:3005 with SMTP id x23-20020a17090ab01700b001b9485b3005mr9759342pjq.33.1645141710595;
        Thu, 17 Feb 2022 15:48:30 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9013])
        by smtp.gmail.com with ESMTPSA id c3sm668306pfd.129.2022.02.17.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:48:30 -0800 (PST)
Date:   Thu, 17 Feb 2022 15:48:28 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/008: check CPU offline failure due to
 many IRQs
Message-ID: <Yg7ezE/wSmCek2H0@relinquished.localdomain>
References: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 28, 2022 at 06:45:12PM +0900, Shin'ichiro Kawasaki wrote:
> When systems have more IRQs than a single CPU can handle, the test case
> block/008 fails with kernel message such as,
> 
>    "CPU 31 has 111 vectors, 90 available. Cannot disable CPU"
> 
> The failure cause is that the test case offlined too many CPUs and the
> left online CPU can not hold all of the required IRQ vectors. To avoid
> this failure, check error message of CPU offline. If CPU offline failure
> cause is IRQ vector resource shortage, do not handle it as a failure.
> Also keep the actual number of CPUs which can be offlined without the
> failure and use this number for the test.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks, applied.
