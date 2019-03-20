Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15236C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5316213F2
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 04:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="36qL7z0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfCTERq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:17:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCTERq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 00:17:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K4EO0X118415;
        Wed, 20 Mar 2019 04:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LpDdTveu9Pyz7AEhASEdQ2wlPx0GffNcfh/cp7mr9PQ=;
 b=36qL7z0CZAvapdr1fU9bsnQAzAN7MQhJ/vj05/JLz3UqFApkXJhRS/q972NrUu43h8og
 nHrupLrPf/hqjST3AFUzKinEmoykfSaEaTZnh2XH/jidnkEdckXP2zvqWTaUMAJP3+cu
 g1pcMFUjybyZi+w3wxy/6EOclcKU6q6azeh2jDa1EJGiLF3Mx7udDLhQpVA+NfkLUlGc
 P/S86n0ImxltncHLnCJCSvUJuTqHX+Ka+HYBKm4gcXdVtTFMdbatw8dqk8LHkrdm38+E
 y8C/AS3pTsfpBcvmkmJQT+4uAc5VvLVK/xZo8S86yvK8ygdnwexurllzOPXiow8A7Blw zA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjure65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 04:17:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2K4HYmK012343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 04:17:35 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2K4HXlD003651;
        Wed, 20 Mar 2019 04:17:33 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 21:17:33 -0700
Subject: Re: general protection fault in loop_validate_file (2)
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        penguin-kernel@i-love.sakura.ne.jp
References: <00000000000098bf7d05845616d7@google.com>
 <cb7aa6d1-6d1e-a9ac-239a-1b5d8160f8cd@oracle.com>
 <20190319094136.GE17334@quack2.suse.cz>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a6a6fda6-4911-69a1-9db1-97e3ec7cce99@oracle.com>
Date:   Wed, 20 Mar 2019 12:21:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190319094136.GE17334@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200037
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/19/19 5:41 PM, Jan Kara wrote:
> On Mon 18-03-19 20:27:02, Dongli Zhang wrote:
>> Hi Jan,
>>
>> Indeed there is another issue implicitly reported by below console output from
>> syzkaller:
>>
>> [  245.524424][ T9455] loop_reread_partitions: partition scan of loop0 () failed
>> (rc=-13)
>> [  245.563340][ T9499] kasan: CONFIG_KASAN_INLINE enabled
>> [  245.576412][ T9489] __loop_clr_fd: partition scan of loop0 failed (rc=-13)
>> [  245.581275][ T9499] kasan: GPF could be caused by NULL-ptr deref or user
>> memory access
>> [  245.602596][ T9499] general protection fault: 0000 [#1] PREEMPT SMP KASAN
>>
>> I think rc=-13 is because of below code at line 168:
>>
>> 162 int __blkdev_reread_part(struct block_device *bdev)
>> 163 {
>> 164         struct gendisk *disk = bdev->bd_disk;
>> 165
>> 166         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
>> 167                 return -EINVAL;
>> 168         if (!capable(CAP_SYS_ADMIN))
>> 169                 return -EACCES;
>> 170
>> 171         lockdep_assert_held(&bdev->bd_mutex);
>> 172
>> 173         return rescan_partitions(disk, bdev);
>> 174 }
>> 175 EXPORT_SYMBOL(__blkdev_reread_part);
>>
>> I can reproduce this by 'chown username /dev/loop0' on my test machine.
>>
>> Taking 'losetup -d /dev/loop0' as sample, as /dev/loop0 belongs to my username,
>> I am able to detach the loop without 'su'.
>>
>> However, because of above line 168, the partition scan would fail.
>>
>> Should we always assume the user should have admin privilege to detach
>> the loop and this is not a bug?
> 
> Firstly, __blkdev_reread_part() is used for all devices so we have to be
> *very* careful when we relax the permission checks there.
> 
> Secondly, I'm not convinced it is always safe to allow non-priviledged user
> to force repartitioning of a device. That exposes the whole partition table
> parsing code to non-priviledged user and thus increases possible attack
> surface.
> 
> But in this specific case we call __blkdev_reread_part() only to tear down
> partitions. So in this specific case calling it by unpriviledged user is
> fine plus leaving stale partitions behind is certainly not nice. What we
> could do is:
> 
> Export drop_partitions() functionality as a function like
> __blkdev_drop_part() that would call drop_partitions(bdev->bd_disk, bdev).
> It would expect (and assert) that &bdev->bd_mutex is already locked. It
> should probably also replicate the check:
> 
>         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
>                 return -EINVAL;
> 
> from __blkdev_reread_part(). And we can call this from __loop_clr_fd().
> 
> Then we can just unexport __blkdev_reread_part() (since only loop.c is
> using it) and fold it inside blkdev_reread_part().
> 
> What do you think?
> 
> 								Honza
> 

The idea is to duplicate a new caller of drop_partitions() which is specifically
used by loop. I think it works. It is safe as well as the functionality is
limited within loop.

However, perhaps we should not regard this as a bug? Below is the sample to
reproduce this issue:

$ dd if=/dev/zero of=tmp.raw bs=1M count=100 oflag=direct

$ parted tmp.raw --script mklabel msdos mkpart primary 0% 50% mkpart primary 50%
100%

$ sudo chown zhang /dev/loop0

$ losetup -P /dev/loop0 tmp.raw

$ ls -l /dev | grep loop0
brw-rw---- 1 zhang disk      7,   0 Mar  20 11:42 loop0   --> user (zhang)
brw-rw---- 1 root  disk    259,   0 Mar  20 11:42 loop0p1 --> root
brw-rw---- 1 root  disk    259,   1 Mar  20 11:42 loop0p2 --> root

$ losetup -d /dev/loop

From above case, /dev/loop0 is owned by user (zhang), while the partitions are
owned by root.

Should the detach of loop owned by user also unmaps all related partitions owned
by root?

Perhaps we should assume the '-P' option is always used by root?


This is similar to the fact that the administrator should always use '-P' in
order to enforce partscan when the loop is detached. Otherwise, the partitions
belong to the loop would remain after 'losetup -d'.


Another example is from kpartx as below. If the partitions are mapped via
'kpartx -av', the user should always run 'kpartx -d' to remove all partition
mappings.

Otherwise, there would be dm-0 and dm-1 left.

$ sudo kpartx -av  tmp.raw
add map loop0p1 (253:0): 0 102400 linear 7:0 1
add map loop0p2 (253:1): 0 102399 linear 7:0 102401

$ ls -l /dev/mapper/
total 0
crw------- 1 root root 10, 236 3月  20 11:16 control
lrwxrwxrwx 1 root root       7 3月  20 11:21 loop0p1 -> ../dm-0
lrwxrwxrwx 1 root root       7 3月  20 11:21 loop0p2 -> ../dm-1

$ sudo losetup -d /dev/loop0

$ ls -l /dev/mapper/
total 0
crw------- 1 root root 10, 236 3月  20 11:16 control
lrwxrwxrwx 1 root root       7 3月  20 11:21 loop0p1 -> ../dm-0
lrwxrwxrwx 1 root root       7 3月  20 11:21 loop0p2 -> ../dm-1

Dongli Zhang
