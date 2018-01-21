Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932145AbeAUC5G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jan 2018 21:57:06 -0500
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: Al Viro <viro@ZenIV.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <20180119021352.GE13338@ZenIV.linux.org.uk> <20180119035951.GM16421@dastard>
 <20180119063118.GD5597@magnolia> <20180119063356.GI13338@ZenIV.linux.org.uk>
 <20180120194744.GA14716@ZenIV.linux.org.uk>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <8e77a39a-304d-020d-086f-6f5093dc6c8d@suse.de>
Date: Sat, 20 Jan 2018 20:57:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180120194744.GA14716@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 01/20/2018 01:47 PM, Al Viro wrote:
> On Fri, Jan 19, 2018 at 06:33:56AM +0000, Al Viro wrote:
>>> For both patches,
>>> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>>
>> Applied; will be in -next tomorrow morning after the tree I'm putting together
>> gets through local beating.
> 
> FWIW, it consistently blows generic/250 and generic/252.
> 

Thanks. I will look into it. It is performing direct writes with dm_error.
Hopefully it should be just updating the md5sum in the output files.

-- 
Goldwyn
