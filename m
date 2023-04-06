Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DBAC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbjDFVMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjDFVMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:12:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D27ECB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:12:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so44085445pjb.4
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlFUgMtjkCAvVDvIImCh0BJ7emo04tZEDGabB7XakPQ=;
        b=L6r+c7Smg+P9SC6x+HcYBq4HkAbdGrNNApNanO75IIfPyNcwG3LUuZtNVU9lohBhOO
         BkWNTMm/YlyENxj42GXH9WNbdaMjYe2Ycd2GvqBXGedLaMQV9HSulIZDCeRm2WzmBRWj
         jSqDxRaoUCn+f83YsH1JV4ObljbqxXCB1F9VMsG9vWMU+/ztzQAuBxd5VZLUW6/keZnb
         hBf5VZv7AVEfztSGdQ+DLYWW4FV3Rep4Sh6nKrwIGRmYqDFq9NlxN107VnY/lynpiicl
         CNIWPWrH3SnawNhSElkV4m3qQjU5/GTmJAv3o0Edpt1mF7m+Mh0yhPIwJokdXryVYVMy
         //7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlFUgMtjkCAvVDvIImCh0BJ7emo04tZEDGabB7XakPQ=;
        b=xJ/dugH7fL/7u49P/smFcarCqBPM6teZgh+9ZsMeyOaGJaA5dSAvDYznFhtmy0tkYV
         Zpk5+H14IgL2dcudp07b4zlOyVBYPJLI9gXiQlxeQTF1DsjlJ7IncSLS6+i44NGqhQ56
         psFPTaXTrFCN3mlK6xnR0VliGA3xwPB8tCq8+ZzvAaTl5zOR/Vn+vAyWbyfhZPgpY/gU
         v++ZrGW9+FnkWFyyD4NzvNLzwGd4BQkGGHrGixWt0358GNpWMAPQPswqOWi+NXoH2AGI
         O73m+I8DsimUV3Cg8ZrcOAmntwR/tdtDQbFE7s9HIVJbZPuwRZl4/AE+Ur8n6XnemQH+
         NY2w==
X-Gm-Message-State: AAQBX9dIRGJ544kp6D96duwPKireDe3h1MS83Vr18C+ApkW9+FYVp6Ee
        H3UtxVSxia6kCgWuQdX4N0k=
X-Google-Smtp-Source: AKy350bls0MFEbu33jFi6bOn6HR7YtgCWeS6RH5oHZDNsXZILeSo0NGHHDVMONIrJJ+UZDu6q1e8Cg==
X-Received: by 2002:a17:902:f683:b0:1a5:668:2952 with SMTP id l3-20020a170902f68300b001a506682952mr785320plg.14.1680815534811;
        Thu, 06 Apr 2023 14:12:14 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id ik23-20020a170902ab1700b001a281063ab4sm1775536plb.233.2023.04.06.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:12:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:12:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/16] zram: simplify bvec iteration in
 __zram_make_request
Message-ID: <ZC81rMVVz8mnkczw@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:49PM +0200, Christoph Hellwig wrote:
> bio_for_each_segment synthetize bvecs that never cross page boundaries,
> so don't duplicate that work in an inner loop.

Oh, never know it.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
