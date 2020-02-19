Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4007AC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2482464E
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBSPme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:42:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgBSPmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 10:42:32 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JFbAaH041915
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 10:42:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucky101-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 10:42:30 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 19 Feb 2020 15:42:25 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Feb 2020 15:42:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01JFgKeq20906272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 15:42:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 494E74C046;
        Wed, 19 Feb 2020 15:42:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D27A94C040;
        Wed, 19 Feb 2020 15:42:19 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Feb 2020 15:42:19 +0000 (GMT)
Date:   Wed, 19 Feb 2020 16:42:18 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH 1/2] virtio-blk: fix hw_queue stopped on arbitrary error
In-Reply-To: <CACVXFVPBPCzr+sfQ4HOw1DNPGnEfp+5BLqQkXWQgkaBKqr3yVQ@mail.gmail.com>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
        <20200213123728.61216-2-pasic@linux.ibm.com>
        <CACVXFVNiADTW_vLVc1bUSa0CoViLbVzoMnSJW4=sx=MCE-xUPw@mail.gmail.com>
        <20200218133531.3eb08120.pasic@linux.ibm.com>
        <CACVXFVPBPCzr+sfQ4HOw1DNPGnEfp+5BLqQkXWQgkaBKqr3yVQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021915-0012-0000-0000-0000038853E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021915-0013-0000-0000-000021C4E7E3
Message-Id: <20200219164218.6164cb17.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190118
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Feb 2020 09:46:56 +0800
Ming Lei <tom.leiming@gmail.com> wrote:

> On Tue, Feb 18, 2020 at 8:35 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Tue, 18 Feb 2020 10:21:18 +0800
> > Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > > On Thu, Feb 13, 2020 at 8:38 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >
> > > > Since nobody else is going to restart our hw_queue for us, the
> > > > blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
> > > > necessarily sufficient to ensure that the queue will get started again.
> > > > In case of global resource outage (-ENOMEM because mapping failure,
> > > > because of swiotlb full) our virtqueue may be empty and we can get
> > > > stuck with a stopped hw_queue.
> > > >
> > > > Let us not stop the queue on arbitrary errors, but only on -EONSPC which
> > > > indicates a full virtqueue, where the hw_queue is guaranteed to get
> > > > started by virtblk_done() before when it makes sense to carry on
> > > > submitting requests. Let us also remove a stale comment.
> > >
> > > The generic solution may be to stop queue only when there is any
> > > in-flight request
> > > not completed.
> > >
> >
> > I think this is a pretty close to that. The queue is stopped only on
> > ENOSPC, which means virtqueue is full.
> >
> > > Checking -ENOMEM may not be enough, given -EIO can be returned from
> > > virtqueue_add()
> > > too in case of dma map failure.
> >
> > I'm not checking on -ENOMEM. So the queue would not be stopped on EIO.
> > Maybe I'm misunderstanding something In any case, please have another
> > look at the diff, and if your concerns persist please help me understand.
> 
> Looks I misread the patch, and this patch is fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thank you very much!

Regards,
Halil

> 
> 
> Thanks,
> Ming Lei

