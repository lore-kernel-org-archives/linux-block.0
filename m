Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:18400
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeAYP1B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jan 2018 10:27:01 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: [LSF/MM ATTEND] OCSSD topics
Date: Thu, 25 Jan 2018 15:26:56 +0000
Message-ID: <986429B2-A254-4247-AA4F-F631A565DA8B@cnexlabs.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

There are some topics that I would like to discuss at LSF/MM:
  - In the past year we have discussed a lot how we can integrate the
    Open-Channel SSD (OCSSD) spec with zone devices (SMR). This
    discussion is both at the interface level and at an in-kernel level.
    Now that Damien's and Hannes' patches are upstreamed in good shape,
    it would be a good moment to discuss how we can integrate the
    LightNVM subsystem with the existing code. Specifically, in ALPSS'17
    we had discussions on how we can extend the kernel zoned device
    interface with the notion of parallel units that the OCSSD geometry
    builds upon. We are now bringing the OCSSD spec. to standarization,
    but we have time to incorporate feedback and changes into the spec.
   =20
    Some of the challenges are (i) adding vector I/O interface to the
    bio structure and (ii) extending the report zone to have the notion
    of parallelism. I have patches implementing the OCSSD 2.0 spec that
    abstract the geometry and allow upper layers to deal with write
    restrictions and the parallelism of the device, but this is still
    very much OCSSD-specific.

  - I have started to use the above to do a f2fs implementation, where
    we would implement the data placement and I/O scheduling directly in
    the FS, as opposed to using pblk - at least for the journaled part.
    The random I/O partition necessary for metadata can either reside in
    a different drive or use a pblk instance for it. This is very much
    work in progress, so having feedback form the f2fs guys (or other
    journaled file systems) would help to start the work in the right
    direction. Maybe this is interesting for other file systems too...

  - Finally, now that pblk is becoming stable, and given the advent of
    devices imposing sequential-only I/O, would it make sense to
    generalize pblk as a device mapper translation layer that can be
    used for random I/O partitions? We have ad internal use cases for
    using such translation layer for frontswap devices. Maybe others are
    looking at this too...

Javier
