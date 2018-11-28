Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615F6C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BBE2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9OvwBNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BBE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeK2Dtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:49:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbeK2Dtw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:49:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASGhulB028735;
        Wed, 28 Nov 2018 16:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uYoS2uHWsmwFcYNxZUpnWboocvYxHxu4Drtmg5taZeM=;
 b=S9OvwBNRUK+x0aXemBm8aUKJkUDDeUEY8g1w2/d0sEXy3FwuTcqwKbVsTsU06qO6DoAH
 hmf3lw5Y0YpLxt0YEkZPjBW2/kV0+yl8pnTSiWhqHrbGBEnxhV1X6ozPxYUkR2bPOqYQ
 j/Ws+n+siRr2h8bphD+Q+F3aizVPTFA9r7yBui+RzURlJ1GlkWQpcnM3nqXhz/KrnVKT
 6UdntPLa+fSxcBuPIBJXiFG+UPMqoLBwFXVGT0y4LmTeZwK9/sCZPWeo5l40xBgdJj5m
 YvaqYSZ/hFcge4q/BCItfAiVpuonx/QMM9UsvZ2jaGniJ9a2sUJQFHD9/FpUUkR6HUBZ QA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9rbcb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:47:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wASGlFFH020708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:47:15 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wASGlEbi003497;
        Wed, 28 Nov 2018 16:47:14 GMT
Received: from [192.168.1.226] (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 08:47:14 -0800
Subject: Re: [PATCH v1 5/7] xfs: Add device retry
To:     Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
 <20181128050850.GJ6311@dastard> <20181128073520.GA7084@infradead.org>
 <f30fd190-28e5-938a-1cb9-3690559a60f0@oracle.com>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <b24bdf13-e5b3-3793-54fe-5eca5b10915a@oracle.com>
Date:   Wed, 28 Nov 2018 09:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f30fd190-28e5-938a-1cb9-3690559a60f0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280146
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/28/18 5:41 AM, Bob Liu wrote:
> On 11/28/18 3:35 PM, Christoph Hellwig wrote:
>> On Wed, Nov 28, 2018 at 04:08:50PM +1100, Dave Chinner wrote:
>>> So the first time through this loop the block layer devices what
>>> device to read from, then we iterate devices 1..n on error.
>>>
>>> Whihc means if device 0 is the only one with good information in it,
>>> we may not ever actually read from it.
>>>
>>> I'd suggest that a hint of "-1" (or equivalent max value) should be
>>> used for "device selects mirror leg" rather than 0, so we can
>>> actually read from the first device on command.
>>
>> Yes.  For one thing I think we really need to split this retry counter
>> of sorts from the write hints.  I.e. make both u8 types and keep them
>> separate.  Then start out with (u8)-1 as initialized by the block layer
>> for the first attempt.  The device then fills out which leg it used
>> (in the completion path, so that another underlying driver doesn't
>> override it!), and then the file system just preserves this value on
>> a resumit, leaving the driver to chose a new value when it gets a
>> non -1 value.
>>
> 
> Will update as suggested, thank you for all your feedback :)
> 
> -Bob
> 

Yes, thanks everyone for your feed back.  Maybe Bob and I can come up 
with some test cases that recreate the problem scenarios described here 
and see if we can work out a solution to the multi bio complexities. 
Thanks!

Allison
