Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829DBC77B6C
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjDFWFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbjDFWFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:05:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4972A5DA
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:05:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so2567923pjl.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcK56ualKvMBqInhwsiZ04cpsdahPxeTwkePXplurj4=;
        b=AYLoR2UPUZT8cUKhPwNwpYfAsGh3WXyrFmQlAPqRWPlOwfcFf54RS6cwTGP+yCSL3A
         AxJ4VtYbhkyPbaHxUlfNRQR4dnBbJ5UalWY1dqruLoBtZSYOeJKl6LYDkbR4l8cNMuqG
         EDqwgNMHWFm+Tps2x7o+3KiZjin6VRkvMdubhTyvKR0bAh1dmwO3v3CX9EYYsDYNTybe
         WgC7z0iWshfX93ndAq1UmGSZuWaoK2iTnIk7Lofm9/mrefoU1N8GuEnQVaCVjD8MecQp
         LoLWg68ftZD4lXT1SdI0UThta1yAtj4ERITu0lvJSVxWYIkqzdv/8+UtlX2PdKvsPS7w
         W+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcK56ualKvMBqInhwsiZ04cpsdahPxeTwkePXplurj4=;
        b=RJ4Q1OkEr2dwU3XA+Eug4inutcT1WJS/BJBCYHxJYU1/3LPHI+Xf7qblmFOLcjEqg6
         nicOobpZBCrlbGPIz6N7EaywW3eKm7AwCQwqN1EntPHrX2rWvzZhSejt2tNQI7ctMvfs
         RdAluWjeIuygRTQSbbHzpmRCjrEbiNeJTs/7JT9XNnMPggr0Meo8+Hb+ThYrKqbtNzBK
         dc4Alz6baL9+JAIUEQVSUjPuP8VrOiePQiXITYyi3setWvyCrBx56LgwoNHM0qhobuil
         mAYGWUe1XQmn8m3MCKbrtXr8nmWH/msCJzmVVvVCHemr8VeBuvnZ01TVxkzNk4NY7OL6
         Ak/A==
X-Gm-Message-State: AAQBX9cGpPZwpO6D4VglQ0MkYOtzsl3xo2qvUvyoHKH0xlT4LrXipHrP
        WbtbUnnFBS7WQJEk+9AOplgFrBE31nU=
X-Google-Smtp-Source: AKy350ZlF0tR1sM5xfO5dyoafKyN+vnEtC0l9APi52SZX1acRMH2zJJQv8H8JTFzSt4A1GRfbUfzmg==
X-Received: by 2002:a17:903:64c:b0:1a4:fcc9:ec61 with SMTP id kh12-20020a170903064c00b001a4fcc9ec61mr603107plb.5.1680818725052;
        Thu, 06 Apr 2023 15:05:25 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b0019f1222b9f6sm1818723plb.154.2023.04.06.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:05:24 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 15:05:22 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <ZC9CIsMcwCjYvbXX@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:41:01PM +0200, Christoph Hellwig wrote:
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
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>

So this fixes zram_rw_page + CONFIG_ZRAM_WRITEBACK feature on
ppc some arch where PAGE_SIZE is not 4K.

IIRC, we didn't have any report since the writeback feature was
introduced. Then, we may skip having the fix into stable?
