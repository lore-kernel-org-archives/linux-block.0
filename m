Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeASCN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 21:13:56 -0500
Date: Fri, 19 Jan 2018 02:13:53 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Message-ID: <20180119021352.GE13338@ZenIV.linux.org.uk>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119005741.32058-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 18, 2018 at 06:57:40PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> In case direct I/O encounters an error midway, it returns the error.
> Instead it should be returning the number of bytes transferred so far.
> 
> Test case for filesystems (with ENOSPC):
> 1. Create an almost full filesystem
> 2. Create a file, say /mnt/lastfile, until the filesystem is full.
> 3. Direct write() with count > sizeof /mnt/lastfile.
> 
> Result: write() returns -ENOSPC. However, file content has data written
> in step 3.
> 
> This fixes fstest generic/472.

OK...  I can live with that.  What about the XFS side?  It should be
a prereq, to avoid bisection hazard; I can throw both into vfs.git,
if XFS folks are OK with that.  Objections?
