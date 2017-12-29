Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751084AbdL2Oeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Dec 2017 09:34:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBTEYCcD144207
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2017 09:34:35 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2f5mk31ktu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2017 09:34:35 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 29 Dec 2017 14:29:33 -0000
Subject: Re: regression 4.15-rc: kernel oops in dm-multipath
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>
References: <7dc463af-554f-1778-7e24-757de143d6b7@de.ibm.com>
 <1513958435.2579.1.camel@wdc.com>
 <e2340502-a5f3-355a-008a-d15dc5e2b7a3@de.ibm.com>
Date: Fri, 29 Dec 2017 15:29:30 +0100
MIME-Version: 1.0
In-Reply-To: <e2340502-a5f3-355a-008a-d15dc5e2b7a3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5064ec29-d212-5e7e-7463-980bc1839acc@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 12/22/2017 09:10 PM, Christian Borntraeger wrote:
> I will give that commit a try. Thanks.
> 
> On 12/22/2017 05:00 PM, Bart Van Assche wrote:
>> On Fri, 2017-12-22 at 10:53 +0100, Christian Borntraeger wrote:
>>> any quick ideas?
>>
>> Hello Christian,
>>
>> Was commit afc567a4977b ("dm table: fix regression from improper dm_dev_internal.count
>> refcount_t conversion") included in your test kernel?

With this commit the problem seems solved. thanks
