Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDCC433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiEBQZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiEBQZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:25:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AF60FE
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:21:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A0E21F38D;
        Mon,  2 May 2022 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651508494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=edd7jxQViAR43IxjOJjos/lpAa+2WDWsd6FGN/8ns54=;
        b=OdVP2yY50H4Gd5WxJh8MFc9mK2FHhMDG/z9JuSZQmpec8tXlYpNdkuxdt/VRSOhezCj/Lp
        uLRmoQgsD81ho8JlPZIrt6zwY1N+ZoFn7ae8czofMxb6wbipf29sxSOjkiJTGraT1ESDa8
        8jCvXewTPbbJeLnm7qvdmc9XlMMJ8N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651508494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=edd7jxQViAR43IxjOJjos/lpAa+2WDWsd6FGN/8ns54=;
        b=QCPWBHPiivvgcoFXso5gpE+cOMLKnSe9bfPQpqRmVDL6fZo47XLvPaur6ow0gfyz+78VLg
        dIoCqHP3D4Q98MBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57E0213491;
        Mon,  2 May 2022 16:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NQ4CBw0FcGKBZgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 May 2022 16:21:33 +0000
Message-ID: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
Date:   Mon, 2 May 2022 09:21:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] eBFP for block devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

and another topic which came up during discussion yesterday:

eBPF for block devices
It would be useful to enable eBPF for block devices, such that we could 
do things like filtering bios on bio type, do error injection by 
modifying the bio result etc.
This topic should be around how it could be implemented and what 
additional use-cases could be supported.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
