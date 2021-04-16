Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FFBC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 06:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDB16113D
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 06:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhDPGI5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 02:08:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:47661 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhDPGI5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 02:08:57 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210416060830epoutp01ecf1c4938e8089e64c95eec08ece01b1~2QakivR4V2418524185epoutp01B
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 06:08:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210416060830epoutp01ecf1c4938e8089e64c95eec08ece01b1~2QakivR4V2418524185epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618553310;
        bh=TVR2NG8Dla8sUBALdtzvQt19CiAXv7/CBvFbD/vfHuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ba/7jgl+Bmpbaum/c4so8ozz8pDkfErerUohQVKeIBTgXP1kWZyBeGnNR5O2JgW+9
         sP6OVyutReRI8QSbGV8HyIvXfhG+v4+uw86rOGxWg1R+CzbSyYAsAnk8LDtnfAcYlV
         6MsxIXt7eOLc0h7yB4JRDKRR7RplLxHB5r6RFRII=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210416060829epcas1p1f2aca6faecc6e2dd8098d2b93bb3738c~2QajgKAqv3073230732epcas1p15;
        Fri, 16 Apr 2021 06:08:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FM5P81hp3z4x9Q9; Fri, 16 Apr
        2021 06:08:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.3B.07927.CD929706; Fri, 16 Apr 2021 15:08:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210416060827epcas1p39350d45cef64c91be681b76180b63140~2QahhMA5_0256402564epcas1p3W;
        Fri, 16 Apr 2021 06:08:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210416060827epsmtrp2ad5489f2cafc2395104e3858cbfada6f~2QahfyNHe0969609696epsmtrp2W;
        Fri, 16 Apr 2021 06:08:27 +0000 (GMT)
X-AuditID: b6c32a35-f4c0da8000011ef7-82-607929dc0434
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.B5.33967.BD929706; Fri, 16 Apr 2021 15:08:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210416060827epsmtip102808d4f8ed04bb94b0896ddbd207681~2QahQvFMt0913309133epsmtip1d;
        Fri, 16 Apr 2021 06:08:27 +0000 (GMT)
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
Date:   Fri, 16 Apr 2021 14:50:39 +0900
Message-Id: <20210416055039.20126-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <bb8f7127-edff-4a32-2d5c-4343002bda19@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+5tbwumUB6DIz6GDYuhW6GlKzuOR0ZclhtxhggqYYa2wg1F
        S1t7y2RqCFsp2woyOhiEx8aGOLbOifISKs9OVASXDYQJwgAlG4wAkwIZwyWWXoj89/v+zuf3
        +57feXBxbwcRwE3XGCi9RqkWEO6sllvBYtF48AmFuHHWDVVZWwC6MXGOQKWP13FkOr2GIeOX
        9QTqL6rBUMHMKTZ6Zr6PodVpGnWM7UVDtioC2YuNGCprrMLRyOQAB926P8xC07UWHN3uW2aj
        S38fQk/regFaenKPg35tLcZRfcc6cciPHPo9lrQYFzlkW8UEh2y8JiSHfsskG6xnCbLr4tcc
        cqlzmCALm6yAdDS8TJ7uzsfinktSR6ooZSqlD6Q0KdrUdE1alCA2Xv66XBYulogkr6EDgkCN
        MoOKEhx+M050JF3tnFQQeFypznSm4pQ0LQiNjtRrMw1UoEpLG6IElC5VrZOIdSG0MoPO1KSF
        pGgzDkrE4jCZk1SoVXXVUyzdiFdWw2ATJweUe5iBGxfy98OGm/c4ZuDO9ea3Atiz2r0llgGc
        P/kUZ8QagKVjJvZ2yfg3doxZ6ADw0Y07gBEOAO9cb+ZsUgR/HyxcGCM2Y1++HxxaWXNBOD+P
        BcdyR1wLPnwp/P7ZFVcBi78Hbty2u/I8fgS0mWoJxm43/HeyAN+M3Zz5uooVNsN4wb7yGdZm
        jDsZY3Ola6+Q/4QLfzJecEJcpzgM2+8eZ/r4wEc/N3GYOAA6FjsIhs8H0JhXDRhRBGDtw6sY
        Q0nhssMBNhvh/GBYbwtl0q/Ato2LgDH2gIurBVtePHgmz5tBguBA7iS+7fXwZttWRxKaRs1b
        B1wIYJ81hygCgRU75qnYMU/F/86XAW4FfpSOzkijaIlOsvOSG4Dr9QtlrcCy8DjEDjAusAPI
        xQW+POnZLIU3L1V54lNKr5XrM9UUbQcy52lb8IBdKVrn99EY5BJZmFQqRfvDD4TLpAJ/3gfi
        Kbk3P01poD6iKB2l367DuG4BOdhVqmRgFu8q93wJP+bfsrG+W/Xjqla1UHKsU/JOP/vjr1TJ
        oQ9W3vZyT7fEy9XtWQnZZRKRvZ/97Z97tW4tPX3tMW9gjbbeF7N1pXMKu29EdOUVhemP1n1B
        uUueuYmfF13769QDVJeYHxTqI6z0jS9E4tFm81uiV8uq8yrbYpM4a8NJu56vKT5jEQoSvK5/
        Nn/JQ9xp76Wzvzga9kPP3Q+V8UcvnEvgcf/pHxIOjtYcebdtxtMrfO6k9RPb6HS3RVNSn2Dj
        LOPt7OmuyKkJ0XzMd4nR7MGY8vOFitIXDra/n7zH4B+RnozEwhjfX8yz44ZIz+JQxeUllc00
        9h5cc4+ZE7BolVIixPW08j93SaykhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnO5tzcoEg7k7JCzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnL5z9gKbgmWLHp0hb2BsaZfF2MnBwSAiYSd9YdYgKxhQR2M0rsP84J
        EZeSOH7iLWsXIweQLSxx+HBxFyMXUMlHRom23iNg9WwCOhJ9b2+xgdgiAmISl798YwQpYhZY
        wCJxcOcJdpCEsICxxPa/C8FsFgFVid/nDoE18ApYS+xqXcIGsUxe4s/9HmYQmxMovnzWF1aI
        g6wk/jXNYYGoF5Q4OfMJmM0MVN+8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcr
        TswtLs1L10vOz93ECI5NLc0djNtXfdA7xMjEwXiIUYKDWUmE17izIkGINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJsXri21+OWj0L9TuljjVt25ZhqbQ
        RdeCpM3fLUWvVee8uGA2+d6/m49fam0X9Ny52KL49GXOkiqLzq4D3dqvokujn4Q/WfuKccnP
        wPvrzXgs6x50NTsphq01X8MT517N+Sc240G834+FG878aGB3rDYKdTRrrL70cTnD4SsHVV8y
        R07seJW+P2bBfeULXg/nfbawnWEhnBITmRFq6pf24V1TZefNSe7X7J4aVYlyBVgXpUZKhtn5
        urDbuLcU77hYlLnqW8vcSj/TL6lsIe/bvly7cHOxmbbH49mfEk+t7Fy34krPi8D8sqnJyWcV
        8yNllivFzlt9cO9c1S81X1wKXomZqq5oz09c7ZOgYnRSiaU4I9FQi7moOBEA+/FzrDwDAAA=
