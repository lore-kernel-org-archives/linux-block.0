Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB01C001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 12:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHDMzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDMzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 08:55:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A111B
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 05:55:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC33C1F74D;
        Fri,  4 Aug 2023 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691153735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxuNE7EC0VQnJSO02qPrq1Amt0j8J/AVJ8tjhc5rwls=;
        b=w9ovV+qULygpjIceOOXvFsUWs6uwsY/nC4Ke9gFeBNGXW0MaUVFTDLtNxeTcuoBwkIDARZ
        pmOQXOWcDiz78a/JAMeJx5fVq/CPjD5UU2VBl+neQHrfXtOj2WuXw0iDtm0weSHusyfpdQ
        10CcoTTxeNqPr1DOgufGC84R++qw9Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691153735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxuNE7EC0VQnJSO02qPrq1Amt0j8J/AVJ8tjhc5rwls=;
        b=p4lts56iLg1R6F7/AKjnczkL4uece5lqEa+Vk/EgCq2Z3cPX363YUmaDfIzSdnuF1vjud9
        iZFYOjBo/M3YjyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAD73133B5;
        Fri,  4 Aug 2023 12:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+GOJEf1zGQfBQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 04 Aug 2023 12:55:35 +0000
Message-ID: <d6ce5f11-46d3-cf05-ad47-0114d0f88096@suse.de>
Date:   Fri, 4 Aug 2023 14:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests] block/004: reset zones of TEST_DEV before fio
 operation
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/23 14:20, Shin'ichiro Kawasaki wrote:
> When test target is a zoned block device with max_active_zones limit
> larger than max_open_zones, fio write operation may fail depending on
> zone conditions. To avoid the failure, reset zones of the device before
> the fio run.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/block/004 | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/block/004 b/tests/block/004
> index 63484a4..52a260f 100755
> --- a/tests/block/004
> +++ b/tests/block/004
> @@ -15,7 +15,10 @@ requires() {
>   }
>   
>   device_requires() {
> -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> +	if _test_dev_is_zoned; then
> +		_have_fio_zbd_zonemode
> +		_have_program blkzone
> +	fi
>   }
>   
What would be the return value here?
Do we care?
Should we make it explicit?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)

