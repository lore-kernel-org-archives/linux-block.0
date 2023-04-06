Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBFC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDFVLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:11:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31157ECB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:10:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so38644226ple.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+F97FaBMk2cZp08QwOZrRH+YMZiWL+xWSZpsXb06x0=;
        b=ExXn8X9Tf+ltU90r+x0l1TTIwzcauCfO19JXOQvARlCrLUkRcMwUScket82sSiPf9P
         b925uFrnztEm7wVSSi4XMqtWo5WhUXTQDgwGdwMugHXfPp4ADoP6UHxqGtBQ+Fic1GXT
         ljDdrsDQu/434eaRy72qPjaOOQGfmULON3wc/9f5XbaeifmzIaL/H+1IgRgsdrByrGr+
         3XceFZjhsNEhfMagaiVsNAjSZEF3TS6j+cvvjt1fwtndoN9CyIKLxm2dAJVwZza4bqcV
         Wa7ell9GQTo+vsYI16H126Xp0myrgJ8JqArqEjV9simzALdbZh3Rkn3PxwufE8euUy68
         NW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+F97FaBMk2cZp08QwOZrRH+YMZiWL+xWSZpsXb06x0=;
        b=7QBRNWJIp726xw9kLy7KEIipzdFOQuKTw46mRMcOhxqaz1w7SMyJQKyAIhVsA2Eo5q
         eRafq6CStCh28fWD5kQlUsGopQIeQevkvErcSfPp5SsEP+EOWhc/yPULvf5X2MevYLs6
         45lqG9OopVvPJVh0P51Qw7su90u21ZWLnheWwCz6sMcIMwSEZrk5UgDjxDScGVMUIGrg
         V+nvApsfvret+HAnZxA7eTVRHNCcRP/z1p09ifNPVdG8W5xac7/vXmIe7WwMpSexqc0d
         FSkBw7m/wyWVufetTXWJZ56yESRmtVRAumXgZZvMlo3foHeN4LNtowmCijX19w7tx89C
         twWg==
X-Gm-Message-State: AAQBX9dMZRwpXF+ejjrTK3iEf3qx6PuJPkxCpuHIErX3+1R0DLtd0NDf
        +xI8wzhucY/HvA2lw1VgGJc=
X-Google-Smtp-Source: AKy350Zd0eCRZn2RJQvNm6UKwue3vJCJB44iQJaziTCORVfTszE5bvfwj0syARIWSHvOdCOCBj0Cug==
X-Received: by 2002:a05:6a20:1610:b0:da:d4eb:9e07 with SMTP id l16-20020a056a20161000b000dad4eb9e07mr3251559pzj.30.1680815459102;
        Thu, 06 Apr 2023 14:10:59 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id l14-20020a63ea4e000000b004fab4455748sm1527234pgk.75.2023.04.06.14.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:10:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:10:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/16] zram: make zram_bio_discard more self-contained
Message-ID: <ZC81YEC6FG0ytmoS@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:48PM +0200, Christoph Hellwig wrote:
> Derive the index and offset variables inside the function, and complete
> the bio directly in preparation for cleaning up the I/O path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
