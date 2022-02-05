Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC1C433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Feb 2022 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiBERub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Feb 2022 12:50:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47979 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235159AbiBERub (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Feb 2022 12:50:31 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 215HoHV8005452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Feb 2022 12:50:18 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 419F015C401D; Sat,  5 Feb 2022 12:50:17 -0500 (EST)
Date:   Sat, 5 Feb 2022 12:50:17 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dwagner@suse.de, osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <Yf642Rr4mDsZ7HnS@mit.edu>
References: <20211116172926.587062-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116172926.587062-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 09:29:26AM -0800, Luis Chamberlain wrote:
> diff --git a/common/rc b/common/rc
> index 85e6314..2b551bf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -321,15 +321,143 @@ _uptime_s() {
>  	awk '{ print int($1) }' /proc/uptime
>  }
>  
> -# Arguments: module to unload ($1) and retry count ($2).
> -unload_module() {
> -	local i m=$1 rc=${2:-1}
> -
> -	[ ! -e "/sys/module/$m" ] && return 0
> -	for ((i=rc;i>0;i--)); do
> -		modprobe -r "$m"
> -		[ ! -e "/sys/module/$m" ] && return 0
> -		sleep .1
> +# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
> +# modprobe removal to run forever trying to remove a module.
> +MODPROBE_REMOVE_PATIENT=""
> +modprobe --help | grep -q -1 "remove-patiently"

Could you add the same guard I suggested for fstests for ancient
versions of modprobe?  e.g.,:

modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"

Thanks!

						- Ted
