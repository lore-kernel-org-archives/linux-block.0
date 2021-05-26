Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A99C2B9F7
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 03:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8980F6142D
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 03:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhEZDuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 23:50:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:31949 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEZDug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 23:50:36 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210526034904epoutp0132195dd8779e309ea48bdaa0328755ed~CgUPVQ1RP0077800778epoutp01m
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 03:49:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210526034904epoutp0132195dd8779e309ea48bdaa0328755ed~CgUPVQ1RP0077800778epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622000944;
        bh=etMLZWLC9ZkHwqmsS1HhSY8hQ7xQoVjfJgP1eeh6VHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bcl4dQw51ysySfH0q1r9+st7NDGGPE7+OCmc+3oRL2V4s6ye/aUMRDuveQH2mmqOs
         zlOMtBnsCkJfKxtU3yMXCc4RrjUaZuG/tRTkB/yoc1l4hwEBafRS2KkzwrhOQPmw9P
         8oJjS74MopcZeTOJLu4kmFRmCNwPDUPk5SQ9OiuM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210526034902epcas1p1f455ed386abbb7bd216fdc4fcff00fbf~CgUNXk2050594105941epcas1p1X;
        Wed, 26 May 2021 03:49:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FqcPm5c92z4x9Pt; Wed, 26 May
        2021 03:49:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.E8.10258.C25CDA06; Wed, 26 May 2021 12:49:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210526034859epcas1p3b3ab803406c983df431f89b6f9097f08~CgULUWk3s1684516845epcas1p3r;
        Wed, 26 May 2021 03:48:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210526034859epsmtrp25ddf9a84a79377197f48721d3ee65173~CgULS7oMS2577825778epsmtrp23;
        Wed, 26 May 2021 03:48:59 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-9f-60adc52c1a93
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.B0.08637.B25CDA06; Wed, 26 May 2021 12:48:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210526034859epsmtip2eb65df52a16ed768dee1434906d5b9ba~CgULCz-yz2984429844epsmtip2Q;
        Wed, 26 May 2021 03:48:59 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org
