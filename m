Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBCC433FE
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356336AbiD0ATF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiD0ATE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Apr 2022 20:19:04 -0400
X-Greylist: delayed 1148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 17:15:54 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B6B5C
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 17:15:53 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QLowVm021147;
        Wed, 27 Apr 2022 00:56:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=7hSBAyq2+Zyp9lF8lCdKSeRFBH1jhTiVei4UUg5Yago=;
 b=WmVdfG2FvwiIYuWSVMMj0lEnsv5jbnBtJakVVsfm06cgx8IhIyL00X+qNX05X3AqIKOU
 g8Fngb0rYBt8YmbhH+eUB81rlkznm/3qJWEPsgZ80zSv4f1mQYsD78Z+MYxBRxspCFIY
 QUDkfYIt3OwZWMUR8Kkq78rptxAdUqVdyaKMncDE6SBBJkBHX00J3sweLVShYWWcPViG
 MtpWC9MPuHtnK6fTosh1BC0EB6rRQdjGOxDYhPRKe9SddUZA8CJEEIIpHaswot12rZ4x
 aIq0A4h/2m8S/Ebtb20lJjA6sdHj+PweLCovkxaoqcXKmauAb+nC9tEiG7o1btqgkhsu FQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3fps0tunph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 00:56:33 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 23QNZGgs027118;
        Tue, 26 Apr 2022 19:56:32 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.32])
        by prod-mail-ppoint2.akamai.com with ESMTP id 3fmx4gcnx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:56:32 -0400
Received: from USTX2EX-DAG3MB2.msg.corp.akamai.com (172.27.165.126) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 19:56:32 -0400
Received: from USTX2EX-DAG3MB4.msg.corp.akamai.com (172.27.165.128) by
 USTX2EX-DAG3MB2.msg.corp.akamai.com (172.27.165.126) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 18:56:31 -0500
Received: from USTX2EX-DAG3MB4.msg.corp.akamai.com ([172.27.165.128]) by
 USTX2EX-DAG3MB4.msg.corp.akamai.com ([172.27.165.128]) with mapi id
 15.00.1497.033; Tue, 26 Apr 2022 18:56:31 -0500
From:   "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To:     "yukuai (C)" <yukuai3@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>
CC:     "Hunt, Joshua" <johunt@akamai.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: Precise disk statistics
Thread-Topic: Precise disk statistics
Thread-Index: AQHYWTa/6pejk/4vlkykdmgWiOb/660C1gn9
Date:   Tue, 26 Apr 2022 23:56:31 +0000
Message-ID: <1651017390610.22782@akamai.com>
References: <1650661324247.40468@akamai.com>
 <1650915337169.63486@akamai.com>,<87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com>
