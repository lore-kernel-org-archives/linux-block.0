Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F4C4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B2C218A6
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FhIHo14L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfC2Rqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:46:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729658AbfC2Rqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:46:33 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2THho3q014324
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=RbTeFel0E88w0B4T/74Hp1JsrJFcU4lFW56ilObLSKc=;
 b=FhIHo14LndU9u1go7qHX0sqLa26SZDaM9n3apxQuoD8UX8ioY0484zxuMY8P6ablRTit
 fYyW1m6zlneWWrsFIciYmS5CI+bsT4AW9AfRD68awTJCMci0GWcrnNaAWIVzrgDU/aCX
 KcPOX635eAWUNACpgbAc1byKScgvpLVRfGA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rhb9n2x0d-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:32 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 10:46:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id EB2F062E1BDA; Fri, 29 Mar 2019 10:46:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <neilb@suse.com>, <xni@redhat.com>,
        <ncroxon@redhat.com>, <axboe@kernel.dk>, <stable@vger.kernel.org>,
        David Jeffy <djeffery@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 1/3] Don't jump to compute_result state from check_result state
Date:   Fri, 29 Mar 2019 10:46:15 -0700
Message-ID: <20190329174617.3670341-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329174617.3670341-1-songliubraving@fb.com>
References: <20190329174617.3670341-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Nigel Croxon <ncroxon@redhat.com>

Changing state from check_state_check_result to
check_state_compute_result not only is unsafe but also doesn't
appear to serve a valid purpose.  A raid6 check should only be
pushing out extra writes if doing repair and a mis-match occurs.
The stripe dev management will already try and do repair writes
for failing sectors.

This patch makes the raid6 check_state_check_result handling
work more like raid5's.  If somehow too many failures for a
check, just quit the check operation for the stripe.  When any
checks pass, don't try and use check_state_compute_result for
a purpose it isn't needed for and is unsafe for.  Just mark the
stripe as in sync for passing its parity checks and let the
stripe dev read/write code and the bad blocks list do their
job handling I/O errors.

Repro steps from Xiao:

These are the steps to reproduce this problem:
1. redefined OPT_MEDIUM_ERR_ADDR to 12000 in scsi_debug.c
2. insmod scsi_debug.ko dev_size_mb=11000  max_luns=1 num_tgts=1
3. mdadm --create /dev/md127 --level=6 --raid-devices=5 /dev/sde1 /dev/sde2 /dev/sde3 /dev/sde5 /dev/sde6
sde is the disk created by scsi_debug
4. echo "2" >/sys/module/scsi_debug/parameters/opts
5. raid-check

It panic:
[ 4854.730899] md: data-check of RAID array md127
[ 4854.857455] sd 5:0:0:0: [sdr] tag#80 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 4854.859246] sd 5:0:0:0: [sdr] tag#80 Sense Key : Medium Error [current]
[ 4854.860694] sd 5:0:0:0: [sdr] tag#80 Add. Sense: Unrecovered read error
[ 4854.862207] sd 5:0:0:0: [sdr] tag#80 CDB: Read(10) 28 00 00 00 2d 88 00 04 00 00
[ 4854.864196] print_req_error: critical medium error, dev sdr, sector 11656 flags 0
[ 4854.867409] sd 5:0:0:0: [sdr] tag#100 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 4854.869469] sd 5:0:0:0: [sdr] tag#100 Sense Key : Medium Error [current]
[ 4854.871206] sd 5:0:0:0: [sdr] tag#100 Add. Sense: Unrecovered read error
[ 4854.872858] sd 5:0:0:0: [sdr] tag#100 CDB: Read(10) 28 00 00 00 2e e0 00 00 08 00
[ 4854.874587] print_req_error: critical medium error, dev sdr, sector 12000 flags 4000
[ 4854.876456] sd 5:0:0:0: [sdr] tag#101 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 4854.878552] sd 5:0:0:0: [sdr] tag#101 Sense Key : Medium Error [current]
[ 4854.880278] sd 5:0:0:0: [sdr] tag#101 Add. Sense: Unrecovered read error
[ 4854.881846] sd 5:0:0:0: [sdr] tag#101 CDB: Read(10) 28 00 00 00 2e e8 00 00 08 00
[ 4854.883691] print_req_error: critical medium error, dev sdr, sector 12008 flags 4000
[ 4854.893927] sd 5:0:0:0: [sdr] tag#166 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 4854.896002] sd 5:0:0:0: [sdr] tag#166 Sense Key : Medium Error [current]
[ 4854.897561] sd 5:0:0:0: [sdr] tag#166 Add. Sense: Unrecovered read error
[ 4854.899110] sd 5:0:0:0: [sdr] tag#166 CDB: Read(10) 28 00 00 00 2e e0 00 00 10 00
[ 4854.900989] print_req_error: critical medium error, dev sdr, sector 12000 flags 0
[ 4854.902757] md/raid:md127: read error NOT corrected!! (sector 9952 on sdr1).
[ 4854.904375] md/raid:md127: read error NOT corrected!! (sector 9960 on sdr1).
[ 4854.906201] ------------[ cut here ]------------
[ 4854.907341] kernel BUG at drivers/md/raid5.c:4190!

raid5.c:4190 above is this BUG_ON:

    handle_parity_checks6()
        ...
        BUG_ON(s->uptodate < disks - 1); /* We don't need Q to recover */

Cc: <stable@vger.kernel.org> # v3.16+
OriginalAuthor: David Jeffery <djeffery@redhat.com>
Cc: Xiao Ni <xni@redhat.com>
Tested-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: David Jeffy <djeffery@redhat.com>
Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/raid5.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c033bfcb209e..4204a972ecf2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4223,26 +4223,15 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
 	case check_state_check_result:
 		sh->check_state = check_state_idle;
 
+		if (s->failed > 1)            
+		    break;
 		/* handle a successful check operation, if parity is correct
 		 * we are done.  Otherwise update the mismatch count and repair
 		 * parity if !MD_RECOVERY_CHECK
 		 */
 		if (sh->ops.zero_sum_result == 0) {
-			/* both parities are correct */
-			if (!s->failed)
-				set_bit(STRIPE_INSYNC, &sh->state);
-			else {
-				/* in contrast to the raid5 case we can validate
-				 * parity, but still have a failure to write
-				 * back
-				 */
-				sh->check_state = check_state_compute_result;
-				/* Returning at this point means that we may go
-				 * off and bring p and/or q uptodate again so
-				 * we make sure to check zero_sum_result again
-				 * to verify if p or q need writeback
-				 */
-			}
+			/* Any parity checked was correct */
+			set_bit(STRIPE_INSYNC, &sh->state);
 		} else {
 			atomic64_add(STRIPE_SECTORS, &conf->mddev->resync_mismatches);
 			if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery)) {
-- 
2.17.1

