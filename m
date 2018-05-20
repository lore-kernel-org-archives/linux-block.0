Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57240 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbeETB3J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 May 2018 21:29:09 -0400
Date: Sat, 19 May 2018 21:29:01 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v7 2/2] Return bytes transferred for partial direct I/O
Message-ID: <20180520012901.GA5805@thunk.org>
References: <20180208185948.26827-1-rgoldwyn@suse.de>
 <20180208185948.26827-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208185948.26827-2-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 08, 2018 at 12:59:48PM -0600, Goldwyn Rodrigues wrote:
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
> Added a sysctl entry: dio_short_writes which is on by default. This is
> to support applications which expect either and error or the bytes submitted
> as a return value for the write calls.
> 
> This fixes fstest generic/472.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Hi,

I was wondering if you could give an update regarding what's up with
this patch?

There doesn't seem to be any movement on this patch in a while, and so
I still have xfstests generic/472 suppressed in {kvm,gce}-xfstests.

Thanks,

						- Ted
