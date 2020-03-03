Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB04C3F2D1
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84702083E
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 17:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgCCRCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:02:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15461 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727175AbgCCRCa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 12:02:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023GoX89008485
        for <linux-block@vger.kernel.org>; Tue, 3 Mar 2020 12:02:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmu5e598-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 12:02:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Mar 2020 17:02:26 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 17:02:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 023H2M4V37880164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 17:02:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFC684C052;
        Tue,  3 Mar 2020 17:02:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 823854C04A;
        Tue,  3 Mar 2020 17:02:21 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.80])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Mar 2020 17:02:21 +0000 (GMT)
Date:   Tue, 3 Mar 2020 18:02:20 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
In-Reply-To: <20200303094909-mutt-send-email-mst@kernel.org>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
        <20200303151252.59d45e86.pasic@linux.ibm.com>
        <20200303094909-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030317-4275-0000-0000-000003A80899
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030317-4276-0000-0000-000038BD117E
Message-Id: <20200303180220.7e38f9fd.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 3 Mar 2020 09:49:21 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 03, 2020 at 03:12:52PM +0100, Halil Pasic wrote:
> > On Thu, 13 Feb 2020 13:37:26 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > > Two patches are handling new edge cases introduced by doing DMA mappings
> > > (which can fail) in virtio core.
> > > 
> > > I stumbled upon this while stress testing I/O for Protected Virtual
> > > Machines. I deliberately chose a tiny swiotlb size and have generated
> > > load with fio. With more than one virtio-blk disk in use I experienced
> > > hangs.
> > > 
> > > The goal of this series is to fix those hangs.
> > > 
> > > Halil Pasic (2):
> > >   virtio-blk: fix hw_queue stopped on arbitrary error
> > >   virtio-blk: improve virtqueue error to BLK_STS
> > > 
> > >  drivers/block/virtio_blk.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > 
> > > base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> > 
> > ping
> > 
> > Hi Michael, hi Jason,
> > 
> > I got some favorable reviews for this, but AFAIK I got nothing form the
> > maintainers yet.
> > 
> > Is some of you going to pick these?
> > 
> > Regards,
> > Halil
> 
> I've queued this, thanks!
> 

Thank you!

