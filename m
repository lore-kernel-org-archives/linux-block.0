Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC4C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 03:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2023120838
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 03:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AlNDBD8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfGNDoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 23:44:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27188 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfGNDoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 23:44:22 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190714034419epoutp028e9dcddc3753dd6fd7b59de1ac10328d~xKTaBx0ue3080630806epoutp02S
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 03:44:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190714034419epoutp028e9dcddc3753dd6fd7b59de1ac10328d~xKTaBx0ue3080630806epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563075859;
        bh=51EVK/VVBV4bQIfR6AA8vvn+T0TomM5j6lduh/y2oCw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=AlNDBD8FvU1mxLfDaE9+r3JpY6VmURlTK2kgKGc1qDhTK7W0mFnYt1ECJhS2j6xuW
         HnyPkuEU6p6pkKL7ZdzZW7hCwidGUNA7AKHY1FbsfSBf2yg8mPM3epHximEshpDSLt
         JJwKhTB6hp6M/O72g7QjpWjjYXWr0PmHQ3+B0jdk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190714034418epcas2p3296a1f5033d55ce2d383b28d29f0db61~xKTY0R_Qe3243732437epcas2p3_;
        Sun, 14 Jul 2019 03:44:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45mXb440DBzMqYll; Sun, 14 Jul
        2019 03:44:16 +0000 (GMT)
X-AuditID: b6c32a45-ddfff7000000103c-19-5d2aa510dce2
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.9B.04156.015AA2D5; Sun, 14 Jul 2019 12:44:16 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH V2] mpt3sas: support target smid for [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "sreekanth.reddy@broadcom.com" <sreekanth.reddy@broadcom.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
Date:   Sun, 14 Jul 2019 12:44:15 +0900
X-CMS-MailID: 20190714034415epcms2p25f9787cb71993a30f58524d2f355b543
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmqa7AUq1Yg6UbxS0+rtjFbvHwnbPF
        ohvbmCz23tK2uLxrDptF9/UdbBbLj/9jsvjVyW3x7PQBZou5rxuYLBZtfc9qsWHeLRaL7pMe
        FusPTWCzmPn1KbvFszMxDgIes+6fZfPYOesuu8eERQcYPT4+vcXi0bdlFaPH501yAWxROTYZ
        qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
        hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQv0ihNzi0vz0vWS83OtDA0MjEyBKhNyMn63
        zmItmChU8WZrB3sD422+LkZODgkBE4mTbX/Yuhi5OIQEdjBKnFz6kKWLkYODV0BQ4u8OYZAa
        YQF3iQufdrGChIUE5CV+vDKACGtKvNt9hhXEZhNQl2iY+ooFZIyIwH4miY0fN7CAJJgFlrFI
        3O8ygNjFKzGj/SkLhC0tsX35VkYIW1Ti5uq37DD2+2PzoeIiEq33zjJD2IISD37uZgS5QUJA
        QuLeOzsIs15iywoLkLUSAi2MEjferIVq1ZdofP4RbBWvgK/EgWWz2EBsFgFVieWPO5kgalwk
        HkxoZIQ4U15i+9s5zCAzmYH+Wr9LH2K8ssSRW1CP8El0HP7LDvPIjnlPoKYoS3w8dAjqSEmJ
        5Zdes0HYHhLzOxaB2UICgRIPv/xnm8AoPwsRtLOQ7J2FsHcBI/MqRrHUguLc9NRiowJD5Njc
        xAhOsFquOxhnnPM5xCjAwajEw7uDWytWiDWxrLgy9xCjBAezkgjvqv/qsUK8KYmVValF+fFF
        pTmpxYcYTYHen8gsJZqcD0z+eSXxhqZGZmYGlqYWpmZGFkrivJu5b8YICaQnlqRmp6YWpBbB
        9DFxcEo1MF6RWjc1ZMnmr0/nu7nPaNypkXHS6Y+E7HW1yykXAqenxR77pL2291QW7/P0Y1sv
        KP9Uq0xrv9gxee/eWGal5IVqVZOZbsxemZB3OmKt55X67cdaJq5X9t98PuGT9vX6NXNEtY8/
        fOJhqWF6Re6zbOb3Fzujuq4mcbi3Flzf8yzI4XKCaKbOnwtKLMUZiYZazEXFiQCrMirrxgMA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190714034415epcms2p25f9787cb71993a30f58524d2f355b543
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
to /dev/mpt3ctl.  If the given task_type is either abort task or query
task, it may need a field named "Initiator Port Transfer Tag to Manage"
in the IU.

Current code does not support to check target IPTT tag from the
tm_request.  This patch introduces to check TaskMID given from the
userspace as a target tag.  We have a rule of relationship between
(struct request *req->tag) and smid in mpt3sas_base.c:

3318 u16
3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
3320         struct scsi_cmnd *scmd)
3321 {
3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
3323         unsigned int tag = scmd->request->tag;
3324         u16 smid;
3325
3326         smid = tag + 1;

So if we want to abort a request tagged #X, then we can pass (X + 1) to
this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
abort the first outstanding smid which is legacy behaviour.

Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c14d35..f6b8fd90610a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
 		if (priv_data->sas_target->handle != handle)
 			continue;
 		st = scsi_cmd_priv(scmd);
-		tm_request->TaskMID = cpu_to_le16(st->smid);
-		found = 1;
+
+		/*
+		 * If the given TaskMID from the user space is zero, then the
+		 * first outstanding smid will be picked up.  Otherwise,
+		 * targeted smid will be the one.
+		 */
+		if (!tm_request->TaskMID || tm_request->TaskMID == st->smid) {
+			tm_request->TaskMID = cpu_to_le16(st->smid);
+			found = 1;
+		}
 	}
 
 	if (!found) {
-- 
2.16.1

