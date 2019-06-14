Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C629C31E4E
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F332217F9
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560533338;
	bh=4683ClDaIiLcsvAViN+EPI6B6BEsXS+iRBo2ab4wGwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NJPTjFALN2sgLlc317MNoLdSxYUNDIynM4HCPNwZhv9LjAFtgkhdQiOGltKKf4TS8
	 J2dFPNQTHtVgfVOQXzZPYyoVBzJ/Oluxvc385+SARFUmu36uYdc0UiGlIFeWWMYGHL
	 yjU08qIk0LiRBt5sts0vpUWtTMPzBHHYdlgTlCzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNR2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:28:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42290 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfFNR2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 13:28:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so3356134qtk.9;
        Fri, 14 Jun 2019 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dg+yr2j8TD2tOeWN+mTqClvlcOIVqj1KKksx271TJrk=;
        b=ssS6y8VmviRvlot/CRTLA7KZx5V0/s+D+0Hre7ySB8N+URNzknGbw4VlsYvDQltOKt
         BahmS/KfDl8aupY+2UBCfbtStKZZv3IyoX8auZC5qcHSi/h5QAJoSVca2IU2S+P+rlfq
         /RBhJ/oyAXWgsxnLFeXpQb8aCmzIxpRiEwC35j7vrJhacDhru/lTQGZEd0nQxK+Ggm0r
         V844cjDWQtntAqSVghm6uxBwITfGUNMGEaFMpTl1UohUnlIlsTDGO2rUJBoUlxbqHgsY
         lpErarwErjDgQE5K7GBrka9JBWSI945Dk+HceNbUXILc/FfQp16VOyBwqginzLPlybio
         Ifew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dg+yr2j8TD2tOeWN+mTqClvlcOIVqj1KKksx271TJrk=;
        b=SKb2ix7BQdgvwgVov+NNtS/Sub5iHJ/vvP64sdi8fw18N4vGqu5isxcwfBwx6HhAYL
         2VIqw3Zxgk19FHHoHidYRTu1WSplS6zIPHNm4Q2ZaBQ9KRGs6V2qSdvViE4OTPG6QHc0
         vfGFX3c6bhV1mfEY6UnDWEqfrE3Oo9K5u2ZRlRrWp2pvJNmnTXaLY+tLaTp56wQgdGTk
         SUq+Z7+B4rkddDlus0RSaAmzZRp7HlfyG9dKqcZ8TxLP2zBiScbEBw52YlE3jCcVGqoi
         Lx0EXeKrTYKohRqFDIGKCWfB4a5o93kwW+sS6djMpLGTi4F1jCW/O8+3edmGqaeUfocC
         Wy3w==
X-Gm-Message-State: APjAAAWo4r+1rCyL3d7CBZyqOwv65+4qb5yhtavryIwmxBRtPfe7xOtH
        5taQCDU1ryPVX62CKfOjqO9iWddv
X-Google-Smtp-Source: APXvYqy1IPm/izuBobTUYE9Y+ecsxXBEygVaJJtyAYjNbHDQGYsZbcuQzr5UsBw25Zvwbyw/pJDRAA==
X-Received: by 2002:aed:2fa7:: with SMTP id m36mr55097230qtd.344.1560533329984;
        Fri, 14 Jun 2019 10:28:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id t197sm1638944qke.2.2019.06.14.10.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:28:49 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:28:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blkio-controller.txt: Remove references to CFQ
Message-ID: <20190614172847.GH538958@devbig004.ftw2.facebook.com>
References: <20190612061732.GA3711@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612061732.GA3711@suselix>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 12, 2019 at 08:17:32AM +0200, Andreas Herrmann wrote:
> CFQ is gone. No need anymore to document its "proportional weight time
> based division of disk policy".

BFQ might provide a compat interface.  Let's wait a bit.

Thanks.

-- 
tejun
