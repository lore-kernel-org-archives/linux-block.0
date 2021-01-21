Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48919C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 01:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CBB2388C
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 01:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbhAUBTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 20:19:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58697 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392154AbhAUBOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 20:14:25 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210121011327epoutp0192889bd7028f49b3efce4c07b3b06fdb~cGjshyC1D2664126641epoutp01c
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 01:13:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210121011327epoutp0192889bd7028f49b3efce4c07b3b06fdb~cGjshyC1D2664126641epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611191608;
        bh=9vQr2GzgZ8KCGqVOlQ6dcP7S4PxwJvGiExe5sk6ZWoE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IRSiuvwopHPPesizU2T4uMDg2ECw5R05Yq7Jxn9CHdn/eGrwzjYAk2D/Ji/qSYxDQ
         jUgsAfIT6uxBwejLktGYZjYw57pvKreagjFzhYDGQw2/BBfV0knctMbY0Ukn+4FMSh
         8PoHwKiP6fCFuDBmbRMTdl8M9AXpcwPSu32jWjtM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210121011326epcas1p34c5a6dfff24ec47b03b8d28ce6560fe6~cGjriZyFj1290312903epcas1p3Z;
        Thu, 21 Jan 2021 01:13:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DLksx3r7Zz4x9Px; Thu, 21 Jan
        2021 01:13:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.CA.10463.535D8006; Thu, 21 Jan 2021 10:13:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210121011324epcas1p3a213069e873fd324a7ce3188558f0782~cGjpnKpBF1550615506epcas1p31;
        Thu, 21 Jan 2021 01:13:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210121011324epsmtrp2787f302d75965a95d86e553ac4912200~cGjpmEUQj1645816458epsmtrp2V;
        Thu, 21 Jan 2021 01:13:24 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-b5-6008d535b62c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.0C.08745.435D8006; Thu, 21 Jan 2021 10:13:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210121011324epsmtip1d7157936078900a8182def9c359c067e~cGjpSJgyT0190001900epsmtip1L;
        Thu, 21 Jan 2021 01:13:24 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, patchwork-bot@kernel.org, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v2] bio: limit bio max size.
Date:   Thu, 21 Jan 2021 09:58:03 +0900
Message-Id: <20210121005803.26052-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmvq7pVY4Eg4cNEhZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QN8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMq6evMlcsEK74vqDVvYGxp1yXYycHBICJhLTut8y
        djFycQgJ7GCUuLXoFpTziVGisW03G4TzmVHiy54eVpiW7hWzmSASuxgl2vpPssBVfXvUwQhS
        xSagI9H39hZYu4hAC5PE7Pf/2EEcZoHHjBJXTraxgVQJA1VNOnObGcRmEVCVOPm5hQXE5hWw
        lth6uIsRYp+8xNPe5cwQcUGJkzOfgNUwA8Wbt85mBhkqIbCHQ6J3Zw87RIOLxPubV6BsYYlX
        x7dA2VISn9/tZYNo6GaUaG6bzwjhTGCUWPJ8GRNElbHEp8+fgRIcQCs0Jdbv0ocIK0rs/D2X
        EWIzn8S7r6DQ4ACK80p0tAlBlKhInGm5zwyz6/nanVATPSQu7H0KFhcSiJWY1niEZQKj/Cwk
        /8xC8s8shMULGJlXMYqlFhTnpqcWGxaYIMfsJkZwstay2ME49+0HvUOMTByMhxglOJiVRHgf
        WXIkCPGmJFZWpRblxxeV5qQWH2I0BYbwRGYp0eR8YL7IK4k3NDUyNja2MDEzNzM1VhLnTTJ4
        EC8kkJ5YkpqdmlqQWgTTx8TBKdXAtODL8yO77ztO+n/mnp+Fowi3uMAP18Vp/TwbuN1r1ea3
        zlxquGn3mraW2TEr/aNObKsKum2VpNb5d8oeK2Uhw+OP/kxarLNkS0rFuflzptxbYvmzedEG
        62C/zaYOjpKbXxxO5X69iHHJVd3HCjP3TE09L8Sn6R6z5u+zz6FZR2f5K58WPz/lokeurl/Q
        aocp0yW+LlqwwN/hRnj1lwrRBRcu7uFjLD+xJ0veaa3qkW+dkdWTitY7bxFbteIii5He6SeG
        WfOti606ygsn5BzOuqlc4fzAT0FyvuuW3lDvgN+Krs9ncD6wWD77OEfeqm1t61/uSZp4yUi5
        gq3J/+/XC0vVWphajyzq3F8+f33NlA1KLMUZiYZazEXFiQAFB2eAXwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK7JVY4Eg439OhZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBlXT95kLlihXXH9QSt7A+NO
        uS5GTg4JAROJ7hWzmboYuTiEBHYwStxe18EMkZCSOH7iLWsXIweQLSxx+HAxRM1HRolL8w6x
        gdSwCehI9L29xQaSEBGYxCRx9toPsEnMAq8ZJboeL2IBqRIGqpp05jbYVBYBVYmTn1vA4rwC
        1hJbD3cxQmyTl3jau5wZIi4ocXLmE7AaZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4brS0djDuWfVB7xAjEwfjIUYJDmYlEd5HlhwJQrwpiZVV
        qUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTA5S07o4sv+F3TiRFCY
        8I1zzD+TUxQ0tk9kl/IUkVc+YP/UNvaNUa7G8/q8a+rn9rb1bz5l8cq2RWa/t4LaLAFV8dvr
        C3qCN7rvnrbgbdcGqQuyCl+LmHgun7Znn6FwJ+rlKa+GLbaspvteRM47rP3O3yt1g+pMfeea
        txXZVzqu6p7XTFoV2bvvQ+4Jz8rvkY5T0r6cK2u59Ubzt+P0X8qBBdn33omdMntpaHKNJ2vV
        k2mfnn2wmXfXNPS93znbxQIm+WZHOoqylr5z1WZZweO23MXxXnmGV1vIE/338TpGE/unhgRy
        Vs/UW7/V+vHDxONqMzyuHfq4Z+3r6epusyr4J/E6LhdSmfKU5ZSikJsSS3FGoqEWc1FxIgCP
        aZy0CgMAAA==
