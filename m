Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D35C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A738206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 20:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot5G5Gxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHRUkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:40:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgHRUkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 16:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597783206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jq7TaraFgdD6GIFln8P44fNHpj56x8PqwtIkHGoyWF8=;
        b=Ot5G5GxlXv7/YNaw5A8BgeCfdKeQpHpI75VEKT7A2lRNcCeFrdITyMLLUBvuE/b90rR4Pm
        WrBt5uqKhAZP4iQKbJP0or8A6TsJRGCJKp1dYHZtefoWeHP6SPkU3r9i7I3byTNyYU+w8S
        Xfq4EGTbC/uzPpNgeCV1p7MgusxsCYE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-mX1AlG8wN927FDWo4KsIhw-1; Tue, 18 Aug 2020 16:40:05 -0400
X-MC-Unique: mX1AlG8wN927FDWo4KsIhw-1
Received: by mail-ua1-f71.google.com with SMTP id k5so5047549ual.20
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 13:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jq7TaraFgdD6GIFln8P44fNHpj56x8PqwtIkHGoyWF8=;
        b=Wkk5PNTx7PXSaSrBpH6czg4Xmlj6T/OwbjOxBhSTRPXZp7wu3KpeW+Jj/f8zs2OLwk
         l2g18TRE0XTZuKX5OpYgKQDIj7WPwCrxefjvZTfmRTRFmm70UV3MBW1p5+oA7rn+rQSq
         qHtKdBalZC3vOXCRRYll9hlM7wQQ+/6XvDB2znK5DsvjgNMumOJVnkJ8Wd3KFpWhNKiN
         C25ndNdbURQOrBCdXhepsUpVcMNieB+/VGHESkI4d62kpXzKtX7PvPZREFRo0iGzOXUA
         hsbNNyVIybDbWEajLj4z5XJ+ucWl89cXBbhiRiYpTxVG84+QiCpHHIyj1ZeLM5q+Q/B1
         pQ/A==
X-Gm-Message-State: AOAM530PCmddMLPLHy8ZAZHwJgZNkUzE9go9XfcIgtzgXVkrOte9ACRw
        srKhydUOzjnvfeVGMirRKhXtEskactdnGQJC6qd0HyZ2UQCy7w5rsaOc0adWxtUpS2Gz+jWItSY
        tePNJ2IfIYEP+SHH7C+2jScQihOlIbyklRg8/gtc=
X-Received: by 2002:ab0:6907:: with SMTP id b7mr11833393uas.127.1597783203989;
        Tue, 18 Aug 2020 13:40:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO2C7FcRgLbOrfnCyFGrJ2KcHQLrlvHiTGOCTqJvvy/bHLksOICglYQ+74GqrFOTKDQ3niWHTELNvazWK3X8M=
X-Received: by 2002:ab0:6907:: with SMTP id b7mr11833377uas.127.1597783203699;
 Tue, 18 Aug 2020 13:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160327.GA977@redhat.com> <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
 <20200807204015.GA2178@redhat.com>
In-Reply-To: <20200807204015.GA2178@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Tue, 18 Aug 2020 16:39:52 -0400
Message-ID: <CAMeeMh_=M3Z7bLPN3_SD+VxNbosZjXgC_H2mZq1eCeZG0kUx1w@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 5.9
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
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

For what it's worth, I just ran two tests on a machine with dm-crypt
using the cipher_null:ecb cipher. Results are mixed; not offloading IO
submission can result in -27% to +23% change in throughput, in a
selection of three IO patterns HDDs and SSDs.

(Note that the IO submission thread also reorders IO to attempt to
submit it in sector order, so that is an additional difference between
the two modes -- it's not just "offload writes to another thread" vs
"don't offload writes".) The summary (for my FIO workloads focused on
parallelism) is that offloading is useful for high IO depth random
writes on SSDs, and for long sequential small writes on HDDs.
Offloading reduced throughput for immensely high IO depths on SSDs,
where I would guess lock contention is reducing effective IO depth to
the disk; and for low IO depths of sequential writes on HDDs, where I
would guess (as it would for a zoned device) preserving submission order
is better than attempting to reorder before submission.

Two test regimes: randwrite on 7xSamsung SSD 850 PRO 128G, somewhat
aged, behind a LSI MegaRAID card providing raid0. 6 processors
(Intel(R) Xeon(R) CPU E5-1650 v2 @ 3.50GHz); 128G RAM; and seqwrite,
on a software raid0 (512k chunk size) of 4 HDDs on the same machine
specs. Scheduler 'none' for both. LSI card in writethrough cache mode.
All data in MB/s.


depth    jobs    bs    dflt    no_wq    %chg    raw disk
----------------randwrite, SSD--------------
128    1    4k    282    282    0    285
256    4    4k    251    183    -27    283
2048    4    4k    266    283    +6    284
1    4    1m    433    414    -4    403
----------------seqwrite, HDD---------------
128    1    4k    87    107    +23    86
256    4    4k    101    90     -11    91
2048    4    4k    273    233    -15    249
1    4    1m    144    146    +1    146

