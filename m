Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15808C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 04:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65442083B
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 04:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCcsVzG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgHSEZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 00:25:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725275AbgHSEZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 00:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597811138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5xoXHfY7Hx9a4qXAIGO65sRQTEoqN+pm9vJlgSDX9c=;
        b=XCcsVzG0Xr0B2HSJgqC0ZZQbKYF88FjCSB49SYNFXV0nIiUuw7iotPfCB5Kx1NrNSsBLN0
        aasMAh5FKRgYVEkFjd4p+It5adeElrz5jIKRqb4QyMfOPGBir9wWAaLimIYs0YuY8vc2WR
        J6qco5BXcba8ioSlCWUFklS2hUzJxO0=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-is5HRDG_ON-FNBmcgckk-A-1; Wed, 19 Aug 2020 00:25:36 -0400
X-MC-Unique: is5HRDG_ON-FNBmcgckk-A-1
Received: by mail-ua1-f71.google.com with SMTP id b6so5533817uak.8
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 21:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5xoXHfY7Hx9a4qXAIGO65sRQTEoqN+pm9vJlgSDX9c=;
        b=t+wtaie7wRgN+a5Rk/TPWZk+Ww2YQbpVbZml+D8ggCR97NbzL4ZGvX9SNrUVX9PRxR
         C4mqT/eAZmjviT6KyLh3ZL+RX7dag9YW3+ne7XwsT147B5bCjhkfmrnL1iULViYAF6jW
         RufpKtjzhXxbujvQiM/XLT3ZcqE8cj1zqxn1kztaKpmRVnEPbna/f0BsVffGBUQg5gqG
         nwpalZW4FX6hYCs8Tuonj9H0domwJIV9b6GPh+21LXxmKeor+ovv7tTBpc7hRvO4g88G
         h4tJnoj53mEVRfAAR7TWZ4H4u9YLFUkTaQqlXSfBPC0Z9xjvnkjXA4D9IsYXx/WpuRLS
         fMWA==
X-Gm-Message-State: AOAM530M9PFRJ8DWovLaa70nLrO4xCKf9Cs7GLOcU1lRtqA8BQqAyqNr
        /Y54EWaJ7pCRIoRgbnexnGrXx5YGpF6T4H4SQNRxxhpzrQiJTDRwobMCb3b6Db0IbgQQKL/0Uxf
        hU1vPv6X+OdlQ2C1rkH8N0i8XBAfcYtUDH6oRG+I=
X-Received: by 2002:a67:69c3:: with SMTP id e186mr12369953vsc.20.1597811132284;
        Tue, 18 Aug 2020 21:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIFPUsE/VWuXb9s9uNGUuCZINz6bavw3tjyGN+MxKJLIhreNrKa3v7D09cqxb/fkrSKNhD003/B44UPM4+fyI=
X-Received: by 2002:a67:69c3:: with SMTP id e186mr12369946vsc.20.1597811132053;
 Tue, 18 Aug 2020 21:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160327.GA977@redhat.com> <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
 <20200807204015.GA2178@redhat.com> <CAMeeMh_=M3Z7bLPN3_SD+VxNbosZjXgC_H2mZq1eCeZG0kUx1w@mail.gmail.com>
 <CALrw=nHD81X4YCpuk-Pp9_FSFba6LZEVUwo-YkYh1nL9pEbzpA@mail.gmail.com> <CAHk-=wj95eQxPOEMHe8j3zmpZYHbv8kZ0nz8fUUCO6acENTs0w@mail.gmail.com>
In-Reply-To: <CAHk-=wj95eQxPOEMHe8j3zmpZYHbv8kZ0nz8fUUCO6acENTs0w@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Wed, 19 Aug 2020 00:25:20 -0400
Message-ID: <CAMeeMh_4j9EyOB3evyHi536d8kocH3egPdGO_FZj+G5iZzkVrQ@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Your points are good. I don't know a good macrobenchmark at present,
but at least various latency numbers are easy to get out of fio.

I ran a similar set of tests on an Optane 900P with results below.
'clat' is, as fio reports, the completion latency, measured in usec.
'configuration' is [block size], [iodepth], [jobs]; picked to be a
varied selection that obtained excellent throughput from the drive.
Table reports average, and 99th percentile, latency times as well as
throughput. It matches Ignat's report that large block sizes using the
new option can have worse latency and throughput on top-end drives,
although that result doesn't make any sense to me.

Happy to run some more there or elsewhere if there are suggestions.

devicetype    configuration    MB/s    clat mean    clat 99%
------------------------------------------------------------------
nvme base    1m,32,4     2259    59280       67634
crypt default    1m,32,4     2267    59050       182000
crypt no_w_wq    1m,32,4     1758    73954.54    84411
nvme base    64k,1024,1    2273    29500.92    30540
crypt default    64k,1024,1    2167    29518.89    50594
crypt no_w_wq    64k,1024,1    2056    31090.23    31327
nvme base    4k,128,4    2159      924.57    1106
crypt default    4k,128,4    1256     1663.67    3294
crypt no_w_wq    4k,128,4    1703     1165.69    1319

Ignat, how do these numbers match up to what you've been seeing?

-John


On Tue, Aug 18, 2020 at 5:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 18, 2020 at 2:12 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > Additionally if one cares about latency
>
> I think everybody really deep down cares about latency, they just
> don't always know it, and the benchmarks are very seldom about it
> because it's so much harder to measure.
>
> > they will not use HDDs for the workflow and HDDs have much higher IO latency than CPU scheduling.
>
> I think by now we can just say that anybody who uses HDD's don't care
> about performance as a primary issue.
>
> I don't think they are really interesting as a benchmark target - at
> least from the standpoint of what the kernel should optimize for.
>
> People have HDD's for legacy reasons or because they care much more
> about capacity than performance.  Why should _we_ then worry about
> performance that the user doesn't worry about?
>
> I'm not saying we should penalize HDD's, but I don't think they are
> things we should primarily care deeply about any more.
>
>                Linus
>

