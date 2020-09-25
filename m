Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D576C4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F2F20936
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kGFSLFPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIYOUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgIYOUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 10:20:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102EAC0613CE
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 07:20:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so3333305pfc.7
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E/Cgz17cLyD0MSQK14hl7iUyBkqVrB5po7hyqcxRBDo=;
        b=kGFSLFPE8mp0aEH5oAk7nraSruDlhCRRacMEOOLP+UVNgGUJXHtnYa+WXULeJumUqQ
         qZGhSE5D/zbdlbfzYqQTQ8BA33vPDn9sYq05ZLFwZ224rEGtNje6pnIhENdn/2O9SfVO
         INMvI2U5y+WRjmMC8YadGEpVSrqmGP40VNcbf0EVz92PwSQysM5J/U6KRfW7zKcLXFiQ
         p2kNt+pjqj/iMEbWZ3/cPONhdPOyQIdJ4pbzU+9HL0p2jaS6EXfrpHLyNg1ZzzxeMwBr
         6yB1QvxQNdUT0bgeFRVwud8i0ZqjMnCEvfCGOpeGGz1eFf1GHVJmlkNnmXArLVcuZQbe
         0hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/Cgz17cLyD0MSQK14hl7iUyBkqVrB5po7hyqcxRBDo=;
        b=dSO+Dfzp+GTww0k6Ea9itwkyoMlyiymtxBwXaOgHByNoiC04pVlQ0bMxborV0NV3CP
         OrxGaqQM+S+qkKJgO7QzZZNnkLkSVS/A6+i4ASDQNDr3IBuEP9I9ev9XYu2UR1i3NNLW
         59zN822sCbLMeusKpYuXEaqNI/J2aT720RFBjQQhjPhqoFFstLjBotHrLgMa8fXHME+9
         Mt8inv5JddXxa+blczJvMx9e4hRWqo1yOVVXAHNbvaFvmeK03Bq88X+iw2AityCq117m
         qzxQtjt0PU6kbrjszB6TFJ5haVTLGRstuoLPMgb0QBjljFRJBuvk1QCFsJiGYuxpj/5T
         SXlg==
X-Gm-Message-State: AOAM530FbwZjl398gtTMyHY1IeAwVTY0aVTt0gd1T9ppbgQUKPy5qDtz
        gUtoBNLKn4alv4m8tyGYIiPDqZykbY7a+g==
X-Google-Smtp-Source: ABdhPJzjLyrDphzZGw97pOcptA6NpA+iljbIgqNxU7CuI0SsW4LbOTMxXHN1kVGXgDjpbNBZ6QOn0Q==
X-Received: by 2002:a62:d456:0:b029:13c:1611:66c2 with SMTP id u22-20020a62d4560000b029013c161166c2mr4213234pfl.13.1601043620286;
        Fri, 25 Sep 2020 07:20:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t6sm2430962pgj.86.2020.09.25.07.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:20:19 -0700 (PDT)
Subject: Re: [PATCH 0/2] block/dm: add REQ_NOWAIT support for bio-based
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20200923200652.11082-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a406078-7652-f8eb-e29c-bc4851b23dde@kernel.dk>
Date:   Fri, 25 Sep 2020 08:20:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923200652.11082-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/20 2:06 PM, Mike Snitzer wrote:
> Hi,
> 
> I got guilted into this by this Twitter exchange:
> https://twitter.com/axboe/status/1308778488011337728
> 
> Started with this patchset from June and revised it:
> https://patchwork.kernel.org/project/dm-devel/list/?series=297693
> (dropped MD patch while doing so_.
> 
> Tested these changes with this test Jens provided:
> 
> [mikes-test-job]
> filename=/dev/dm-0
> rw=randread
> buffered=1
> ioengine=io_uring
> iodepth=16
> norandommap
> 
> Jens, please feel free to pickup both patches, I don't have any
> conflicting DM changes for 5.10.

Thanks Mike! Applied.

-- 
Jens Axboe

