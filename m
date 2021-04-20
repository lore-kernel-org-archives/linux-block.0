Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2335C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 01:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4DC613AB
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 01:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDTBMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 21:12:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28110 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhDTBMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 21:12:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210420011145epoutp04f4790e7ce958c5c7cb1dfe11a414c830~3a8nEaVtd1974419744epoutp04z
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 01:11:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210420011145epoutp04f4790e7ce958c5c7cb1dfe11a414c830~3a8nEaVtd1974419744epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618881105;
        bh=cPUVays932a8Z7IzMdAKt0lW0LDbSc+HPSAngtKsORg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQDztH36K9JFpQg1wNPc7Pr7VRPujXUrdybKkq4HpxfnZNg2m80o8Z37qZE7w1uWd
         I+C+f+mSyoI6gbLqV4dyxeHTSipGe1ZE94CUxQ1nvwOUnCxlDUwPujzgp3lhu28Go6
         DAW1yoxtbR0iQxlS/qUahI4rBFEF2CnFOam3kKH8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210420011142epcas1p3c4148562bda42baa357583395a5c6a2f~3a8kVznTX2467324673epcas1p3W;
        Tue, 20 Apr 2021 01:11:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FPQcs0j62z4x9Pp; Tue, 20 Apr
        2021 01:11:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.2E.09578.C4A2E706; Tue, 20 Apr 2021 10:11:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210420011139epcas1p429e791d6f8ffea596661e9366babbec8~3a8hpQvIc0588405884epcas1p4D;
        Tue, 20 Apr 2021 01:11:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210420011139epsmtrp284e9cf995594a8c2b5390c10400cbd06~3a8hnKQJo0693106931epsmtrp2U;
        Tue, 20 Apr 2021 01:11:39 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-39-607e2a4c34bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.3D.08163.B4A2E706; Tue, 20 Apr 2021 10:11:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210420011139epsmtip2f58a2d04986b0186009196abbef436b0~3a8hXiGh80386603866epsmtip2k;
        Tue, 20 Apr 2021 01:11:39 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
Date:   Tue, 20 Apr 2021 09:53:44 +0900
Message-Id: <20210420005344.9280-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <918e0d57-ffbc-7dcd-6eba-87d22aceb9d6@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJsWRmVeSWpSXmKPExsWy7bCmga6PVl2CwbwvNhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO6o
        HJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoE+VFMoS
        c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5
        GQ0vrzAV/BatmHnOroHxmWAXIweHhICJxIym8i5GLg4hgR2MEocvbGXqYuQEcj4xSsw9wgeR
        +Mwo0fhhGiNIAqRh37SXTBCJXYwS38/PY4Kr2rvhKQtIFZuAjkTf21tsILaIgJjE5S/fGEGK
        mAXaWCRutVwDSwgLGEts/7uQHeQOFgFViVtLZUDCvAJWEguPLGaH2CYv8ed+DzOIzSlgLbGn
        fy8bRI2gxMmZT8B2MQPVNG+dzQwyX0LgP4fE+WsfWSGaXSS+v9gCdbawxKvjW6CGSkl8fgcy
        CKShm1GiuW0+I4QzgVFiyfNlTBBVxhKfPn9mBLmOWUBTYv0ufYiwosTO33MZITbzSbz72sMK
        CUheiY42IYgSFYkzLfeZYXY9X7sTaqKHxNv2i4yQ0OpjlFi45SrzBEaFWUgemoXkoVkImxcw
        Mq9iFEstKM5NTy02LDBEjuFNjOCkr2W6g3Hi2w96hxiZOBgPMUpwMCuJ8N6vrUkQ4k1JrKxK
        LcqPLyrNSS0+xGgKDO2JzFKiyfnAvJNXEm9oamRsbGxhYmZuZmqsJM6b7lydICSQnliSmp2a
        WpBaBNPHxMEp1cAk66Djbzjjv6iG+trr9rua+52Dr/ow7BWMU9P83cRg8q94Uh7rbAOzyZpy
        BZfdEutPerVv9XXnV7knt3TLEz6/6jd2Lz6aJe3YOY83SI2jUF04/PHRnr/VrK8LDkV3uf0z
        X8Ixv+jXuVs7f8Qd96o23xpwU3K3jau2blu0M2PF2cds9+419dXvFruuHW6uvj416bGoU+/f
        jefu1T5/xzvLYv8SqYXbvi4LLPlsH/7uxvUzhfOT5+ukNMlypT+r3uvMe9t103sfscvZGds2
        rp6XdqLJQz5ZouO03Kt/MRZiixb/rvond/jQs+kiSupWDjZMu0N7rAvkfHqnM3SefK55J8cu
        Ov1n9ttGBXuzdUosxRmJhlrMRcWJADMYBSuDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK63Vl2CwY3HkhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsEroyGl1eYCn6LVsw8Z9fA+Eywi5GTQ0LARGLftJdMXYxcHEICOxglFm+f
        wgSRkJI4fuItaxcjB5AtLHH4cDFEzUdGiR8HvzKC1LAJ6Ej0vb3FBmKLCIhJXP7yjRGkiFlg
        AYvEwZ0n2EESwgLGEtv/LmQHGcQioCpxa6kMSJhXwEpi4ZHF7BC75CX+3O9hBrE5Bawl9vTv
        BZspBFRz9uRNVoh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGydSC4tz03GLDAqO8
        1HK94sTc4tK8dL3k/NxNjODI1NLawbhn1Qe9Q4xMHIyHGCU4mJVEeO/X1iQI8aYkVlalFuXH
        F5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNQ0RZ/d+H+cZ+VxYZG7vKJ8
        i+5fNxc4tnRCdFX6nfcWUbz3BKq7X8wN0mdknXtDd+mt1C7eMzmhf/I5mf7sjwys2ry65y6r
        GP/Fto9sWwQu/fp0Y2oQn9J8/+T1QRFiWRwZaVKa54IZHNnU1+zlM1z8cbvgwfAU7xtNAiGN
        sxc2dP4pqzc9fHXl8uVcy15wrufMCbjUyv9UkEWtUaq2yi2zTfTvBq9fbd08sVv8vLn8X2SH
        ld1SKrRNsPvimSGeeO7lO07B2Wn8klzMRjdOfXZwv7smOCHXfqbF58y8mQL1EoUpsQ/UGHrz
        zjxPs4k1NF5y4eS69uP+F7743X22N2zjieh9U2oi9ULWiSQosRRnJBpqMRcVJwIADyeTlTsD
        AAA=
