Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B2C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 20:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiFZUPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFZUPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 16:15:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA9277
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 13:15:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 89so12306769qvc.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SC11fPbmGhwe/HFGa6xIWCfkHncSeLbd/U+Eo/PJLJ0=;
        b=J0NkeSfwR2HL+f+29tuz6PHIWj/pjf0ZGjL6T5hgO62c+fGGJVte1oNMFL3wDoZhQv
         XLm3kcvUErdJ3XQrtze6kRSGNdOJ/+hQSaXaT8jzL0op6BSdkVhgGiv3Fvz87whU9xsG
         zfVpe3qmongU9qTurbEv2U/ypxeTbPcScWyUans6wAl95sc8kL/9zN//U+gXXKe7wWsz
         bkjd5U5kjN3+K6xOqqZsB2eY1zDKPtXQnqF422PZ8bdquxy3K5RZAP3n1f/M1b7jVuSk
         fkPEzzTFjyahP+/rGsZUeinbdD2S15GSHiXZrrcFYalElJo8+7qzAn04NpbXRiGeBy/h
         dtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SC11fPbmGhwe/HFGa6xIWCfkHncSeLbd/U+Eo/PJLJ0=;
        b=PL+ZBekJmdg3RnvOZlTYU4Shr0fBTb8gQmE5lN4Yd2qoLtsaA2bNMlK1jXHqDpE4w7
         VUeCj5vHc6JEH2Fn4eyn8FAwoOBhAvi9lu4lQwC6Xdg2azU9baaTrEfZlI7lQ0tgu07s
         SIsYKs+mVJnCPsvwnkkx6X1BXm121Gr5YXaD+W7s8Q13sUnFFB3D5+vMCXUACeEW/zUq
         P3bm5/Vb9iIu8RcKHFQAGhN3ogRG5rZ6zvQ4cY8Q+CJFFd/yXpoKjcLw6mJ6P0SSNB9R
         +KUReH5c9vxNSMozrFfzxvNrVD8LnC2BsiWAePrLYA6Qvtd8jVcYF3lQC50t5ViKQHse
         awQA==
X-Gm-Message-State: AJIora+WYs/losTs3rmdAUxfwz3HfMk3OJallv6lPsPvsMi3fkwQRyNT
        b3MiMwrOP5p1DLTgYQwlvA==
X-Google-Smtp-Source: AGRyM1syJ1I0Gigy4oxMoBw1RXUSvYhgAG9+m4iR0XvFRzxhbc1EDxQC2xSD+V/WLQtZJI22NPGrIg==
X-Received: by 2002:a0c:a98a:0:b0:470:5200:8c61 with SMTP id a10-20020a0ca98a000000b0047052008c61mr6480960qvb.122.1656274499872;
        Sun, 26 Jun 2022 13:14:59 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g84-20020a379d57000000b0069c72b41b59sm7060197qke.2.2022.06.26.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:14:59 -0700 (PDT)
Date:   Sun, 26 Jun 2022 16:14:58 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624141255.2461148-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
> Commit 7759eb23fd98 ("block: remove bio_rewind_iter()") removes
> the similar API because the following reasons:
> 
>     ```
>     It is pointed that bio_rewind_iter() is one very bad API[1]:
> 
>     1) bio size may not be restored after rewinding
> 
>     2) it causes some bogus change, such as 5151842b9d8732 (block: reset
>     bi_iter.bi_done after splitting bio)
> 
>     3) rewinding really makes things complicated wrt. bio splitting
> 
>     4) unnecessary updating of .bi_done in fast path
> 
>     [1] https://marc.info/?t=153549924200005&r=1&w=2
> 
>     So this patch takes Kent's suggestion to restore one bio into its original
>     state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
>     given now bio_rewind_iter() is only used by bio integrity code.
>     ```
> 
> However, it isn't easy to restore bio by saving 32 bytes bio->bi_iter, and saving
> it only can't restore crypto and integrity info.
> 
> Add bio_rewind() back for some use cases which may not be same with
> previous generic case:
> 
> 1) most of bio has fixed end sector since bio split is done from front of the bio,
> if driver just records how many sectors between current bio's start sector and
> the bio's end sector, the original position can be restored
> 
> 2) if one bio's end sector won't change, usually bio_trim() isn't called, user can
> restore original position by storing sectors from current ->bi_iter.bi_sector to
> bio's end sector; together by saving bio size, 8 bytes can restore to
> original bio.
> 
> 3) dm's requeue use case: when BLK_STS_DM_REQUEUE happens, dm core needs to
> restore to the original bio which represents current dm io to be requeued.
> By storing sectors to the bio's end sector and dm io's size,
> bio_rewind() can restore such original bio, then dm core code needn't to
> allocate one bio beforehand just for handling BLK_STS_DM_REQUEUE which
> is actually one unusual event.
> 
> 4) Not like original rewind API, this one needn't to add .bi_done, and no any
> effect on fast path

It seems like perhaps the real issue here is that we need a real bio_iter,
separate from bvec_iter, that also encapsulates iterating over integrity &
fscrypt. 
