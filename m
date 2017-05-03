Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43989 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdECQKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 12:10:17 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
        <yq1h91jpzyn.fsf@oracle.com> <87wp9xq60c.fsf@dmlp.sw.ru>
Date: Wed, 03 May 2017 12:10:04 -0400
In-Reply-To: <87wp9xq60c.fsf@dmlp.sw.ru> (Dmitry Monakhov's message of "Wed,
        03 May 2017 19:06:43 +0300")
Message-ID: <yq1h911zztv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Dmitry,

> AFAIU: bip->bip_iter.bi_sector is always equals to bio->bi_iter.bi_sector
> at least bip_set_seed() and bip_get_seed() relays on that.
> Only bip->bip_vec must be advanced in intervals (this behavior not
> changed by the patch this patch).

Yep, I realized that a bit after sending but forgot to follow up.

-- 
Martin K. Petersen	Oracle Linux Engineering
