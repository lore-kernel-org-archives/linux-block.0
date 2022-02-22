Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE22C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 17:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiBVRqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiBVRqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 12:46:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458E170D42
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 09:46:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE8BA21110;
        Tue, 22 Feb 2022 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645551967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwS6ZQKfugFLAZS4OVdDYPWY2GMGcI3mwcbOXD+tBUI=;
        b=ohrc7ZC15uOx2h3004gbftp11YoHHWcDx6sBSFEJFxfaA0/A4OQMHtucomh7ld818yXhrf
        OQRruSw077aKzcBSaRMtfH4qfmbS6Bz9+eFWtfwV6bByZliZLhDbaPk4qNZtIz4YNRyjwa
        Xk+rLi+IX6ltoAjfbZedAnvrh+d11Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645551967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwS6ZQKfugFLAZS4OVdDYPWY2GMGcI3mwcbOXD+tBUI=;
        b=LzVIxUjUmEiGvFbUNEI1aX2ROixNCRdnqtqeGaVE4oql7xqZfz2wqQQHd+gHWuqQPYRwPs
        x8BxV0t08z0uvzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACC8F13C06;
        Tue, 22 Feb 2022 17:46:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yK+EKV8hFWKaZQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 22 Feb 2022 17:46:07 +0000
Message-ID: <c67683ac-b13a-23b6-3e50-e07ee2b88606@suse.de>
Date:   Tue, 22 Feb 2022 18:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org,
        Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
In-Reply-To: <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/22 15:46, Sagi Grimberg wrote:
> 
>> Actually, I'd rather have something like an 'inverse io_uring', where
>> an application creates a memory region separated into several 'ring'
>> for submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
> 
> There is lio loopback backed by tcmu... I'm assuming that nvmet can
> hook into the same/similar interface. nvmet is pretty lean, and we
> can probably help tcmu/equivalent scale better if that is a concern...

Yeah; maybe. I've had a look at tcmu, but it would need to be updated to
handle multiple rings.
Mike? What'd you say?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
