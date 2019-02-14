Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C728DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 05:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2421934
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 05:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBnrREsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404354AbfBNF5s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:57:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403946AbfBNF5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 00:57:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E5rruP137725;
        Thu, 14 Feb 2019 05:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VEHARTz3L96Isw/6vjmnriPs1HjxOK8/i9kYwu8JBec=;
 b=MBnrREsk0q+lBTRFgKVcKaxWq97r8BIHTjNEVo4Xztne+EcZkvUsAypGYX79dG8TzTJ0
 Hyu/YdLmfeN2ZupDjaJBDTW3aUwD0fr5pa23JBzagwSYPbF6ybbx7YZTtbZClskoO7jt
 MeCfwdl+fo9+mVvwQ4emc7xkAcopdxJLMVk+2bf8eHE9aECFWfN+K9lAj1z1dhSVDPmL
 9H9vOKImhT0rXd6RHu2PTC6wcdPki42wh203zwRMLH5Nc1Ju8k3ssbIzsXjXlIqaO2U0
 Pa/vR7H5qzIiN7/vvZF37OTsQ4AS0eIAyGVT+NZUqWLEEHUMBGa3haNa6U6/WRM8cXAY oQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhreknym0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 05:57:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E5vbJk004093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 05:57:37 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E5vaTO012111;
        Thu, 14 Feb 2019 05:57:36 GMT
Received: from [172.20.10.5] (/223.104.212.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 05:57:35 +0000
Subject: Re: [RFC PATCH v2 1/9] block: add nr_mirrors to request_queue
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, martin.petersen@oracle.com,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-2-bob.liu@oracle.com> <20190213160408.GW23000@mit.edu>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <56d2dc78-01f8-9991-9199-372fe864d9f0@oracle.com>
Date:   Thu, 14 Feb 2019 13:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213160408.GW23000@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/19 12:04 AM, Theodore Y. Ts'o wrote:
> On Wed, Feb 13, 2019 at 05:50:36PM +0800, Bob Liu wrote:
>> @nr_mirrors is 1 by default which means only one copy, drivers e.g raid1 are
>> responsible for setting the right value. The maximum value is
>> BITS_PER_LONG which is 32 or 64. That should be big enough else retry lantency
>> may be too high.
> 
> This is admittedly bike-shedding, so feel free to ignore, but...
> 
> In the case of Raid 6, "mirrors" will be a bit of a misnomer.  Would
> "nr_recovery" be better?
> 

Now the initial/default value is 1 indicating only one copy of data.
Would nr_copy be more accurate?

> Thanks for working on this!!  I would be interested in using this for
> ext4 once it's available.
> 
> 				- Ted
> 
