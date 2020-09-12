Return-Path: <SRS0=0HSq=CV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0041C43461
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 06:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9321734
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599891470;
	bh=uuS+Z49skG3lx+esbagnWe105drLTNKLOy8Ma2dzjMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QimKOC4Dc31FOUN4cX5K+BNqRfB3ir8Hqc8++gi6T/Tv6sw6SmlX7tWtaBeV98ME/
	 pmrRTrQwDt303K/TtSPVnxwOi1NwA/+TdJxbwOZ/xbi/qRO8YqifbpYLuD5R/3/kV6
	 BskJlXAOHscUWiyiJB4MFA6ihFv12dg+C0yE0gbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgILGRm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgILGRl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Sep 2020 02:17:41 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE2521D40;
        Sat, 12 Sep 2020 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599891461;
        bh=uuS+Z49skG3lx+esbagnWe105drLTNKLOy8Ma2dzjMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZyDz7oUXmzrS2wbdCR1OjKcH7321NGa7jyxMDH4h/o9UFLTl0K1PPE+nTnMPNcaO
         pFhcF7zZNdVWBScpmda30k1PDw7hv27W+vep/NtOAu79ccmU1uTlmfOyQ7QIgiL3rv
         v+vZsGweGVfhdRtBDeOgxgmo0SHmfbkdHi6VqF9g=
Received: by mail-lf1-f47.google.com with SMTP id y17so8017325lfa.8;
        Fri, 11 Sep 2020 23:17:41 -0700 (PDT)
X-Gm-Message-State: AOAM533Ql6v51uDU3YdHitioOgdo8CtgbcSf653MiA+qLElLSOWVB32L
        Qfcwc/T12dP8aRHwLW/uPqUyTWRNSccGFwPSsj8=
X-Google-Smtp-Source: ABdhPJxOiiANvrJ6fr7d6kLKZBhdGAMugfK2BYTTNlwkd2Y5yYk1Y7sPwQKbOfKHnZSoz9jAWmxnXjr56qyYcRtmpeU=
X-Received: by 2002:a19:cc09:: with SMTP id c9mr1179259lfg.482.1599891459438;
 Fri, 11 Sep 2020 23:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910144833.742260-1-hch@lst.de> <20200910144833.742260-6-hch@lst.de>
In-Reply-To: <20200910144833.742260-6-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 11 Sep 2020 23:17:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW56nRgq_hAs4zdg+qabVsbyYkmZk2+4+4ykzbg0Aa=W2g@mail.gmail.com>
Message-ID: <CAPhsuW56nRgq_hAs4zdg+qabVsbyYkmZk2+4+4ykzbg0Aa=W2g@mail.gmail.com>
Subject: Re: [PATCH 05/12] md: update the optimal I/O size on reshape
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 10, 2020 at 7:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The raid5 and raid10 drivers currently update the read-ahead size,
> but not the optimal I/O size on reshape.  To prepare for deriving the
> read-ahead size from the optimal I/O size make sure it is updated
> as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>
