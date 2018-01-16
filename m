Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41577 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751639AbeAPKAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 05:00:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0G9wexC009752
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2018 05:00:16 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fhc39ge2j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2018 05:00:15 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.vnet.ibm.com>;
        Tue, 16 Jan 2018 10:00:13 -0000
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
To: Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20180112025306.28004-1-ming.lei@redhat.com>
 <20180112025306.28004-3-ming.lei@redhat.com>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 11:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180112025306.28004-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1b45f625-f59c-9def-1346-f91ed89ac72f@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ming or Christoph,

would you mind to send this patch to stable #4.12? Or is the fixes tag 
enough to get this fixed in all related releases?

Regards,
Stefan
