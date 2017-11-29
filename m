Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751366AbdK2Tgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 14:36:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vATJXhTQ087578
        for <linux-block@vger.kernel.org>; Wed, 29 Nov 2017 14:36:52 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ej1pbm2q9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 29 Nov 2017 14:36:51 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 29 Nov 2017 19:36:50 -0000
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
 <20171122072857.GA19338@lst.de>
 <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
 <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
 <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
 <20171123183232.GA2845@lst.de>
 <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
 <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
 <20171127155409.GA6937@lst.de>
 <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
Date: Wed, 29 Nov 2017 20:36:45 +0100
MIME-Version: 1.0
In-Reply-To: <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c9c269aa-58ee-450b-31d5-069d00580efe@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 11/29/2017 08:18 PM, Christian Borntraeger wrote:
> Works fine under KVM with virtio-blk, but still hangs during boot in an LPAR.
> FWIW, the system not only has scsi disks via fcp but also DASDs as a boot disk.
> Seems that this is the place where the system stops. (see the sysrq-t output
> at the bottom).

FWIW, the failing kernel had CONFIG_NR_CPUS=256 and 32 CPUS (with SMT2) == 64 threads
with CONFIG_NR_CPUS=16 the system booted fine.
