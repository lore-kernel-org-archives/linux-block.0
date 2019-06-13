Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6911C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC0720896
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 19:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EztMCVPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfFMTTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:19:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 15:19:18 -0400
X-Greylist: delayed 5688 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 15:19:17 EDT
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DHhgvL054116;
        Thu, 13 Jun 2019 17:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=j84ZJa4X+x5WSx5QJGHY2SflMYwM961qM/LO80WmcPg=;
 b=EztMCVPD0NBZOtvnuD9FgBhXYSoJVTpJ7JlEchc9rGYRkL+CmJ65ucac6fszbb3XVUvq
 2OimAdIwg50EFJXg1bAlJso1vF7yGQ9Gg4ioxO/UusJr8WLJTUqhXDD8hiOVRkV8PYEY
 dMXfE365EzZu0RHvl13HSWqLXoYbHuVSIVvFRHDdSAGGL+fjJ4rbMJzr/+FNSkZpLW73
 ym0tLFcegKcyVX3emEZXuE/sfUFU1jh0lkaNa7Xi2r9SXupeqZi+JUrYqMSyKv7y22tW
 1BMa2KYf3RheLhPP9sxsCmERAA8VVeOWmJllb88F2SPLHnKfPo3S8FLSDt0k/2mMNtaB +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t04ynu1ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 17:43:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DHhrXH153828;
        Thu, 13 Jun 2019 17:43:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t04j0kg1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 17:43:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DHh2rF004452;
        Thu, 13 Jun 2019 17:43:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 10:43:02 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, hch@lst.de, hare@suse.com
Subject: Re: [PATCH V2 2/2] block: add more debug data to print_req_err
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
        <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
        <d369fbbd-0d98-b804-619b-23049ee12398@acm.org>
        <yq1d0jhtoii.fsf@oracle.com>
        <be1e3944-4f5a-ca40-1496-614058fd3bb2@acm.org>
Date:   Thu, 13 Jun 2019 13:43:00 -0400
In-Reply-To: <be1e3944-4f5a-ca40-1496-614058fd3bb2@acm.org> (Bart Van Assche's
        message of "Thu, 13 Jun 2019 10:05:12 -0700")
Message-ID: <yq1tvcts7ob.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130130
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> I'm in favor of improving consistency. But are you sure that we can
> modify the tracing output format without breaking any applications?

Chaitanya is already working on enhancing tracing. I seem to recall
blktrace being fairly flexible with what it digests.

On top of that, we also have the option of changing the error path
output as opposed to changing the tracing ditto should that be an issue.

My main point is that there is probably going to be close to a 1:1
mapping between what you would want to see in an error message and what
you would want to see in tracing. So it would be good to use the same
plumbing for both.

-- 
Martin K. Petersen	Oracle Linux Engineering
