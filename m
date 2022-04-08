Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ABDC433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiDHPEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiDHPEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 11:04:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09B2359F4
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 08:02:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso252410pjj.1
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dw6sluGZPNAiiEgCFWBZyzySwlZyM82T1lEG/zKHTFQ=;
        b=CsjFd/mRmdhrJXMfXIBZxWQ+CQyEK279nunIU2odsRosVfg+S45jNz9qb4lDRz6a/l
         g8rb5V2DzqDIMOPoFwS6D2xRt33ASiGV4CHtJx2SN95qau1/DQvUAnR6hj+YI2yb+Egr
         D7Dczf4mBrXWZwkKKtWSf5hUK1eOr/lo4NkD+If6EQw0nJ/gts0JS5Qpm5yBuk3uSFoa
         u+tAdua+l67RGq/TQKrGJM/d4IXPZxmWc64w+Ku4otl5vLXlQgZYdllPj4qqdunwInvU
         JMFb03HtZFblSzZaP4Pifp01lRJ1yNQd670a8GQ2t4Nv20vtTvfe+zTxZK2ztjMQ029z
         93CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dw6sluGZPNAiiEgCFWBZyzySwlZyM82T1lEG/zKHTFQ=;
        b=c3kAlvFEvIeo4uvPTVLkmgBa/N/Dlj56ifEYc8OxxwXPTrAce6FBL/gxxsneJwF+1F
         7TCfrhlpkvsoOGbWleTTx3gu8kginIy8QHjUEf10o+drgOI3X+9oGc/MX7ocxtQiu2SG
         fkM3s3oy1nPELFIgWnhr4IXjSare93DDcHGpaFsTqNMMBvby4xL1T4BS3kAc+G7DdGmr
         VpvDWgqRx/GENI9dz3DxE/Hk9iBn75NL112pliuiMSTTLBf16I0Nnd6x02lAe+VCfZaG
         79so/S3etf7EOxxZokihbNokvlcI08/hs3CD2FSxq5zO0Z0YXj9IJsfU7hrEKqorcofh
         9T8w==
X-Gm-Message-State: AOAM532kl0deJ8FYDVNTgIhTIPwieHcVYaCTmD8RQFEcsfN14M956IXM
        qg8iVV9SCoXBgMceeZALYC4=
X-Google-Smtp-Source: ABdhPJxgxsY8mgixTrjkYtArhXGsz7n8CcYtvAacpHZJYUbSur4JqSiGCQoobE9a8pbLiJiKce5l8Q==
X-Received: by 2002:a17:90a:550a:b0:1cb:5799:30b4 with SMTP id b10-20020a17090a550a00b001cb579930b4mr1600266pji.9.1649430151971;
        Fri, 08 Apr 2022 08:02:31 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm12268263pjk.12.2022.04.08.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:02:31 -0700 (PDT)
Date:   Sat, 9 Apr 2022 00:02:24 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "elliott@hpe.com" <elliott@hpe.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Message-ID: <YlBOgKV/y/9bCWD4@localhost.localdomain>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
 <3b36802a-94ca-776b-bc15-51f60fbbcf51@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b36802a-94ca-776b-bc15-51f60fbbcf51@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 07, 2022 at 07:36:00PM +0000, Chaitanya Kulkarni wrote:
> On 4/6/22 08:32, Suwan Kim wrote:
> > This patch serise adds support for polling I/O and mq_ops->queue_rqs()
> > to virtio-blk driver.
> > 
> 
> Thanks for doing this work, can you please add a blktests [1]
> for this so it will get tested by different ppl under different
> environment by various backend for each release ?
> 
> Please CC me and Omar for blktests I'll be happy to review.
> 
> -ck
> 
> [1] https://github.com/osandov/blktests.git
> 
> 

Hi Chaitanya,

Sure. I will do.
Do I need to add a new test script about vdN device IO polling
to blktests/tests/block/?

Regards,
Suwan Kim
