Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35958 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbdECQGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 12:06:48 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
In-Reply-To: <yq1h91jpzyn.fsf@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org> <1491332201-26926-4-git-send-email-dmonakhov@openvz.org> <yq1h91jpzyn.fsf@oracle.com>
Date: Wed, 03 May 2017 19:06:43 +0300
Message-ID: <87wp9xq60c.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

"Martin K. Petersen" <martin.petersen@oracle.com> writes:

> Dmitry Monakhov <dmonakhov@openvz.org> writes:
>
>> SCSI drivers do care about bip_seed so we must update it accordingly.
>
>> +	bip->bip_iter.bi_sector += bytes_done >> 9;
>
> This needs to count protection intervals. Otherwise things will break
> for block sizes different from 512 bytes.
No,
AFAIU: bip->bip_iter.bi_sector is always equals to bio->bi_iter.bi_sector
at least bip_set_seed() and bip_get_seed() relays on that.
Only bip->bip_vec must be advanced in intervals (this behavior not
changed by the patch this patch).
>
> -- 
> Martin K. Petersen	Oracle Linux Engineering
