Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE2C433E9
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123BC230FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbhASSp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391707AbhASSEK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 13:04:10 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79CFC0613C1
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 10:03:29 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so22684441qkc.13
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j1M3uq+mXePAcpFXiBOTYof3FY5bhcapXrpc6RKaHY0=;
        b=Hh9SblNojKOb5EYq3K8qUhYmB3i+erqETW1LvC5Uy6ZQG4qMseKDpiMEz841rNTZtM
         piAYeqNY5m2TdjvJhkSAWhKNgGCOjG4i/PpQj5QuIIUpP8/qZO/rPv5EdJ1icP8JF/RV
         zpK2vpvYwcHH2bud0iHBJxcdsOjCrzvlc7iOnWumPvzG4N1kvFI2AfXfG5+Z1Qshu0FK
         pMwTb9bFOG2y5hZzWellK8LRib/HfIn066Mstgx+ewJPy6QpF/PbTZsnl1A7hBuWbhga
         zLA/rKh1y/1AVUtAGOnEkigIKTS2hwFmgvEQbdveQmrPiAbvLMAGZA+FpscMSuo87voy
         w3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1M3uq+mXePAcpFXiBOTYof3FY5bhcapXrpc6RKaHY0=;
        b=Fk1e4dg+fEof1lI80O7xbW0ikBcxfbwnNd7Hn9gXkd0RIkts+4ooafz7WnUw64EEwf
         gYXfHPenFpn0ywAwmZk9OIs41y7X1FFtJw94sTw7iN5UnmN14Jem8V2gMQXhmCkiODQ6
         SR1d+gZcKu7ravUhBwNBxYlbLdZuL+2nB94vta0ro1oGxDkKhZ3weLnBGbPDYWSiTMoc
         nvq5JlpefYgm93skWaote+o1lSQ/9B26dBfjihVJke46FKXE9rfp89NlDRRXi5Q0ZGtJ
         M0DLjriEdu+5AnOrJC74mDjcOE1WL4Cg/9YjRArEb9SOiVdaQqTGEOd/fzss4SMjDmfp
         j9GA==
X-Gm-Message-State: AOAM530gUiyjgl7M27KC9jsPFuUPdgQ1F8NMKNQGDdiNS60wL5retW2z
        gGfBKWmkAhm8EGmOYhqa+q1g7A==
X-Google-Smtp-Source: ABdhPJw2XCT7fzRIheQITlzWVeRsNY4eXnLldryVnmv9+vJo9i0eBjqYTuC3jm5yDDU9pEhFsVWc3A==
X-Received: by 2002:a05:620a:2149:: with SMTP id m9mr5538332qkm.60.1611079408965;
        Tue, 19 Jan 2021 10:03:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id s30sm12979164qte.44.2021.01.19.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:03:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vLj-003pDY-Qf; Tue, 19 Jan 2021 14:03:27 -0400
Date:   Tue, 19 Jan 2021 14:03:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210119180327.GX4605@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
 <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 19, 2021 at 06:24:49PM +0100, Bodo Stroesser wrote:
> 
> I had a second look into math.h, but I don't find any reason why round_up
> could overflow. Can you give a hint please?

#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
                                                    ^^^^^

That +1 can overflow

It looks like it would not be so bad to implement some
check_round_up_overflow() if people prefer

Jason
