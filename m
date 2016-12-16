Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49179 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751710AbcLPDOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 22:14:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBG3DvOi038625
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 22:14:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27c2hnhg78-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 22:14:18 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 15 Dec 2016 20:14:17 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM ATTEND] Un-addressable device memory and block/fs implications
In-Reply-To: <20161213181511.GB2305@redhat.com>
References: <20161213181511.GB2305@redhat.com>
Date: Fri, 16 Dec 2016 08:44:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgvgwoos.fsf@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jerome Glisse <jglisse@redhat.com> writes:

> I would like to discuss un-addressable device memory in the context of
> filesystem and block device. Specificaly how to handle write-back, read,
> ... when a filesystem page is migrated to device memory that CPU can not
> access.
>
> I intend to post a patchset leveraging the same idea as the existing
> block bounce helper (block/bounce.c) to handle this. I believe this is
> worth discussing during summit see how people feels about such plan and
> if they have better ideas.
>
>
> I also like to join discussions on:
>   - Peer-to-Peer DMAs between PCIe devices
>   - CDM coherent device memory
>   - PMEM
>   - overall mm discussions

I would like to attend this discussion. I can talk about coherent device
memory and how having HMM handle that will make it easy to have one
interface for device driver. For Coherent device case we definitely need
page cache migration support.

-aneesh

