Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED845CCA468
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 14:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355336AbiFAOYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355382AbiFAOXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 10:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BC011021CA
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654092819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6cFmagpZS+hji6WNkFHLta2n7SzyuJJ+i8HVMquW3Y=;
        b=Lpi6hFpNgKDrFVp0YZ5Ig5FzvEo04p6dXKVpLPE14sidqMlrepce43LyUdJKJ0xWa34phv
        t9LyjgXyR7KwKhElcV1p28mLkR3kxbIqbhBdhaLxq1Dsn3PNGxXDSXPLdkgtVa0ZUSo4vN
        Ibuw2k35qV4JvwMqJjFNt9mB8/B9Mc0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-4ct46U8DOuGlHyVyNnyuPw-1; Wed, 01 Jun 2022 10:13:37 -0400
X-MC-Unique: 4ct46U8DOuGlHyVyNnyuPw-1
Received: by mail-qk1-f198.google.com with SMTP id b1-20020a05620a118100b006a36dec1b16so1387538qkk.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 07:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6cFmagpZS+hji6WNkFHLta2n7SzyuJJ+i8HVMquW3Y=;
        b=E1PWsKltbtlFeALxBLZs4VwBOylUHyJF2cFikYsXb7Iu8IA3ttgKAtjVQr2yizxKpw
         OLHc8NUSDY/Xu7s2ZaeO+adIG7TZUqvdH+patiqtok5dzG/rWxQeTkBagix8M0Fr349w
         vu59kt8Tv+FLCHQRP6nBch4PZR0zWsFJALw9snVbK6tJbFrQJrke7X7WZpkpQJril8lv
         Hs0O8n3UMw1UpNt5LwcbW7wP4Hu/ptDZtJujibNjwr1qdceyIyPPh17LMLm+8U58ySy4
         lHcF17lwnjcvSjL1PyDFXRXlGUhuCK0wukzKM9ifYCte2bU6OLkU4g39o5PuYijHefEh
         WWLA==
X-Gm-Message-State: AOAM533Od44SN9ns6VluOcCKy10ojrG6gT+bRlAFTGWymQkEhUKFi3ag
        Oj2huUzbo92PBs5oA+zfqkqsyClXb/drtK/YHoppi7IWY1DfgrUGwv6wmUwtOMzIDX9si0zqCIZ
        oBLyHZpJCQDWDi6aAGwLCRg==
X-Received: by 2002:a05:622a:14ca:b0:304:c23f:bf48 with SMTP id u10-20020a05622a14ca00b00304c23fbf48mr44103qtx.250.1654092816392;
        Wed, 01 Jun 2022 07:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTtzbPjDv8fpmrGbyUXl2t6UMgh4OaBJ04+ZVxvQBYai7b7j9eAy3BavkBCtobjtfzDJlUqQ==
X-Received: by 2002:a05:622a:14ca:b0:304:c23f:bf48 with SMTP id u10-20020a05622a14ca00b00304c23fbf48mr44046qtx.250.1654092815837;
        Wed, 01 Jun 2022 07:13:35 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l186-20020a3789c3000000b006a37710ef89sm1404072qkd.115.2022.06.01.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:13:35 -0700 (PDT)
Date:   Wed, 1 Jun 2022 10:13:34 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <Ypd0DnmjvCoWj+1P@redhat.com>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <YpcBgY9MMgumEjTL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcBgY9MMgumEjTL@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01 2022 at  2:04P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, May 31, 2022 at 02:58:00PM -0400, Mike Snitzer wrote:
> > Yes, we need the above to fix the crash.  Does it also make sense to
> > add this?
> 
> Can we just stop treating bio_sets so sloppily and make the callers
> handle their lifetime properly?  No one should have to use
> bioset_initialized (or double free bio_sets).
> 

Please take the time to look at the code and save your judgement until
you do.  That said, I'm not in love with the complexity of how DM
handles bioset initialization.  But both you and Jens keep taking
shots at DM for doing things wrong without actually looking.

DM uses bioset_init_from_src().  Yet you've both assumed double frees
and such (while not entirely wrong your glossing over the detail that
there is intervening reinitialization of DM's biosets between the
bioset_exit()s)

And it really can just be that the block code had a bug where it
didn't clear bs->cache.  Doesn't need to be cause for attacks.

