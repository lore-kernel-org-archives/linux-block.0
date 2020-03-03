Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77382C3F2C6
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E482086A
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 14:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgCCONC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:13:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbgCCONB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 09:13:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023Dt2N5123054
        for <linux-block@vger.kernel.org>; Tue, 3 Mar 2020 09:13:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfhs53g6c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 09:13:00 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Mar 2020 14:12:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 14:12:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 023ECrkS50069520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 14:12:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D75FC4204B;
        Tue,  3 Mar 2020 14:12:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2484203F;
        Tue,  3 Mar 2020 14:12:53 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.80])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Mar 2020 14:12:53 +0000 (GMT)
Date:   Tue, 3 Mar 2020 15:12:52 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping
 failures
In-Reply-To: <20200213123728.61216-1-pasic@linux.ibm.com>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030314-0020-0000-0000-000003B0199C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030314-0021-0000-0000-000022084913
Message-Id: <20200303151252.59d45e86.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_04:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003030107
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 13 Feb 2020 13:37:26 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> Two patches are handling new edge cases introduced by doing DMA mappings
> (which can fail) in virtio core.
> 
> I stumbled upon this while stress testing I/O for Protected Virtual
> Machines. I deliberately chose a tiny swiotlb size and have generated
> load with fio. With more than one virtio-blk disk in use I experienced
> hangs.
> 
> The goal of this series is to fix those hangs.
> 
> Halil Pasic (2):
>   virtio-blk: fix hw_queue stopped on arbitrary error
>   virtio-blk: improve virtqueue error to BLK_STS
> 
>  drivers/block/virtio_blk.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473

ping

Hi Michael, hi Jason,

I got some favorable reviews for this, but AFAIK I got nothing form the
maintainers yet.

Is some of you going to pick these?

Regards,
Halil

