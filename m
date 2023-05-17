Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9AC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEQHSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQHSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:18:39 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F7E1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:18:37 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230517071834epoutp03fe2ec5c0c35ff68de58ba9b47ec483ac~f3R-hLA2w0806608066epoutp03_
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 07:18:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230517071834epoutp03fe2ec5c0c35ff68de58ba9b47ec483ac~f3R-hLA2w0806608066epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684307914;
        bh=5Q30/+fCuMJRZ4YDgvx/07ZdSEUpn25r/7gObpGT8s0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=n0dSpJH4SZpnMqswnwWNcOgsUXtQevq72N5tqHZfe3PS4PdcE5hRmkRWbtzdHYJVI
         O62j+TT3xjLdkYKb9uh0CyAG5BIcJxSWCJdJiDu+gzRaMG5hx7L5eD0TLRUVt/G9A8
         DdRTMDVevl1RuJ9FMIyhNFnKhK986PsTwVznR8dk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230517071834epcas2p2c2d2b87fbffc5a0c2f0831318e69172a~f3R-OV1651748417484epcas2p2R;
        Wed, 17 May 2023 07:18:34 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QLkwn755gz4x9Q7; Wed, 17 May
        2023 07:18:33 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-db-64647fc93537
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.F0.03265.9CF74646; Wed, 17 May 2023 16:18:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/8] block: tidy up the bio full checks in
 bio_add_hw_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-2-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230517071833epcms2p6049875f3644f10914777fb1160c3a822@epcms2p6>
Date:   Wed, 17 May 2023 16:18:33 +0900
X-CMS-MailID: 20230517071833epcms2p6049875f3644f10914777fb1160c3a822
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmme7J+pQUg7Wv1C1W3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcsPNXPXHBapOLNnqcsDYxfhbsYOTkk
        BEwktnx8w9bFyMUhJLCDUeLk53PMXYwcHLwCghJ/dwiDmMICARJPLjOClAsJKEmcWzOLESJs
        IHGr1xwkzCagJ/FzyQw2EFtEwEFi9oalYDazgL3E3tutjBCbeCVmtD9lgbClJbYv3woW5xQw
        kjg8vYkZIq4h8WNZL5QtKnFz9Vt2GPv9sflQc0QkWu+dhaoRlHjwczdUXFLi0KGvbCCnSQjk
        S2w4EAgRrpF4u/wAVIm+xLWOjWAn8Ar4Stxc9APsVxYBVYk1ewQhSlwk+u52MENcry2xbOFr
        sBJmAU2J9bv0IYYrSxy5xQJRwSfRcfgvO8x/DRt/Y2XvmPeECaJVTWJRk9EERuVZiCCehWTV
        LIRVCxiZVzGKpRYU56anFhsVGMJjNTk/dxMjOM1pue5gnPz2g94hRiYOxkOMEhzMSiK8gX3J
        KUK8KYmVValF+fFFpTmpxYcYTYF+nMgsJZqcD0y0eSXxhiaWBiZmZobmRqYG5krivNK2J5OF
        BNITS1KzU1MLUotg+pg4OKUamHK+Nv4xbpWa+HDJHUe3Ryc5Q5VWemzc3KG4XM73nMWKczOv
        WbAICt/TlZuRvuGFcbmMQ9ey+K7NX7UfsakVTsqtaRTJv7naJSjm+bzkd1ldvx/+27XoUnqC
        8yUVof+1ndueHOzP7Qnaej5hxsqMzQnlm55EZjdsWPWgs6htr9j5hj/+Xz7+PszAMGmO+qV1
        RdwyIq8f3EvLKhRlO5Ny92jwA/bbCm3Kzln87mcZGq7y5Dtd7LSzqnxheyHFKUug6bvIMUfb
        KNHfBgHT3NawxT90bFEOqXpV+/LjPqZFBXoLDhb80Nhovsbe+WjENdnmmPXyR44IuDnPf3n/
        wjTGaTsWHc3f7Gh/qsbcZnuckBJLcUaioRZzUXEiAEqZU7n8AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133921epcas2p2525f5e77b9931ffa1f17db16eea3dae9
References: <20230512133901.1053543-2-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133921epcas2p2525f5e77b9931ffa1f17db16eea3dae9@epcms2p6>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph.

>=40=40 -1014,6 +1014,10 =40=40 int bio_add_hw_page(struct request_queue *q=
, struct bio *bio,
> =C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(bio_try_merge_hw_seg(q,=20bio,=20page,=20len,=20offset,=20same_pag=
e))=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20len;=0D=0A>=C2=
=A0=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0if=20(bio->bi_vcnt=20>=3D=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0min(bio->bi_max_ve=
cs,=20queue_max_segments(q)))=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=
urn=200;=0D=0A>+=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0/*=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20If=20the=20queue=20doesn't=20=
support=20SG=20gaps=20and=20adding=20this=20segment=0D=0A>=20=C2=A0=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20would=
=20create=20a=20gap,=20disallow=20it.=0D=0A>=40=40=20-1023,12=20+1027,6=20=
=40=40=20int=20bio_add_hw_page(struct=20request_queue=20*q,=20struct=20bio=
=20*bio,=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20=
=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=C2=A0=0D=0A>-=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0if=20(bio_full(bio,=20len))=0D=0A>-=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=
-=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(bio->bi_vcnt=20>=3D=20qu=
eue_max_segments(q))=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>-=0D=0A>=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0bvec_set_page(&bio->bi_io_vec=5Bbio->bi_vcnt=5D,=20pag=
e,=20len,=20offset);=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->b=
i_vcnt++;=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bio->bi_iter.bi_s=
ize=20+=3D=20len;=0D=0A>--=20=0D=0A>2.39.2=0D=0A=0D=0AIf=20the=20wrong=20bi=
_max_vecs=20is=20set=20in=20bio_init(e.g.=20bi_max_vec=20=3D=200),=0D=0AI=
=20think=20we=20need=20a=20code=20to=20defend=20against=20page_add.=0D=0AIf=
=20modified=20in=20this=20way,=20it=20may=20be=20added=20to=20bvec=20normal=
ly=20and=0D=0Acause=20inconsistency=20in=20the=20information=20of=20bio.=0D=
=0A=0D=0ABest=20Regards,=0D=0AJinyoung.
