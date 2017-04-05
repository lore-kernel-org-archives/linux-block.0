Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44545 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753769AbdDEGlJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:41:09 -0400
Subject: Re: [PATCH 9/9] bio-integrity: Restore original iterator on verify
 stage
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-10-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57ae8e22-9a7c-1fd9-82a2-96224786e1d2@suse.de>
Date: Wed, 5 Apr 2017 08:41:07 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-10-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Currently ->verify_fn not woks at all because at the moment it is called
> bio->bi_iter.bi_size == 0, so we do not iterate integrity bvecs at all.
> 
> In order to perform verification we need to know original data vector,
> with new bvec rewind API this is trivial.
> 
> testcase: https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  block/bio-integrity.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
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
