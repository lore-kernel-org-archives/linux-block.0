Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D1C7618E
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA73214C6
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 07:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfGOHVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:21:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbfGOHVu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 03:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 225C9AFA9;
        Mon, 15 Jul 2019 07:21:49 +0000 (UTC)
Date:   Mon, 15 Jul 2019 09:21:48 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests 11/12] common: Use sysfs instead of modinfo for
 _have_module_param()
Message-ID: <20190715072148.GC4495@x250>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712235742.22646-12-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 12, 2019 at 05:57:41PM -0600, Logan Gunthorpe wrote:
> Using modinfo fails if the given module is built-in. Instead,
> just check for the parameter's existence in sysfs.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 49050c71dabf..d48f73c5bf3d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -48,7 +48,7 @@ _have_modules() {
>  }
>  
>  _have_module_param() {
> -	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
> +	if ! [ -e "/sys/module/$1/parameters/$2" ]; then
>  		SKIP_REASON="$1 module does not have parameter $2"
>  		return 1
>  	fi

But this now fails if the module isn't loaded yet. IMHO we'll need to check if
"/sys/module/$1" exists and if it does check for
"/sys/module/$1/parameters/$2", if not try modinfo.

Does that make sense?

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
