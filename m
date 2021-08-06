Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6219CC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4315E610FC
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhHFLix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:38:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58582 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbhHFLiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 07:38:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 63CE52240C;
        Fri,  6 Aug 2021 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628249916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74p1E+p8LcsCmT89H6VwKBRuLoJxSHC8dZgtgLIZbHg=;
        b=gx/TIw5bC7BWyYdCvaWI8oJzJgZOy6wYOIyQlhiqFtgg7scvgbkAjN43IZR84h6lozb2vf
        v22910D1csvcSVsWzcDq1CclpZP1CuvZtq9VoFFwE5xdoKtsNSkMOdGqKRfpzk2app4bSW
        I4um1IESkgVb5q0qKM3+t1mqmMXoP8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628249916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74p1E+p8LcsCmT89H6VwKBRuLoJxSHC8dZgtgLIZbHg=;
        b=3mekd9XppFP+5C04mczS4/WPcYqS/nFAMuoFO9DFIAQqYTzuzAfIvNyDv/kfSx+bpD45qT
        Pgb3voa4MKgQzhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5498A13A83;
        Fri,  6 Aug 2021 11:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8KViFDwfDWGAFwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 11:38:36 +0000
Subject: Re: [PATCH v3 3/4] block: rename IOPRIO_BE_NR
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-4-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c035ea17-ae49-99eb-5bab-30733467bf90@suse.de>
Date:   Fri, 6 Aug 2021 13:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806111857.488705-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 1:18 PM, Damien Le Moal wrote:
> The BFQ scheduler and ioprio_check_cap() both assume that the RT
> priority class (IOPRIO_CLASS_RT) can have up to 8 different priority
> levels. This is controlled using the macro IOPRIO_BE_NR, which is badly
> named as the number of levels also applies to the RT class.
> 
> Rename IOPRIO_BE_NR to the class independent IOPRIO_NR_LEVELS to make
> things clear.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/bfq-iosched.c         | 8 ++++----
>  block/bfq-iosched.h         | 4 ++--
>  block/bfq-wf2q.c            | 6 +++---
>  block/ioprio.c              | 3 +--
>  fs/f2fs/sysfs.c             | 2 +-
>  include/uapi/linux/ioprio.h | 4 ++--
>  6 files changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
