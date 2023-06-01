Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147AAC7EE23
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 21:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjFAVtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjFAVtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 17:49:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08869E68
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 14:48:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af7e368bb7so1192275a34.1
        for <linux-block@vger.kernel.org>; Thu, 01 Jun 2023 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685656130; x=1688248130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OcnCx/pmbtKXZ7Da/cfbjcjL+zu9BSzJDqrWeCJgqM=;
        b=iJ+8KgBdIdC0fmpV+4X5AKELAx0FWqlDQWhfpsM+A7pnnV/3/dVBEBpGetyDVC4ugR
         K/OZ5yTSh2/Hk3/Ch55PUxSbD/VlFdQbMoibi19k4RKFT5WhvtOqoEUyc0wbsCeBZPLn
         Z0F/FCkSFr5gt7mnVJP7Xfej7iMQCk1AOqFuxHsYLceDp2DJbAT6BHetM17aJ+MLxOYJ
         UgBs+hheP7eKDjZ8LgeVTIRLxYXUP01QDIeck0U2kF5B40/7hUOKs3H5MIG5ilO2BK9W
         NAlDPf8Y9tnkQDg4ogyDVoFGO9CALjAVW0iifu8WadfLVGgLiIOl0VO1iuluLRKySMYv
         5x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656130; x=1688248130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OcnCx/pmbtKXZ7Da/cfbjcjL+zu9BSzJDqrWeCJgqM=;
        b=keeKaQrxcyjuywXCI2LDyExm01RmxjaZ5pmtrv2508aPtlBTcjpLLzLt44DTvBdEbE
         nMjg92DtoR2vAwaMB/vXdwhzwxs5XVhInn56/As6Q+V1Tr9ZMZAQPu5hq5pCYeqckCNv
         fLniQW6+uA9mwYln5x5vz7lL/hc4UMa0qrYrtnrknLRG1CxEGY/zJB/3oEnbDlHyBM0z
         2dpGUS8d/Zk9GqJ/z/xiSyJiZ1vN6Ofg6smQl2fzywUsM77x0r2Ha8r83cwOSqxvffv6
         vy9KOr4fZaAY3bmGsYwLXIq5hU6K40QTrmN1UK1Ys6q0zQll/aimfdCKLZjdE1Cr4UfW
         AsbQ==
X-Gm-Message-State: AC+VfDyIayIPEBvQ1o+Fq7jd98ypUNSfD1iRviFK0yT7ZCOb9LFcHxIa
        GTqlgDOVSG6YLRmKijKh8IOhQw==
X-Google-Smtp-Source: ACHHUZ415WnubrhQMrYWFgLqY3RXllLba3VYlMrHqu2QPousFmk1Hej1ZnqOsZGP095dGQGVDiGwOA==
X-Received: by 2002:a05:6358:7242:b0:123:3f75:f56a with SMTP id i2-20020a056358724200b001233f75f56amr6105303rwa.0.1685656130299;
        Thu, 01 Jun 2023 14:48:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7848a000000b00627fafe49f9sm5485376pfn.106.2023.06.01.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:48:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4qA3-006f3I-0v;
        Fri, 02 Jun 2023 07:48:47 +1000
Date:   Fri, 2 Jun 2023 07:48:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: introduce bdev holder ops and a file system shutdown method v3
Message-ID: <ZHkSP0qlKQWDcStr@dread.disaster.area>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 01, 2023 at 11:44:43AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes the long standing problem that we never had a good way
> to communicate block device events to the user of the block device.
> 
> It fixes this by introducing a new set of holder ops registered at
> blkdev_get_by_* time for the exclusive holder, and then wire that up
> to a shutdown super operation to report the block device remove to the
> file systems.

Thanks for doing this, Christoph.

For the series:

Acked-by: Dave Chinner <dchinner@redhat.com>

For the XFS patches in the series:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-Dave.
-- 
Dave Chinner
david@fromorbit.com
