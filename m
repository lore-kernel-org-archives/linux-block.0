Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3154C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC77207D8
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 13:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irMAWLTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEVNgb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 09:36:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNga (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 09:36:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDNNTL158770;
        Fri, 22 May 2020 13:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=q4iEMKKBFsl3YsjEDz6MJCE6wc50DDr5Q/Qc07Ys0Bw=;
 b=irMAWLTWpYWfvNou3Ds23K9HMo0JjnDqsYnnAtRuiNE1Z5GTylcuZ9H4Hs/WF0y001zK
 oHWsOjU4u2rMRS18ow0XQJEcayPC33FC03wIyIIQOnwwgMUV65lAEthAcoWmHb3R4guK
 MeGVIqpaUhzV31u2ufZcg/OZpPRR60F29so4YfCfCXFbeN4WPjG6xk8E/ECmwIRML9Wh
 4ieQsZFy9uYxiCXM5ia76mxepJJjycI3wJZBP6DK/+RTygpfBv9pcbYiES5yrOxOuXBB
 uZAkVBBzLBMqV3PkTx33D8vp1bg4U/zsMUikPW2Vpwf2/E50PEcZVEsUh4k7FLX83eFA kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127krntfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 13:36:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDSivM174067;
        Fri, 22 May 2020 13:36:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj7gghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 13:36:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MDaKhJ008637;
        Fri, 22 May 2020 13:36:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 06:36:20 -0700
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ftbsp06e.fsf@ca-mkp.ca.oracle.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
        <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
        <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com>
Date:   Fri, 22 May 2020 09:36:18 -0400
In-Reply-To: <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
        message of "Fri, 22 May 2020 09:28:36 -0400")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=901
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 mlxlogscore=924 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> +	if (t->io_opt & (t->physical_block_size - 1))
>>> +		t->io_opt = lcm(t->io_opt, t->physical_block_size);
>
>> Any comment on this patch ?  Note: the patch the patch "nvme: Fix
>> io_opt limit setting" is already queued for 5.8.
>
> Setting io_opt to the physical block size is not correct.

Oh, missed the lcm(). But I'm still concerned about twiddling io_opt to
a value different than the one reported by an underlying device.

Setting io_opt to something that's less than a full stripe width in a
RAID, for instance, doesn't produce the expected result. So I think I'd
prefer not to set io_opt at all if it isn't consistent across all the
stacked devices.

Let me chew on it for a bit...

-- 
Martin K. Petersen	Oracle Linux Engineering
