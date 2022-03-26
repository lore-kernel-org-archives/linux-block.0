Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A112BC433F5
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiCZLzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiCZLzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 07:55:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FE280C07
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 04:53:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so10724420plg.5
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIBykqeJdfJj3Rpq1bIu3t2+kXWV6iy9ohF8kA7fKSk=;
        b=kGU4TO4d8G4tS+yBJxGpTr1U51jNCV3ic2PJ2FlGHvkE5C1IoFzR8hRS0MCfsEW2U7
         7hcj6Vj2cG9RlHMgBjfoB5Lm119lWvLWZyrnkZrv7iRq6J+Agbtne658ckk+bPGnMdh1
         IDX4xzzW8kaC+JO/o8ECjyztOD7fJTlEUlH3FmOcc7Y8Liv55F4uVDE0lvDDqea/SYTO
         n4Qf873Wh+kbDODZue17l/x7DCfsDVQVZmsTaJgcPdd2cf6I3epHzYfao+eoTDhGu0ka
         e1vAC2lv40oyosUqkFNYTGmaMgAPwAWHjj7Jz96lvMoxAjDkDZu9iyYSbv4xQ+0E+MD6
         ImUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIBykqeJdfJj3Rpq1bIu3t2+kXWV6iy9ohF8kA7fKSk=;
        b=H0uVVEZc8QTayAfwQhnzuleVi9/YgcLjsAjSvitzfS5W/NjZfg9YwMUtz0A1tHjvhK
         GE1JESblB/DP9fbwBrL6aMWBgrfA3cBop1O1VanI4OBKJOT/dSDoxR+WuKE+Pm0r4bVW
         qd+stnzysZONNrHNNxj4CkxjfJQx7br+X3d+aVsS2sN6z07fTHFiVwSaz62rClA6Pe3m
         A1+S4PQXQQw2fTVXwEOyUi9qgMJjOshql+LX2srBBRTRobDUErRdGRd4jV41kURftefD
         vJ26M2b6jtPNFjGu+F+2oCgTupJvNfJBum82jQ3RQiWjQyScxuxPC6K9CfVbtdxj3vXk
         o9dA==
X-Gm-Message-State: AOAM530WXXayvMjwQMU/BWp+MQQI2KR9JM6u4Fylk1EdDo+Pf0HnN6hT
        GM5yRto1tt//tKR6JQ2xra8=
X-Google-Smtp-Source: ABdhPJxBUqtNhN3QfdVPaCp9CbnUAa6Bn3HsmlRKLRmqcIOJvx5dM0lVqPbx/hTavnp1V4gr5XgdDA==
X-Received: by 2002:a17:902:b709:b0:151:49e7:d4e1 with SMTP id d9-20020a170902b70900b0015149e7d4e1mr16762163pls.144.1648295608735;
        Sat, 26 Mar 2022 04:53:28 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm9729883pfu.150.2022.03.26.04.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 04:53:27 -0700 (PDT)
Date:   Sat, 26 Mar 2022 20:53:21 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <Yj7+sasrVSWnVcAf@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <50bfac4d-5111-6724-4fca-4499627b909c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bfac4d-5111-6724-4fca-4499627b909c@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 10:34:04AM -0700, Dongli Zhang wrote:
> Hi Suwan,
> 
> The NVMe prints something like below by nvme_setup_io_queues() to confirm
> if the configuration takes effect.
> 
> "[ 0.620458] nvme nvme0: 4/0/0 default/read/poll queues".
> 
> How about to print in virtio-blk as well?

Hi Dongli,

Thansk for your feedback. It is good idea.
I will add it in next version.

Regards,
Suwan Kim
