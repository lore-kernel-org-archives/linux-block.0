Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C47C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93E56112D
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJVPPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhJVPPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 11:15:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9E6C061766
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:12:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so4701350otq.12
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=t14QNG0UwN7dkt//C3KUcPq8O3yC3SfxZ3I+al+TmyY=;
        b=aehp0UXp5f5G0YhjnWl5royZh/sGTRtPzxAL4qjMQ8Ye7q/dfvWI7TcVD5OQVnNM2v
         ybwAPH0i4HNzC9S4SFbjS/1mZ0w6ujBryo2SlwPu0XCvFelsR87oIwy6+tz7BwUWhpgx
         qpdDcm4+rRFmHHi/cIH6xhY1A6NkFifwciPECB0dewPzSlCRIqa+ukzeH6Rrsd0GzfZN
         WKugNxPvEGTuWoPumhdEeywDY5UATUtm9yBblOXamoedUYXOaC1ChePx+YQvGFTOWJZ+
         cH4Y7alli87+oNP4fo4Ng3deMjH12LZDCaraLgKnc78kNPQx9ASGheFnk5AhPdu7LLb9
         xZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=t14QNG0UwN7dkt//C3KUcPq8O3yC3SfxZ3I+al+TmyY=;
        b=l2zK/MhG8XqrlbnqgREvXHQ9gouh0Fbe7aI/8acV81OtHq0VzPykhs3pAhEPQ04nYJ
         LOmvkMVDH9wXbYDLGlxtDDWu+ttn1MvENZTZjd8pMNYb6oE7u9Sw1Ao6HFFk7pMtrSis
         2PL9ldD+ejeZc70MyxKVi0ioJQSUG1azQ2K1wppHPwp4VWr5op7o4rJzz0W0ymJwzJnX
         rvWNpvlpJ/3DOb8GVSQJ/zHcakCEyEdrY9v7PI27uZuEY+HQcl++ORlchrXtwCEcLIEW
         eqEM//XmsT6wUVnqlABjQvb8rULaX4urhuNIR3XfxpRw9MoMIJ5ffWaYgcYTsSqFn5wl
         3iLg==
X-Gm-Message-State: AOAM532JcLfIlgmovHoWB62RfLWcjSVv1YP3pwCLK84PsEJ4uYeLGHiu
        WyguLx1F+06L8IhUB8v56D0pJdaag1kyTw==
X-Google-Smtp-Source: ABdhPJyY8IvevMOtVlADk/YdTCs4RWU1Xze2ohCuVyMHpmZIgPIFHr+ZFrbP7kRVpEPws8vr024S2w==
X-Received: by 2002:a9d:2a8:: with SMTP id 37mr416701otl.58.1634915567461;
        Fri, 22 Oct 2021 08:12:47 -0700 (PDT)
Received: from [127.0.1.1] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id i13sm1871695oig.35.2021.10.22.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:12:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <344ea4e334aace9148b41af5f2426da38c8aa65a.1634914228.git.asml.silence@gmail.com>
References: <344ea4e334aace9148b41af5f2426da38c8aa65a.1634914228.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next] block: fix req_bio_endio append error handling
Message-Id: <163491556674.90769.9432329880143557478.b4-ty@kernel.dk>
Date:   Fri, 22 Oct 2021 09:12:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Oct 2021 16:01:44 +0100, Pavel Begunkov wrote:
> Shinichiro Kawasaki reports that there is a bug in a recent
> req_bio_endio() patch causing problems with zonefs. As Shinichiro
> suggested, inverse the condition in zone append path to resemble how it
> was before: fail when it's not fully completed.
> 
> 

Applied, thanks!

[1/1] block: fix req_bio_endio append error handling
      commit: 297db731847e7808881ec2123c7564067d594d39

Best regards,
-- 
Jens Axboe


