Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752536AbeDQPSX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 11:18:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3HFB4H5068624
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 11:18:23 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hdj4pvxd6-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 11:18:23 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 09:18:22 -0600
Subject: Re: [PATCH] target: Fix Fortify_panic kernel exception
To: Christoph Hellwig <hch@lst.de>
Cc: nab@linux-iscsi.org, martin.petersen@oracle.com,
        seroyer@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org
References: <1523566722-24667-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <20180413164452.GA22904@lst.de>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 10:18:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180413164452.GA22904@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <7b51a970-942e-2ac5-4762-07d6aec82d09@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 4/13/18 11:44 AM, Christoph Hellwig wrote:

> The patch looks fine, but in general I think descriptions of what
> you fixed in the code or more important than starting out with
> a backtrace.
>
> E.g. please explain what was wrong, how you fixed it and only after
> that mention how it was caught.  (preferably without the whole trace)
>
I will put the trace at the end next time. Do you want me to re-submit
with it moved?

-Bryant