X-CMS-MailID: 20210420011139epcas1p429e791d6f8ffea596661e9366babbec8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210420011139epcas1p429e791d6f8ffea596661e9366babbec8
References: <918e0d57-ffbc-7dcd-6eba-87d22aceb9d6@acm.org>
        <CGME20210420011139epcas1p429e791d6f8ffea596661e9366babbec8@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/18/21 10:49 PM, Changheun Lee wrote:
> >>> @@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
> >>>  	max_sectors = round_down(max_sectors,
> >>>  				 limits->logical_block_size >> SECTOR_SHIFT);
> >>>  	limits->max_sectors = max_sectors;
> >>> +	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
> >>>  
> >>>  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
> >>>  }
> >>
> >> Can the new shift operation overflow? If so, how about using
> >> check_shl_overflow()?
> > 
> > Actually, overflow might be not heppen in case of physical device.
> > But I modified as below. feedback about this.
> > 
> > @@ -168,6 +169,9 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
> >  				 limits->logical_block_size >> SECTOR_SHIFT);
> >  	limits->max_sectors = max_sectors;
> >  
> > +	limits->bio_max_bytes = check_shl_overflow(max_sectors, SECTOR_SHIFT,
> > +		&limits->bio_max_bytes) ? UINT_MAX : max_sectors << SECTOR_SHIFT;
> > +
> >  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
> >  }
> >  EXPORT_SYMBOL(blk_queue_max_hw_sectors);
> 
> If no overflow occurs, check_shl_overflow() stores the result in the
> memory location the third argument points at. So the above expression
> can be simplified into the following:
> 
> if (check_shl_overflow(max_sectors, SECTOR_SHIFT, &limits->bio_max_bytes)) {
> 	limits->bio_max_bytes = UINT_MAX;
> }

OK. No problem. It might be more readable.

> 
> >>> diff --git a/include/linux/bio.h b/include/linux/bio.h
> >>> index d0246c92a6e8..e5add63da3af 100644
> >>> --- a/include/linux/bio.h
> >>> +++ b/include/linux/bio.h
> >>> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
> >>>  	return NULL;
> >>>  }
> >>>  
> >>> +extern unsigned int bio_max_size(struct bio *bio);
> >>
> >> You may want to define bio_max_size() as an inline function in bio.h
> >> such that no additional function calls are introduced in the hot path.
> > 
> > I tried, but it is not easy. because request_queue structure of blkdev.h
> > should be referred in bio.h. I think it's not good to apply as a inline function.
> 
> Please don't worry about this. Inlining bio_max_size() is not a big
> concern to me.
> 
> Thanks,
> 
> Bart.

I think removing of UINT_MAX setting in blk_stack_limits() might be good.
Because default queue limits for stacking device will be set in
blk_set_stacking_limits(), and blk_set_default_limits() will be called
automatically. So setting of UINT_MAX in blk_stack_limits() is not needed.
And setting in blk_stack_limits() can overwrite bio_max_bytes as a default
after stacking driver set to proper bio_max_bytes value.


Thanks,

Changheun Lee.
