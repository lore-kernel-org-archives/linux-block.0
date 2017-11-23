Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752931AbdKWS2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 13:28:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vANISa1F106750
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 13:28:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2edyapk1c2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 13:28:38 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 23 Nov 2017 18:28:35 -0000
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <c438db5f-f4f1-69f8-37f3-e91eae29fa25@de.ibm.com>
 <d8dbde03-f528-1cac-03dd-bcc724fcd5c8@kernel.dk>
 <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com>
 <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk>
 <1ddd1cd4-2862-849e-7849-82544bcb86be@de.ibm.com>
 <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
 <20171122072857.GA19338@lst.de>
 <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
 <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 23 Nov 2017 19:28:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171123182542.GA2680@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

zfcp on s390.

On 11/23/2017 07:25 PM, Christoph Hellwig wrote:
> What HBA driver do you use in the host?
> 
