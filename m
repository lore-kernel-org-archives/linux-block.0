Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A849C433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 15:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382265AbiEMPxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbiEMPxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 11:53:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ECE20CA7E
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 08:53:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdxTi001893;
        Fri, 13 May 2022 15:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=sXL5vCuOHERqD8QfiuBvDX7W6XxrlWnlAHkj0d/1sx8=;
 b=SliWgSPIt68UrAyE1AQ2/8NZz+WCXxGlopsZJpgcfybeX/t41byGVzPIRiKoOID99o3t
 bRSVi0LPgY7obsgOU/pJbOc1eQkL6t6ZzjP/KkLYxJAFoVN76gpORcvk5R0rcI4wPyEn
 CbQxbyj0+u63ADldpxwNEH1nMnCGU8vc5tcMeraG//VotMbiK62bLLmmf6nMoG59bDFe
 ww+aldcLjF4pdbVQATUQ1nA13PttYSRQKNbnmop93mhyBAWXqsloLYAhbM6KNV1clfjq
 jxy3c5+QNq2QzditsiQcqBCciKb9Ou1Nt2Xekz3MARrO0/nHB6I1pBthTQUx4VO8fODU Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9y9c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 15:53:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DFjZt2012168;
        Fri, 13 May 2022 15:53:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf766251-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 15:53:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24DFr1xO034295;
        Fri, 13 May 2022 15:53:05 GMT
Received: from dhcp-10-159-226-103.vpn.oracle.com (dhcp-10-159-226-103.vpn.oracle.com [10.159.226.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf766243-1;
        Fri, 13 May 2022 15:53:05 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: blktests v3 tests/nvme: add tests for error logging
Date:   Fri, 13 May 2022 08:52:50 -0700
Message-Id: <20220513155252.14332-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IHEs12wroBOG8T3Sezrb4jIW60GSYEB-
X-Proofpoint-ORIG-GUID: IHEs12wroBOG8T3Sezrb4jIW60GSYEB-
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blktests tests/nvme: add tests for error logging

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

These test verify the functionality delivered by the follow:
        commit bd83fe6f2cd2 ("nvme: add verbose error logging")

V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
V3 - Add error injector helper functions to nvme/rc


Alan Adamson (2):
  tests/nvme: add helper routine to use error injector
  tests/nvme: add tests for error logging

 tests/nvme/039     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 tests/nvme/rc      |  44 +++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

-- 
2.27.0

