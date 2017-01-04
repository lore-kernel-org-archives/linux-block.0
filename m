Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757987AbdADIuJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Jan 2017 03:50:09 -0500
To: lsf-pc@lists.linux-foundation.org
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM TOPIC] blk-trace update vs API stability
Message-ID: <62463a62-2dcb-639c-364c-3cc8b50628d2@suse.de>
Date: Wed, 4 Jan 2017 09:49:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

during investigating performance issues I frequently have the need to
include the request tag in the scsi tracepoints. While this can be
easily done for scsi, including it in block trace output is not that
easy due to the interdependency with the blktrace utilities.

Also there had been some discussion on KS last year, but with no
conclusive result IIRC.

At LSF I'd like to discuss
- Do we consider blktrace (and any other tracepoint in eg SCSI) as a
stable API?
- How do we go about modifying blktrace? Is this even desired?
  Or should any trace event modification be opaque to blktrace output?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
