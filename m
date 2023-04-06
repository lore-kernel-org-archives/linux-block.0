Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D860C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjDFGlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjDFGlj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:41:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE5102
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:41:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r7-20020a17090b050700b002404be7920aso37937277pjz.5
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680763298; x=1683355298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GERY29s89QzJnkVIVTIOusTW1nAFZQnDqjpytuNovwI=;
        b=Ubg/pJsDbXwhP+JemXUyPiI+Lo5qal1j1m6s0AOTmDk8zF99dy4+IsT5l5zKSUd0P2
         EDOzjtoZU2QukruYPK84ulEsNanzVwukFq5J79IT4Fzw651fanjRO9ovqysoCNSUgeGO
         tu7OiKHAzqP8iJhmp7BkdnbN24UW9J9dkIKBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763298; x=1683355298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GERY29s89QzJnkVIVTIOusTW1nAFZQnDqjpytuNovwI=;
        b=61tV2mvetTbPBZukYrFvLdeCY/ojMpDlcKn+c2FwUj87HzlKYQXGuauzhfVqTUymQf
         10SKZA+rRoGyqcCL7/Uec9OJYUo7tVUNgy9upPUMGslm8UDsFSGfhdicsFUtHUfD7ACt
         QO19zE+Nrv9yL2jkhr0m1RCIGS5usfnaOnNqI3gu8J+cshKB4ateIs2trHHTeSATC4ZJ
         FJCPE5FOKnMaSVDPZKAmG57H1YL5P99T1njmG1Kcb8cd0e9/VR6hsoai6yzem/mTCH+v
         QiXRXBj0QEpSPKVI8WucZYRDjImGMrcMBEFnr+gjrtgIC1WYwzk884jO3AwSPsrLMZzr
         eAVg==
X-Gm-Message-State: AAQBX9e27XZX8EvsbdeLNPXiHMOCPJQhGkPVMuuTzG2F3zU6QxTZLAJ8
        deEd6D1E8osJG+KJYgIdmpqUXg==
X-Google-Smtp-Source: AKy350aF4FAXCGp7N0EgMfIIdb2rARf7vk9vMCWERE1Q79Vh8HbStsapbvBnR0iuK5dGZHLNiPt1+w==
X-Received: by 2002:a17:903:294e:b0:19a:a267:f16c with SMTP id li14-20020a170903294e00b0019aa267f16cmr8849922plb.31.1680763297825;
        Wed, 05 Apr 2023 23:41:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id r16-20020a170902be1000b001a0757b1539sm630383pls.36.2023.04.05.23.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:41:37 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:41:34 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <20230406064134.GH10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> Currently nothing waits for the synchronous reads before accessing
> the data.  Switch them to an on-stack bio and submit_bio_wait to
> make sure the I/O has actually completed when the work item has been
> flushed.  This also removes the call to page_endio that would unlock
> a page that has never been locked.
> 
> Drop the partial_io/sync flag, as chaining only makes sense for the
> asynchronous reads of the entire page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
