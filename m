Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755940AbdLVUKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Dec 2017 15:10:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBMK96xW135354
        for <linux-block@vger.kernel.org>; Fri, 22 Dec 2017 15:10:36 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2f16atdwxb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 22 Dec 2017 15:10:36 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 22 Dec 2017 20:10:34 -0000
Subject: Re: regression 4.15-rc: kernel oops in dm-multipath
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>
References: <7dc463af-554f-1778-7e24-757de143d6b7@de.ibm.com>
 <1513958435.2579.1.camel@wdc.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Dec 2017 21:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <1513958435.2579.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <e2340502-a5f3-355a-008a-d15dc5e2b7a3@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I will give that commit a try. Thanks.

On 12/22/2017 05:00 PM, Bart Van Assche wrote:
> On Fri, 2017-12-22 at 10:53 +0100, Christian Borntraeger wrote:
>> any quick ideas?
> 
> Hello Christian,
> 
> Was commit afc567a4977b ("dm table: fix regression from improper dm_dev_internal.count
> refcount_t conversion") included in your test kernel?
> 
> Bart.
> 
