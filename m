Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08913C433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiEBUmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiEBUmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 16:42:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00648A1A8
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 13:38:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9322C210ED;
        Mon,  2 May 2022 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651523930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoHj23O8hja1dkJO7+9oYydLRUULq5PhUKa3MqdF0BY=;
        b=RSuWbp7J8Ur47+Hr3e7m7+LJ4RQrILKA6QHfV3pDXeipPi5KaV0VU6xgl1rfPxFkviv5sW
        o+WLaiWhA/lPaJ/6QOOgVcOYMgWpOfvxz7vNitIc+Oj7IZxumNc0atrq4JCCHZ6gh2Lbm/
        60kKGBnvHm6kJY++KCP5/Ost42ZIjx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651523930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoHj23O8hja1dkJO7+9oYydLRUULq5PhUKa3MqdF0BY=;
        b=FKrAg+4H3X0QtA+XEjeW+QIjMCbA/Wg9mWsiX7nQMYMOC+J6s6R7Aw2zmyjVgQnfdIyHhq
        aMU+9pZ2GpSGQpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DFCC13491;
        Mon,  2 May 2022 20:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BTvSMlhBcGKaRwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 May 2022 20:38:48 +0000
Message-ID: <8b731c39-4b41-6b41-08c1-9467f9dbf293@suse.de>
Date:   Mon, 2 May 2022 13:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
 <87y1zjq14c.fsf@collabora.com> <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
 <CACGdZY+=Ugn0vd4+zsFoKwHp6f3Rv27wdssgvSoS_Onoi1yXUw@mail.gmail.com>
 <yq1y1zjd6am.fsf@ca-mkp.ca.oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <yq1y1zjd6am.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/22 13:34, Martin K. Petersen wrote:
> 
> Khazhy,
> 
>>> We've been working in this area too. It possible to write BPF filters to
>>> protect block ranges using should_fail_bio().
>>
>> It'd be nice to have a "proper" api vs. ALLOW_ERROR_INJECTION, which
>> feels more debug-y and has the drawback of
>> CONFIG_FUNCTION_ERROR_INJECTION being all-or-nothing
> 
> I agree that it would be nice for this to be detached from error
> injection.
> 
Actually, I'd rather turn this around such that error injection is 
running _on top_ of eBPF...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
