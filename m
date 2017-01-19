Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdASGcz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 01:32:55 -0500
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media
 management
To: Song Liu <songliubraving@fb.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
Cc: Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Coly Li <colyli@suse.de>
Message-ID: <f053f641-3fbd-0276-faff-fba954985b66@suse.de>
Date: Thu, 19 Jan 2017 14:32:45 +0800
MIME-Version: 1.0
In-Reply-To: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/1/19 上午7:34, Song Liu wrote:
> 
> Media health monitoring is very important for large scale distributed storage systems. 
> Traditionally, enterprise storage controllers maintain event logs for attached storage
> devices. However, these controller managed logs do not scale well for large scale 
> distributed systems. 
> 
> While designing a more flexible and scalable event logging systems, we think it is better
> to build the log in block layer. Block level event logging covers all major storage media
> (SCSI, SATA, NVMe), and thus minimizes redundant work for different protocols. 
> 
> In this LSF/MM, we would like to discuss the following topics with the community:
>     1. Mechanism for drivers report events (or errors) to block layer. 
>        Basically, we will need a traceable function for the drivers to report errors 
>        (most likely right before calling end_request or bio_endio).  
>   
>     2. What mechanism (ftrace, BPF, etc.) is mostly preferred for the event logging?
> 
>     3. How should we categorize different events?
>        Currently, there are existing code that translates ATA error (ata_to_sense_error) 
>        and NVMe error (nvme_trans_status_code) to SCSI sense code. So we can 
>        leverage SCSI Key Code Qualifier for event categorizations. 
> 
>     4. Detailed discussions on data structure for event logging. 
> 
> We will be able to show a prototype implementation during LSF/MM. 

This is an interesting topic. For stacked block devices, all layers
higher than the fault layer will observe the media error, reporting the
underlying failure in every layer may introduce quite a lot noise.

Yes, I am willing to attend this discussion.

Thanks.

Coly Li
