Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A1C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1952082F
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 20:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jesU0vjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfKYUNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:13:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41849 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYUNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 15:13:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id t8so6911497plr.8
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2019 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SU6TsSbBzeSs/e3bhPm8m2XCWSnbOEfh3IiQPmccc9c=;
        b=jesU0vjRdCu5el2BSZ/x3Uly8ne8WPKpBxf5LhFnWCPcX37vSuKt0plhiWAO73Ct/P
         O/dPwJ13ioEAc3LNOLoQHQuvhAqWHbGk/x1wEYrJEKSm9/hyr/bL/JzyIlJVWnDxSIMj
         9ZHwVS0hFYsIDTZqdbXxFIiFxFkCXPvrv6AWlWnFZTt45R+pIcguoV19/MMp4A4vBLJ4
         oDl+lNVyHuIc9d20N/ApbFbbO6t9dejCV+dqWLn/dfwzyBY/q3605bBdvdaIGvwa9tvM
         EfrtqB+I8Vt3mCdYL1xmkjHAFLM2Z10yRTSAhPMSmLUZqI7mNENzfFrfpWH3+qesrGLs
         goAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SU6TsSbBzeSs/e3bhPm8m2XCWSnbOEfh3IiQPmccc9c=;
        b=SohEjjspFWLluKxl5i2+daihWrTvdxag4mFCzhpOMS8PVlvorY7nRltd5AhYtut8fW
         zljZAt2Exo3v60GxA0PJTKv3X0Jw0COGcsZ7/vZSAz5PGz+I7Mhg6hyP7/y+qefpTUeM
         9dhTXx1CKtONYTRNknmAjmYtgG/X0/OnHqp7ptvepEdAvep92SMljytzWz+o0v+BqxQ8
         U4yLZSVlmJdwUq7mdXS+DFHGsIN/Zb1U4QmGhsYeMV7qz1kwpRrs1Kk/30K/GaZEgpA+
         yn5pGM31egLpJQuEnBbm3YeqSgdyLBr+YarvUbJbr2ljJKa22TMB1G8n3XJ1De5fcgiB
         9W3g==
X-Gm-Message-State: APjAAAUtnYRqQJOcnEjrHft93aOkwnV6yJIhVP1jRFmWxdmu3zGKu9u2
        MfgfhZ2SfKIEXNDzhzAxCYqc9A==
X-Google-Smtp-Source: APXvYqykeSEL6iIuskt8dXFK1EI8Oz7I/Lc396zlrPEGGRTGRPncXB/drkV+GUBMSs1MRjm+asvWTw==
X-Received: by 2002:a17:90a:a483:: with SMTP id z3mr976701pjp.55.1574712815804;
        Mon, 25 Nov 2019 12:13:35 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2:16e0])
        by smtp.gmail.com with ESMTPSA id x3sm216617pjq.10.2019.11.25.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:13:34 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:13:34 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 4/4] tests/srp/015: Add a test that uses the
 SoftiWARP (siw) driver
Message-ID: <20191125201334.GA639675@vader>
References: <20191115170711.232741-1-bvanassche@acm.org>
 <20191115170711.232741-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191115170711.232741-5-bvanassche@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 15, 2019 at 09:07:11AM -0800, Bart Van Assche wrote:
> Recently support has been added in the SRP initiator and target drivers
> for the SoftiWARP driver. Add a test for SRP over SoftiWARP.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/srp/015     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/srp/015.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/srp/015
>  create mode 100644 tests/srp/015.out

Hi, Bart,

I'm getting:

srp/015 (File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver) [failed]
    runtime  1.076s  ...  1.026s
    --- tests/srp/015.out       2019-11-25 12:07:06.749425714 -0800
    +++ /home/vmuser/repos/blktests/results/nodev/srp/015.out.bad       2019-11-25 12:12:07.634062201 -0800
    @@ -1,2 +1 @@
    -Configured SRP target driver
    -Passed
    +mkdir: cannot create directory ‘0x52540012345600000000000000000000’: Invalid argument

This is on v5.4-rc8 with CONFIG_RDMA_SIW=m. Do you know what is wrong
here?

Thanks!
