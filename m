Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E9C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01CB2082E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDDPaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:30:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfDDPaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 11:30:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34FQxST090390
        for <linux-block@vger.kernel.org>; Thu, 4 Apr 2019 11:30:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rnktqats8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 11:30:18 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <anoo@linux.ibm.com>;
        Thu, 4 Apr 2019 16:30:17 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 16:30:15 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34FUEwf59834470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 15:30:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929C6BE051;
        Thu,  4 Apr 2019 15:30:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B71BE054;
        Thu,  4 Apr 2019 15:30:14 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 15:30:14 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Apr 2019 10:31:01 -0500
From:   Adriana Kobylak <anoo@linux.ibm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, medadyoung@gmail.com, openbmc@lists.ozlabs.org,
        nbd@other.debian.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd:clear NBD_BOUND flag when NBD connection is closed
In-Reply-To: <20190403174908.jk6xuhzvn2gm2l2g@MacBook-Pro-91.local>
References: <1544509023-18923-1-git-send-email-medadyoung@gmail.com>
 <a1da3fff285fe13d04522f1a6e72bdc1@linux.vnet.ibm.com>
 <7e192d24976532141c8c985329f5ca1c@linux.vnet.ibm.com>
 <20190403174908.jk6xuhzvn2gm2l2g@MacBook-Pro-91.local>
X-Sender: anoo@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 19040415-0012-0000-0000-000017227227
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184257; UDB=6.00620066; IPR=6.00965010;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 15:30:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040415-0013-0000-0000-000056C008B1
Message-Id: <de0564ed9e5316e5fe6c30c08a0ddec2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040099
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-04-03 12:49, Josef Bacik wrote:
> On Wed, Apr 03, 2019 at 12:13:53PM -0500, Adriana Kobylak wrote:
>> Adding Josef (updated email address in the maintainers file).
>> 
>> On 2018-12-13 08:21, Adriana Kobylak wrote:
>> > On 2018-12-11 00:17, medadyoung@gmail.com wrote:
>> > > From: Medad <medadyoung@gmail.com>
>> > >
>> > >     If we do NOT clear NBD_BOUND flag when NBD connection is closed,
>> > >     then the original NBD device could not be used again.
>> > >
>> > > Signed-off-by: Medad <medadyoung@gmail.com>
> 
> This doesn't sound right, this is just making sure we don't use the 
> IOCTL
> configuration stuff with the netlink stuff.  Once the disconnect 
> happens the
> configuration should go away and it doesn't matter anymore.  What are 
> you doing
> to reproduce this problem?  Thanks,
> 
> Josef

I'm not seeing an issue now that we've moved to a new version of Yocto 
containing
NBD 3.17. For reference we were reproducing by setting up a virtual 
media device
on a BMC (https://github.com/openbmc/jsnbd).
We can close this patch request unless Medad still sees an issue in his 
environment.

