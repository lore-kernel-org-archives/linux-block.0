Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4499C2BAEE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4A2076E
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cD8qN2if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCXNMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgCXNMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OD98e3100769;
        Tue, 24 Mar 2020 13:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=izQffAPMCkPyhswmqTh42EEmqNfBWD2nZcuUr/piHSY=;
 b=cD8qN2ifS/8PyZ37Uz2e/bht+qXFNK4AZ7qfVtiO3AR/p5hPn1iSqGgvyYSCjHr82dI2
 zQi31DmeMEiIVxgCXw+YLtsl4Q0RWajPH9VZT14o5UXEqkVMfQWRQPS1s5Z1WK3YQznB
 B3EtqgJs0qy0swJNsTznYHYpFb2m0c0xjSL3qQeqgrKmZWPdEXRvsGqLnU3Lbgoz+8hC
 BFRvvmk342Jfdhld/lzTLaEM+RiTdJL1M6WI+Je3PcMnZKzDp9kp7dTi+0Xs2bYqNQXu
 2NCUhgYG3R36QfpLLhpJ1gytflVREC7w53Ts8tQCOgUKcQr6TAW8D5+bWtjuADmydHXa BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavm45y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:12:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ODCCl8031198;
        Tue, 24 Mar 2020 13:12:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yyd9w3yyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:12:39 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ODCc3v015764;
        Tue, 24 Mar 2020 13:12:38 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 06:12:38 -0700
Subject: Re: [RFC PATCH v2 0/3] dm zoned: extend the way of exposing zoned
 block device
To:     Hannes Reinecke <hare@suse.de>, dm-devel@redhat.com
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        Dmitry.Fomichev@wdc.com
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <e2bef18e-f363-47c4-dd38-971a60ec1eca@suse.de>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <f1cc2096-21f6-59e7-174f-e5e51c492b6b@oracle.com>
Date:   Tue, 24 Mar 2020 21:12:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e2bef18e-f363-47c4-dd38-971a60ec1eca@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 7:52 PM, Hannes Reinecke wrote:
> On 3/24/20 12:02 PM, Bob Liu wrote:
>> Motivation:
>> dm-zoned exposes a zoned block device(ZBC) as a regular block device by storing
>> metadata and buffering random writes in its conventional zones.
>> This way is not flexible, there must be enough conventional zones and the
>> performance may be constrained.
>>
>> This patchset split the metadata from zoned device to an extra regular device,
>> with aim to increase the flexibility and potential performance.
>> For example, now we can store metadata in a faster device like persistent memory.
>> Also random writes can go to the regular devices in this version.
>>
>> Usage(will send user space patches later):
>>> dmzadm --format $zoned_dev --regular=$regu_dev --force
>>> echo "0 $size zoned $regu_dev $zoned_dev" | dmsetup create $dm-zoned-name
>>
>> v2:
>>   * emulate regular device zone info
>>   * support write both metadata and random writes to regular dev
>>
>> Bob Liu (3):
>>    dm zoned: rename dev name to zoned_dev
>>    dm zoned: introduce regular device to dm-zoned-target
>>    dm zoned: add regular device info to metadata
>>
>>   drivers/md/dm-zoned-metadata.c | 205 +++++++++++++++++++++++++++--------------
>>   drivers/md/dm-zoned-target.c   | 205 +++++++++++++++++++++++------------------
>>   drivers/md/dm-zoned.h          |  53 ++++++++++-
>>   3 files changed, 299 insertions(+), 164 deletions(-)
>>
> Well, surprise, surprise, both our patchsets are largely identical ...
> 

You may missed my first rfc.
https://www.redhat.com/archives/dm-devel/2020-January/msg00024.html

> So how to proceed? I guess if you were using 'cdev' instead of 'regu_dm_dev' we should be having an overlap of about 90 percent.
> 
> The main difference between our implementation is that I didn't move the metadata to the cache/regulard device, seeing that dmzadm will only write metadata onto the zoned device.

I also patched dmzadm(will sent out soon) a lot, now my implementation can compatible with original usage.

It supports two different usage:
- Original zoned device only:
#: dmzadm --format $zoned_dev
#: echo "0 $size zoned $zoned_dev" | dmsetup create $dm-zoned-name
(All data in zoned device)

- With regular device：
dmzadm --format $zoned_dev --regular=$regu_dev
echo "0 $size zoned $regu_dev $zoned_dev" | dmsetup create $dm-zoned-name
(Metadata in regular device, other data spread in both regular device and zoned device.)

I haven't thought about store metadata in zoned dev while other data in both cache/regular device and zoned dev.
Actually in my first rfc I just plan to split metadata to a fast device, so as to get performance improvement.

> I would rather keep it that way (ie storing metadata on the zoned device, too, if possible) as we would be keeping backwards compability with that.
> And we could always move metadata to the cache/regular device in a later patch; for doing it properly we'll need to update the metadata anyway as we need to introduce UUIDs to stitch those devices together.

Sure.

> Remember, one my have more than one zoned device and regular device...
> 
> Should I try to merge both patchsets and send them out as an RFC?
> 

Fine to me, just please keep my signed-off-by.

Thanks,
Bob