X-CMS-MailID: 20210121011324epcas1p3a213069e873fd324a7ce3188558f0782
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210121011324epcas1p3a213069e873fd324a7ce3188558f0782
References: <CGME20210121011324epcas1p3a213069e873fd324a7ce3188558f0782@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio size can grow up to 4GB when muli-page bvec is enabled.
but sometimes it would lead to inefficient behaviors.
in case of large chunk direct I/O, - 32MB chunk read in user space -
all pages for 32MB would be merged to a bio structure if memory address is
continued phsycally. it makes some delay to submit until merge complete.
bio max size should be limited as a proper size.

When 32MB chunk read with direct I/O option is coming from userspace,
kernel behavior is below now. it's timeline.

 | bio merge for 32MB. total 8,192 pages are merged.
 | total elapsed time is over 2ms.
 |------------------ ... ----------------------->|
                                                 | 8,192 pages merged a bio.
                                                 | at this time, first bio submit is done.
                                                 | 1 bio is split to 32 read request and issue.
                                                 |--------------->
                                                  |--------------->
                                                   |--------------->
                                                              ......
                                                                   |--------------->
                                                                    |--------------->|
                          total 19ms elapsed to complete 32MB read done from device. |

If bio max size is limited with 1MB, behavior is changed below.

 | bio merge for 1MB. 256 pages are merged for each bio.
 | total 32 bio will be made.
 | total elapsed time is over 2ms. it's same.
 | but, first bio submit timing is fast. about 100us.
 |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
      | 256 pages merged a bio.
      | at this time, first bio submit is done.
      | and 1 read request is issued for 1 bio.
      |--------------->
           |--------------->
                |--------------->
                                      ......
                                                 |--------------->
                                                  |--------------->|
        total 17ms elapsed to complete 32MB read done from device. |

As a result, read request issue timing is faster if bio max size is limited.
Current kernel behavior with multipage bvec, super large bio can be created.
And it lead to delay first I/O request issue.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>

---
 block/bio.c               | 17 ++++++++++++++++-
 include/linux/bio.h       | 13 +++----------
 include/linux/blk_types.h |  1 +
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..027503c2e2e7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 
 	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
+	bio->bi_max_size = UINT_MAX;
 }
 EXPORT_SYMBOL(bio_init);
 
+void bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	if (bio->bi_disk != bdev->bd_disk)
+		bio_clear_flag(bio, BIO_THROTTLED);
+
+	bio->bi_disk = bdev->bd_disk;
+	bio->bi_partno = bdev->bd_partno;
+	bio->bi_max_size = blk_queue_get_max_sectors(bio->bi_disk->queue,
+			bio_op(bio)) << SECTOR_SHIFT;
+
+	bio_associate_blkg(bio);
+}
+EXPORT_SYMBOL(bio_set_dev);
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio->bi_max_size - len)
 				*same_page = false;
 				return false;
 			}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..b9803e80c259 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
 		return true;
 
 	return false;
@@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
 extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
 extern unsigned int bvec_nr_vecs(unsigned short idx);
 extern const char *bio_devname(struct bio *bio, char *buffer);
-
-#define bio_set_dev(bio, bdev) 			\
-do {						\
-	if ((bio)->bi_disk != (bdev)->bd_disk)	\
-		bio_clear_flag(bio, BIO_THROTTLED);\
-	(bio)->bi_disk = (bdev)->bd_disk;	\
-	(bio)->bi_partno = (bdev)->bd_partno;	\
-	bio_associate_blkg(bio);		\
-} while (0)
+extern void bio_set_dev(struct bio *bio, struct block_device *bdev);
 
 #define bio_copy_dev(dst, src)			\
 do {						\
 	(dst)->bi_disk = (src)->bi_disk;	\
 	(dst)->bi_partno = (src)->bi_partno;	\
+	(dst)->bi_max_size = (src)->bi_max_size;\
 	bio_clone_blkg_association(dst, src);	\
 } while (0)
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261b3b..e5dd5b7d8fc1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -270,6 +270,7 @@ struct bio {
 	 */
 
 	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned int		bi_max_size;	/* max data size we can hold */
 
 	atomic_t		__bi_cnt;	/* pin count */
 
-- 
2.28.0