X-CMS-MailID: 20210416060827epcas1p39350d45cef64c91be681b76180b63140
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210416060827epcas1p39350d45cef64c91be681b76180b63140
References: <bb8f7127-edff-4a32-2d5c-4343002bda19@acm.org>
        <CGME20210416060827epcas1p39350d45cef64c91be681b76180b63140@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/15/21 3:38 AM, Changheun Lee wrote:
> > @@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
> >  	max_sectors = round_down(max_sectors,
> >  				 limits->logical_block_size >> SECTOR_SHIFT);
> >  	limits->max_sectors = max_sectors;
> > +	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
> >  
> >  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
> >  }
> 
> Can the new shift operation overflow? If so, how about using
> check_shl_overflow()?

OK, I'll check.

> 
> > @@ -538,6 +540,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >  {
> >  	unsigned int top, bottom, alignment, ret = 0;
> >  
> > +	t->bio_max_bytes = min_not_zero(t->bio_max_bytes, b->bio_max_bytes);
> > +
> >  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
> >  	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
> >  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
> 
> The above will limit bio_max_bytes for all stacked block devices, which
> is something we do not want. I propose to set t->bio_max_bytes to
> UINT_MAX in blk_stack_limits() and to let the stacked driver (e.g.
> dm-crypt) decide whether or not to lower that value.
> 

Actually, bio size should be limited in dm-crypt too. Because almost I/O
from user space will be gone to dm-crypt first. I/O issue timing will be
delayed if bio size is not limited in dm-crypt.
Do you have any idea to decide whether takes lower bio max size, or not
in the stacked driver?
Add a flag to decide this in driver layer like before?
Or insert code manually in each stacked driver if it is needed?

> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index d0246c92a6e8..e5add63da3af 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
> >  	return NULL;
> >  }
> >  
> > +extern unsigned int bio_max_size(struct bio *bio);
> 
> You may want to define bio_max_size() as an inline function in bio.h
> such that no additional function calls are introduced in the hot path.

Thanks, I'll try.

> 
> Thanks,
> 
> Bart.
