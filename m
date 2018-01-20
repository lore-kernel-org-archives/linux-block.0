Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51686 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbeATTrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jan 2018 14:47:52 -0500
Date: Sat, 20 Jan 2018 19:47:44 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Message-ID: <20180120194744.GA14716@ZenIV.linux.org.uk>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <20180119021352.GE13338@ZenIV.linux.org.uk>
 <20180119035951.GM16421@dastard>
 <20180119063118.GD5597@magnolia>
 <20180119063356.GI13338@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119063356.GI13338@ZenIV.linux.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 19, 2018 at 06:33:56AM +0000, Al Viro wrote:
> > For both patches,
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Applied; will be in -next tomorrow morning after the tree I'm putting together
> gets through local beating.

FWIW, it consistently blows generic/250 and generic/252.
