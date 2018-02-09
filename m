Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:37456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBIEwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Feb 2018 23:52:08 -0500
Date: Thu, 8 Feb 2018 20:52:00 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v7 1/2] xfs: remove assert to check bytes returned
Message-ID: <20180209045200.GA5426@magnolia>
References: <20180208185948.26827-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208185948.26827-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 08, 2018 at 12:59:47PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we can return less than count in case of partial direct
> writes, remove the ASSERT.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D