Cc:     Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yi.zhang@redhat.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v10 0/1] bio: limit bio max size
Date:   Wed, 26 May 2021 12:30:36 +0900
Message-Id: <20210526033036.30257-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YKJBWClI7sUeABDs@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTH89xbbguxrgNkz5pFSnUsIm8Fig8TlAUnd8EszfSTc4MObtrG
        0tZeMHPMjK0gDhiIzJoViihvjhebFMabYlmhAg5YGG9JURDGRMcAQ4GIzGQtFzK+/c/J73/O
        c86Tw8E989h8jkKVRmlVUqWQ8GA1dx0IDgq0NSSFdhr90Z1H9WxUWtsMUN3jQgK1D90ASP9i
        HUfZOWsY0lWYCPTblVsYmjUZcJQ/+50bep07iaHVaRp12A+i4fZSAlmLdRi63liKo7Gpfjbq
        mhxloenKIhwN9i27obI/Y9GrGhtASy/H2ehhazGOxgf1BDJ1rBOxfHJ4JIEs0i2yyTbDYzbZ
        eDuAHB5IJ8213xOkxVjPJpfujxJkQVMtIB3mvWROZx5GWq3VuGTXaWW0nJKmUFoBpUpWpyhU
        shhhwsnEuERxZKgoSBSFDgkFKmkqFSM8dkISdFyhdK5AKDgvVaY7UxIpTQtDjkRr1elplECu
        ptNihJQmRakRhWqCaWkqna6SBSerU98XhYaGiZ1kklLesFRFaJre/nL+uZ6dCYa8c4E7B/Ii
        YKn9LzwXeHA8ea0APhi/uxUsA1jYWIHlAo4zWAOwSrNt6LTPsxmmA8AKvQVjAgeAtzufYC6K
        4AXCggU74dLevD1w8voIcEE4b4IFmyuubkJezlLdxU/YLs3ivQt7s2s281zeYVg/+ppg2vnC
        f6fycZd25wXBe4ZpwDBvwr6fZlkujTsZ3S8lm8+GvBJ3eKv8rhtjPgbNumcYo73g3z1NbEbz
        oWOxg2AMeQDqLt0ATHAFwMq56i1HOFx2OIBrATjvADS1hzBpP9i2YQRM591wcTXfzYVAHhde
        vuTJIPthf9YUvt1rrqFtqyIJa3pztnaXCWDnj0WsK0Bg2DGQYcdAhv87lwO8FvhQGjpVRtEi
        TcTOPzaDzasIQK3AuPAi2AowDrACyMGF3txfdQ1JntwU6YWvKK06UZuupGgrEDvXXYTz9ySr
        nWelSksUicPCw8NRROShSHG48C2uLC4jyZMnk6ZRZylKQ2m3fRjHnZ+J3YyqjLTZVi50tTq6
        svqMNrH2PfjNzX0yUfc5nzvSR2Nz0RMZ61k+ZcXHV/85bB4znIqyNPhHkIpC2tiB+OcEamNY
        9RsbR60bnz7dX9Y9EEkcrNLH3cu9tlFpkioyV5+WA+yIbGai//zFZ93rvqdsJouds5Bw7ejg
        ytlvReYWf82Iv5/895e1Pn4P5pMuitaas+PH/Bq5gjVJaVOGgoxpCfqoPMpw+gvfmpLAEI/k
        n1tS8z6JPzEgsdZ9PFH9/AeryiKJ/3Cw3Pr55T+Ikt1xryw99pWl0Q+EPe88bJvp3VWnV48X
        16saz8wJh86c/MzLPfC+fHRmX2z9QkzzXvB1wZqQRculogBcS0v/AwNobC6eBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RWUwTURiFc2fKzFBFx7bqpRgbG9FIAcX1KmKamOioCe4GeIEqQ4u0BTvW
        ItForEgsiBgUYq0bimhlCzsoYluNoqAgWwQFETRxQcAdkCClMfHty/+dnPPwU7jAxhNT0dr9
        rE6rUEsJPq/MIZX4yR7mRSxKfidD+a9ySWSxlgF0+/VpAlU1XgYoY2AIR4lJPzFkvFZAoKdp
        WRjqLTDjKKX3mBsaNXVi6Ec3h6rbZaipykIge7oRQ5nFFhy1dtWRyNHZwkPd18/g6FntVzd0
        qUeOhnMeAtT/u41ETyrScdT2LINABdVDhFzMNDVvYs4Yv5BMpfk1yRTf9GGa6vVMkfUkwdRc
        zCWZ/nstBJNaYgXMt6LZTNL9ZIyx22/gWyaH8VdHsuroA6xu4ZoIviqvP5uIK/GM//QhgzwK
        GkUm4E5Beim83/6JdLKAvgNgZuca110MHz3uczMBapyF0OHgXJFBAI3DXk4maF+Y2tdOOFlE
        T4edmc3ABPgUTo/wYMfbwQkhHO9/kP5mop9He8PHiTmYkz3oQJjbMkq4tiTwT1cK7mR32g/e
        NXcD15gvTGrMIV35abD2fC/Pyfh43lh6AU8DtPk/Zf5PXQGYFXiycZxGqeEC4gK0rMGfU2g4
        vVbpvydWUwQmvuyzoAKUWwf87QCjgB1ACpeKPGzGvAiBR6TiYAKriw3X6dUsZwdeFE8606PB
        VBsuoJWK/WwMy8axun8Wo9zFR7FVq6ZsVZ0LW3tw30hs8Ih9cc9TYfiQUN4+lD13h3rGSJS3
        0ZNvDZGEZV9fJCIlhx3PQUxNzDJ9fGp9gY2xrHu3PKqwVHm86uXcyo+qgUnq2LZX0elp1LCp
        rfpR8DxJ2vbd83psqTNXSGHu4CDLEearXWeDNC3vTxh23704G5sl+r4rdOUMiy5B2ivuO5x/
        58iR0D8JUrLj66+u7UEN3qpfQq8Gx9STt5jNgr3yJS+4mvyQioV9Y+Xre45/PsSFehnsSnaM
        KtvpqN74JjjRb9SNMMjxOYG3hfNHU5INH33HZK2BG06djc8KkQXYVpvndyg2ag9kvd+WP7zP
        j6grDNJLeZxKEeCD6zjFX0K3KYBUAwAA
