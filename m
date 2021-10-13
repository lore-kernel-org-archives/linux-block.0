Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 01:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BC660BD3
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 01:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhJMBpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 21:45:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64266 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhJMBpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 21:45:16 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211013014312epoutp0393f949396cfa33eb34ecc0bc674cfc64~tc6Uac7bD2073020730epoutp03c
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 01:43:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211013014312epoutp0393f949396cfa33eb34ecc0bc674cfc64~tc6Uac7bD2073020730epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634089392;
        bh=5hgsZMnyHmMQuJ17+DuONfTtOtgQHJQx6uixMnpyb9w=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=IMdhHaT6sgaJdi8SaLkAKpO4pbXlzdY/zpwFcBk98u5jf83t2VMRNtQqyGXn+uXB0
         a2nf+a/ZyqqDeAjkgkKdde14dQgLwGn5KWPfiho4RhOVTj67jNDP4Ou1TDiQZV0Zuj
         rzCND24TzEGtsvDjLeWiGmbv5/LzXfQAeWQdlRto=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20211013014309epcas2p15f019c6c8a12ef5633d9f87784e9de70~tc6Rchuyl0925409254epcas2p1E;
        Wed, 13 Oct 2021 01:43:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HTZzn5PtYz4x9QF; Wed, 13 Oct
        2021 01:43:01 +0000 (GMT)
X-AuditID: b6c32a48-d75ff70000002500-7e-616639a135d6
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.F4.09472.1A936616; Wed, 13 Oct 2021 10:42:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] block-map: added error handling for bio_copy_kern()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb@epcms2p5>
Date:   Wed, 13 Oct 2021 10:42:56 +0900
X-CMS-MailID: 20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmhe5Cy7REgxe3eCxW3+1ns3h5SNPi
        9IRFTBa9/VvZLPbe0ra4vGsOmwObx+YVWh6Xz5Z69G1ZxejxeZNcAEtUtk1GamJKapFCal5y
        fkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0GIlhbLEnFKgUEBicbGSvp1N
        UX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG35Logt+yFSdPHGNq
        YHwt08XIySEhYCKx5sh+1i5GLg4hgR2MEs/eNrJ0MXJw8AoISvzdIQxSIyzgLvG1r5UFxBYS
        UJI4t2YWI0iJsICBxK1ec5Awm4CexM8lM9hAxogIXGCUWDxhJzPEfF6JGe1PWSBsaYnty7cy
        QtgaEj+W9ULViErcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKNE6YBjWzXOLq8jksIIsl
        BDoYJS4vuQmV0Je41rERzOYV8JWY2/cUrJlFQFViWfMfJogaF4nuKSBXc3IwC2hLLFv4mhnk
        MWYBTYn1u/RBTAkBZYkjt1hgXmnY+Jsdnc0swCfRcfgvXHzHvCdMEK1qEouajCDCMhJfD8+H
        KvGQmDmng3kCo+IsRDjPQnLCLIQTFjAyr2IUSy0ozk1PLTYqMIHHbHJ+7iZGcALU8tjBOPvt
        B71DjEwcjIcYJTiYlUR4DYHpSog3JbGyKrUoP76oNCe1+BCjKdDzE5mlRJPzgSk4ryTe0MTS
        wMTMzNDcyNTAXEmcd+4/p0QhgfTEktTs1NSC1CKYPiYOTqkGJnm+Nb0Mj5+n9s6W2LEoY1/d
        nFmhN6cYzTFdpJ2QtCZIJ8SM68/l+Mw/HJ/C30/exCuqtUJ5x6a46AL35Cop4y0L8r4Uh3zI
        n371Du+/BCsn/saiJ05+fVxTlKZHuciXrzPifrtH+llh7uHm5l/7b/u18fGGFN9/u+DDzjbX
        Ha0CL25d3fH01cP8aRGfvqXPvRtVHOS0/5VzmHVK7Sd3T0OhwK2/35zQfPpG5YvSlnUvXlja
        cgluP3aUaW9YjoSGZNoCPpYvfaocBXedN4R3Mb4JnxuiXafueGrWgkkq65bVX+Te3BOq3Gp4
        ukt+8REOF93D7pZK4mwNS1T0Vz/fVl2eHFG7my1v6e11T5+dUWIpzkg01GIuKk4EAFaElbsJ
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb
References: <CGME20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb@epcms2p5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When new pages are allocated to bio through alloc_page() in
bio_copy_kern(), the pages must be freed in error handling after that.
There is little chance of an error occurring in blk_rq_append_bio(), but
in the code flow, pages additionally allocated to bio must be released.

