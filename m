Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDECC433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BE720BED
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npEe+ZBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgIARIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbgIAPSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 11:18:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE0C061244;
        Tue,  1 Sep 2020 08:18:11 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so669184qvk.11;
        Tue, 01 Sep 2020 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSPbN6+pEjMV+xpddTd26AaYfZpdzQy4X//1J45BFMU=;
        b=npEe+ZBaVYxoJTHXvduFysmSnA58RM43MK3pS41Uk6E/DWF3vBm4jFOhg00AnXeBP5
         nQE1ZcNhOtddARcVjxxadI7lEo2B5dFKHSRtc1kbp/Xtq2odocq1KkHIYNlAV2ySkn8M
         v70gTkTkr0cuTzEAfL0FUFsjwk9fr/jfwqmZ0bEmij2yw3LgsWg7PHDIhBYiEUOTH3au
         qgITsMP99r8yj06RFuyD6FQYXzW8ptGltM0nfpM3DutAFa0idghXLxiczQ2ippyNbiq3
         nz35EdXhRgMRgLawqrRtcu3LJddqdgseM4a3K797J2QOWDurbZz1dekWMx1Pjc79gcM2
         0Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSPbN6+pEjMV+xpddTd26AaYfZpdzQy4X//1J45BFMU=;
        b=PirHXop3YFxulzsY6rrcH9B0NqlsWJmopxxrRvHoeRYOJJwGprFtB727dJpwkkh487
         zvVk5lFTgzjxTlBISKIyTvBAaz4RmkRJdtq6Az7FWToQxzUii5jMbnsTOrI2bTrV0+t3
         OKJ+WauHB35DhNWJjrjiP58bmPVRp9pzgD7UIG7sg1P4EcGrrv2ePneaZ8LYz0EuZmW+
         ExQHVcxJRD2OiZM1MV3CsydDY4GjRa36fxIpee4IO1wldpErMNSNbHGwbP1G/RBypYkX
         g5atIEZPsBAYZKm+2pDfARGhdwqN7hq5r7BxkscsNn1+XNrp9URGDidPRxCuILfvNIuK
         94NQ==
X-Gm-Message-State: AOAM533nmfmwPdwo9Zb641VrkjQKIv3EbLG8XWfbd6GOwPE/V19Wp/k5
        UVtAR6JqRfQTjXq/Xwa81FreeDIQ3ZYOCFc9
X-Google-Smtp-Source: ABdhPJyjYpa9sfomJf/xnDSFBjbkkKGYaWmfU2d3xG5XUFfpCWVu1HLs7HpX/ChqViWX9NzuP8NFLA==
X-Received: by 2002:a0c:e783:: with SMTP id x3mr2556298qvn.114.1598973490393;
        Tue, 01 Sep 2020 08:18:10 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:dd5a:a6db:5e16:1fed])
        by smtp.gmail.com with ESMTPSA id n203sm1736574qke.66.2020.09.01.08.18.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 08:18:10 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:18:07 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 4/4] bpf: add BPF_PROG_TYPE_LSM to bpftool name array
Message-ID: <20200901151807.GA5599@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-5-leah.rumancik@gmail.com>
 <20200812181705.hadjvarvjxwj36ai@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812181705.hadjvarvjxwj36ai@distanz.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 08:17:05PM +0200, Tobias Klauser wrote:
> On 2020-08-12 at 18:33:05 +0200, Leah Rumancik <leah.rumancik@gmail.com> wrote:
> > Update prog_type_name[] to include missing entry for BPF_PROG_TYPE_LSM
> 
> FWIW, this was already fixed in bpf-next by commit 9a97c9d2af5c ("tools,
> bpftool: Add LSM type to array of prog names"), the definition of
> prog_type_name also moved to tools/bpf/bpftool/prog.c from
> tools/bpf/bpftool/main.h

I'll remove this patch and update the location of the change to
prog_type_name in the first patch.

Thanks,
Leah
