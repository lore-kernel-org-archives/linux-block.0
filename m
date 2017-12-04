Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751208AbdLDMbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 07:31:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB4CTI00105564
        for <linux-block@vger.kernel.org>; Mon, 4 Dec 2017 07:31:13 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2en46w72ex-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2017 07:31:12 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Mon, 4 Dec 2017 05:31:10 -0700
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
 <1512144528.2520.2.camel@sandisk.com>
 <ea717cce-a083-1fef-362f-6c302b4434fa@linux.vnet.ibm.com>
 <20171202004953.GB24521@ming.t460p>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 10:31:01 -0200
MIME-Version: 1.0
In-Reply-To: <20171202004953.GB24521@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <80ff6002-2fa5-a6ce-f6a2-d65df72280b2@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/01/2017 10:49 PM, Ming Lei wrote:
>> Unfortunately v2 has been found to exhibit another problem, an Oops in
>> the systemd shutdown path for device-mapper LVM volumes at least, when
>> calling 'q->request_fn(q)' if 'q->request_fn' is NULL.
> That issue can be fixed easily in V2 and we understand DM's case clearly.

Yes. It just had not been mentioned upstream yet.

> But the most important thing is that V2 can't fix Chenxiang's issue, but
> V3/V1 can.

Agree.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
