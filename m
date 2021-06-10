Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C474C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A151613C1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFJGEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:04:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:04:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1E7C1FD37;
        Thu, 10 Jun 2021 06:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSVQItQbYbReMS/BBmDFyK6JJvVJu3Ehn28b115N1rY=;
        b=wVpGkA7byDpYXj2R2yvne/8gfkCDbtgxRKLrCcZGiFywPgzQh170tMp3l1nR3/hmEARFZ8
        dYmUzEmruHlvLUF+LPPcgNwL9KsqyL2ecWWv5fbcNE22hB1AgcUmb+GOqhn3ANO96cfU5C
        U2SfzA0CRm7YPmugX+YLd0C8Nh0OqGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSVQItQbYbReMS/BBmDFyK6JJvVJu3Ehn28b115N1rY=;
        b=MvfdvkrEcWVb7CJB7UeZqg5ine4fwlSjRf7vDNTLWI4udLQM3wY85vnCRSHXZhDVZXmtUA
        ne89oUQXR/kkOKDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AF313118DD;
        Thu, 10 Jun 2021 06:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSVQItQbYbReMS/BBmDFyK6JJvVJu3Ehn28b115N1rY=;
        b=sZ19RMWYnVbIfOyi8TQ3FrESLxHuUFOTn4oY4dInBhWqGtO4wVw6yLrioWZ3EhVdUXsrUs
        ayX7rx5lu+5UgYEMLaQimkenYZKfUVLX8mrWf347cR8Rz0Kxc5Tat1rFyQHf8d6WChnV0E
        PwMR5aq0pJEpNVdhZ7jRLT4hfdGLsDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSVQItQbYbReMS/BBmDFyK6JJvVJu3Ehn28b115N1rY=;
        b=nRi27GUbfGPg/GTvPKc2K7OMi8plHU8wV16rorypI09BlIsMEHnenMElj8xx7CKJwBdBrE
        42FCrJj1hBDOSaAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id d1ydKO+qwWClUgAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:02:23 +0000
Subject: Re: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <6292d300-50ba-d1a2-2941-7f805479737e@suse.de>
Date:   Thu, 10 Jun 2021 08:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> These entries were consecutive at the time of their introduction but are no
> longer consecutive. Make these again consecutive. Additionally, modify the
> help text since it refers to blk-mq and since the legacy block layer has
> been removed.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
