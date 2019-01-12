Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB8C43612
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 02:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A32A204FD
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 02:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d2bTrNOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfALCer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:34:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfALCer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 21:34:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C2YQH3144399;
        Sat, 12 Jan 2019 02:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2grzZ8KhBlAoecpkfOhrU3PmA2ozXi3hys0ShEeMTqE=;
 b=d2bTrNOGnst0Vt8Wr6FLa7G4u+ZNqg36IPYNBldTg3E1wyG0p0ZKp0d8Eab0VEp2fWme
 HfXRKJBzf1mHtzDUk9c90hhYcMC3Qx0oO7/bupRGjABUxSmn+tl9EIqDRi9c574RJfWB
 ZeUmJPVDkwJqw7ZChcyoJWBHM5GbzQLO+0krgmB6Nuerd7nOT6pLnWVoKVVtOMVwAepK
 ppmOvTRO8nJoAH7dNM/kdMvpUfmmpIfZAAgdgqXEsR65b+9GH+Fnnd8CGtQ5ebd78ASI
 beM4Q8HZ57TDCdGjwCoZ71vqbpFP9oJArqn4pGmmARo3bz+5YMpSK68PX4zcpPjXpuhz vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ptm0uqssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:34:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0C2YONo027807
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:34:24 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0C2YMOg009452;
        Sat, 12 Jan 2019 02:34:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 18:34:22 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling scsi_add_host()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190108205043.3122-1-logang@deltatee.com>
        <20190109184105.GB22070@lst.de>
        <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com>
Date:   Fri, 11 Jan 2019 21:34:19 -0500
In-Reply-To: <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com> (John Garry's
        message of "Thu, 10 Jan 2019 09:11:44 +0000")
Message-ID: <yq1lg3qy578.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> So how about just drop these APIs and let the user set the shost
> protection parameters directly, like other shost parameters,

The protection interfaces here obviously predate the block layer
allocation changes that made this particular issue pop up.

> which should make it a bit clearer when these should be set,
> i.e. before scsi_add_host()?

In general, I am not so keen on the somewhat messy intersection between
the host parameters and the host template. The static host templates
made lots of sense in the days of Seagate ST01 and fixed hardware
capabilities.  But reality is that most modern controllers have to query
firmware interfaces to figure out what their actual capabilities are.

So in this case I think that accessor functions are actually better
because they allow us to print a big fat warning when you twiddle
something you shouldn't post-initialization. So that's something I think
we could--and should--improve.

-- 
Martin K. Petersen	Oracle Linux Engineering
