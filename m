Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537EE7C4FA
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 20:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbjJDUUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244549AbjJDUUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 16:20:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB19C6
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 13:20:27 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394K6i6L032592;
        Wed, 4 Oct 2023 20:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=60uuHAhjbFNbrxsW4mTGZK1/QN2qvb773gv1YRF42vM=;
 b=R5o8UGUAU/lfCoEiI9SCAAroTjs2TykkUyRzj3OwRAGCWVA1uYJcQekIosNGTn94Wlz9
 RDQWRA+9JHJtxjRQPALo6U97OKDhFJWwa15hY6gPUuXRZDO3IQkm0NXacSifFH2SWRMW
 lwCQfKvEZzQIGRpRT9KQipz9HyKB1X0r4GIC15J1qJqvE3woUMlZ19fHSMGos6FVOAhn
 dWvCT7WmQ2bytO5PCk2x9E7aNlgCpKJN5sEkCz97qJ5yhak5QHB5M1QnUutE6ICsELkk
 9IVbwo1xoQrtG8qfn8Vt3Zv5Rm9VmsXVDqazUs4Coe0E95xsrUKJjmSoJimIZTzKsQNs 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thdm6j46h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394K7dRg007199;
        Wed, 4 Oct 2023 20:20:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thdm6j460-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394K8wHS006672;
        Wed, 4 Oct 2023 20:19:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07kb642-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:19:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394KJw482622066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 20:19:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43205805B;
        Wed,  4 Oct 2023 20:19:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E08B58055;
        Wed,  4 Oct 2023 20:19:58 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.54.52])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 20:19:58 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, ndesaulniers@google.com,
        nathan@kernel.org, jarkko@kernel.org, okozina@redhat.com
Subject: [PATCH v8 0/3] generic and PowerPC SED Opal keystore
Date:   Wed,  4 Oct 2023 15:19:54 -0500
Message-Id: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QNt4rnHyHauUo92tZB1p6o7Cl947Cxla
X-Proofpoint-ORIG-GUID: 27DqnB4yWvIFe9Uk43lrHA5qVak4umQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=732
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040148
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

This patchset has gone through numerous rounds of review and
all comments/suggetions have been addressed. The reviews have
covered all relevant areas including reviews by block and keyring
developers as well as the SED Opal maintainer.

TCG SED Opal is a specification from The Trusted Computing Group
that allows self encrypting storage devices (SED) to be locked at
power on and require an authentication key to unlock the drive.

PowerPC/pseries versions of key functions provide read/write access
to SED Opal keys in the PLPKS keystore.

The SED block driver has been modified to read the SED Opal
keystore to populate a key in the SED Opal keyring. Changes to the
SED Opal key will be written to the SED Opal keystore.


Changelog
v8:     - rebased to 6.6-rc4
	- fixed issues using clang (thanks Nathan Chancellor and Nick
	  Desaulniers)
	- fixed crash if PLPKS is not present for pseries (thanks Michael
	  Ellerman)

v7:     - rebased to for-6.5/block

v6:     - squashed two commits (suggested by Andrew Donnellan)

v5:     - updated to reflect changes in PLPKS API

v4:
        - scope reduced to cover just SED Opal keys
        - base SED Opal keystore is now in SED block driver
        - removed use of enum to indicate type
        - refactored common code into common function that read and
          write use
        - removed cast to void
        - added use of SED Opal keystore functions to SED block driver

v3:
        - No code changes, but per reviewer requests, adding additional
          mailing lists(keyring, EFI) for wider review.

v2:
        - Include feedback from Gregory Joyce, Eric Richter and
          Murilo Opsfelder Araujo.
        - Include suggestions from Michael Ellerman.
        - Moved a dependency from generic SED code to this patchset.
          This patchset now builds of its own.




Greg Joyce (3):
  block:sed-opal: SED Opal keystore
  block: sed-opal: keystore access for SED Opal keys
  powerpc/pseries: PLPKS SED Opal keystore support

 arch/powerpc/platforms/pseries/Kconfig        |   6 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../powerpc/platforms/pseries/plpks_sed_ops.c | 131 ++++++++++++++++++
 block/Kconfig                                 |   1 +
 block/sed-opal.c                              |  18 ++-
 include/linux/sed-opal-key.h                  |  26 ++++
 6 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c
 create mode 100644 include/linux/sed-opal-key.h

-- 
gjoyce@linux.vnet.ibm.com

