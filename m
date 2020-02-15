Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C44EC35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA32207FF
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rpj30XWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBOBid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:38:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15619 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBOBid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 20:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581730714; x=1613266714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aNsmvkaH4ULgQFsXfejZzWVM/4puB/idKPxtDie+r7g=;
  b=rpj30XWc1bmOihyULmDBkXeJ9ZucVFmYplKKQtJu0RORh29eScvUiEDd
   EDbzp9eiEwV8ehy1XMu1ABRVHo22S4y4evH72J/czoWf/jDE21jODaZE2
   Rnvb+010FrMQHmmG20//iVIr65D9DcSrTi3R4QcBXDlSLAHHoH7LZsnw+
   92EtQh73YpM3D0NOnspLc+PkVL33qyYOyDtGy2ZffeGkeFbI0dofcOJAQ
   Xb1p97ZHuHn+6w6AbMhLn9izk3oU+TR3iOsHTwRh+L92fVpzszE/yXYcC
   3nXvSy3VKdYZ8S7mCKcVnwJd4o2Vb+arqgQhDLkXAixQabmx9PvLoDoyf
   Q==;
IronPort-SDR: PeRzGmpzuZKik4w6ZMTookROb7t2rHyfwoIAO7N/GOmort6jXsgeNmPlDc0WHc0GGrE7kawc1f
 ekywVfvgUD4y71v+sJnXrmIW7JgnrPfUj1EJWSJ/ZQn0r5rISGwhq3Ax0TvTvS5maA1VMcs/dp
 1TCa0Y336L7y4npF3QM1pluuMtVtUu2xF4hLZsdqyRfmR3Rhtvdf1JCD29orUwciY3NFvs9cOO
 AxmUBSG22sS90s+uI7hbZbSTDmLLHBmwnxNpGXp6/MHcwLwn/BCnpuUpZAtYJczNJTjqQlDDwI
 XV8=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="130431803"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:33 +0800
IronPort-SDR: da6TGbNBDKTmFCBAVXMQkTpkayJTNZWuPNsJU3tDrDFwQQVqu/2B5hQxrKFrisChJTZouAGHMK
 mbsTmnpMSDV7NGii20DNrV4D8AzNY+48O15BWhfNOCw2GgKr77ZrU48CbOHVuVB6HK+T/rhh0L
 IL5pkpSb+RjQBwl1AM0Xu3PFE3z7JnqZWWrH9bNe17DDDKcx7qgWMJGTU5D8uJeMY0D3sY4PoW
 jHXr9EVxDueNqxkTfHBacuvT2+FiCLWKaBCDyA5mu6zDE+CHhABwG2pEGBDZ+RukORQA+psaDx
 7rJLoLFHWAb5bwvkQ9/HUyRP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:31:17 -0800
IronPort-SDR: mXXkIDZ3lJFYANe+amb8ctB+mL/we5+Tfq9lkGy7gt06t4kQ1JOok4j/pEZcYJ71a6Jg6Bleu4
 Nc6pGJ56wnGo4gBkA2z8SXd/D1elvNpZwYqfowxvrNFEHniDppGXsBxspymEBDosAAkp5STU66
 iCNAfmue1hVRPlpDbfvdk1x9cTOJ/uz2KFOqOsJBSWeSKsvp0eknl9MRP4NplWEdI4kJ0jMrIF
 s3bB/MBt5eb5XA8VKq/iq40eyR4ZXduXN+498vlF6dnufcYA4AisMVukZb8qbVdE48Lz2K4vZ/
 p6c=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:32 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH blktests V2 0/3] nvme: add cntlid and model testcases
Date:   Fri, 14 Feb 2020 17:38:28 -0800
Message-Id: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

This is a small patch-series which adds two new testcases for
setting up controller IDs and model from configfs.

I've tested these testcases with and without newly added attribute.
If they still fail on your system, I'll creata a new vm and test it
on nvme-5.5 branch.

Regards,
Chaitanya

Changes from V1:-

1. Reorg series into three patches.
2. Fix shellcheck warnings (and shellcheck on my machine :P)
3. Fix test description.
4. For model related testcases declare global variable model and use 
        nvme list | grep "${nvmedev}n1" | grep -o "$model"
   instead of 
        nvme list | grep ${nvmedev}n1 | grep -q test~model.

Chaitanya Kulkarni (3):
  nvme: allow target to set cntlid min/max & model
  nvme: test target cntlid min cntlid max
  nvme: test target model attribute

 tests/nvme/033     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 tests/nvme/034     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 tests/nvme/rc      | 25 ++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

 Here is the test result with and without cntlid and model attributes :-
Shellcheck :-
# /bin/shellcheck -x tests/nvme/rc tests/nvme/033 tests/nvme/034 
# echo $?
0
# for i in 033 034; do ./check tests/nvme/${i} ; done 
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
    attr_cntlid_[min|max] not found
nvme/034 (Test NVMeOF target model attribute)                [not run]
    attr_model not found

# for i in 033 034; do ./check tests/nvme/${i} ; done 
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
    runtime  1.706s  ...  1.513s
nvme/034 (Test NVMeOF target model attribute)                [passed]
    runtime  1.672s  ...  1.510s

-- 
2.22.1

