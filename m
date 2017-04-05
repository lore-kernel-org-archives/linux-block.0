Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44471 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbdDEGkB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:40:01 -0400
Subject: Re: [PATCH 8/9] bio: add bvec_iter rewind API
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-9-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <40f06650-15bd-a4d0-57d2-f3fba12271c1@suse.de>
Date: Wed, 5 Apr 2017 08:39:59 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-9-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Some ->bi_end_io handlers (for example: pi_verify or decrypt handlers)
> need to know original data vector, but after bio traverse io-stack it may
> be advanced, splited and relocated many times so it is hard to guess
> original iterator. Let's add 'bi_done' conter which accounts number
> of bytes iterator was advanced during it's evolution. Later end_io handler
> may easily restore original iterator by rewinding iterator to
> iter->bi_done.
> 
> Note: this change makes sizeof (struct bvec_iter) multiple to 8
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  include/linux/bio.h  | 21 +++++++++++++++++++--
>  include/linux/bvec.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
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
