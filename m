Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24824 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934137AbdDTCvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:51:19 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 8/9] bio: add bvec_iter rewind API
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-9-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:51:08 -0400
In-Reply-To: <1491332201-26926-9-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:40 +0400")
Message-ID: <yq1zifbokpv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

Dmitry,

> Some ->bi_end_io handlers (for example: pi_verify or decrypt handlers)
> need to know original data vector, but after bio traverse io-stack it
> may be advanced, splited and relocated many times so it is hard to
> guess original iterator. Let's add 'bi_done' conter which accounts
> number of bytes iterator was advanced during it's evolution. Later
> end_io handler may easily restore original iterator by rewinding
> iterator to iter->bi_done.

Originally, the original integrity bip was immutable. Any slicing and
dicing was exclusively done on clones. And therefore the original bip
was always suitable for use with verify.

-- 
Martin K. Petersen	Oracle Linux Engineering
