Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:43869 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752671AbcLMUQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 15:16:13 -0500
Date: Wed, 14 Dec 2016 07:15:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jerome Glisse <jglisse@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Un-addressable device memory and block/fs
 implications
Message-ID: <20161213201515.GB4326@dastard>
References: <20161213181511.GB2305@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213181511.GB2305@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 13, 2016 at 01:15:11PM -0500, Jerome Glisse wrote:
> I would like to discuss un-addressable device memory in the context of
> filesystem and block device. Specificaly how to handle write-back, read,
> ... when a filesystem page is migrated to device memory that CPU can not
> access.

You mean pmem that is DAX-capable that suddenly, without warning,
becomes non-DAX capable?

If you are not talking about pmem and DAX, then exactly what does
"when a filesystem page is migrated to device memory that CPU can
not access" mean? What "filesystem page" are we talking about that
can get migrated from main RAM to something the CPU can't access?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
