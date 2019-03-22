Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E849BC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 02:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CFD213F2
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 02:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUlr0P9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCVCTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:19:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 22:19:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2M2F7tM159821;
        Fri, 22 Mar 2019 02:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=EFiOCs572gBZuqK7Q/oYIYLzvuPd9aNf3faHDmZaGJA=;
 b=kUlr0P9dJBoPWm4TB5rooCFcHh+GDLcypkh37IHTHJQ//h2nTui9d19C2CDXpZd6UjAI
 VBWyX76JCQCnsx6XI6wqJ4NZyFWRFUAfOoW15D20h5gcXZBBSKnm+/3s7L1/ui0C08bd
 W9VQtgZe3cBC/HulUNV0xGW1meRTOF7OCZmzgOuGe0t/mrQoL8oViPlzNZORMu9MHmXq
 ATYtXpnKGC6hssh6PYg12RQ271lVsl8MT0cTI/llIBuVJt4Kr7JvMGDYvMtP2mZ1j9MV
 Mpffz2iCpAvK3fUxOOq5yI8CYjmfIWorMTsfB0RMWVuIIzmW5l4X6912PwLezlrYMn1G ow== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssrug2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 02:19:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2M2J71C024961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 02:19:07 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2M2J7Yw031733;
        Fri, 22 Mar 2019 02:19:07 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 19:19:07 -0700
Subject: Re: [PATCH blktests 2/2] loop/001: verify all partitions are removed
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, jack@suse.cz
References: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
 <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
 <20190314175533.GC11825@vader>
 <c55aa1f3-6b5f-3dab-6c74-247ba65b5bd0@oracle.com>
 <20190321232628.GE20838@vader>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <d5a32d6f-b679-f960-8904-489556383537@oracle.com>
Date:   Fri, 22 Mar 2019 10:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190321232628.GE20838@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220016
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/22/19 7:26 AM, Omar Sandoval wrote:
> On Fri, Mar 15, 2019 at 10:00:27AM +0800, Dongli Zhang wrote:
>>
>>
>> On 3/15/19 1:55 AM, Omar Sandoval wrote:
>>> On Thu, Mar 14, 2019 at 07:45:17PM +0800, Dongli Zhang wrote:
>>>> loop/001 does not test whether all partitions are removed successfully
>>>> during loop device partition scanning. As a result, the regression
>>>> introduced by 0da03cab87e6 ("loop: Fix deadlock when calling
>>>> blkdev_reread_part()") can not be detected.
>>>>
>>>> The regression will generate below message in dmesg:
>>>>
>>>> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
>>>>
>>>> and leave orphan partitions like below:
>>>>
>>>> - /dev/loop0p1
>>>> - /sys/block/loop0/loop0p1
>>>>
>>>> This patch verifies all partitions are removed by checking if there is
>>>> /sys/block/loopX/loopXpY left. The expected number of partitions left is 0.
>>>
>>> Thanks for the test! A couple of comments below.
>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>>  tests/loop/001     | 5 +++++
>>>>  tests/loop/001.out | 1 +
>>>>  2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/tests/loop/001 b/tests/loop/001
>>>> index 47f760a..a0326b7 100755
>>>> --- a/tests/loop/001
>>>> +++ b/tests/loop/001
>>>> @@ -4,6 +4,9 @@
>>>>  #
>>>>  # Test loop device partition scanning. Regression test for commit e02898b42380
>>>>  # ("loop: fix LO_FLAGS_PARTSCAN hang").
>>>> +#
>>>> +# Test loop device paritition scanning. Regression test for commit 758a58d0bc67
>>>> +# ("loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
>>>
>>> These can just be combined to
>>>
>>> # Test loop device partition scanning. Regression test for commits e02898b42380
>>> # ("loop: fix LO_FLAGS_PARTSCAN hang") and 758a58d0bc67 ("loop: set
>>> # GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
>>>
>>>>  . tests/loop/rc
>>>>  
>>>> @@ -24,9 +27,11 @@ test() {
>>>>  		mkpart primary 50% 100%
>>>>  
>>>>  	loop_device="$(losetup -P -f --show "$TMPDIR/img")"
>>>> +	loop_name=${loop_device:5}
>>>>  	lsblk -ln "$loop_device" | wc -l
>>>>  
>>>>  	losetup -d "$loop_device"
>>>> +	ls /sys/block/$loop_name | grep loop | wc -l
>>>
>>> We can just repeat the same `lsblk -ln "$loop_device" | wc -l` from
>>> earlier, right? That's a bit cleaner than the hardcoded string slicing
>>> and ls.
>>
>> Seems 'lsblk' does not work here.
>>
>> step1: truncate -s 100M /tmp/tmp.raw
>> step2: parted /tmp/tmp.raw --script mklabel msdos \
>>        mkpart primary 0% 50% mkpart primary 50% 100%
>> step3: losetup -P -f --show /tmp/tmp.raw
>>
>> Now we are able to see two loop partitions from 'lsblk'
>>
>> # lsblk -ln /dev/loop0
>> loop0     7:0    0  100M  0 loop
>> loop0p1 259:0    0   50M  0 loop
>> loop0p2 259:1    0   50M  0 loop
>>
>>
>> step4: # losetup -d /dev/loop0
>>
>> There is below syslog as  partscan is failed.
>>
>> [  261.181049] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
>>
>>
>> There are 2 partitions left:
>>
>> # ls /dev | grep loop0
>> loop0
>> loop0p1
>> loop0p2
>>
>> # ls /sys/block/loop0 | grep loop
>> loop0p1
>> loop0p2
>>
>>
>> However, 'lsblk -ln' does not report the orphan paritions:
>>
>> # lsblk -ln
>> sr0   11:0    1 1024M  0 rom
>> sda    8:0    0   20G  0 disk
>> sda2   8:2    0    1K  0 part
>> sda5   8:5    0  4.1G  0 part [SWAP]
>> sda1   8:1    0 15.9G  0 part /
>>
>>
>> Therefore, we would not be able to use 'lsblk' here.
> 
> I see. I think we should check both lsblk and sysfs here. How about
> something like
> https://github.com/osandov/blktests/commit/6c1237cd358008024ece90bd915a67c23add8a2a?
> 

It is good to me. Thank you very much for improve the patchset! I have tested it
would pass with commit 758a58d0bc67 and not pass w/o 758a58d0bc67.

To check both lsblk and sysfs may test the loop much more thoroughly.


Just one programming question about loop_partition_sysfs():

+find_loop_partition_sysfs() {
+	find "$sysfs/" -mindepth 1 -maxdepth 1 -name "$1"'p*' -printf '%f\n' |
+		sed -n "s/^${1}p//p" | sort
+}

Why not something like:

ls "$sysfs/" | grep $1 | sed -n "s/^${1}p//p" | sort

Is that because it is better to use 'find' than 'ls' in bash programming?

Thank you very much!

Dongli Zhang
