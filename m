Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22700 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936041AbdDTClI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:41:08 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 5/9] bio-integrity: fold bio_integrity_enabled to bio_integrity_prep
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-6-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:40:58 -0400
In-Reply-To: <1491332201-26926-6-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:37 +0400")
Message-ID: <yq18tmvpzr9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

> Currently all integrity prep hooks are open-coded, and if prepare
> fails we ignore it's code and fail bio with EIO. Let's return real
> error to upper layer, so later caller may react accordingly.
>
> In fact no one want to use bio_integrity_prep() w/o
> bio_integrity_enabled, so it is reasonable to fold it in to one
> function.

Agree with Christoph's comments. Otherwise OK.

-- 
Martin K. Petersen	Oracle Linux Engineering
