Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C2C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiCITTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiCITT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 14:19:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7F114FC3
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 11:18:21 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a14so2720516qtx.12
        for <linux-block@vger.kernel.org>; Wed, 09 Mar 2022 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V59HgvRc61glNOVchpXeR9lrKfDnI5JVZxCRrOe4PRw=;
        b=iI4AVJfDe2rTLVR5kFUQ47GJYK0B64dsIEiT0iiLSmBiX/DirSdJUpyJg1gkefekcd
         7rZpVe2BLc878GhnKz7ojbP41jmTM/KchQ5Rr+DmAMxO1Tr5AJXQpbvV7Wu/9KbHXGSW
         1cEi85cR1+tl0b3zerdE35IYi3cjOJhODO4pcmugXZhgtEHUS5Q/mppaZKrA0xq8choB
         sqKnLqxJ5LAVyge5tVouHdQ+SY3H6pMT6vO1LnjN2WAMYUhUJzpTH6AvCDFhw39/i4Ly
         Oo/ERGpImlyfJsA0F269mgwQIeJEqoQqqtFgevrd9EnVCJrtdIzX5C0O/ca/mjG1lql3
         SPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V59HgvRc61glNOVchpXeR9lrKfDnI5JVZxCRrOe4PRw=;
        b=LaJMd7slrwtzE2tKIbi+KAWs+GVIyDpb+bcslycwceDeX7/3hwurqdEA2+X6KcI2UG
         iHZj94a8ifa6exBXTMls2dL4wil1Q8s54YQPnFl6tk4E9d7m9T8yAWzLoT2X3FNzbuvm
         qasq/wcs7/ZpZcryPMHo45FHSCZnhJB8b1mP+6akSikRMmQ6QDBxQd6cbGh66yTQLRw7
         ysbuWFM/W86KvovB13R15hn0jrhLTFJEhUXAvrl7zlXQoFapIzKfMhTaQ/MiprrQKZFa
         LcoRPHWOAV+vG6YaAEQx1Syhy/jVJHIGSKAOt9WT5ctkCezUXltLyVpjh7OpSQqTUO2T
         TGBw==
X-Gm-Message-State: AOAM531z80KVlLHhfm61TRWKVLi99qTDOeA+/6kDlLSocqGXUjOvmLib
        IIrchb3AxwHM8yEzBLo3+wUIxg==
X-Google-Smtp-Source: ABdhPJwojhJ2jO+Hc+klRruTOm98kS9CL/R0u4elp0+vS8geZsyq/412gxGCq0Y/QKSQEu64XQ2pZA==
X-Received: by 2002:ac8:7dc6:0:b0:2de:708:3e3a with SMTP id c6-20020ac87dc6000000b002de07083e3amr1026671qte.459.1646853500165;
        Wed, 09 Mar 2022 11:18:20 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm876005qki.28.2022.03.09.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:18:19 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:18:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <Yij9eygSYy5MSIA0@cmpxchg.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 09, 2022 at 09:43:24AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> psi tracks the time spent submitting the IO of refaulting pages[1].
> But after we tracks refault stalls from swap_readpage[2][3], there
> is no need to do so anymore. Since swap_readpage already includes
> IO submitting time.
> 
> [1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
> [2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
> [3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

It's still needed by file cache refaults!

NAK
