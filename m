Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750789AbdEBKV0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 06:21:26 -0400
Date: Tue, 2 May 2017 12:21:23 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Treat REQ_FUA and REQ_PREFLUSH as synchronous
Message-ID: <20170502102123.GE13916@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

Commit b685d3d65ac7 "block: treat REQ_FUA and REQ_PREFLUSH as synchronous"
made requests with REQ_FUA and REQ_PREFLUSH to be treated as synchronous
and dropped REQ_SYNC from definitions of WRITE_FUA and friends. This
however introduced a bunch of bugs to filesystems (I know about ext4,
btrfs, f2fs, gfs2, reiserfs regressing because of this) because they
implicitely expected REQ_FUA or REQ_PREFLUSH implies a synchronous request.
At the first sight they do however generic_make_request_checks() will strip
REQ_FUA and REQ_PREFLUSH flags from a bio if the underlying storage does
not have volatile write cache and so writes suddenly become async. I will
go and fix filesystems to explicitely set REQ_SYNC if they want sync
behavior as that is a good cleanup anyway but I wanted to question whether
it makes sense to treat REQ_FUA and REQ_PREFLUSH ops as synchronous in
op_is_sync() since callers cannot rely on this anyway... Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
