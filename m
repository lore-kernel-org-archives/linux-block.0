Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E252CA9EA0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 06:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1307F20873
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 06:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sam8O0Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfJ1GN4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:13:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfJ1GN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 02:13:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S69CZs096108;
        Mon, 28 Oct 2019 06:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vAOl6JM4jiL17x/cri2Kvvp462gTFxiihQiyHs26x2Q=;
 b=sam8O0Lp0PKRtYT6FRVT1AgDMz4QySEmbo0Ntlld+kunSachd1chDZF8kOYrvSlh60do
 VHEL4XimCBYezYrzCfe2xnamNPHg0VpY5TLKD7FbBEklNQOdVFHC8b9n8YicjZXBf7Vw
 0ChEOPVXQSfC8gwQo2UxWJFU2DF79CpJSjskcEATqLPpAf8CFacEAjn3bi3YkL3ivQ/X
 CF6DJ7bieIsHBLDllEoA1w6ZLRoq73nA8jdcmEexjG0NIrtnJoIeVRgj88BuAvgLJg2e
 BtpDr2zkVAaSEu6kg2dadHcw5mVKkVja/A8YGpG5puxZXiZs6zxmQx6TfLUKZSBAh4Oc 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vvumf4kgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 06:13:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S67bvP079225;
        Mon, 28 Oct 2019 06:13:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vw09f36y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 06:13:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9S6Dprg005173;
        Mon, 28 Oct 2019 06:13:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 27 Oct 2019 23:13:50 -0700
Date:   Mon, 28 Oct 2019 09:13:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay Joshi <Ajay.Joshi@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] null_blk: return fixed zoned reads > write pointer
Message-ID: <20191028061342.GA1922@kadam>
References: <20191023130623.GA3196@mwanda>
 <658eaf70-beaf-240c-199a-e54a22d7095d@kernel.dk>
 <CY4PR04MB3719FA7043998B66D0E35BBA8F660@CY4PR04MB3719.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3719FA7043998B66D0E35BBA8F660@CY4PR04MB3719.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280062
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Argh...  Sorry.  No, I just read the code badly.  Forget about it.

regards,
dan carpenter