X-CMS-MailID: 20210526034859epcas1p3b3ab803406c983df431f89b6f9097f08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210526034859epcas1p3b3ab803406c983df431f89b6f9097f08
References: <YKJBWClI7sUeABDs@infradead.org>
        <CGME20210526034859epcas1p3b3ab803406c983df431f89b6f9097f08@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, May 14, 2021 at 03:32:41PM +0900, Changheun Lee wrote:
> > I tested 512MB file read with direct I/O. and chunk size is 64MB.
> >  - on SCSI disk, with no limit of bio max size(4GB) : avg. 630 MB/s
> >  - on SCSI disk, with limit bio max size to 1MB     : avg. 645 MB/s
> >  - on ramdisk, with no limit of bio max size(4GB)   : avg. 2749 MB/s
> >  - on ramdisk, with limit bio max size to 1MB       : avg. 3068 MB/s
> > 
> > I set ramdisk environment as below.
> >  - dd if=/dev/zero of=/mnt/ramdisk.img bs=$((1024*1024)) count=1024
> >  - mkfs.ext4 /mnt/ramdisk.img
> >  - mkdir /mnt/ext4ramdisk
> >  - mount -o loop /mnt/ramdisk.img /mnt/ext4ramdisk
> > 
> > With low performance disk, bio submit delay caused by large bio size is
> > not big protion. So it can't be feel easily. But it will be shown in high
> > performance disk.
> 
> So let's attack the problem properly:
> 
> 1) switch f2fs to a direct I/O implementation that does not suck
> 2) look into optimizing the iomap code to e.g. submit the bio once
>    it is larger than queue_io_opt() without failing to add to a bio
>    which would be annoying for things like huge pages.

There is bio submit delay in iomap_dio_bio_actor() too.
As bio size increases, bio_iov_iter_get_pages() in iomap_dio_bio_actor()
takes time more. I measured how much time is spent of bio_iov_iter_get_pages()
for each bio size with ftrace.

I added ftrace at below position.
--------------
static loff_t
iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
		                struct iomap_dio *dio, struct iomap *iomap)
{
	... snip ...

	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
	do {
		... snip ...

		trace_mark_begin_end('B', "iomap_dio_bio_actor",
			"bio_iov_iter_get_pages", "bi_size", bio->bi_iter.bi_size, 0);
		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
		trace_mark_begin_end('E', "iomap_dio_bio_actor",
			"bio_iov_iter_get_pages", "bi_size", bio->bi_iter.bi_size, 0);
		... snip ...

	} while (nr_pages);
	... snip ...
}

bio submit delay was 0.834ms for 32MB bio.
----------
4154.574861: mark_begin_end: B|11511|iomap_dio_bio_actor:bio_iov_iter_get_pages|bi_size=0;
4154.575317: mark_begin_end: E|11511|iomap_dio_bio_actor:bio_iov_iter_get_pages|bi_size=34181120;
4154.575695: block_bio_queue: 7,5 R 719672 + 66760 [tiotest]

bio submit delay was 0.027ms for 1MB bio.
----------
4868.617791: mark_begin_end: B|19510|iomap_dio_bio_actor:bio_iov_iter_get_pages|bi_size=0;
4868.617807: mark_begin_end: E|19510|iomap_dio_bio_actor:bio_iov_iter_get_pages|bi_size=1048576;
4868.617818: block_bio_queue: 7,5 R 1118208 + 2048 [tiotest]

To optimize this, current patch, or similar approch is needed in
bio_iov_iter_get_pages(). Is it OK making a new function to set bio max
size like as below? And call it where bio max size limitation is needed.

void blk_queue_bio_max_size(struct request_queue *q, unsigned int bytes)
{
	struct queue_limits *limits = &q->limits;
	unsigned int bio_max_size = round_up(bytes, PAGE_SIZE);

	limits->bio_max_bytes = max_t(unsigned int, bio_max_size,
			              BIO_MAX_VECS * PAGE_SIZE);
}
EXPORT_SYMBOL(blk_queue_bio_max_size);

