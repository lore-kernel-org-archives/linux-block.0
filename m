Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE3C32773
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiHSU4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbiHSU42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBFCAE43
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso5919567pjj.4
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=DxL025cDMy8bj/txGlGSV4F0uiylq0n/L4z97TqCZGY=;
        b=s9XbufH+frXibGcELkQdxL2cG/ze1vfGRZ46jgvgnpX3Pjkm+os59lBblD4+F5h+MP
         Fj6b9GrYsoDgDAqKKD+5AnGyDGR92qsQHTKxbB2JsgUz5dgTGZb9Nq7p4MHOkHx3beLd
         8oHmq72EgLnDplF2Oa+VxUds4uJ8zlHPRHUurbhkcgkdW2QFdYVdGUl4PKFOpzO9ULur
         ug6JJ167ub1D5U/yllEI6e2PbYAw+7Z6ULEBrqB2kILKakZi9zLFGO9BW78l+sVPMi26
         E71wumLLZZiEJ3vuWmbr+0xKyjYb3063g6/Rk+9a/DFGx+OI6Bhd2+YDdbNDzOGjLyaY
         esNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DxL025cDMy8bj/txGlGSV4F0uiylq0n/L4z97TqCZGY=;
        b=UUhUqzi8ZTNs95B1g7jEMIq31egSbWr0h925hQcx5nozYFK6BdhtnSLFo7IWIVhqnq
         S3JTn/KH5DeWUzclf0oidTi3tWrMbiH4/OaopXnx+UTUMzf5XNEBjJk6d2t5wnIYBWQQ
         O8lMkGy/N6pbl7PvMmc6a3VCZNNx8TPljN5oVkorkRaMGH45gnhOVYQjgIEc5XOX5o83
         7XesTQ3nABSavCnnoqQkyZxFoYQ7q4qtNirsKdzertczTO88a+Bc3IuF79Oyo8FoKvq4
         t//laIxw8rYvfH2usv0sAVaBVeu00dY2Nd3CG5HnjS5rolEvqika/ZGLW5cgCSyvprz9
         RDpg==
X-Gm-Message-State: ACgBeo1I8TXDjiXJKvDWg0BytHanSCN8Aau/lgvBLebmNnYfda13iCjC
        Coy7WmNKFtkVaOa+HCAfxJvRsw==
X-Google-Smtp-Source: AA6agR5hcN2z+QGlJo2U0BXRDrdbIfsGOibNJJuA1/8XvgUTaCkIDka4L4ydtB2lut8PdkjoPnM1Fw==
X-Received: by 2002:a17:90b:1bd0:b0:1f5:32a7:2bc8 with SMTP id oa16-20020a17090b1bd000b001f532a72bc8mr10052267pjb.61.1660942584363;
        Fri, 19 Aug 2022 13:56:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a2c0400b001f54fa41242sm5658791pjd.42.2022.08.19.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, linux-block@vger.kernel.org
Cc:     sagi@grimberg.me, bvanassche@acm.org, jinpu.wang@ionos.com,
        hch@infradead.org
In-Reply-To: <20220818105551.110490-1-haris.iqbal@ionos.com>
References: <20220818105551.110490-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH for-next 0/1] Add trace event support to RNBD
Message-Id: <166094258341.37366.1029213673361705574.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 18 Aug 2022 12:55:50 +0200, Md Haris Iqbal wrote:
> Please consider to include following change to the next merge window.
> 
> It adds trace event to rnbd-srv
> 
> Santosh Pradhan (1):
>   block/rnbd-srv: Add event tracing support
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-srv: Add event tracing support
      commit: 12ee160671e0354c9ccb93d54614eb4a98f682e8

Best regards,
-- 
Jens Axboe


