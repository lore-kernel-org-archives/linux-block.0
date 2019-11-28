Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A82C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 12:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986BB217C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U899dvbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfK1MRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:17:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 07:17:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xASCEURn041078;
        Thu, 28 Nov 2019 12:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=K23tF4ZOTDK2mqDQjS6SPO2vyRMwZ30j/1NOK4W0JhU=;
 b=U899dvbj2nf503rUrhC7bjlnabTEc8CnGq3kxTbIN9FQZZ7PaHselctxJP0PdlYJaLh1
 MtUr7y3iYlfnHUUoy7vW84HeRpysuJAHISh6hp36cHyPZ8CrfKPoUBbZerKOHfreJwJl
 7UyhVeXac0Z2hHde+5XqVvg+llnJGS44sBpSHGrgmhKkhT/zKgScPs5ijVSg3N9rSZEt
 0MpHQyi4PugxpNgdpMGeUxSXJyw4X+sETczYGhlCdIvjimklQs6DGtd17fc/S8IXirJi
 TkpL89TnxKaDyZDfgmvkf9es+AiGbWfo8LmUTCQ6BreW71hxMJ8MdO+fmzWmLT2jn2tT Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqqkbnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 12:15:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xASCEOYE100925;
        Thu, 28 Nov 2019 12:15:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2why49ykr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 12:15:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xASCFD2B023073;
        Thu, 28 Nov 2019 12:15:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Nov 2019 04:15:12 -0800
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        "\(Exiting\) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1573456283.git.baolin.wang@linaro.org>
        <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
        <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
        <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
        <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
        <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
        <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
        <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
        <20191127090023.GA23040@infradead.org>
Date:   Thu, 28 Nov 2019 07:15:09 -0500
In-Reply-To: <20191127090023.GA23040@infradead.org> (Christoph Hellwig's
        message of "Wed, 27 Nov 2019 01:00:23 -0800")
Message-ID: <yq1v9r46vua.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911280108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911280108
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> equivalent to SCSI logical units and nvme namespace, just with a
> pretty idiotic design decision that only allows I/O to one of them at
> a time.  The block layer way to deal with them is to use a shared
> tagset for multiple request queues, which doesn't use up a whole lot
> of resources.  The only hard part is the draining when switching
> between partitions, and there is no really nice way to deal with that.
> If requests are batched enough we could just drain and switch every
> time an other partition access comes in.

This mirrors single_lun in SCSI closely. I was hoping we could
eventually get rid of that travesty but if MMC needs something similar,
maybe it would be good to move that plumbing to block?

-- 
Martin K. Petersen	Oracle Linux Engineering
