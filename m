Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C9AC43381
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD362173C
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qJ1rYtc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfC3BoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:44:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfC3BoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 21:44:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2U1cR1A150783;
        Sat, 30 Mar 2019 01:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=mekobCvzhxT3poVMFYifuTbkzkKjAcHew1lIGTSnPto=;
 b=qJ1rYtc0ZExkxhBDL2HTzHsOekOv8YIo92q0ziANmf9GSskAMlIfhnLhk2CYEcOHSv/s
 SXzsb3K/jXs+DccoYa1eAJS7hCNVNMfB3NuQ7ULwC1kmi/nePwXCmkrQGXC4f8QYComG
 cspP/LQwFVDMirLgV/hf2DMTa58dNHRPvHHHlbJuL+tFaa6YVHH47FPxM42IYSwLaATV
 hbv/XeUheZ1IArFNUszzDfKng1TKWeNJh/o8ONtYtPyuGncPAHXdKEb0bQQC/D3FFOb2
 38tbBtaDg/XarzKd/I3gOg9kHROeLf8cIAAmicS192dyRo8lnbD9tLQZTe6LMZHImJN7 zA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2re6djybcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 01:44:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2U1hsvP029581
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 01:43:54 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2U1hpBo012205;
        Sat, 30 Mar 2019 01:43:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 18:43:51 -0700
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        axboe@kernel.dk, tytso@mit.edu
Subject: Re: [PATCH v3 1/3] block: introduce submit_bio_verify()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190329142346.1677-1-bob.liu@oracle.com>
        <20190329142346.1677-2-bob.liu@oracle.com>
        <0FA09E34-400A-473D-9F3A-3014F79B2A82@dilger.ca>
Date:   Fri, 29 Mar 2019 21:43:48 -0400
In-Reply-To: <0FA09E34-400A-473D-9F3A-3014F79B2A82@dilger.ca> (Andreas
        Dilger's message of "Fri, 29 Mar 2019 16:22:18 -0600")
Message-ID: <yq1muldp25n.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=901 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903300010
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andreas,

> How does this interact (if at all) with bio_integrity_verify() code?
> Does it mean if e.g. XFS is on storage with T10-PI that only one or
> the other can be used,

Yes. Although if your storage is sophisticated enough to be T10 PI
capable, you are probably using redundancy inside the array and
therefore not MD.

But I think there are other problems with the callback approach. See my
impending email.

-- 
Martin K. Petersen	Oracle Linux Engineering
