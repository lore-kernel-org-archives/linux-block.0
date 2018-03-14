Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:48288 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCNPur (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:47 -0400
To: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Subject: Re: [PATCH] dm mpath: fix passing integrity data
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 11:46:21 -0400
In-Reply-To: <20180314143306.98405-1-maier@linux.vnet.ibm.com> (Steffen
        Maier's message of "Wed, 14 Mar 2018 15:33:06 +0100")
Message-ID: <yq14llid5iq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Steffen,

> After v4.12 commit e2460f2a4bc7 ("dm: mark targets that pass integrity
> data"), dm-multipath, e.g. on DIF+DIX SCSI disk paths, does not support
> block integrity any more. So add it to the whitelist.

Ugh.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
