Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A2CA9EA0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 08:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A00620873
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 08:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TIOdz48+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfJ1Iv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:51:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40498 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731992AbfJ1Iv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 04:51:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S8iF4M025773;
        Mon, 28 Oct 2019 08:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=9saFiIVD4K6KegoAkGcpay9swJ3gk/oMJYVDWNV8Qi4=;
 b=TIOdz48+ewtjbEyPALjjHR+lOvRYfu1LTeJz3GVTpOz3KprrbtCwFkFqpag0MT0yBliM
 Hu8tSGwXojbST6PIES9FZ8Y4AzXu4fwoaxK6M5uHJ5YxhK7vcAIN+NLul2XCUeFshUU3
 yOY/MDgKQdVr9DGDtRzRPVu5aaEUb+UYQHxSk8vEmIkjxcElhRraot1ZTkt7o6su0H4d
 P7gqHY9mir57x28yuhBduSgwnVq7MOiqOSb3IugU4ooO5Tqp8pJxn9qqswt1vP5CbI+J
 Oa9Km8Kvhgx8PiJShmupG04TRHLNOri8CVZySO0hgs1g/UZaliTmD/rKNmZDy9D06/TT FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vvumf5cru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 08:51:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S8mXgT169533;
        Mon, 28 Oct 2019 08:51:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vwakxmkfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 08:51:19 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9S8pGSg026381;
        Mon, 28 Oct 2019 08:51:17 GMT
Received: from [192.168.1.13] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 01:51:16 -0700
Subject: Re: INFO: task syz-executor can't die for more than 143 seconds. (2)
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, axboe@kernel.dk
Cc:     syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
Date:   Mon, 28 Oct 2019 16:51:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280087
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 6:08 PM, Tetsuo Handa wrote:
> On 2019/10/23 16:56, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    c4b9850b Add linux-next specific files for 20191018
>> git tree:       linux-next
>> console output: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_log.txt-3Fx-3D177b3ab0e00000&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=wOlNeKk9puri9Fvxn8bGDrlWHd-4GPMeJ9rb2CVqXaE&s=PZfBliKlYjm16VnyPzu-3i0SgqlbByIB0iI8jVhcGuk&e= 
>> kernel config:  https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_.config-3Fx-3Dc940ef12efcd1ec&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=wOlNeKk9puri9Fvxn8bGDrlWHd-4GPMeJ9rb2CVqXaE&s=z8tV220wKFTQIJH1tSYLUl8ecAnll94C_mFVcHkuTlc&e= 
>> dashboard link: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_bug-3Fextid-3Db48daca8639150bc5e73&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=wOlNeKk9puri9Fvxn8bGDrlWHd-4GPMeJ9rb2CVqXaE&s=VZ2ZdnAqEd_AkXJujidN3EgwscGpUAdsZjuObKjXN-U&e= 
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.syz-3Fx-3D1356b8ff600000&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=wOlNeKk9puri9Fvxn8bGDrlWHd-4GPMeJ9rb2CVqXaE&s=Q_svUYj2OBYmIJXnResNzOWVUCyjRpxnpun2Cu15S9M&e= 
>> C reproducer:   https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.c-3Fx-3D14f48687600000&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=wOlNeKk9puri9Fvxn8bGDrlWHd-4GPMeJ9rb2CVqXaE&s=FGZNxR7w-rU29MhJxJtno-c_wUXCJHgPC5V1YNp7h58&e= 
> 
> The reproducer is trying to allocate 64TB of disk space on /dev/nullb0 using fallocate()
> but __blkdev_issue_zero_pages() cannot bail out upon SIGKILL (and therefore cannot
> terminate for minutes). Can we make it killable? 

Yeah, I think we can consider add fatal_signal_pending(current) checking in the while() loop..

> I don't know what action is needed
> for undoing this loop...
> 
>         while (nr_sects != 0) {
>                 bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
>                                    gfp_mask);
>                 bio->bi_iter.bi_sector = sector;
>                 bio_set_dev(bio, bdev);
>                 bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> 
>                 while (nr_sects != 0) {
>                         sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
>                         bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
>                         nr_sects -= bi_size >> 9;
>                         sector += bi_size >> 9;
>                         if (bi_size < sz)
>                                 break;
>                 }
>                 cond_resched();
>         }
> 

