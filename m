Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A85C47094
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C9A610A8
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 08:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEaI01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 04:26:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhEaI0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 04:26:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E44AE2191F;
        Mon, 31 May 2021 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622449473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7IUpnFl8MiyaREqhYO3UJlM9LtjduOHzIC1QfHta58=;
        b=IG4LEwJvHGirCDc1Lh1d0DONz8EoqPOwZeJUbUm//hC4iTNL8Bka4Rb1mVu2mNANEWQl6y
        5IDeRYa92bH4wMaPMKfF7/xSzOctVb9m8jwOZA20rpQcfTFZTyX1VzLbv6ve4XuDnGeOsY
        DLm9Ut0npH0djdtovyYmNbtFeJQu8bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622449473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7IUpnFl8MiyaREqhYO3UJlM9LtjduOHzIC1QfHta58=;
        b=BD4cQyVGaw8EUOCwylWkJc7diFOa+7+h8voTDO5Zyb4GirSqtAn0echvCDcCNU6kjVJaPI
        wl64J5i4XKYfAcCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 86671118DD;
        Mon, 31 May 2021 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622449473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7IUpnFl8MiyaREqhYO3UJlM9LtjduOHzIC1QfHta58=;
        b=IG4LEwJvHGirCDc1Lh1d0DONz8EoqPOwZeJUbUm//hC4iTNL8Bka4Rb1mVu2mNANEWQl6y
        5IDeRYa92bH4wMaPMKfF7/xSzOctVb9m8jwOZA20rpQcfTFZTyX1VzLbv6ve4XuDnGeOsY
        DLm9Ut0npH0djdtovyYmNbtFeJQu8bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622449473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7IUpnFl8MiyaREqhYO3UJlM9LtjduOHzIC1QfHta58=;
        b=BD4cQyVGaw8EUOCwylWkJc7diFOa+7+h8voTDO5Zyb4GirSqtAn0echvCDcCNU6kjVJaPI
        wl64J5i4XKYfAcCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id t880IEGdtGAFNAAALh3uQQ
        (envelope-from <hare@suse.de>); Mon, 31 May 2021 08:24:33 +0000
Subject: Re: [PATCH] remove the raw driver
To:     Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <20210531072526.97052-1-hch@lst.de> <YLSSgyznnaUPmRaT@kroah.com>
 <CAK8P3a0sctUYZnRBxS+PLted8_O1mT8JisLqO4jMHQaU=Q5iNw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3665636f-6a74-e24f-e4b7-ff7790ebb3e4@suse.de>
Date:   Mon, 31 May 2021 10:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0sctUYZnRBxS+PLted8_O1mT8JisLqO4jMHQaU=Q5iNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/21 10:21 AM, Arnd Bergmann wrote:
> On Mon, May 31, 2021 at 9:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, May 31, 2021 at 10:25:26AM +0300, Christoph Hellwig wrote:
>>> The raw driver used to provide direct unbuffered access to block devices
>>> before O_DIRECT was invented.  It has been obsolete for more than a
>>> decade.
>>
>> What?  Really?  We can finally do this?  Yes!
>>
>> For some reason, I thought there was some IBM userspace tools that
>> relied on this device, if not, then great!
>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/Pine.LNX.4.64.0703180754060.6605@CPE00045a9c397f-CM001225dbafb6/
> 
> The discussion from 2007 is the last one I could find on lore that has
> useful information on when and why this was not removed in the past.
> The driver was scheduled from a 2005 removal in 2004, but not removed
> because both Red Hat and SuSE relied on the feature in their distros.
> 
>  From what I could find out, this continued to be the case in Red Hat
> Enterprise Linux 6 and SUSE Linux Enterprise server 11 that were
> supported between 2009 and 2020, but the following versions dropped
> the support.
> 
Which I can confirm for SUSE.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
