Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758153AbdCUQc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 12:32:59 -0400
Subject: Re: [PATCH v2 0/4] block: callback-based statistics
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <cover.1490110621.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b1e275a2-f254-db5a-212c-81ce545fef57@fb.com>
Date: Tue, 21 Mar 2017 12:04:35 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/21/2017 11:56 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This patchset generalizes the blk-stats infrastructure to allow users to
> register a callback to be called at a given time with the statistics of
> requests completed during that window. Writeback throttling and hybrid
> polling are converted to the new infrastructure. The new Kyber I/O
> scheduler uses this, as well (but it needs to be rebased on this v2).
> 
> The details are in patch 4, which is the actual conversion. Patches 1-3
> are preparation cleanups.
> 
> Changes since v1:
> 
> - Now the user can subdivide stats into arbitrary buckets. Both in-tree
>   users just do reads vs. writes, but we can extend poll based on
>   request size in the future
> - blk_stat_arm_callback() became blk_stat_activate_msecs() and
>   blk_stat_activate_nsecs()
> - The poll statistics are exposed in debugfs
> 
> Omar Sandoval (4):
>   block: remove extra calls to wbt_exit()
>   blk-stat: use READ and WRITE instead of BLK_STAT_{READ,WRITE}
>   blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
>   blk-stat: convert to callback-based statistics reporting

Added for 4.12, thanks Omar. This is a nice improvement for the
writeback throttling as well, since solves the issues with
the stats and throttling having separate and unsynced windows.

-- 
Jens Axboe
