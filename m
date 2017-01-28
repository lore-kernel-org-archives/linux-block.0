Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35585 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbdA1ASf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 19:18:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0S0EOsT043471
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 19:18:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 288ajgkpuq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 19:18:34 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Fri, 27 Jan 2017 19:18:33 -0500
Subject: Re: [PATCH V2 0/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
To: Tejun Heo <tj@kernel.org>
References: <1485559936-14133-1-git-send-email-dougmill@linux.vnet.ibm.com>
 <20170128001349.GB2476@mtj.duckdns.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        linux-block@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 18:18:30 -0600
MIME-Version: 1.0
In-Reply-To: <20170128001349.GB2476@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5fe40284-dd72-7952-47a6-b5ebc375f8a1@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I will re-test and post the patch using "bool" when finished.

On 01/27/2017 06:13 PM, Tejun Heo wrote:
> On Fri, Jan 27, 2017 at 05:32:15PM -0600, Douglas Miller wrote:
>> Removed extraneous parentheses. Did not switch to "bool" as that would necessitate
>> more testing and raises the question whether other platforms might have a different
>> definition for "bool" that would not fix this problem.
> Please switch to bool.
>
> Thanks.
>