V2:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20-=20As=20pointed=20out=20by=20=
Christoph,=20replace=20int=20with=20bool=0D=0A=0D=0ASigned-off-by:=20Jinyou=
ng=20Choi=20<j-young.choi=40samsung.com>=0D=0A---=0D=0A=C2=A0block/blk-map.=
c=20=7C=2011=20++++++++---=0D=0A=C2=A01=20file=20changed,=208=20insertions(=
+),=203=20deletions(-)=0D=0Adiff=20--git=20a/block/blk-map.c=20b/block/blk-=
map.c=0D=0Aindex=204526adde0156..b137a2f569f8=20100644=0D=0A---=20a/block/b=
lk-map.c=0D=0A+++=20b/block/blk-map.c=0D=0A=40=40=20-628,6=20+628,7=20=40=
=40=20int=20blk_rq_map_kern(struct=20request_queue=20*q,=20struct=20request=
=20*rq,=20void=20*kbuf,=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20i=
nt=20reading=20=3D=20rq_data_dir(rq)=20=3D=3D=20READ;=0D=0A=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=20unsigned=20long=20addr=20=3D=20(unsigned=20lo=
ng)=20kbuf;=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20struct=20bio=
=20*bio;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20bool=20do_copy;=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20int=20ret;=0D=0A=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20if=20(len=20>=20(queue_max_hw_sectors(q)=
=20<<=209))=0D=0A=40=40=20-635,8=20+636,9=20=40=40=20int=20blk_rq_map_kern(=
struct=20request_queue=20*q,=20struct=20request=20*rq,=20void=20*kbuf,=0D=
=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20if=20(=21len=20=7C=7C=20=21=
kbuf)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=20return=20-EINVAL;=0D=0A-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20if=20(=21blk_rq_aligned(q,=20addr,=20len)=20=7C=7C=20obje=
ct_is_on_stack(kbuf)=20=7C=7C=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20blk_queue_may_bounce(q))=0D=0A+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20do_copy=20=3D=20=21blk_rq_aligned(q,=20addr,=20len)=20=
=7C=7C=20object_is_on_stack(kbuf)=20=7C=7C=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20blk_queue_ma=
y_bounce(q);=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20if=20(do_copy)=0D=
=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20bio=20=3D=20bio_copy_kern(q,=20kbuf,=20len,=20gfp_mask=
,=20reading);=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20else=0D=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20bio=20=3D=20bio_map_kern(q,=20kbuf,=20len,=20gfp_mask);=
=0D=0A=40=40=20-648,8=20+650,11=20=40=40=20int=20blk_rq_map_kern(struct=20r=
equest_queue=20*q,=20struct=20request=20*rq,=20void=20*kbuf,=0D=0A=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20bio->bi_opf=20=7C=3D=20req_op(rq);=0D=
=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20ret=20=3D=20blk_rq_append_b=
io(rq,=20bio);=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20if=20(unlikely(=
ret))=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20if=20(unlikely(ret))=20=
=7B=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20if=20(do_copy)=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=20bio_free_pages(bio);=0D=0A=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20=
bio_put(bio);=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20=7D=0D=0A=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20return=20ret;=0D=0A=C2=A0=7D=0D=0A=
=C2=A0EXPORT_SYMBOL(blk_rq_map_kern);=0D=0A--=0D=0A2.25.1=C2=A0
