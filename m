Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40368 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdDCVMu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:12:50 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 0/7] block: T10/DIF Fixes and cleanups v2
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
Date: Mon, 03 Apr 2017 17:12:42 -0400
In-Reply-To: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Mon, 3 Apr 2017 11:23:25 +0400")
Message-ID: <yq1mvbxw5yt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

Dmitry,

> This patch set fix various problems spotted during T10/DIF integrity
> machinery testing.
>
> TOC:
> ## Fix various bugs in T10/DIF/DIX infrastructure
> 0001-bio-integrity-Do-not-allocate-integrity-context-for-fsync
> 0002-bio-integrity-save-original-iterator-for-verify-stage
> 0003-bio-integrity-bio_trim-should-truncate-integrity-vec
> 0004-bio-integrity-fix-interface-for-bio_integrity_trim
> ## Cleanup T10/DIF/DIX infrastructure
> 0005-bio-integrity-add-bio_integrity_setup-helper
> 0006-T10-Move-opencoded-contants-to-common-header
> ## General bulletproof protection for block layer
> 0007-Guard-bvec-iteration-logic-v2

Looks like a nice cleanup of some of the things that have rotted a bit
as a result of the immutable bvec efforts. No major objections from
here. I'll try your series on my qual setup tomorrow to make sure
everything is working correctly.

-- 
Martin K. Petersen	Oracle Linux Engineering
