Return-Path: <SRS0=Zleb=OR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD14C04EB8
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5454C2081C
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="suQecOOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5454C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLHOuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Dec 2018 09:50:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33948 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeLHOuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Dec 2018 09:50:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB8EmwZ8064478;
        Sat, 8 Dec 2018 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JFBMYZWBmc7SPf1f0x4qxLLuJRTSB5XO1i8h/f8Aqts=;
 b=suQecOOXWXEYpS3IgkfgJJUc2BssI+BiO396VVjjYE75vkKIHY9thNx7qVhQFA7hk2Dh
 4G2TgbAITuczQ1+xyjOsXf5vkgI0sq5eSuRMu/GBl/UXr6ytLwZvK/r6Jh7pi9k9uljO
 GV8QpHH+02f4rVrN+Vfj0u7muQq5unAQyuH1PPffuRUrWmjmCY22T03ph1/QcnbKL5mh
 rD4KlADJ2zjQ2SUYcC/+B/bv5HZZR8OztROz51+XGS3f7LTOZQeKICT6G8gxdVCt0V7D
 icwWa0k2RVUJACjEAuazr3+XEv95fqAzCBz7ekp/zhcVQUJvaFSlElafYAJA/IYuIRoN 7Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p83fds34f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 14:49:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB8EnovL020843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 14:49:50 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB8EnmeV028661;
        Sat, 8 Dec 2018 14:49:48 GMT
Received: from [192.168.1.10] (/116.231.183.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Dec 2018 06:49:48 -0800
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard> <20181128074544.GA20702@infradead.org>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <f7bf5329-e756-1edb-af3f-41aca02691fe@oracle.com>
Date:   Sat, 8 Dec 2018 22:49:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128074544.GA20702@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9101 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080139
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 3:45 PM, Christoph Hellwig wrote:
> On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
>> 	- how does propagation through stacked layers work?
> 
> The only way it works is by each layering driving it.  Thus my
> recommendation above bilding on your earlier one to use an index
> that is filled by the driver at I/O completion time.
> 
> E.g.
> 
> 	bio_init:		bi_leg = -1
> 
> 	raid1:			submit bio to lower driver
> 	raid 1 completion:	set bi_leg to 0 or 1
> 
> Now if we want to allow stacking we need to save/restore bi_leg
> before submitting to the underlying device.  Which is possible,
> but quite a bit of work in the drivers.
> 

I found it's still very challenge while writing the code.
save/restore bi_leg may not enough because the drivers don't know how to do fs-metadata verify.

E.g two layer raid1 stacking

fs:                  md0(copies:2)
                     /          \
layer1/raid1   md1(copies:2)    md2(copies:2)
                  /    \          /     \
layer2/raid1   dev0   dev1      dev2    dev3

Assume dev2 is corrupted
 => md2: don't know how to do fs-metadata verify. 
   => md0: fs verify fail, retry md1(preserve md2).
Then md2 will never be retried even dev3 may also has the right copy.
Unless the upper layer device(md0) can know the amount of copy is 4 instead of 2? 
And need a way to handle the mapping.
Did I miss something? Thanks!

-Bob

>> 	- is it generic/abstract enough to be able to work with
>> 	  RAID5/6 to trigger verification/recovery from the parity
>> 	  information in the stripe?
> 
> If we get the non -1 bi_leg for paritity raid this is an inidicator
> that parity rebuild needs to happen.  For multi-parity setups we could
> also use different levels there.
> 

