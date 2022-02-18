Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53DC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 15:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiBRPVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 10:21:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiBRPVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 10:21:23 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C518CC46
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 07:21:02 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c7so6084955qka.7
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFva2jphudu5nNQOtFetMtWWxY8U+kSkf6ymT6sVouY=;
        b=6cqBgFFBOvizHU93Po+Zmf3Phx4g1oVC0Ve/zIfQpn7TkYyMnMeR1iI8Mrx1PpICf5
         Z5UAmE86htGVfvf1UDCIY/gPeDwGJ0+h9FXY1kU/AAR2Ampat4gzDgpi4r3f4XZd4ZoJ
         LMgccAH3CuN9komOtrImQ3Yg/wGl/H+D1cr3lgu089ljtPtZnIntdsk7MuAyu19rn9E+
         AVz3ae3PKLAZi1oWAXIqAO/2pVAymh7igvT2Ai0dWGeuibDwrJIRa1IlOrGy73y1b8iC
         /IOIDsgS7LoRfkVysGHJZgK2O5fBJCqRe0w3cmOqXc5d8Z1CEXkD7DgDm1wGZ1cdAes0
         oVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFva2jphudu5nNQOtFetMtWWxY8U+kSkf6ymT6sVouY=;
        b=DaoIwnOrrNIg1XjTc/vhqBmmKu1nESwMFvA1AjqDxv5cDNZg+lcHigQXmfvOGGU/4x
         sBk3wsXjrA3w5L1VJF8STyEql4SKqtKT8PzNf8owmyVLN3UtNTE+LLJDI+XsDsWLXYut
         RLaDTw8QamxjrGSuNcx8y3EIk+c3GYzmCoeBe7fV75gnA2Sf7ffKohzAfDchUky/Cdy6
         9otrOeW7Er8bg6CgmjtqSnlynuYCrrN2XWfHaharJtqUN/QJb4RSqhYwuwK70QdYZAKZ
         BW+0iOKo4pwjsd6PuUlHvxV8TTT4mKe3n0uSwZcGY/1zzNKeXKmbX22I+393+9N5UJCq
         BPeQ==
X-Gm-Message-State: AOAM532djBfNa3bEPGaekOJ4xsIY9sggDVkyn+uGaJB1Aa7ffyRDfDBQ
        /4VGT9ak48IVHMjqme+0Xf0JEA==
X-Google-Smtp-Source: ABdhPJyGNUkWSTWwJo7nhA780UyQwUX+LwX0Q7tqbWJWKYGoikX/fIia26lFPmjFrxCM1vj2GlgaqA==
X-Received: by 2002:a37:c442:0:b0:60d:da8a:1c6 with SMTP id h2-20020a37c442000000b0060dda8a01c6mr4606180qkm.162.1645197661178;
        Fri, 18 Feb 2022 07:21:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o5sm6282400qtp.48.2022.02.18.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:21:00 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:20:59 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <Yg+5Wytvc2eG8uLD@localhost.localdomain>
References: <20211227091241.103-1-xieyongji@bytedance.com>
 <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain>
 <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain>
 <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
 <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
 <CACycT3thVwb466u2JR-oDRHLY5j_uxAx5uXXGmaoCZL5vs__mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3thVwb466u2JR-oDRHLY5j_uxAx5uXXGmaoCZL5vs__mQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 09:17:37PM +0800, Yongji Xie wrote:
> Ping again.
> 
> Hi Josef, could you take a look?

Sorry Yongji this got lost.  Again in the reconnect case we're still setting up
a long running thread, so it's not like it'll happen during a normal reclaim
path thing, it'll be acted upon by userspace.  Thanks,

Josef
