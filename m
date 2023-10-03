Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF7E776DA
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 01:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbjJCBQg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 21:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjJCBQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 21:16:35 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED3B4
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 18:16:32 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so166302241.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2023 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696295791; x=1696900591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BB3iEMAprkU5w0PW0FKGJedlQe7dl0je9yUM666sRNU=;
        b=2l9DQ2caNkgwt4KBMb3fa0dTqG31I9wCJaeyp2u577goNIthX5eM2eFph50kCnn5je
         jnhgmr4v3cht6a9/ScikbRMElDKAhq21NjSDiICouLyQ6c7cIdWTUR/kN0uDRCNACzod
         9IxjtXbGhHLQrOJ7fccrAMU2xr1Y/piifR0F6kDmBYttJsSx1E93hl/ZA38BUxPQHIwx
         NAjmhGUhJpP9MRe4KTkmJYVFLucA8+0bK8cjdLdnewceGkucZaYy7JplJW2fhsTgTrj9
         zn400jcIxVQH8sR7waSziz7eaQ/O7MScr8g8/+vFPGCzr1WDCJQhVL8e/0OWHWra62Ln
         r6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696295791; x=1696900591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB3iEMAprkU5w0PW0FKGJedlQe7dl0je9yUM666sRNU=;
        b=O16FtpjZa8PRoVUPB/ux08AZgCheTKoTK3BzTtqBIljX15iKE3EmGwW2VmLlBSmf5/
         ymtOgokJl9CSVDHIlte41faqpuyYYpY57Gtbdm311fzlW3bDk9g9ezV+pWWnXk4b6TmS
         tmy72rewnuO1CWwE/4EGuvxRdYmwq4cdK+Mua/JYh9x1qjC7q0f/P7+WS6MhVroZ8r5/
         n43bPMWHbHsH/eucvRxgK3PVfKaZBOUkcmlqW2ZFKdL7Nvo7r+LR+r5LK6f2bOkN5IA8
         RevZmHfQ/b/cIy/DG3rvda2Y8mPJGhgXTBwsPUGUbRzOLF0k/mDUy0WcoxExNXsKyOL0
         WrrQ==
X-Gm-Message-State: AOJu0Yw43H6AD8KnI70vV02axmlWC5Ym5UF6MDVKHQHKiT35SGiBKmn7
        bXa91h+T8zgcivuMtewUcQb+Lg==
X-Google-Smtp-Source: AGHT+IE35X8Sz7vQVe8EdhhrT+0QOjqYkjnQDhJaF4R5rYBMaePmI4d2ce5eF4SjFNEwfyHeQyalJQ==
X-Received: by 2002:a1f:4ac1:0:b0:49a:b737:4dfa with SMTP id x184-20020a1f4ac1000000b0049ab7374dfamr9143255vka.4.1696295791419;
        Mon, 02 Oct 2023 18:16:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm7572762pjb.20.2023.10.02.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:16:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnU1S-008hIN-36;
        Tue, 03 Oct 2023 12:16:26 +1100
Date:   Tue, 3 Oct 2023 12:16:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZRtrap9v9xJrf6nq@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-12-john.g.garry@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> The low-space allocator doesn't honour the alignment requirement, so don't
> attempt to even use it (when we have an alignment requirement).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 30c931b38853..328134c22104 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	/* The allocator doesn't honour args->alignment */
> +	if (args->alignment > 1)
> +		return 0;
> +

How does this happen?

The earlier failing aligned allocations will clear alignment before
we get here....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
