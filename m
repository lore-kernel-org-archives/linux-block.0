Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B719C4743D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3916135D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhFHMD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23537 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232345AbhFHMD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 08:03:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158Bi5tD101563;
        Tue, 8 Jun 2021 08:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=SF8iQ8wY3M8EdUhAUJGyFS7jwJUI2uMR5Wzge09zd4c=;
 b=Mi63TgWlXkbjdESlaRoeOGVd1h5BDfReYVWwG6CSBUiE+davR+U2uMKSvHjC9LAgdWn2
 H+Pf0ADt6cZDUFQEejD5AXJDc+KFBqKWHJnDjyI664+0dmcpuDDYjXHmSvHLileHbEhH
 PjCTay40mvMMSJ+dMFg1TziNmFq8H6fwEdBv1OpsloAULEV3U9OaB3zLDPvqRu9Bw1Jq
 upcrsuacehEr22quYZbmnmddnhbQ+zn1oTFXPjF92K3NU060Rrnzr7VuSISaEnhzxUeB
 WNT3NCcMrpp35Jo+TLCKqaOdhIf0WN1VaE2YkwoqBoU2y9gSjeBVjplpcQhqZ6r0o9mr TA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3927xe0fuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 08:01:32 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158BvbVs019767;
        Tue, 8 Jun 2021 12:01:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3900w88u6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 12:01:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158C1SZn24904086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 12:01:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BEA04C04A;
        Tue,  8 Jun 2021 12:01:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 503D94C052;
        Tue,  8 Jun 2021 12:01:28 +0000 (GMT)
Received: from [9.145.39.189] (unknown [9.145.39.189])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jun 2021 12:01:28 +0000 (GMT)
From:   Ingo Franzki <ifranzki@linux.ibm.com>
Subject: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Christ <jchrist@linux.ibm.com>
Message-ID: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
Date:   Tue, 8 Jun 2021 14:01:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zSTJAGjN6nYFhubd1GAAxConFJIBp2oc
X-Proofpoint-ORIG-GUID: zSTJAGjN6nYFhubd1GAAxConFJIBp2oc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_09:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080077
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

we occasionally encounter a problem when setting up a loop device in one of our automated testcases.

We set up a loop device as follows:

    # dd if=/dev/zero of=/var/tmp/loopbackfile1.img bs=1M count=2500 status=none
    # losetup --sector-size 4096 -fP --show /var/tmp/loopbackfile1.img

This works fine most of the times, but in the seldom case of the error, we get 'losetup: /var/tmp/loopbackfile1.img: failed to set up loop device: Resource temporarily unavailable'.

I am sure that no other loop device is currently defined, so we don't run out of loop devices.

We also see the following message in the syslog when the error occurs:

     loop_set_block_size: loop0 () has still dirty pages (nrpages=2)

The nrpages number varies from time to time. 

"Resource temporarily unavailable" is EAGAIN, and function loop_set_block_size() in drivers/block/loop.c returns this after printing the syslog message via pr_warn:

static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
{
	int err = 0;

	if (lo->lo_state != Lo_bound)
		return -ENXIO;

	err = loop_validate_block_size(arg);
	if (err)
		return err;

	if (lo->lo_queue->limits.logical_block_size == arg)
		return 0;

	sync_blockdev(lo->lo_device);
	invalidate_bdev(lo->lo_device);

	blk_mq_freeze_queue(lo->lo_queue);

	/* invalidate_bdev should have truncated all the pages */
	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
		err = -EAGAIN;
		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
			__func__, lo->lo_number, lo->lo_file_name,
			lo->lo_device->bd_inode->i_mapping->nrpages);
		goto out_unfreeze;
	}

	blk_queue_logical_block_size(lo->lo_queue, arg);
	blk_queue_physical_block_size(lo->lo_queue, arg);
	blk_queue_io_min(lo->lo_queue, arg);
	loop_update_dio(lo);
out_unfreeze:
	blk_mq_unfreeze_queue(lo->lo_queue);

	return err;
}

So looks like invalidate_bdev() did actually not truncate all the pages under some circumstances....

The problem only happens when '--sector-size 4096' is specified, with the default sector size is always works. It does not call loop_set_block_size() in the default case I guess.

The loop0 device has certainly be used by other testcases before, most likely with the default block size. But at the time of this run, no loop device is currently active (losetup shows nothing). 

Anyone have an idea what goes wrong here? 

This happens on upstream kernels on the s390x platform, but I can't tell if is related to the platform or a specific kernel version. 
The failing use case is not that old, so I can't tell if it would have happened on earlier kernels or not, or since when it happens. 

Any help is appreciated!

-- 
Ingo Franzki
ifranzki@linux.ibm.com  
Linux on IBM Z Development, Schoenaicher Str. 220, 71032 Boeblingen, Germany

IBM Deutschland Research & Development GmbH / Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/
