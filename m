Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbiEJQrz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiEJQrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 12:47:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BAB36D1
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 09:43:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AF0bhF024483;
        Tue, 10 May 2022 16:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=L7WT2PZP9lCaY2OiXLy2iEOGPpGUZCS/JZbi4PID7Dc=;
 b=M8bhntWCC6PDHsuYIlTZIUyuBrnj1bfVqGCi+F1ODHznsG3mg8reMk+38yEtnjV3Eubv
 TXvxXT89dpXdH2VW0Wh0/ryF4v/Zgb9cT+14zu8HK1MyNe5AXPdWWnSm4GP3fI4xo/yB
 jrJ5DwxTAt0a+t5dLDtSF/ualCsQd4I3SAWCbTQBy62NLKMywfWbohnAA5D8sv/u/cx8
 B6JhXHlSSpRZICCt28eDx7lA9rJEz8usgW185ElG7EjC/gm53+S6C3oeB9fOUWi50BI9
 cWirqiujAn1cZ/j3oRU2e72TT7glBYRP+94dQHPQ6fuS6ekpkQdkzHr7gh/e3ofqLvWl gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2fd54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:43:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AGPdiB036801;
        Tue, 10 May 2022 16:43:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf738sjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:43:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24AGhHnR030233;
        Tue, 10 May 2022 16:43:17 GMT
Received: from dhcp-10-39-195-127.vpn.oracle.com (dhcp-10-39-195-127.vpn.oracle.com [10.39.195.127])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf738sj7-1;
        Tue, 10 May 2022 16:43:16 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: tests/nvme: add tests for error logging
Date:   Tue, 10 May 2022 12:43:03 -0400
Message-Id: <20220510164304.86178-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gmfs7kvyFJEcD1PR6o1Rphby7qcF59GC
X-Proofpoint-GUID: gmfs7kvyFJEcD1PR6o1Rphby7qcF59GC
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

These test verify the functionality delivered by the follow:
        commit bd83fe6f2cd2 ("nvme: add verbose error logging")

V2 - Update from suggestions from shinichiro.kawasaki@wdc.com


Alan Adamson (1):
  tests/nvme: add tests for error logging

 tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 ++
 2 files changed, 192 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

-- 
2.27.0

