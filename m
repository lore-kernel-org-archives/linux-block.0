Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF8CDB483
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJKVJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJKVJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 17:09:09 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1539E
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 14:08:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d8168d08bebso284860276.0
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 14:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058503; x=1697663303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vFhMHCh6uUl8avUdhvw8MzdlyCHTFfcctmbku9CIHU=;
        b=K+94LPwlgchEmdypq4qbdDuJvRH41HAbwgglfd6Rmtf3m54oug8e+U9EVwn59RrN0S
         XRW2sVW7X/V9oKv5gEtrplZyunvtHgWWbdZRl4JnS588OzCBXtRkMmMd1RCfoE0dZX7r
         rE/Kcu+VcJjRKKhk7TpYwgAkEgCpK5ieT37Ca98GYAOGSI6Kcosbww6X67njd5mC+6ZI
         WZJqXLfmZG/nhvYOtkarw7Vm8u51j/q54hM1bACsSYDCwAGi1dKgZSb9/fkj8Ja1wPeo
         WdQK7ddApt8oDp9PX9XM6VsV53mgKhBPM5+lAu7hnMpbwdKn2V4scdCLqbbuS/Cct2f8
         Hxhw==
X-Gm-Message-State: AOJu0YyVd9ZJAPd8I0h9KXg0N7uyLVXosVweIuP4OU1yK4PosCDZPF5H
        WvgIeEUMGAKsOgk208xmp+tR
X-Google-Smtp-Source: AGHT+IFqA6QGfUWZi1RXIloHbmN4XvJcpqvKaIcnLySXfbMdpQuScK+rDzGXX5QOE6SPYfejs9SWUg==
X-Received: by 2002:a25:aaad:0:b0:d9a:526a:2514 with SMTP id t42-20020a25aaad000000b00d9a526a2514mr6479268ybi.62.1697058502868;
        Wed, 11 Oct 2023 14:08:22 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d7-20020a0cb2c7000000b0064f5d70d072sm6049114qvf.37.2023.10.11.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:08:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:08:21 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Message-ID: <ZScOxR5p0Bhzy2Uk@redhat.com>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
 <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 11 2023 at  4:53P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/11/23 2:50 PM, Mike Snitzer wrote:
> > On Wed, Oct 11 2023 at  4:20P -0400,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> >>> Only call truncate_bdev_range() if the fallocate mode is
> >>> supported. This fixes a bug where data in the pagecache
> >>> could be invalidated if the fallocate() was called on the
> >>> block device with an invalid mode.
> >>
> >> Fix looks fine, but would be nicer if we didn't have to duplicate the
> >> truncate_bdev_range() in each switch clause. Can we check this upfront
> >> instead?
> > 
> > No, if you look at the function (rather than just the patch in
> > isolation) we need to make the call for each case rather than collapse
> > to a single call at the front (that's the reason for this fix, because
> > otherwise the default: error case will invalidate the page cache too).
> 
> Yes that part is clear, but it might look cleaner to check a valid mask
> first rather than have 3 duplicate calls.

OK.
 
> > Just so you're aware, I also had this feedback that shaped the patch a
> > bit back in April:
> > https://listman.redhat.com/archives/dm-devel/2023-April/053986.html
> > 
> >> Also, please wrap commit messages at 72-74 chars.
> > 
> > Not seeing where the header should be wrapped.  You referring to the
> > Fixes: line?  I've never seen those wrapped.
> 
> I'm referring to the commit message itself.

Ah, you'd like lines extended because they are too short.
