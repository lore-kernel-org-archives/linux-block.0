Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B62C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926AD217F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zPcTTxX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfA2ImE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:42:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49124 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfA2ImE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:42:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T8d8a4182956;
        Tue, 29 Jan 2019 08:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=zPcTTxX01FpkG35+8UypRXklZtX9VaiRUuDoUv7BjSnixVLHb+CQzBf3MSHSQPlS5Sia
 zfw1OxgBv2xMSUWeSDYe5idDyxSFo+6NzFSVH6KERgvZi0Gb6V8F+T6zy960r8fZY5AG
 FvE5bf5ZeK8DNY6ETt5UyLRbY0Q9NjehVy4Mjft7JtUENM8AiHVyh3G/ca4we30/dO6L
 jNjdziygikMiQ9djveuhb/00LEvVu/yRML4nj6wVCDB3U4TPPxnTSKkXCLlg4rqdzI6s
 qo4EgM0IeDbeG8RUWKsmszzR53trrjBlS5fPmteZuvLLUJ/6tkhGRrFIFGpAlVlVC4zx xw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2e32qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:41:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T8fpAI017597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:41:51 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T8fpQC020728;
        Tue, 29 Jan 2019 08:41:51 GMT
Received: from kadam (/197.157.0.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 00:41:50 -0800
Date:   Tue, 29 Jan 2019 11:41:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] floppy: check_events callback should not return a
 negative number
Message-ID: <20190129084144.GD1773@kadam>
References: <20190129083404.47318-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129083404.47318-1-yuyufen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=956
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290066
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

