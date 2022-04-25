Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 19:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiDYTit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiDYTis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 15:38:48 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC9111153
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 12:35:43 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.17.1.5/8.17.1.5) with ESMTP id 23PH8MAw021232;
        Mon, 25 Apr 2022 20:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=TIzVC+MUUmP99qiHXsSdlBUIjEg4h1tzn/qxjzLVKIc=;
 b=eAOzjSlZg9rb8bhn56IhL7MMz2Bra1Lt5fAcTNaldZ1M70MRRCMHYe/nttJHt40JnyBO
 OCtYVJrcl1wrdj/AUqixzH0Kis4xmHX6tzfKQPjtD2gHs8BfSqHxW9Xf8ljLuOcGM+l0
 D0UkARi898h1HaS0keYZoXEALLzEQQJd2srtnMDbdyTaUkCpXGYHJjBSjqqHc+bVd1aD
 AEBbBf4kgNO6MOMNNVfFn9KiQEbIAFlS5CRYDgcSdp0aKP0Sxd29G1E3xxsAd9qDVwGC
 excOWrX71YbkLOZyc55P0Ybl0iFwhXYVvqCNsFIrzGwQ5t1rXDqV0n2+Bs6/uHBDHTac vA== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 3fm908x4up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 20:35:40 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 23PJZ6Zf008621;
        Mon, 25 Apr 2022 15:35:39 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint6.akamai.com with ESMTP id 3fmct0bw6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 15:35:38 -0400
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com (172.27.165.125) by
 usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 15:35:38 -0400
Received: from USTX2EX-DAG3MB4.msg.corp.akamai.com (172.27.165.128) by
 USTX2EX-DAG3MB1.msg.corp.akamai.com (172.27.165.125) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 14:35:37 -0500
Received: from USTX2EX-DAG3MB4.msg.corp.akamai.com ([172.27.165.128]) by
 USTX2EX-DAG3MB4.msg.corp.akamai.com ([172.27.165.128]) with mapi id
 15.00.1497.033; Mon, 25 Apr 2022 14:35:37 -0500
From:   "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Hunt, Joshua" <johunt@akamai.com>
Subject: Re: Precise disk statistics 
Thread-Topic: Precise disk statistics 
Thread-Index: AQHYVouZqvQv+uCO7UOGBZRe2qwZNq0BCWyA
Date:   Mon, 25 Apr 2022 19:35:37 +0000
Message-ID: <1650915337169.63486@akamai.com>
References: <1650661324247.40468@akamai.com>
In-Reply-To: <1650661324247.40468@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.27.97.87]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250087
X-Proofpoint-ORIG-GUID: 5dYL6fndmt3NXhOksDYh8vAxR6ZyE7AW
X-Proofpoint-GUID: 5dYL6fndmt3NXhOksDYh8vAxR6ZyE7AW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250087
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

________________________________________=0A=
From: Jayaramappa, Srilakshmi=0A=
Sent: Friday, April 22, 2022 5:02 PM=0A=
To: axboe@kernel.dk; snitzer@redhat.com; linux-block@vger.kernel.org=0A=
Cc: Hunt, Joshua=0A=
Subject: Precise disk statistics=0A=
=0A=
Hi,=0A=
=0A=
We install LTS kernel on our machines. While moving from 4.19.x to 5.4.x we=
 noticed a performance drop in one of our applications.=0A=
We tracked down the root cause to the commit series for removing the pendin=
g IO accounting (80a787ba3809 to 6f75723190d8)=0A=
which includes 5b18b5a73760 block: delete part_round_stats and switch to le=
ss precise counting.=0A=
=0A=
The application (which runs on non-dm machines) tracks disk utilization to =
estimate the load it can further take on. After the commits in question,=0A=
we see an over reporting of disk utilization [1] compared to the older meth=
od of reporting based on inflight counter [2] for the same load.=0A=
The over-reporting is observed in v5.4.190 and in v5.15.35 as well. I've at=
tached the config file used to build the kernel.=0A=
=0A=
We understand that the disk util% does not provide a true picture of how mu=
ch more work the device is capable of doing in flash based=0A=
devices and we are planning to use a different model to observe the perform=
ance potential.=0A=
In the interim we are having to revert the above commit series to bring bac=
k the original reporting method.=0A=
=0A=
In the hopes of getting back our application's performance with a new chang=
e on top of the 5.4.x reporting (as opposed to reverting commits),=0A=
I tried checking if the request queue is busy before updating io_ticks [3].=
 With this change the applications's throughput is closer to=0A=
