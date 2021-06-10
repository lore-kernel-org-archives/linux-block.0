Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A7DC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10436128A
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFJGZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:25:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36336 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJGZD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:25:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED498219A5;
        Thu, 10 Jun 2021 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSQHa8JwhjH4wFmeXi4aIpF5b0N0N+QJ7Nsd8f1GK9I=;
        b=flWw2Icvk8AdMhGH4iPOXhHfUrEntsRKjAHrmRSoDFkRDnyn/JR7LKCiext6IyQVZlldzf
        gt+n+kPj3B5xFcWsQcZ6Q0Sgsf2wsfmIHe7vJ4CyQFTdYo6Wv3wqHt9cf/W3tSSQtTyQYa
        W8B9gT9ziP0oJkVHiq62W7q1+yBb+Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSQHa8JwhjH4wFmeXi4aIpF5b0N0N+QJ7Nsd8f1GK9I=;
        b=hH13yoF6aosiu5ksm6thUQWLs7OwVGEJU+hZ8z8YwKWieM1JjzNr5ef3aYq76uhB+3ISU+
        7gLdo4O1ex/8bXCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 96C4C118DD;
        Thu, 10 Jun 2021 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSQHa8JwhjH4wFmeXi4aIpF5b0N0N+QJ7Nsd8f1GK9I=;
        b=flWw2Icvk8AdMhGH4iPOXhHfUrEntsRKjAHrmRSoDFkRDnyn/JR7LKCiext6IyQVZlldzf
        gt+n+kPj3B5xFcWsQcZ6Q0Sgsf2wsfmIHe7vJ4CyQFTdYo6Wv3wqHt9cf/W3tSSQtTyQYa
        W8B9gT9ziP0oJkVHiq62W7q1+yBb+Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSQHa8JwhjH4wFmeXi4aIpF5b0N0N+QJ7Nsd8f1GK9I=;
        b=hH13yoF6aosiu5ksm6thUQWLs7OwVGEJU+hZ8z8YwKWieM1JjzNr5ef3aYq76uhB+3ISU+
        7gLdo4O1ex/8bXCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gr3aIsqvwWAxWgAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:23:06 +0000
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <51e6ffc5-b6ed-8995-c8c3-40aecf5611cb@suse.de>
Date:   Thu, 10 Jun 2021 08:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-11-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> Define separate macros for integers and jiffies to improve readability.
> Use sysfs_emit() and kstrtoint() instead of sprintf() and simple_strtol()
> since the former functions are the recommended functions.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 66 ++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
