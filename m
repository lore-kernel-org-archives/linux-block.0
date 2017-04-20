Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22355 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764035AbdDTCgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:36:44 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:36:32 -0400
In-Reply-To: <1491332201-26926-4-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:35 +0400")
Message-ID: <yq1h91jpzyn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

> SCSI drivers do care about bip_seed so we must update it accordingly.

> +	bip->bip_iter.bi_sector += bytes_done >> 9;

This needs to count protection intervals. Otherwise things will break
for block sizes different from 512 bytes.

-- 
Martin K. Petersen	Oracle Linux Engineering