what we observe with the commits reverted, but still behind by ~ 6 %. Thoug=
h, I am not sure that this change is safe overall.=0A=
=0A=
I'd appreciate your expert opinion on this matter. Could you please let us =
know if there is some other idea we could explore to report precise disk st=
ats=0A=
that we can build on top of existing reporting in the kernel and submit a p=
atch, or if going back to using the inflight counters is indeed our best be=
t.=0A=
=0A=
Thank you=0A=
-Sri=0A=
=0A=
[1]=0A=
root@xxx:~# DISK=3Dnvme3n1; dd if=3D/dev/$DISK of=3D/dev/null bs=3D1048576 =
iflag=3Ddirect count=3D2048 & iostat -yxm /dev/$DISK 1 1 ; wait=0A=
...=0A=
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.721532 s, 3.0 GB/s=0A=
=0A=
avg-cpu:  %user   %nice %system %iowait  %steal   %idle=0A=
           0.13    0.00    0.28    1.53    0.00   98.07=0A=
=0A=
Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s   =
  wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm =
d_await dareq-sz  aqu-sz  %util=0A=
nvme3n1       16383.00   2047.88     0.00   0.00    0.21   128.00    0.00  =
    0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00=
    0.00     0.00    0.00  72.20=0A=
=0A=
[2]=0A=
=0A=
root@xxx:~# DISK=3Dnvme3n1; dd if=3D/dev/$DISK of=3D/dev/null bs=3D1048576 =
iflag=3Ddirect count=3D2048 & iostat -yxm /dev/$DISK 1 1 ; wait=0A=
...=0A=
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.702101 s, 3.1 GB/s=0A=
=0A=
avg-cpu:  %user   %nice %system %iowait  %steal   %idle=0A=
           0.03    0.00    0.18    1.57    0.00   98.22=0A=
=0A=
Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s   =
  wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm =
d_await dareq-sz  aqu-sz  %util=0A=
nvme3n1       16380.00   2047.50     0.00   0.00    0.20   128.00    0.00  =
    0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00=
    0.00     0.00    0.00  64.20=0A=
=0A=
=0A=
[3]=0A=
diff --git a/block/bio.c b/block/bio.c=0A=
index cb38d6f3acce..8275b10a1c9a 100644=0A=
--- a/block/bio.c=0A=
+++ b/block/bio.c=0A=
@@ -1754,14 +1754,17 @@ void bio_check_pages_dirty(struct bio *bio)=0A=
        schedule_work(&bio_dirty_work);=0A=
 }=0A=
=0A=
-void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)=
=0A=
+void update_io_ticks(struct request_queue *q, struct hd_struct *part, unsi=
gned long now, bool end)=0A=
 {=0A=
        unsigned long stamp;=0A=
 again:=0A=
        stamp =3D READ_ONCE(part->stamp);=0A=
        if (unlikely(stamp !=3D now)) {=0A=
                if (likely(cmpxchg(&part->stamp, stamp, now) =3D=3D stamp))=
 {=0A=
+                      if (blk_mq_queue_inflight(q)) {=0A=
                                __part_stat_add(part, io_ticks, end ? now -=
 stamp : 1);=0A=
+            }=0A=
                }=0A=
        }=0A=
        if (part->partno) {=0A=
=0A=
=0A=
=0A=
Sorry, resending without the config attachment since my original email boun=
ced from linux-block.=0A=
=0A=
=0A=
Thanks=0A=
-Sri=
