Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33627 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbdEJWm7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 18:42:59 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/9] bio-integrity: fold bio_integrity_enabled to bio_integrity_prep
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
        <1494429652-9488-6-git-send-email-dmonakhov@openvz.org>
Date: Wed, 10 May 2017 18:42:48 -0400
In-Reply-To: <1494429652-9488-6-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Wed, 10 May 2017 19:20:48 +0400")
Message-ID: <yq1lgq4mizb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Dmitry,

> Currently all integrity prep hooks are open-coded, and if prepare
> fails we ignore it's code and fail bio with EIO. Let's return real
> error to upper layer, so later caller may react accordingly.
>
> In fact no one want to use bio_integrity_prep() w/o
> bio_integrity_enabled, so it is reasonable to fold it in to one
> function.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
