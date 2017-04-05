Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44297 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753976AbdDEGhu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:37:50 -0400
Subject: Re: [PATCH 6/9] T10: Move opencoded contants to common header
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-7-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <149b2a54-c82b-de5c-5f7f-dea1c0ec16b2@suse.de>
Date: Wed, 5 Apr 2017 08:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-7-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  block/t10-pi.c                   | 9 +++------
>  drivers/scsi/lpfc/lpfc_scsi.c    | 5 +++--
>  drivers/scsi/qla2xxx/qla_isr.c   | 8 ++++----
>  drivers/target/target_core_sbc.c | 2 +-
>  include/linux/t10-pi.h           | 2 ++
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
