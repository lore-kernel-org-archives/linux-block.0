Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751506AbdHGR3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 13:29:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v77HSd5Z027220
        for <linux-block@vger.kernel.org>; Mon, 7 Aug 2017 13:29:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c6rw32ff9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 07 Aug 2017 13:29:55 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Mon, 7 Aug 2017 13:29:54 -0400
Subject: Re: nvmf question - synchronization between target/initiator
 regarding partitions
To: Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc: Mauricio pIO <mauricfo@linux.vnet.ibm.com>,
        Brian J King <bjking1@us.ibm.com>,
        Murali N Iyer <mniyer@us.ibm.com>, vnarasimhan@in.ibm.com
References: <82c4d1d8-ffa9-fa99-df58-05e2945eafdc@linux.vnet.ibm.com>
 <c382184a-1621-c6b2-2a20-bd16498be998@suse.de>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Mon, 7 Aug 2017 14:29:47 -0300
MIME-Version: 1.0
In-Reply-To: <c382184a-1621-c6b2-2a20-bd16498be998@suse.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <4c199e9e-ed58-5a5b-cedc-2d3c3bc1464c@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for your feedback Hannes, agreed!

Cheers,


Guilherme
