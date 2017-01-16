Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbdAPUAm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 15:00:42 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
References: <20170114002008.GA25379@linux.intel.com>
        <20170114082621.GC10498@birch.djwong.org>
Date: Mon, 16 Jan 2017 15:00:41 -0500
In-Reply-To: <20170114082621.GC10498@birch.djwong.org> (Darrick J. Wong's
        message of "Sat, 14 Jan 2017 00:26:21 -0800")
Message-ID: <x49wpduzseu.fsf@dhcp-25-115.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

>> - Whenever you mount a filesystem with DAX, it spits out a message that says
>>   "DAX enabled. Warning: EXPERIMENTAL, use at your own risk".  What criteria
>>   needs to be met for DAX to no longer be considered experimental?
>
> For XFS I'd like to get reflink working with it, for starters.

What do you mean by this, exactly?  When Dave outlined the requirements
for PMEM_IMMUTABLE, it was very clear that metadata updates would not be
possible.  And would you really cosider this a barrier to marking dax
fully supported?  I wouldn't.

> We probably need a bunch more verification work to show that file IO
> doesn't adopt any bad quirks having turned on the per-inode DAX flag.

Can you be more specific?  We have ltp and xfstests.  If you have some
mkfs/mount options that you think should be tested, speak up.  Beyond
that, if it passes ./check -g auto and ltp, are we good?

-Jeff