In-Reply-To: <87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.27.97.87]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_06:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260146
X-Proofpoint-ORIG-GUID: baIla5Rr8LopjSBZXwieiJ_FLVRGYKkG
X-Proofpoint-GUID: baIla5Rr8LopjSBZXwieiJ_FLVRGYKkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_06,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260146
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=0A=
________________________________________=0A=
From: yukuai (C) <yukuai3@huawei.com>=0A=
Sent: Tuesday, April 26, 2022 2:25 AM=0A=
To: Jayaramappa, Srilakshmi; axboe@kernel.dk; snitzer@redhat.com; linux-blo=
ck@vger.kernel.org=0A=
Cc: Hunt, Joshua=0A=
Subject: Re: Precise disk statistics=0A=
=0A=
=1B$B:_=1B(B 2022/04/26 3:35, Jayaramappa, Srilakshmi =1B$B<LF;=1B(B:=0A=
> ________________________________________=0A=
> From: Jayaramappa, Srilakshmi=0A=
> Sent: Friday, April 22, 2022 5:02 PM=0A=
> To: axboe@kernel.dk; snitzer@redhat.com; linux-block@vger.kernel.org=0A=
> Cc: Hunt, Joshua=0A=
> Subject: Precise disk statistics=0A=
>=0A=
> Hi,=0A=
>=0A=
> We install LTS kernel on our machines. While moving from 4.19.x to 5.4.x =
we noticed a performance drop in one of our applications.=0A=
> We tracked down the root cause to the commit series for removing the pend=
ing IO accounting (80a787ba3809 to 6f75723190d8)=0A=
> which includes 5b18b5a73760 block: delete part_round_stats and switch to =
less precise counting.=0A=
>=0A=
> The application (which runs on non-dm machines) tracks disk utilization t=
o estimate the load it can further take on. After the commits in question,=
=0A=
> we see an over reporting of disk utilization [1] compared to the older me=
thod of reporting based on inflight counter [2] for the same load.=0A=
> The over-reporting is observed in v5.4.190 and in v5.15.35 as well. I've =
attached the config file used to build the kernel.=0A=
>=0A=
> We understand that the disk util% does not provide a true picture of how =
much more work the device is capable of doing in flash based=0A=
> devices and we are planning to use a different model to observe the perfo=
rmance potential.=0A=
> In the interim we are having to revert the above commit series to bring b=
ack the original reporting method.=0A=
>=0A=
> In the hopes of getting back our application's performance with a new cha=
nge on top of the 5.4.x reporting (as opposed to reverting commits),=0A=
> I tried checking if the request queue is busy before updating io_ticks [3=
]. With this change the applications's throughput is closer to=0A=
> what we observe with the commits reverted, but still behind by ~ 6 %. Tho=
ugh, I am not sure that this change is safe overall.=0A=
>=0A=
> I'd appreciate your expert opinion on this matter. Could you please let u=
s know if there is some other idea we could explore to report precise disk =
stats=0A=
> that we can build on top of existing reporting in the kernel and submit a=
 patch, or if going back to using the inflight counters is indeed our best =
bet.=0A=
>=0A=
> Thank you=0A=
> -Sri=0A=
>=0A=
> [1]=0A=
> root@xxx:~# DISK=3Dnvme3n1; dd if=3D/dev/$DISK of=3D/dev/null bs=3D104857=
6 iflag=3Ddirect count=3D2048 & iostat -yxm /dev/$DISK 1 1 ; wait=0A=
> ...=0A=
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.721532 s, 3.0 GB/s=0A=
>=0A=
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle=0A=
>             0.13    0.00    0.28    1.53    0.00   98.07=0A=
>=0A=
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s =
    wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drq=
m d_await dareq-sz  aqu-sz  %util=0A=
> nvme3n1       16383.00   2047.88     0.00   0.00    0.21   128.00    0.00=
      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.=
00    0.00     0.00    0.00  72.20=0A=
>=0A=
> [2]=0A=
>=0A=
> root@xxx:~# DISK=3Dnvme3n1; dd if=3D/dev/$DISK of=3D/dev/null bs=3D104857=
6 iflag=3Ddirect count=3D2048 & iostat -yxm /dev/$DISK 1 1 ; wait=0A=
> ...=0A=
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.702101 s, 3.1 GB/s=0A=
>=0A=
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle=0A=
>             0.03    0.00    0.18    1.57    0.00   98.22=0A=
>=0A=
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s =
    wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drq=
m d_await dareq-sz  aqu-sz  %util=0A=
> nvme3n1       16380.00   2047.50     0.00   0.00    0.20   128.00    0.00=
      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.=
00    0.00     0.00    0.00  64.20=0A=
>=0A=
>=0A=
> [3]=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index cb38d6f3acce..8275b10a1c9a 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1754,14 +1754,17 @@ void bio_check_pages_dirty(struct bio *bio)=0A=
>          schedule_work(&bio_dirty_work);=0A=
>   }=0A=
>=0A=
> -void update_io_ticks(struct hd_struct *part, unsigned long now, bool end=
)=0A=
> +void update_io_ticks(struct request_queue *q, struct hd_struct *part, un=
signed long now, bool end)=0A=
>   {=0A=
>          unsigned long stamp;=0A=
>   again:=0A=
>          stamp =3D READ_ONCE(part->stamp);=0A=
>          if (unlikely(stamp !=3D now)) {=0A=
>                  if (likely(cmpxchg(&part->stamp, stamp, now) =3D=3D stam=
p)) {=0A=
> +                      if (blk_mq_queue_inflight(q)) {=0A=
>                                  __part_stat_add(part, io_ticks, end ? no=
w - stamp : 1);=0A=
Hi,=0A=
=0A=
We met the same problem, and I'm pretty sure the root cause is the above=0A=
code: while starting the first IO in the new jiffies, io_ticks will=0A=
always add 1 jiffies in additional, which is wrong. And in your test=0A=
case, dd will issue io one by one, thus if the new io is issued in the=0A=
new jiffies than the jiffies that old io is done, io_ticks will be=0A=
miscaculated.=0A=
=0A=
We reintroduce part_round_stats() to fix the problem. However, iterate=0A=
tags when starting each IO is not a good idea, and we can't figure out=0A=
a good solution that will not affect fast path yet.=0A=
=0A=
Thanks,=0A=
Kuai=0A=
> +            }=0A=
>                  }=0A=
>          }=0A=
>          if (part->partno) {=0A=
>=0A=
>=0A=
>=0A=
> Sorry, resending without the config attachment since my original email bo=
unced from linux-block.=0A=
>=0A=
>=0A=
> Thanks=0A=
> -Sri.=0A=
>=0A=
=0A=
=0A=
[+ Mikulas and Ming]=0A=
=0A=
I see. Thank you for the response, Kuai, appreciate it. =0A=
=0A=
The conversation here https://lkml.org/lkml/2020/3/24/1870 hints at potenti=
al improvements to io_ticks tracking. =0A=
=0A=
@Mikulas, Mike, please let us know if you have plans for more accurate acco=
unting or if there is some idea we can work on and submit a patch.=0A=
=0A=
=0A=
Thanks=0A=
-Sri=0A=
=0A=
