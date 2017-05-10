Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31541 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdEJWp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 18:45:29 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] Guard bvec iteration logic
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
        <1494429652-9488-8-git-send-email-dmonakhov@openvz.org>
Date: Wed, 10 May 2017 18:45:22 -0400
In-Reply-To: <1494429652-9488-8-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Wed, 10 May 2017 19:20:50 +0400")
Message-ID: <yq1d1bgmiv1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Dmitry,

> Currently if some one try to advance bvec beyond it's size we simply
> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
> This simply means that we endup dereferencing/corrupting random memory
> region.
>
> Sane reaction would be to propagate error back to calling context But
> bvec_iter_advance's calling context is not always good for error
> handling. For safity reason let truncate iterator size to zero which
> will break external iteration loop which prevent us from unpredictable
> memory range corruption. And even it caller ignores an error, it will
> corrupt it's own bvecs, not others.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
