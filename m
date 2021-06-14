Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE53C48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBDA613C0
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 07:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhFNHhb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:37:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11324 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhFNHha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 03:37:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E7XZdf088349;
        Mon, 14 Jun 2021 03:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m/7dsjrblojVKzyv1KnEZNb9NuXWzSFiHsjj7DNTCgA=;
 b=f32nY7ou7zDiZQGpI+PP3DX9jZMJ//1s/Oji/jfmSYiPV8otnARBFa+58u/HRFmu115+
 XoytTt6vT9wZInUSZ6xu7caFrfa3csGXjSt2vQX+k/YW25YOL1jreOwFikMACxkNHRy8
 uuqAPeu0H9+SIFmg1fkWqEJC2X84AL2BuKM3nBBJDJQLcHbCYHK0EpGPeAh/0tBppKMA
 tYxTGYzTBkG6X4yHkbXBx5m1jSRD17ffBLPpV8uanFiAwyTXGTA9zl4M2xb3tDbWyfiV
 U9mIgQfj8UVRO4iPZDRFstry28huC+OPitNWlx7PEHzn50CBUeSJbUO1hBQr5BwRe6ue sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3962ct0r3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 03:35:27 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E7XbZR088477;
        Mon, 14 Jun 2021 03:35:27 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3962ct0r35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 03:35:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E7WMjC003885;
        Mon, 14 Jun 2021 07:35:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90dwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 07:35:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E7ZMOl31916456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 07:35:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A082942042;
        Mon, 14 Jun 2021 07:35:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6582B4203F;
        Mon, 14 Jun 2021 07:35:22 +0000 (GMT)
Received: from [9.145.85.225] (unknown [9.145.85.225])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 07:35:22 +0000 (GMT)
Subject: Re: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
To:     Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juergen Christ <jchrist@linux.ibm.com>
References: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
 <YMIliuPi2tTLUJxv@T590>
From:   Ingo Franzki <ifranzki@linux.ibm.com>
Message-ID: <cf3c803f-350e-c365-afac-0a07a9b6cee2@linux.ibm.com>
Date:   Mon, 14 Jun 2021 09:35:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMIliuPi2tTLUJxv@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5BZYHtOqkfBHTr9pdG_Cvmt-C9SbdIe6
X-Proofpoint-ORIG-GUID: 4XUrnMYNjUn1fMfekGJEkYrKalj-Qap2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140055
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.06.2021 16:45, Ming Lei wrote:
> On Tue, Jun 08, 2021 at 02:01:29PM +0200, Ingo Franzki wrote:
>> Hi all,
>>
>> we occasionally encounter a problem when setting up a loop device in one of our automated testcases.
>>
>> We set up a loop device as follows:
>>
>>     # dd if=/dev/zero of=/var/tmp/loopbackfile1.img bs=1M count=2500 status=none
>>     # losetup --sector-size 4096 -fP --show /var/tmp/loopbackfile1.img
>>
>> This works fine most of the times, but in the seldom case of the error, we get 'losetup: /var/tmp/loopbackfile1.img: failed to set up loop device: Resource temporarily unavailable'.
>>
>> I am sure that no other loop device is currently defined, so we don't run out of loop devices.
>>
>> We also see the following message in the syslog when the error occurs:
>>
>>      loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
>>
>> The nrpages number varies from time to time. 
>>
>> "Resource temporarily unavailable" is EAGAIN, and function loop_set_block_size() in drivers/block/loop.c returns this after printing the syslog message via pr_warn:
>>
>> static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>> {
>> 	int err = 0;
>>
>> 	if (lo->lo_state != Lo_bound)
>> 		return -ENXIO;
>>
>> 	err = loop_validate_block_size(arg);
>> 	if (err)
>> 		return err;
>>
>> 	if (lo->lo_queue->limits.logical_block_size == arg)
>> 		return 0;
>>
>> 	sync_blockdev(lo->lo_device);
>> 	invalidate_bdev(lo->lo_device);
>>
>> 	blk_mq_freeze_queue(lo->lo_queue);
>>
>> 	/* invalidate_bdev should have truncated all the pages */
>> 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
>> 		err = -EAGAIN;
>> 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
>> 			__func__, lo->lo_number, lo->lo_file_name,
>> 			lo->lo_device->bd_inode->i_mapping->nrpages);
>> 		goto out_unfreeze;
>> 	}
>>
>> 	blk_queue_logical_block_size(lo->lo_queue, arg);
>> 	blk_queue_physical_block_size(lo->lo_queue, arg);
>> 	blk_queue_io_min(lo->lo_queue, arg);
>> 	loop_update_dio(lo);
>> out_unfreeze:
>> 	blk_mq_unfreeze_queue(lo->lo_queue);
>>
>> 	return err;
>> }
>>
>> So looks like invalidate_bdev() did actually not truncate all the pages under some circumstances....
>>
>> The problem only happens when '--sector-size 4096' is specified, with the default sector size is always works. It does not call loop_set_block_size() in the default case I guess.
>>
>> The loop0 device has certainly be used by other testcases before, most likely with the default block size. But at the time of this run, no loop device is currently active (losetup shows nothing). 
>>
>> Anyone have an idea what goes wrong here? 
> 
> It returns '-EAGAIN' to ask userspace to try again.
> 
> I understand loop_set_block_size() doesn't prevent page cache of this
> loop disk from being dirtied, so it isn't strange to
> see lo_device->bd_inode->i_mapping->nrpages isn't zero after sync_blockdev()
> & invalidate_bdev() on loop.
> 

OK, that makes sense from the kernel perspective. 

However, shouldn't then the losetup userspace utility implement some kind of retry logic in case of -EAGAIN ?
I don't see that in the source of losetup.c nor in loopdev.c in the util-linux package. There is a retry loop in create_loop() in losetup.c retrying loopcxt_setup_device() in case of EBUSY, but not in case of EAGAIN.

And losetup also hides the original error code and just returns EXIT_FAILURE in case of a failure. So no real good chance for the script that uses losetup to catch that error situation and perform a retry itself.

Adding Karel Zak (the maintainer of util-linux).

@Karel Zak: How about adding EAGAIN to the condition for performing a retry? 

Something like this:

-		if (errno == EBUSY && !hasdev && ntries < 64) {
+		if ((errno == EBUSY || errno == EAGAIN) && !hasdev && ntries < 64) {
			xusleep(200000);
			ntries++;
			continue;
		}

>>
>> This happens on upstream kernels on the s390x platform, but I can't tell if is related to the platform or a specific kernel version. 
> 
> It can be reproduced easily when you run buffered write on loop disk,
> meantime keeping to change block size from one to another on this loop.

Yes it is very likely that this is happening in our use case. 
> 
> 
> Thanks,
> Ming
> 


-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Linux on IBM Z Development, Schoenaicher Str. 220, 71032 Boeblingen, Germany

IBM Deutschland Research & Development GmbH / Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/
