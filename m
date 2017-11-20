Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751867AbdKTTaE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Nov 2017 14:30:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKJT4lj088463
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2017 14:30:03 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ec0dchkby-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2017 14:30:02 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 20 Nov 2017 19:30:01 -0000
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jasowang@redhat.com" <jasowang@redhat.com>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 20:29:56 +0100
MIME-Version: 1.0
In-Reply-To: <1511205644.2396.32.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 11/20/2017 08:20 PM, Bart Van Assche wrote:
> On Fri, 2017-11-17 at 15:42 +0100, Christian Borntraeger wrote:
>> This is 
>>
>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1141)     * are mapped to it.
>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1142)     */
>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1143)    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1144)            cpu_online(hctx->next_cpu));
>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1145) 
>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1146)    /*
> 
> Did you really try to figure out when the code that reported the warning
> was introduced? I think that warning was introduced through the following
> commit:

This was more a cut'n'paste to show which warning triggered since line numbers are somewhat volatile.

> 
> commit fd1270d5df6a005e1248e87042159a799cc4b2c9
> Date:   Wed Apr 16 09:23:48 2014 -0600
> 
>     blk-mq: don't use preempt_count() to check for right CPU
>      
>     UP or CONFIG_PREEMPT_NONE will return 0, and what we really
>     want to check is whether or not we are on the right CPU.
>     So don't make PREEMPT part of this, just test the CPU in
>     the mask directly.
> 
> Anyway, I think that warning is appropriate and useful. So the next step
> is to figure out what work item was involved and why that work item got
> executed on the wrong CPU.

It seems to be related to virtio-blk (is triggered by fio on such disks). Your comment basically
says: "no this is not a known issue" then :-)
I will try to take a dump to find out the work item
