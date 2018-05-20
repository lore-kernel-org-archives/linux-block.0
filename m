Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeETNzC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 May 2018 09:55:02 -0400
Subject: Re: [PATCH v7 2/2] Return bytes transferred for partial direct I/O
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        fstests@vger.kernel.org
References: <20180208185948.26827-1-rgoldwyn@suse.de>
 <20180208185948.26827-2-rgoldwyn@suse.de> <20180520012901.GA5805@thunk.org>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <c88b3bcf-dcec-d509-e5ee-708aeb4c2150@suse.de>
Date: Sun, 20 May 2018 08:54:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180520012901.GA5805@thunk.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 05/19/2018 08:29 PM, Theodore Y. Ts'o wrote:
> On Thu, Feb 08, 2018 at 12:59:48PM -0600, Goldwyn Rodrigues wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> In case direct I/O encounters an error midway, it returns the error.
>> Instead it should be returning the number of bytes transferred so far.
>>
>> Test case for filesystems (with ENOSPC):
>> 1. Create an almost full filesystem
>> 2. Create a file, say /mnt/lastfile, until the filesystem is full.
>> 3. Direct write() with count > sizeof /mnt/lastfile.
>>
>> Result: write() returns -ENOSPC. However, file content has data written
>> in step 3.
>>
>> Added a sysctl entry: dio_short_writes which is on by default. This is
>> to support applications which expect either and error or the bytes submitted
>> as a return value for the write calls.
>>
>> This fixes fstest generic/472.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Hi,
> 
> I was wondering if you could give an update regarding what's up with
> this patch?
> 
> There doesn't seem to be any movement on this patch in a while, and so
> I still have xfstests generic/472 suppressed in {kvm,gce}-xfstests.
> 

>From earlier discussions, In between errors of a direct I/O cannot be
handled correctly and may need a lot of tracking that it is not worth
performing.

It would be better to drop this test case and add in the documentation
that a direct I/O error could mean that the write() may or may not have
occurred and underlying data may be inconsistent. I am proposing:

diff --git a/man2/write.2 b/man2/write.2
index f8a94f3ff..86f655e26 100644
--- a/man2/write.2
+++ b/man2/write.2
@@ -274,6 +274,14 @@ On Linux,
 returning the number of bytes actually transferred.
 .\" commit e28cc71572da38a5a12c1cfe4d7032017adccf69
 (This is true on both 32-bit and 64-bit systems.)
+.PP
+While performing
+.BR write()
+using direct I/O, an error returned does not mean the
+entire write has failed. Partial data may be written
+and the file offset to length on which the
+.BR write()
+was attempted should be considered inconsistent.
 .SH BUGS
 According to POSIX.1-2008/SUSv4 Section XSI 2.9.7
 ("Thread Interactions with Regular File Operations"):


-- 
Goldwyn
