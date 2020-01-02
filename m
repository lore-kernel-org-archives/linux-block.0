Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92FC2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E553206E6
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AnVeo0Ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgABQr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:47:26 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38878 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgABQr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 11:47:26 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so34519716ilq.5
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 08:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksNONd8klg8kx9Ylm3S3vUOncoKmkMwNPgBPckohfjY=;
        b=AnVeo0UdvFetsO0p75bZBUA2c2sFDMGIBvIqhqo7vM7ws9KxLhPbN1T0hSPABQsNLS
         +U2OLDDzxhuWA07CisSLV92vFEwy4IuIPvAVK3q4EKfgUtOI0AtKhZEatRgR+8kh6BOF
         6vB4fjAnO+49hq3WVdz+okp7M++vdniW2mK6MBh9lthq+R4nlVoqXIfqUDmeuPEcLRgz
         W1jdN3B+VUWPVYnCPRRpoJv3dp1fxza2bC5h2Ze4f39kDXQBk+lsxAFWgn1en/rbo1wT
         adBuhiVWa4o+pZSu0Np28ffOwKmU7lIfEWMK3Z6udRFlwM4R8imlwOkbbmRY+Dz/A4xe
         lODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksNONd8klg8kx9Ylm3S3vUOncoKmkMwNPgBPckohfjY=;
        b=skoCqHLaAYeB0odfMzyr9A8ynRNCybgirmpiz6gAXnbVhQtA0njYdncJTz9M9fjpeS
         ofJBlW2MYrywFxGpp+mvL442KhUWI2/oCfPFb+aakMTjh9Q2IhTnihyi9kSFIpKzNcg9
         1OyvCW4c+MEXj2rJpMk0TaEueZvxxhS32aeLIYHNtwogYzU+uFUa220wW5PmB1hdg3Mi
         n6+StZMTKn9uN5u3hLwBH/eOlgXP/SoTHrR6yNeyv0FvOeoLMdJBkSpsugjYLHK6WK9p
         R6YdGZJLMKYFYQVHyH6AHP1NV/8B74ELGa38V36X3MEVjRzz3/kEj/2ilMMEWN7ojoO7
         hK4A==
X-Gm-Message-State: APjAAAX70gq5PbcBMJChv8jN6PKw2tGwTtTiFids1JaPH2/tGtM2+XQJ
        6HsYKDSIvrtM5gZ2dFqmUmVZaxzEhNxijuFQDkoeFQ==
X-Google-Smtp-Source: APXvYqzusMHJPXXcA9w++ZY4oIL1+zup1efU4ujaaWXOFhD7Wr3Lc+9aHWRf/0EAbLYsR7hqxbzteJqOtJZo8icaFak=
X-Received: by 2002:a92:d2:: with SMTP id 201mr73828551ila.22.1577983645744;
 Thu, 02 Jan 2020 08:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-3-jinpuwang@gmail.com>
 <cc66bb26-68da-8add-6813-a330dc23facd@acm.org> <CAMGffEmdQ2SuP6JTrPYyP70ZYPC+H+GSyL2Lib7mbG4-DUN6Kg@mail.gmail.com>
 <8b070c98-a9fd-3cb1-d619-8836bf38b851@acm.org>
In-Reply-To: <8b070c98-a9fd-3cb1-d619-8836bf38b851@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 17:47:14 +0100
Message-ID: <CAMGffEkkryXNJn18FNgKDUT6MOSm5Zo+1uHC84=_=XcrDLGi-Q@mail.gmail.com>
Subject: Re: [PATCH v6 02/25] rtrs: public interface header to establish RDMA connections
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 5:36 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/2/20 5:35 AM, Jinpu Wang wrote:
> > On Mon, Dec 30, 2019 at 8:25 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >>> +/**
> >>> + * enum rtrs_clt_con_type() type of ib connection to use with a given permit
> >>
> >> What is a "permit"?
> > Does use rtrs_permit sound better?
>
> I think keeping the word "permit" is fine. How about adding a comment
> above rtrs_permit that explains more clearly what the role of that data
> structure is? This is what I found in rtrs-clt.h:
>
> /**
>   * rtrs_permit - permits the memory allocation for future RDMA operation
>   */
> struct rtrs_permit {
>          enum rtrs_clt_con_type con_type;
>          unsigned int cpu_id;
>          unsigned int mem_id;
>          unsigned int mem_off;
> };
>
> Thanks,
>
> Bart.
Ok, will do.
Thanks.
