Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4217DC61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 00:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjBCAYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjBCAYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 19:24:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66981B2B;
        Thu,  2 Feb 2023 16:24:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso7296024pjj.1;
        Thu, 02 Feb 2023 16:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThsZNAEjunCzoIbygWl1s3g5YVj7pWLNnV0t+0ju9b8=;
        b=qPtS9CsNKmok6OXROA5LDwsstn4DlJpkPIsLk1XbNP3D/lN7r0OApaNOqQmVpYhCUu
         rlnX47Q78n1iRUBBQSGpsNdcU2B/nSfzjwhQOMXUwLUajLVSbxARXthAL1LMm5PtEJmH
         44ClLdXTf6jusIHGIsi7bYWvT6iO03WMuymSMzVFrokhWggaqSts7ITooIOoUHTu9zrP
         b0GH1qrVP5oiZmGIDM5CZ6Iboh6Xth6RzHrr4SiaC1s0LgyfTdA6JZlA0pKc2i3VV5hU
         64uPssxmCrjxd3yGaiZvgfwM0knJlze0TAYjKeHd3QMVsGbRfauAAOsQvcRye4amPk6e
         CecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThsZNAEjunCzoIbygWl1s3g5YVj7pWLNnV0t+0ju9b8=;
        b=mBvsVj7Doe5DCtqCMB68Bid1HO5eT06ClteB3w5QUkY5fG0Q/Ky+zqVDj9xyA6UYFf
         lOhmf/gLlqikawgd3iX9xO/ekqCWwRIMENb2c9rNpSSY5uek0X11So3mj092tWsK9jec
         zXMOlfMyBMSExWt85XJ6VePO7YPV0T1PMAxIYy3exSagvQRX0jGhPNHxnUqSKGCtxrx9
         7yQCe9d2FyavFgrdQsXt/1pD1ivixHdhWdsTzgX6PLkq29XGOGLTyCXpUC5SiAQWLZzv
         SWfU/wWrPbCjJNCe4SzJD6WgUDbKtDkvsrqXLOzqzf6QymWAwTeBLhuH3FhUQ2fUPbMT
         /tRg==
X-Gm-Message-State: AO0yUKWGpHyXiTBgaTo/qx5HOatHBA5zGFndcmi9Q8d4uYPmJOElkhvp
        1hTSDLjjAjQtMbYxgetVuBQ=
X-Google-Smtp-Source: AK7set+tOYAXIUUuz7ys/HOhE3rxaErG41wQbG6a5OrOigJTcXy3y0gnxdL5oNnb8/ZP/XZLLOqVbg==
X-Received: by 2002:a17:902:cecb:b0:195:f3d5:bead with SMTP id d11-20020a170902cecb00b00195f3d5beadmr9934458plg.36.1675383888052;
        Thu, 02 Feb 2023 16:24:48 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id v14-20020a170902e8ce00b001949c680b52sm248230plg.193.2023.02.02.16.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:24:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:24:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 19/19] blk-cgroup: move the cgroup information to struct
 gendisk
Message-ID: <Y9xUTlC0MaDzCCTj@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-20-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:23PM +0100, Christoph Hellwig wrote:
> cgroup information only makes sense on a live gendisk that allows
> file system I/O (which includes the raw block device).  So move over
> the cgroup related members.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

For 08 - 19:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
